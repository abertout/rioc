OAR
===

What is OAR?
~~~~~~~~~~~~

OAR is a versatile resource and task manager (also called a batch scheduler) for HPC clusters and other computing infrastructures.

Where can I find some documentation about OAR?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can find the official documentation of OAR and some other documents `here <https://oar.imag.fr/dokuwiki/doku.php?id=documentation/>`_.

How can I submit a job?
~~~~~~~~~~~~~~~~~~~~~~~

The main command for submitting a job is called ``oarsub``.

There exists two job submission modes: passive mode and interactive mode.
Passive mode let you provide a script containing the commands you want to run on the cluster.
You can submit a job in passive mode with the following command line:

.. code-block:: bash

   oarsub myjob.sh

where `myjob.sh` is a bash script describing your job.
Passive mode should be your preferred way of running parallel programs on the cluster, especially when the computational time of your application is high.
A job submitted in passive mode cannot last more than 168 hours (7 days).

However, it is not always easy to write a correct script `myjob.sh` on the first attempt.
Furthermore, even if your code runs on your machine, you may need to modify it to be able to run it on the cluster.
Interactive mode has been designed to provide an ease of use in these cases.
Indeed, interactive mode let you connect nodes and run commands in a terminal during a given period of time. 
You can submit a job in interactive mode with the following command:

.. code-block:: bash

   oarsub -I

This will let you run as many commands as you want during 12 consecutive hours at most.

How can I get my job identifier?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The identifier of your job is stored in the environment variable named ``OAR_JOB_ID``.

How can I plan a job in the future?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This feature is available with the ``-r <date>`` option of the ``oarsub`` command. The date format to pass to the ``-r`` option is ``YYYY-MM-DD HH:MM:SS``. For example, to submit a job on the 3rd of January in 2967 at 12:34:56, you have to type

.. code-block:: bash

   oarsub ./myjob.sh -r "2967-01-03 12:34:56"

in your terminal.

How can I specify how many nodes, processors and cores I want to reserve?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This feature is available with the ``-l /nodes=<number of nodes>/cpu=<number of processors>/core=<number of cores>`` option of the ``oarsub`` command. For example, if you want to reserve 4 nodes, 2 processors and 8 cores, you have to type

.. code-block:: bash

   oarsub -l /nodes=4/cpu=2/cores=8 ./myjob.sh

in your terminal.

How can I specify the duration of a reservation?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This feature is available with the ``-l walltime=<duration>`` option of the ``oarsub`` command. The duration format to pass to this option is ``HH:MM:SS``. Note that if you decide to specify the duration of your job, it must be done at the end of the ``-l`` option, separated by a comma. For example, if you want to reserve 4 nodes during 2 hours and 30 minutes, you have to type

.. code-block:: bash

   oarsub -l /nodes=4, walltime=02:30:00 ./myjob.sh

in your terminal.







