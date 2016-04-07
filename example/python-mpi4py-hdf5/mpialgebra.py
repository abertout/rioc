import numpy as np

def compute_sub_matrix_range(size, rank, nrows):
    return nrows * rank//size, nrows * (rank+1)//size 

def matrix_dot_vector_on_master(matrix, vector, comm):
    rank = comm.Get_rank()
    size = comm.Get_size()

    # Allocate array.
    nrows = matrix.shape[0]
    product = np.empty( (nrows,) )

    for slave in range(1, size):
        i0,i1 = compute_sub_matrix_range(size,slave,nrows)

        # Send matrix shape to slave.
        matrix_shape = np.array(matrix.shape, dtype=np.int32)
        comm.Send(matrix_shape, dest=slave)

        # Send sub-matrix and vector to slave.
        comm.Send(matrix[i0:i1,:], dest=slave)
        comm.Send(vector, dest=slave)

        # Receive sub-product from slave.
        comm.Recv(product[i0:i1], source=slave)

    # Compute sub-product on master.
    i0,i1 = compute_sub_matrix_range(size,rank,nrows)
    product[i0:i1] = np.dot(matrix[i0:i1,:],vector)

    return product

def matrix_dot_vector_on_slave(comm, master):
    rank = comm.Get_rank()
    size = comm.Get_size()

    # Receive matrix shape from master.
    matrix_shape = np.empty( (2,), dtype=np.int32)
    comm.Recv(matrix_shape, source=master)
    nrows, ncols = matrix_shape

    i0,i1 = compute_sub_matrix_range(size,rank,nrows)

    # Allocate arrays.
    sub_matrix = np.empty((i1-i0, ncols))
    vector = np.empty( (ncols,) )

    # Receive sub-matrix and vector from master.
    comm.Recv(sub_matrix, source=master)
    comm.Recv(vector, source=master)

    # Compute sub-product.
    sub_product = np.dot(sub_matrix,vector)

    # Send sub_product to master.
    comm.Send(sub_product, dest=master)
