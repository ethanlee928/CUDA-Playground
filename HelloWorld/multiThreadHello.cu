#include <stdio.h>

__global__ void cudaHelloWorld() {
  int bid = blockIdx.x;
  int tid = threadIdx.x;
  printf("Hello World from block %d and thread %d\n", bid, tid);
}

__global__ void cuda3DHelloWorld() {
  int bdx = blockDim.x, bdy = blockDim.y;
  int bx = blockIdx.x, by = blockIdx.y, bz = blockIdx.z;
  int tx = threadIdx.x, ty = threadIdx.y, tz = threadIdx.z;
  int tid = tz * bdx * bdy + ty * bdx + tx;
  printf("[%d] Hello World from block (%d, %d, %d), thread (%d, %d, %d) \n",
         tid, bx, by, bz, tx, ty, tz);
}

int main() {
  cudaHelloWorld<<<3, 5>>>();
  cudaDeviceSynchronize();

  printf("\n3D Block Thread\n");
  const dim3 gridSize(3, 3, 3);
  const dim3 blockSize(3, 3, 3);
  cuda3DHelloWorld<<<gridSize, blockSize>>>();
  cudaDeviceSynchronize();
  return 0;
}
