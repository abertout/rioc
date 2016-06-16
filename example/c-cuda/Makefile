# makefile for matriVector exemple in cuda
# Example running in cluster rioc
# INRIA de Paris @2016

NVCC=nvcc

matrix_vector: matrix_vector.o 
	$(NVCC) -o $@ $^

%.o: %.cu
	$(NVCC) -c $<

clean:
	rm -f *.o matrix_vector 
