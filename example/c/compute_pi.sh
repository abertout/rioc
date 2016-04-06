#!/bin/bash

module load openmpi/gcc/64/1.6.5
mpirun -machinefile $OAR_FILE_NODES \
       -mca plm_rsh_agent "oarsh" \
       -np 4 \
       compute_pi
module unload openmpi/gcc/64/1.6.5
