#include <stdio.h>

void helloWorld() { printf("Hello World!\n"); }

__global__ void cudaHelloWorld() { printf("Hello World from GPU!\n"); }

int main(void) {
  helloWorld();
  cudaHelloWorld<<<1, 1>>>();
  cudaDeviceSynchronize();
  return 0;
}
