include config.mk

CXXFLAGS_ALL = $(CXXFLAGS) -I$(HDF5_INC_DIR)
LDFLAGS_ALL = $(LDFLAGS) -L$(HDF5_LIB_DIR) -Wl,-rpath,$(HDF5_LIB_DIR) 
LIBS = $(HDF5_LIBS) $(MPI_LIBS)

all: $(EXE)

test: $(EXE)
	mpirun -n 4 $(EXE) input.h5

%.o: %.cxx
	$(CXX) -c $(CXXFLAGS_ALL) $<

$(EXE): main.o mpialgebra.o
	$(CXX) $^ -o $@ $(LDFLAGS_ALL) $(LIBS)

clean:
	rm -f *.o $(EXE)
