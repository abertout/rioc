Module
===========================

Use thee `module` commands to update your environment for the different tools 
you use (`GCC`, `MPI`, `BLAS`, `LAPACK`, ...).

+------------------------+-------------------------------------+
| module avail           | list available modules              |
+------------------------+-------------------------------------+
| module add             | add a module to your environment    |
+------------------------+-------------------------------------+

For example, in your `.bashrc`, in order to use `parallels` commands (`pexec`,
`pcopy`, `pkilluser`):

.. code-block:: bash

    module add cluster-tools

When leaving your session, do not forget to use the `pkilluser` command
(destructs all your process open on all nodes).

Notes:

    - `home dir` users are stored on `rioc` server which is shared using `NFS`
      on all nodes: `/home/rioc/<user>`.

    - No backup is performed on `/home/rioc/<user>` by administrators.

    - `NAS` storage volumes `/projdata/team` are mounted by `NFS` on each node.

    - Files in `/home/rioc/user` can be copied using `SSH` tools (for example: `scp`).

    - To speed up computation, do no overload the server, and remember local
      disk `/local` of each node can be use.
