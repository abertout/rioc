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

There exists two job submission modes: interactive and passive modes. 
You can submit a job in interactive mode with the following command:

.. code-block:: bash

   oarsub -I

You can submit a job in interactive mode with the following command:

.. code-block:: bash

   oarsub script.sh

Interactif mode is limited to 12 hours and 168 hours (7 days) in passif mode.

How can I get my job identifier?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The identifier of your job is stored in the environment variable named ``OAR_JOB_ID``.

How can I plan a job in the future?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This feature is available with the ``-r <date>`` option of ``oarsub`` command. The date format to pass to the ``-r`` option is ``YYYY-MM-DD HH:MM:SS``. For example, to submit a job on the 3rd of January in 2967 at 12:34:56, you have to type

.. code-block:: bash

   oarsub ./job.sh -r "2967-01-03 12:34:56"

in your terminal.
