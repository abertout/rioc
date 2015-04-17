#!/bin/bash

/cm/shared/apps/openmpi/1.8.4/bin/mpirun \
    -machinefile $OAR_FILE_NODES \
    -mca pls_rsh_agent "oarsh" \
    -np 4 \
    compute_pi
