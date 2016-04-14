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
`CUDA toolkit`_ version currently available in ``rioc`` is 6.5.




.. _CUDA toolkit: https://developer.nvidia.com/cuda-toolkit-65 
.. _CUDA documentation: http://docs.nvidia.com/cuda/index.html




