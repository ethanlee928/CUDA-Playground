#include "vectorAdd.h"

#define N 10000000

__global__ void vectorAdd(float *out, float *x1, float *x2, int n) {
  int tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid < n) {
    out[tid] = x1[tid] + x2[tid];
  }
}

int main() {
  size_t SIZE = sizeof(float) * N;

  float *out = (float *)malloc(SIZE);
  float *x1 = (float *)malloc(SIZE);
  float *x2 = (float *)malloc(SIZE);
  float *d_out, *d_x1, *d_x2;

  cudaMalloc((void **)&d_out, SIZE);
  cudaMalloc((void **)&d_x1, SIZE);
  cudaMalloc((void **)&d_x2, SIZE);

  for (int i = 0; i < N; i++) {
    x1[i] = i;
    x2[i] = i * i;
  }

  cudaMemcpy(d_x1, x1, SIZE, cudaMemcpyHostToDevice);
  cudaMemcpy(d_x2, x2, SIZE, cudaMemcpyHostToDevice);

  int blockSize = 500;
  int gridSize = N / 500 + 1;
  vectorAdd<<<gridSize, blockSize>>>(d_out, d_x1, d_x2, N);
  cudaFree(d_x1);
  cudaFree(d_x2);
  cudaMemcpy(out, d_out, SIZE, cudaMemcpyDeviceToHost);
  cudaFree(d_out);

  testCase(out, x1, x2, N);
  return 0;
}
