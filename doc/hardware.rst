Hardware
===========================

The cluster is made of 94 nodes, divided into 3 groups:

    - **40 nodes** (1 to 40). For each node: 48Go RAM, disk `local` 500Go,
      bi-processors Intel Xeon X5650 of 6 cores, **480 cores at all**.

    - **16 nodes** (41 to 56). For each node: 64Go RAM, disk `local` 500Go,
      bi-processors Intel Xeon X5650 of 10 cores, **320 cores at all**.

    - **38 nodes** (201 to 238). For each node: 32Go RAM, disk `local` 30Go,
      bi-processors AMD Opteron 2220 of 2 cores, **152 cores at all**.

These 94 nodes are interconnected with Ethernet Gigabit on a dedicated network.

An high-spped internal network `InfiniBand` (40Gb/s) connects the first 56
nodes (1 to 56).

These 56 nodes are accessible only using the OAR resouce mananger

    - http://oar.imag.fr/user-quickstart/
    - http://igrida.gforge.inria.fr/experimenting_oar.html
    - http://calculs.unice.fr/assistance/gestion-soumission-travaux/tableau-de-jobs
    - https://ciment.ujf-grenoble.fr/docs/tp-utilisateur-oar2/tp-oar2/

A parallel file system `FhGFS` (2Go/s) on `InfiniBand` (first 56 nodes) and
`Ethernet` (last 38 nodes) can store 120To in `/scratch` (no backup) for
HPC data.

These 94 nodes also are interconnected on the `NAS storage server network <https://sic-roc.inria.fr/?page_id=1183>`_.

For `pthread` users (shared memory), `hyperthreading` `BIOS` mode is activated on 4 nodes (37 to 40).

The cluster runs on `Scientific Linux 5.5` (`Kernel 2.6.18-274.18.1.el5 x86_64
GNU/Linux`) and is administrated using `Bright Cluster` software.
