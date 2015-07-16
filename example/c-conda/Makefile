compute_pi: main.o compute_pi.o
	mpicc -o $@ $^

%.o: %.c
	mpicc -c $<

clean:
	rm -f *.o compute_pi
