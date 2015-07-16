#!/bin/bash

# Activate conda environment
export PATH="/cm/shared/miniconda3/bin:$PATH"
source activate rioc

mpirun -machinefile $OAR_FILE_NODES \
       -mca plm_rsh_agent "oarsh" \
       -np 4 \
       $PWD/main $PWD/input.h5


