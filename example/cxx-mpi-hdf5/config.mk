CXX = $(CONDA_ENV_PATH)/bin/mpicxx
EXE = main

HDF5_LIB_DIR = $(CONDA_ENV_PATH)/lib
HDF5_INC_DIR = $(CONDA_ENV_PATH)/include
HDF5_LIBS = -lhdf5_cpp -lhdf5
