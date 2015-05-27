Data management
===============

How can I import data from my machine to the cluster?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data import can be performed with the ``scp`` command:

.. code-block:: bash

   scp file login@rioc.inria.fr:path

For example, the user `John Doe`, whose login is `jdoe`, can import the file `/home/johndoe/mydata.txt` in the scratch directory of the cluster by typing

.. code-block:: bash

   scp /home/johndoe/mydata.txt jdoe@rioc.inria.fr:/scratch/jdoe

in a terminal from his local machine.

How can I export data from the cluster to my machine?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data export can be performed with the ``scp`` command:

.. code-block:: bash

   scp login@rioc.inria.fr:file path

For example, the user `John Doe`, whose login is `jdoe`, can export the file `/scratch/jdoe/mydata.txt` to `/home/johndoe/mydata.txt` by typing

.. code-block:: bash

   scp jdoe@rioc.inria.fr:/scratch/jdoe/mydata.txt /home/johndoe

in a terminal from his local machine.

