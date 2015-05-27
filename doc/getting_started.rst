Getting started
===============

This 5 minutes tutorial will show you how to execute your first parallel
program on the ``rioc`` cluster.

Account creation and log in
----------------------------


Each user must be registered to obtain `SSH` access to the server.  Using the
`helpdesk`_, ask administrators for the creation of your account on the `rioc`
cluster.

`SSH` access is **restricted to Rocquencourt internal network**, see how to
`access from outside <https://blog.inria.fr/sic-roc/?page_id=1938>`_
otherwise.

Once your account has been created, connect to `rioc` cluster using ssh:

.. code-block:: bash

    ssh <username>@rioc.inria.fr

.. _helpdesk: https://helpdesk.inria.fr/categories/151/submit

Build tutorial code
----------------------------

Download and extract :download:`rioc-c.tar.gz <_static/example/rioc-c.tar.gz>`:

.. code-block:: bash

    wget http://rioc.rtfd.org/en/master/_downloads/rioc-c.tar.gz
    tar xvzf rioc-c.tar.gz
    cd c

This archive contains a minimal ``C`` program using ``MPI``.

Activate the ``openmpi`` rioc module:

.. code-block:: bash

    module load openmpi/gcc/64/1.8.4

Build the code:

.. code-block:: bash

    make

Execute tutorial code
----------------------------

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
