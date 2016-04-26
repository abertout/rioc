#include <stdio.h>
// CUDA runtime
#include <cuda_runtime.h>

// Helper functions and utilities to work with CUDA
#include <helper_functions.h>

/**
 * Matrix vector multiplication (CUDA Kernel) on the device: c = A * b
 * wA is A's width (# of columns) (the same that b's large (or # of rows))
 */
__global__
void kernel(float *A, float *b, float *c, const int N, const int M){
  int tid=threadIdx.x+blockIdx.x*blockDim.x;
  float sum=0;
  if(tid<N){
    for(int i=0; i<M; i++)
      sum += b[i]*A[(tid*M)+i];
    c[tid]=sum;
    }
}

// debuging functions
void init_array(float *a, const int N);
void init_mat(float *a, const int N, const int M);
void print_array(float *a, const int N, char *d);
void print_mat(float *a, const int N, const int M, char *d);

/**
  * Main function
  */
int main (int argc, char **argv) {


  printf("***********************************************************\n");
  printf("[Matrix Vector multiplication using CUDA]\n");
  printf(" Performs matrix multiplication c = A*b , where: \n");
  printf("     A is a NxM matrix\n"); 
  printf("     b is a Mx1 vector\n"); 
  printf("     c is a Nx1 vector\n");
  printf("***********************************************************\n\n");

  printf(" ........ Starting.......\n");


    //checkCmdLineFlag is a function provided by helper_functions.h (Cuda toolkit) 
    if (checkCmdLineFlag(argc, (const char **)argv, "help") ||
        checkCmdLineFlag(argc, (const char **)argv, "?"))
    {
        printf("Usage -device=n (n >= 0 for deviceID)\n");
        printf("     -wA=WidthA (M) -hA=HeightA (N) (A of size [NxM])\n");
        printf("     Note: Size of vector b must be the same than the width of matrix A ([Mx1])\n");

        exit(EXIT_SUCCESS);
    }



  int numDev = 0;   
  int devID = 0;
  cudaError_t error;
  cudaDeviceProp deviceProp;
  
  cudaGetDeviceCount(&numDev);

  // Get CUDA device access from device id
  error = cudaGetDevice(&devID);
    if (error != cudaSuccess)
    {
        printf("cudaGetDevice returned error code %d, line(%d)\n", error, __LINE__);
    }

  // Get properties from CUDA device
  error = cudaGetDeviceProperties(&deviceProp, devID);
    if (error != cudaSuccess)
    {
        printf("cudaGetDeviceProperties returned error code %d, line(%d)\n", error, __LINE__);
    }
    else
    {
        // Print information about the graphic card (gpu) used to run this example
        printf("GPU Devices installed on the cluster: %d \n", numDev);

        printf("GPU Device %d: \"%s\" with compute capability %d.%d\n", devID,
            deviceProp.name, deviceProp.major, deviceProp.minor);
        printf("GPU Device num of multiprocessors:  %d \n", deviceProp.multiProcessorCount);
        printf("GPU Device num of thread per block: %d \n", 
            deviceProp.maxThreadsPerBlock);
        printf("GPU Device num of thread per multiprocessor: %d \n", 
            deviceProp.maxThreadsPerMultiProcessor);



    }


  float *A, *b, *c;
  float *dev_A, *dev_b, *dev_c;

  int N=3;
  int M=4;
  
  // Memory allocation using the typical C way
  A=(float*)malloc(sizeof(float)*N*M);
  b=(float*)malloc(sizeof(float)*M);
  c=(float*)malloc(sizeof(float)*N);

  // Memory allocation in the device (gpu)
  cudaMalloc((void**)&dev_A, sizeof(float)*N*M);
  cudaMalloc((void**)&dev_b, sizeof(float)*M);
  cudaMalloc((void**)&dev_c, sizeof(float)*N);
  
  
  // Functions to initialize with some values matrix A, vector b and vector c
  init_mat(A, N, M);
  init_array(b, M);
  init_array(c, N);


  // Displaying values assigned to initial vectors and matrix
  printf("******** Initializing matrices data randomly ********\n");
  print_mat(A, N, M, "matrix (A) [NXM]");
  print_array(b, M, "in-vector (b) [Mx1]");
  print_array(c, N, "out-vector (c) [Nx1]");



  // Transfering memory from the cpu (host) to the gpu (device)
  cudaMemcpy(dev_A, A, sizeof(float)*N*M, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b, sizeof(float)*M, cudaMemcpyHostToDevice);


  // Kernel code. This portion of code is executed directly in the device (gpu)
  printf("\n\nRunning Kernel...\n\n");
  kernel<<<(N+1023)/1024, 1024>>>(dev_A, dev_b, dev_c, N, M);

  
  // Transfer the result from device memory to cpu memory
  cudaMemcpy(c, dev_c, sizeof(float)*N, cudaMemcpyDeviceToHost);

  // Cleaning memory from the device
  cudaFree(dev_A);
  cudaFree(dev_b);
  cudaFree(dev_c);


  // Displaying the results
  printf("******** Output data ********\n");
  print_array(c, N, "out-vector (c) [Nx1]");

  printf(" ........ Finished.......\n");


  return 0;

};

// Random initialization of a vector
void init_array(float *a, const int N) {
  int i;
  for(i=0; i<N; i++)
    a[i] = rand() % 4 + 1;
}
// Random initialization of a matrix
void init_mat(float *a, const int N, const int M) {
  int i, j;
  for(i=0; i<N; i++)
    for(j=0; j<M; j++)
      a[i*M+j] = rand() % 4 + 1;
}
// Display a vector values
void print_array(float *a, const int N, char *d) {
 int i;
 for(i=0; i<N; i++)
   printf("\n%s[%d]: %f",d, i, a[i]);
 printf("\n");
}
// Display a matrix values
void print_mat(float *a, const int N, const int M, char *d) {
  int i, j;
  for(i=0; i<N; i++){
    printf("\n%s[%d]:", d, i);
      for (j=0; j<M; j++)
        printf("\t%6.4f", a[i*M+j]);
   }
   printf("\n");
}
