#!/bin/bash

export PATH="/cm/shared/miniconda/bin:$PATH"
source activate rioc
mpirun -machinefile $OAR_FILE_NODES \
       -mca plm_rsh_agent "oarsh" \
       -np 4 \
       compute_pi
