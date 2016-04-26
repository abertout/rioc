.. _gpu:
   
GPU Usage
===============================


``rioc`` cluster counts with two computing nodes specialized in gpu processing.
Each of these nodes is equipped with two graphics processing unities (GPU). The 
GPU model available for both nodes is the Nvidia Tesla K20X GPU.

GPU usage can be achieved by using different frameworks and/or platforms: two
common methods include the OpenCL framework or the CUDA application programming 
interface (API). 

To begin, tutorial to start writing your own code using the `CUDA toolkit`_ is 
proposed. This document explains also how to compile, link and execute programs 
using the `CUDA toolkit`_ in the computing cluster.


Where can I find documentation about GPU Toolkit?
--------------------------------------------------

Nvidia webpage host the `CUDA documentation`_. It's important to note that the
`CUDA toolkit`_ version currently available in ``rioc`` is ``6.5``.


A basic example of using Cuda toolkit and C language on the cluster
---------------------------------------------------------------------

Build the example code
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`CUDA toolkit`_ version ``6.5`` in installed in the cluster ``rioc``. This 
version is only compatible with ``gcc`` compilers >= ``4.4``. Then, we need to
select the right compiler's version in order to avoid errors. 
For that reason, the module ``gcc 4.9.2`` activated by default during set-up
of the default environment is unloaded:

.. code-block:: bash

    $ module unload gcc
    $ gcc --version
    gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-16)
    Copyright (C) 2010 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Next, to use the `CUDA toolkit`_ , it must be activated with:

.. code-block:: bash

    $ module load cuda65/toolkit/6.5.14

Download and extract :download:`rioc-c-cuda.tar.gz <_static/example/rioc-c-cuda.tar.gz>`:

.. code-block:: bash

    wget http://rioc.rtfd.org/en/master/_downloads/rioc-c-cuda.tar.gz
    tar xvzf rioc-c-cuda.tar.gz
    cd c-cuda

This archive contains a minimal ``C`` program using `CUDA toolkit`_.

Build the code:

.. code-block:: bash

    make

Execute the example code
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``launch_matrixVector.sh`` script executes the program compiled by ``nvcc``
(Nvidia's C compilator). I consists of a very simple script calling the 
executable:

.. literalinclude:: ../example/c-cuda/launch_matrixVector.sh
   :language: bash

To submit the code, use the ``oarsub`` command specifying the use of a gpu node:

.. code-block:: bash

    oarsub -q gpu -l /nodes=2 ./launch_matrixVector.sh

The script must be executable. If it's not the case use  
``chmod +x launch_matrixVector.sh``.

Results of the process can be consulted in the files ``OAR*.std*``


Code explanation
^^^^^^^^^^^^^^^^^

Let's start by explaining the code. The main functionality consists in calculate
the multiplication of a matrix :math:`\textbf{A}` of size :math:`[N \times M]` 
and a vector :math:`\textbf{b}` of size :math:`[M \times 1]` :

.. math::

   \textbf{c}_{[N \times 1]} = \textbf{A}_{[N \times M]} \times \textbf{b}_{[M \times 1]}

The result of this operation is stored into the vector  :math:`\textbf{c}` of 
size :math:`[N \times 1]`.

.. literalinclude:: ../example/c-cuda/matrix_vector.cu
   :language: c

In the headers section, the file ``cuda_runtime.h`` is included in order to use
the available functions from the library `CUDA toolkit`_. Also, 
``helper_functions.h`` contains some functions as ``checkCmdLineFlag`` used at
the beginning of the main to verify the input arguments passed to the process
using the command line.

Following with the main function, there are two type of objects that save
information about the device's current state: ``cudaError_t`` and 
``cudaDeviceProp``. The latter, in particular, allow us to knowd about the 
physical properties of the devices installed on the cluster (model, version, 
etc.).

Once this "reading arguments" stage is completed, there is a typical sequence 
of operations that are performed in a Cuda C program:

* Declare and allocate memory (on the host and the device (graphic card)).
* Initialize host data.
* Transfer data from host to the device.
* Execute operations on the device (that's called kernel operations).
* Transfer results from the device to the host.

In the code : 

.. code-block:: c

    // Memory allocation using the typical C way
    A=(float*)malloc(sizeof(float)*N*M);
    b=(float*)malloc(sizeof(float)*M);
    c=(float*)malloc(sizeof(float)*N);

    // Memory allocation in the device (gpu)
    cudaMalloc((void**)&dev_A, sizeof(float)*N*M);
    cudaMalloc((void**)&dev_b, sizeof(float)*M);
    cudaMalloc((void**)&dev_c, sizeof(float)*N);


Memory for the arrays A, b, c is allocated in a typical C fashion. There is also
the function ``cudaMalloc`` to allocate a memory space in the device (remember
that device memory and host memory is not shared).

Next in,

.. code-block:: c

  // Functions to initialize with some values matrix A, vector b and vector c
  init_mat(A, N, M);
  init_array(b, M);
  init_array(c, N);

The arrays A, b and c are filled with some data, by using the supplemental
functions written at the end of the file ``matrix_vector.cu``
In the next lines some functions to display the values assigned to the arrays
are used.

Then, we use the function ``cudaMemcpy`` in order to transfer the data contained
on the host memory to the device memory:

.. code-block:: c

  // Transfering memory from the cpu (host) to the gpu (device)
  cudaMemcpy(dev_A, A, sizeof(float)*N*M, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b, sizeof(float)*M, cudaMemcpyHostToDevice);

The next instruction launch the operations on the device (the ``printf`` line 
was suppressed). It calls the kernel function defined at the beginning of the 
file:

.. code-block:: c

  // Kernel code. This portion of code is executed directly in the device (gpu)
  kernel<<<(N+1023)/1024, 1024>>>(dev_A, dev_b, dev_c, N, M);

Information between the triple chevrons is called the *execution configuration*.
It allows to establish how many device threads execute the kernel code in 
parallel. In CUDA programming, threads are organized in blocks. A block is 
executed by a multiprocessing unit. Each block can process an X quantity of 
threads and a particular model of gpu is described by Y multiprocessing units. 
Then, the maximum number of threads to be executed in this gpu is X x Y.
In this kind of architecture, we speak of launching a kernel with a *grid of 
thread blocks*. The first argument, in our example (``(N+1023)/1024``)
specifies the number of thread block in the grid, and the second argument 
(``1024``), specifies the number of threads in a thread block.


**The Kernel Function**

The kernel function (code) it is called from the main function of the program.

.. code-block:: c

  __global__
  void kernel(float *A, float *b, float *c, const int N, const int M){ 
    int tid=threadIdx.x+blockIdx.x*blockDim.x;
    float sum=0;
    if(tid<N){
      for(int i=0; i<M; i++)
        sum += b[i]*A[(tid*M)+i];
      c[tid]=sum;
      }
  }

This function it is defined at the beginning of the file and starts by using the
*__global__* declaration specifier. Variables defined inside this function are
stored into the device memory. The pointers ``*A``, ``*b`` and ``*c`` are 
address corresponding to the device memory. The variables passed by value to the
kernel function (``N``, ``M``), are stored by each thread in a register.

The primordial property of this function is that it is executed by multiple 
threads in parallel. In our matrix-vector operation we want to calculate the 
result of each row-column operation by every single thread. But we need to track 
each thread to process all the row-elements of the resultant vector. This is 
possible thanks to the variables ``threadIdx``, ``blockIdx`` and ``blockDim``. 
These variables, predefined by CUDA, allow us to identify each thread. 
The expression:

.. code-block:: c

    int tid=threadIdx.x+blockIdx.x*blockDim.x;

calculates an index to access rows from matrix A (and also to store results of 
vector c). Then a sum of all the element across the row is evaluated (for loop). 




.. How can I compile my code using CUDA?
.. ---------------------------------------


.. Compile and link my code with CUDA Libraries using Makefile
.. ------------------------------------------------------------



.. _CUDA toolkit: https://developer.nvidia.com/cuda-toolkit-65 
.. _CUDA documentation: http://docs.nvidia.com/cuda/index.html




