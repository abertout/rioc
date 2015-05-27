#!/bin/bash

module load freefem++
ff-mpirun -machinefile $OAR_FILE_NODES \
          -mca plm_rsh_agent "oarsh" \
          -np 4 \
          $FREEFEMSHARE/examples++-mpi/MPIGMRES2D.edp 
module unload freefem++
