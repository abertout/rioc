Getting started
===============

The 5 minutes tutorial will show you how to execute your first parallel
program on the ``rioc`` cluster.

Using the `helpdesk`_, ask administrators for the creation of your account on
the `rioc` cluster.

Once your accout has been created, connect to `rioc` cluster using ssh:

.. code-block:: bash

    ssh <username>@rioc.inria.fr

.. _helpdesk: https://helpdesk.inria.fr/categories/151/submit

Download and extract :download:`cluster-pro-inria-example-c.tar.gz <_static/example/cluster-pro-inria-example-c.tar.gz>`:

.. code-block:: bash

    wget http://cluster-pro-inria-doc.readthedocs.org/en/latest/_downloads/cluster-pro-inria-example-c.tar.gz
    tar xvzf cluster-pro-inria-example-c.tar.gz
    cd cluster-pro-inria-example/c

This archive contains a minimal ``C`` program using ``MPI``.

Activate the ``openmpi`` rioc module:

.. code-block:: bash

    module load openmpi/gcc/64/1.8.4

Build the code:

.. code-block:: bash

    make

The ``compute_pi.sh`` script execute ``mpirun`` for ``OpenMPI`` and ``OAR`` use:

.. literalinclude:: ../example/c/compute_pi.sh
   :language: bash

The script must be executable. (Which has already been done with `chmod +x
compute_pi.sh`).

Submit the code:

.. code-block:: bash

    oarsub -l /core=4,walltime=00:05:00 ./compute_pi.sh

Standard output and error of the program are written to files:

.. code-block:: bash

    cat OAR*.std*
