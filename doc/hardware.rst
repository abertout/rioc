Hardware
===========================

Operating system
-------------------

The cluster runs on ``Scientific Linux 5.5`` (``Kernel 2.6.18-274.18.1.el5 x86_64
GNU/Linux``).

Nodes
-------------------

The cluster is made of 94 nodes, divided into 3 groups:

+------------+------------+------------+--------------+--------------------+------------+
| | id       | | number   | | RAM [1]_ | | ``/local`` | | processor        | | total    |
|            | | of nodes |            | | disk [1]_  | | type             | | number   |
|            |            |            |              |                    | | of cores |
+============+============+============+==============+====================+============+
|  1 to 40   | 40         | 48 Gb      | 500 Gb       | | bi-processors    | 480        |
|            |            |            |              | | Intel Xeon X5650 |            |
|            |            |            |              | | of 6 cores       |            |
+------------+------------+------------+--------------+--------------------+------------+
| 41 to 56   | 16         | 64 Gb      | 500 Gb       | | bi-processors    | 320        |
|            |            |            |              | | Intel Xeon X5650 |            |
|            |            |            |              | | of 10 cores      |            |
+------------+------------+------------+--------------+--------------------+------------+
| 201 to 238 | 38         | 32 Gb      | 30 Gb        | | bi-processors    | 152        |
|            |            |            |              | | AMD Opteron 2200 |            |
|            |            |            |              | | of 2 cores       |            |
+------------+------------+------------+--------------+--------------------+------------+

Host names are ``node000``, ``node001``, etc.

.. [1] For each node.


Network
-------------------

The 94 nodes are interconnected with Ethernet Gigabit on a dedicated network.

An high-speed internal network ``InfiniBand`` (40Gb/s) connects the first 56
nodes (1 to 56).

Storage
-------------------

A parallel file system ``FhGFS`` (2Gb/s) on ``InfiniBand`` (first 56 nodes) and
``Ethernet`` (last 38 nodes) can store 120To in ``/scratch`` (no backup) for
HPC data.

The 94 nodes also are interconnected on the `NAS storage server network
<https://sic-roc.inria.fr/?page_id=1183>`_.

Hyperthreading
-------------------

For ``pthread`` users (shared memory), ``hyperthreading`` ``BIOS`` mode is
activated on 4 nodes (37 to 40).
