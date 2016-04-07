import h5py
from mpi4py import MPI

import mpialgebra as alg

def read_matrix_vector(filename):
    with h5py.File(filename) as f:
        matrix = f['matrix'].value
        vector = f['vector'].value
    return matrix, vector

def main():
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()
    master = 0

    if rank == master:
        matrix, vector = read_matrix_vector('input.h5')
        product = alg.matrix_dot_vector_on_master(matrix, vector, comm)
        print(product)
    else:
        alg.matrix_dot_vector_on_slave(comm, master)

if __name__ == '__main__':
    main()

