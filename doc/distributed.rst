Distributed Computing
=====================

OpenMP
~~~~~~

Here is an example of OpenMP code for distributing a sequential computation (`sequential` function) over several threads. 
For the sake of efficiency, the number of threads is automatically set so that each thread corresponds to one core. 
Note that it is possible to modify the number of threads with the function named `omp_set_num_threads`.

.. code-block:: c

   /* hello.c */
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

   #include <omp.h>

   void sequential(int thread_identifier)
   {
       printf("Hello, I am thread = %d. Nice to meet you!\n", thread_identifier);
       printf("Please wait for me for 10 seconds...\n");
       sleep(10);
       printf("Thank you! See you soon!\n");
   }

   int main (int argc, char *argv[])
   {
       #pragma omp parallel
       {
        int thread_identifier = omp_get_thread_num();
        sequential(thread_identifier);
       }
   }

This example works as follows. 
The main function contains an OpenMP directive (`#pragma omp parallel`) which defines a parallel section: each thread will execute the code defined between the two inner braces.
The first instruction of this code calls an OpenMP function (`omp_get_thread_num`) in order to get the identifier of the current thread.
The second instruction calls a sequential function which takes the current thread identifier as an input argument.

From the code below, an executable file can be generated with `gcc` like this:

.. code-block:: bash

   module load gcc
   gcc hello.c -o hello -fopenmp

Then, it is possible to run it on 4 cores of 1 node with OAR:

.. code-block:: bash

   oarsub -l /nodes=1/core=4 ./hello

Of course, it is possible to choose the number of cores you want to reserve.
