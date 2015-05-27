Good pratices
===============

It is highly discouraged to execute processes from `/home/rioc` (especially to
write), but rather use `/scratch` or `/local` of each node. Indeed, writing on
`/home/rioc` may overload the NFS server.

When leaving your session, do not forget to use the `pkilluser` command
(destructs all your process open on all nodes). This requires to load the
``cluster-tools`` module:

.. code-block:: bash

    module load cluster-tools
