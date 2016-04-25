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
the multiplication of a matrix :math:`\textbf{A}` and a vector 
:math:`\textbf{b}` :

.. math::

   \textbf{c}_{[N \times 1]} = \textbf{A}_{[N \times M]} \times \textbf{b}_{[M \times 1]}

which result is stored into the vector  :math:`\textbf{c}`.






.. How can I compile my code using CUDA?
.. ---------------------------------------


.. Compile and link my code with CUDA Libraries using Makefile
.. ------------------------------------------------------------



.. _CUDA toolkit: https://developer.nvidia.com/cuda-toolkit-65 
.. _CUDA documentation: http://docs.nvidia.com/cuda/index.html




