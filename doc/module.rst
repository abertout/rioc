Module
===========================

Use the ``module`` commands to update your environment for the different tools 
you use (``GCC``, ``MPI``, ``BLAS``, ``LAPACK``, ...).

commands
---------------------------

More usefull ``module`` commands are:

+------------------------+-------------------------------------+
| command                | description                         |
+========================+=====================================+
| module avail           | list available modules              |
+------------------------+-------------------------------------+
| module load <name>     | load a module in your environment   |
+------------------------+-------------------------------------+
| module unload <name>   | unload a module of your environment |
+------------------------+-------------------------------------+
| module list            | list activated modules              |
+------------------------+-------------------------------------+
| module help <name>     | list activated modules              |
+------------------------+-------------------------------------+

For example:

.. code-block:: bash

    module load openmpi

Add this line in your ``~/.bashrc`` if you want it to be executed every time
you log on ``rioc``.

environment
---------------------------

``module`` only modify environement variables.

Use the ``env`` command to see all the defined environment variables:

.. code-block:: bash

    env
