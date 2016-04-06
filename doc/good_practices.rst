Good pratices
===============

It is highly discouraged to execute processes from ``/home/rioc`` (especially to
write), but rather use ``/scratch`` or ``/local`` of each node. Indeed, writing on
``/home/rioc`` may overload the NFS server.

The command ``oarstat`` provides you information about the usage of the cluster.
If necessary, you can use ``oardel`` to destruct the processes open in several
nodes. 
For example,
.. code-block:: bash

    oardel 41417

deletes the jod with id 41417 (in all nodes where it supposed to be executed).    
