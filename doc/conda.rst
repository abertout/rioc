.. _conda:
   
Conda
===============================

Softwares and libraries can be provided on ``rioc`` using the ``Conda``
package manager.

This documentation explains how to execute programs or link with libraries
provided with ``Conda``, as well as advanced usage of ``Conda``.

    Conda is an open source package management system and environment management
    system for installing multiple versions of software packages and their
    dependencies and switching easily between them. It works on Linux, OS X and
    Windows, and was created for Python programs but can package and distribute any
    software. (`conda documentation`_).

.. note::

    :ref:`module` and :ref:`conda` achieve the same goal of providing
    libraries and softwares. :ref:`module` is the solution traditionally used
    on clusters, :ref:`conda` is more recent, and provide among others very
    up-to-date Python scientific packages. Use whatever tool is more suitable
    for you.

Where can I find documentation about Conda?
----------------------------------------------

See the `conda documentation`_. A useful resource is also the `conda cheat
sheet`_.

.. _activate_env:

How can I activate conda?
----------------------------------------------

``conda`` must be in your ``PATH`` to be used:

.. code-block:: bash

    $ export PATH="/cm/shared/miniconda3/bin:$PATH"

Additionally, programs and libraries can be installed in different ``conda``
environments. To use the  default environment named ``rioc``, it must be
activated with:

.. code-block:: bash

    $ source activate rioc

This modify your ``PATH`` to point to activated environment:

.. code-block:: bash

   $ echo $PATH
   /cm/shared/miniconda3/envs/rioc/bin:<... the rest of your PATH... >

This also set the ``$CONDA_ENV_PATH`` environment variable:

.. code-block:: bash

   $ echo $CONDA_ENV_PATH
   /cm/shared/miniconda3/envs/rioc

How can I execute a program provided by Conda?
----------------------------------------------

Once the conda environment is :ref:`activated <activate_env>`, programs are in
the ``PATH`` and can be called directly. For example ``hdf5`` conda package is
installed in the ``rioc``
``conda`` environment, and provides the ``h5ls`` program:

.. code-block:: bash

    $ h5ls --version
    h5ls: Version 1.8.15-patch1

.. code-block:: bash

    $ which h5ls
    /cm/shared/miniconda/envs/rioc/bin/h5ls

``mpicc`` and ``mpirun`` are provided too by the ``openmpi`` ``conda`` package:

.. code-block:: bash

    $ which mpicc
    /cm/shared/miniconda/envs/rioc/bin/mpicc

    $ which mpirun
    /cm/shared/miniconda/envs/rioc/bin/mpirun

How can I link with a library provided by Conda, using a Makefile?
------------------------------------------------------------------

It is common to build source code using a ``Makefile`` which includes a
configuration file that the user edits.

The example :download:`rioc-cxx-mpi-hdf5.tar.gz
<_static/example/rioc-cxx-mpi-hdf5.tar.gz>` provides a example a of
matrix-vector product that make use of ``openmpi`` and ``HDF5``.

The ``Makefile`` build the C++ code, including headers and linking libraries
of ``HDF5`` and ``OpenMPI``:

.. literalinclude:: ../example/cxx-mpi-hdf5/Makefile
   :language: Makefile

The above ``Makefile`` reads a configuration file ``config.mk``, which points
to the ``conda`` environment:

.. literalinclude:: ../example/cxx-mpi-hdf5/config.mk
   :language: Makefile

The application is built with ``make``:

.. code-block:: bash

    $ make

    /cm/shared/miniconda/envs/rioc/bin/mpicxx -c  -I/cm/shared/miniconda/envs/rioc/include main.cxx
    /cm/shared/miniconda/envs/rioc/bin/mpicxx -c  -I/cm/shared/miniconda/envs/rioc/include mpialgebra.cxx
    /cm/shared/miniconda/envs/rioc/bin/mpicxx main.o mpialgebra.o -o main  -L/cm/shared/miniconda/envs/rioc/lib -Wl,-rpath,/cm/shared/miniconda/envs/rioc/lib  -lhdf5_cpp -lhdf5 


How can I link with a library provided by Conda, using CMake?
-------------------------------------------------------------

We use the same :download:`rioc-cxx-mpi-hdf5.tar.gz <_static/example/rioc-cxx-mpi-hdf5.tar.gz>`
example as in the previous section.

``CMake`` provides modules to automatically find libraries and associates
compiler/linker flags. As ``CMake`` is in the ``conda`` environment, it will
automatically find libraries in it.

The ``CMakeLists.txt`` file contains:

.. literalinclude:: ../example/cxx-mpi-hdf5/CMakeLists.txt
   :language: cmake

The application is configured with ``cmake``:

.. code-block:: bash
  
    $ mkdir build; cd build
    $ cmake ..
    -- The C compiler identification is GNU 4.4.7
    -- The CXX compiler identification is GNU 4.4.7
    -- Check for working C compiler: /usr/bin/cc
    -- Check for working C compiler: /usr/bin/cc -- works
    -- Detecting C compiler ABI info
    -- Detecting C compiler ABI info - done
    -- Detecting C compile features
    -- Detecting C compile features - done
    -- Check for working CXX compiler: /usr/bin/c++
    -- Check for working CXX compiler: /usr/bin/c++ -- works
    -- Detecting CXX compiler ABI info
    -- Detecting CXX compiler ABI info - done
    -- Detecting CXX compile features
    -- Detecting CXX compile features - done
    -- Found HDF5: /cm/shared/miniconda/envs/rioc/lib/libhdf5_cpp.so;/cm/shared/miniconda/envs/rioc/lib/libhdf5.so;/usr/lib64/librt.so;/usr/lib64/libz.so;/usr/lib64/libdl.so;/usr/lib64/libm.so  
    -- Found MPI_C: /cm/shared/miniconda/envs/rioc/lib/libmpi.so  
    -- Found MPI_CXX: /cm/shared/miniconda/envs/rioc/lib/libmpi_cxx.so;/cm/shared/miniconda/envs/rioc/lib/libmpi.so  
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /root/tmp/cxx-mpi-hdf5/build

and is built with ``make``:

.. code-block:: bash

    $ VERBOSE=1 make

    /cm/shared/miniconda/envs/rioc/bin/cmake -H/root/tmp/cxx-mpi-hdf5 -B/root/tmp/cxx-mpi-hdf5/build --check-build-system CMakeFiles/Makefile.cmake 0
    /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_progress_start /root/tmp/cxx-mpi-hdf5/build/CMakeFiles /root/tmp/cxx-mpi-hdf5/build/CMakeFiles/progress.marks
    make -f CMakeFiles/Makefile2 all
    make[1]: Entering directory `/root/tmp/cxx-mpi-hdf5/build'
    make -f CMakeFiles/main.dir/build.make CMakeFiles/main.dir/depend
    make[2]: Entering directory `/root/tmp/cxx-mpi-hdf5/build'
    cd /root/tmp/cxx-mpi-hdf5/build && /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_depends "Unix Makefiles" /root/tmp/cxx-mpi-hdf5 /root/tmp/cxx-mpi-hdf5 /root/tmp/cxx-mpi-hdf5/build /root/tmp/cxx-mpi-hdf5/build /root/tmp/cxx-mpi-hdf5/build/CMakeFiles/main.dir/DependInfo.cmake --color=
    make[2]: Leaving directory `/root/tmp/cxx-mpi-hdf5/build'
    make -f CMakeFiles/main.dir/build.make CMakeFiles/main.dir/build
    make[2]: Entering directory `/root/tmp/cxx-mpi-hdf5/build'
    /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_progress_report /root/tmp/cxx-mpi-hdf5/build/CMakeFiles 1
    [ 50%] Building CXX object CMakeFiles/main.dir/main.cxx.o
    /cm/shared/miniconda/envs/rioc/bin/mpicxx    -I/cm/shared/miniconda/envs/rioc/include    -o CMakeFiles/main.dir/main.cxx.o -c /root/tmp/cxx-mpi-hdf5/main.cxx
    /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_progress_report /root/tmp/cxx-mpi-hdf5/build/CMakeFiles 2
    [100%] Building CXX object CMakeFiles/main.dir/mpialgebra.cxx.o
    /cm/shared/miniconda/envs/rioc/bin/mpicxx    -I/cm/shared/miniconda/envs/rioc/include    -o CMakeFiles/main.dir/mpialgebra.cxx.o -c /root/tmp/cxx-mpi-hdf5/mpialgebra.cxx
    Linking CXX executable main
    /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_link_script CMakeFiles/main.dir/link.txt --verbose=1
    /cm/shared/miniconda/envs/rioc/bin/mpicxx      CMakeFiles/main.dir/main.cxx.o CMakeFiles/main.dir/mpialgebra.cxx.o  -o main -rdynamic /cm/shared/miniconda/envs/rioc/lib/libhdf5_cpp.so /cm/shared/miniconda/envs/rioc/lib/libhdf5.so -lrt -lz -ldl -lm /cm/shared/miniconda/envs/rioc/lib/libhdf5_cpp.so /cm/shared/miniconda/envs/rioc/lib/libhdf5.so -lrt -lz -ldl -lm -Wl,-rpath,/cm/shared/miniconda/envs/rioc/lib 
    make[2]: Leaving directory `/root/tmp/cxx-mpi-hdf5/build'
    /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_progress_report /root/tmp/cxx-mpi-hdf5/build/CMakeFiles  1 2
    [100%] Built target main
    make[1]: Leaving directory `/root/tmp/cxx-mpi-hdf5/build'
    /cm/shared/miniconda/envs/rioc/bin/cmake -E cmake_progress_start /root/tmp/cxx-mpi-hdf5/build/CMakeFiles 0


How can I run my application with OAR?
--------------------------------------

When submitting a script with :ref:`OAR <OAR>`, remember to :ref:`activate
<activate_env>` the conda environment in the script.

The script ``run.sh`` of the previous example contains the commands to execute 
our program on the parallel acrhitecture:

.. literalinclude:: ../example/cxx-mpi-hdf5/run.sh
   :language: bash

But before its execution, we need to create input data for the program:

.. code-block:: bash

    ./create_inputs.sh
   
To submit our script to the cluster, we can use ``OAR``. But before that, let's
desactivate the current environment:

.. code-block:: bash
   
   source deactivate

then,

.. code-block:: bash

    oarsub -l /core=4,walltime=00:00:30 ./run.sh

.. _conda documentation: http://conda.pydata.org/docs 
.. _conda cheat sheet: http://conda.pydata.org/docs/_downloads/conda-cheatsheet.pdf 

What softwares/libraries are available?
----------------------------------------

Packages of the official `anaconda distribution
<http://docs.continuum.io/anaconda/pkg-docs>`_ are available. 

Additional packages of the `SED Conda channel
<http://ipscc.readthedocs.org/en/latest/package-listing.html>`_ are
available if channel is added in ``~/.condarc``:

.. code-block:: yaml

    channels:
        - file:///cm/shared/conda-channels/inria-pro-sed
        - defaults



New packages may be added on `demand
<https://helpdesk.inria.fr/categories/151/submit>`_.

Can I use conda packages outside of the cluster?
------------------------------------------------

Yes, conda can be installed on every desktop or laptop, without root
privileges, on `GNU/Linux`, `OSX` or `Windows`.

How do I set up my own environment with selected packages?
----------------------------------------------------------

Suppose you want the ``2.7`` version of ``Python``, instead of the
``3.5`` version of the ``rioc`` environment.

In your Conda configuration file ``~/.condarc``, specify that new
environments must be created in ``/scratch``:

.. code-block:: yaml

    envs_dirs:
      - /scratch/<you username>/miniconda3

    allow_softlinks: False

You can now create a new environment named ``py27`` like this:

.. code-block:: bash

    $ conda create -n py27 python=2.7
    $ source activate py27
    $ python --version
    Python 2.7.11 :: Continuum Analytics, Inc.

Packages are installed in ``/scratch/<user>/miniconda3/<env_name>``:

.. code-block:: bash

    $ echo $CONDA_ENV_PATH
    /scratch/froger/miniconda3/py27

You can now install additional packages in the environment, for example:

.. code-block:: bash

    $ conda install boost cython

    $ ls $CONDA_ENV_PATH/include/boost/regex.h
    /scratch/froger/miniconda3/py27/include/boost/regex.h

    $ which cython
    /scratch/froger/miniconda3/py27/bin/cython
