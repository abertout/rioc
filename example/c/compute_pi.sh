#!/bin/bash

module load openmpi
mpirun -machinefile $OAR_FILE_NODES \
       -mca plm_rsh_agent "oarsh" \
       -np 4 \
       compute_pi
module unload openmpi
