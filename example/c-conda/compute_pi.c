#include "compute_pi.h"

double compute_pi(int rank, int size, int niter, MPI_Comm comm)
{
    int iiter;
    double h = 1.0 / (double) niter; 
    double sum = 0.0; 
    double x;

    for (iiter = rank + 1; iiter <= niter; iiter += size) { 
        x = h * ((double)iiter - 0.5); 
        sum += (4.0 / (1.0 + x*x)); 
    } 

    return h * sum; 
}
