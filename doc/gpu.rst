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

How can I compile my code using CUDA?
----------------------------------------------

`CUDA toolkit`_ version ``6.5`` in installed in the cluster ``rioc``. This 
version is only compatible with ``gcc`` compilers >= ``4.4``. Then, we need to
select the right compiler's version in order to avoid error. 
For that reason, the module ``gcc 4.9.2`` activated by default during the set
uo of the starting environment at ``rioc`` must be unloaded:

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

Compile and link my code with CUDA Libraries using Makefile
------------------------------------------------------------

We use this example extracted from the cuda samples folder to show...


Compile and link my code with CUDA Libraries using CMake
---------------------------------------------------------


.. _CUDA toolkit: https://developer.nvidia.com/cuda-toolkit-65 
.. _CUDA documentation: http://docs.nvidia.com/cuda/index.html




