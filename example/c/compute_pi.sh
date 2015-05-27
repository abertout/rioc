#!/bin/bash

module load mpi
mpirun -machinefile $OAR_FILE_NODES \
       -mca plm_rsh_agent "oarsh" \
       -np 4 \
       compute_pi
unload module mpi
