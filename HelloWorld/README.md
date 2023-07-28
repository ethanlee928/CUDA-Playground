# Hello World CUDA code

Printing `Hello World` from GPU.

## 1. Compile and run CUDA program

CUDA compiler driver `nvcc` can compile pure C++ code as well.

```bash
nvcc hello.cu -o hello && ./hello
```

## 2. CUDA kernel

- A `CUDA kernel` is a function that is called by the hosts and executes in the device.
- Typically decorated by `__global__` and `void`.
- `CUDA kernel` **CANNOT** return values.

### 2.1 Executing kernel

Kernel is being called in the following way:

```cpp
cudaHelloWorld<<<1,1>>>();
```

- `<<<gridSize, blockSize>>>` is the **execution configuration**.
- **Grid size**: Number of blocks within the grid
- **Block size**: Number of threads within the block
- Total No. of threads in a grid = `gridSize` \* `blockSize` (**IMPORTANT**)

### 2.2 Asynchronous nature of kernel launching

- `printf()` function can be directly used in kernels.
- We need to add a function call to synchronize the host and the device, to make sure output stream has been flushed before returning from the kernel to the host.

```cpp
cudaDeviceSynchronize();
```

## 3.Threads, Grids and Blocks

| Variable    | Description              |
| ----------- | ------------------------ |
| gridDim.x   | grid size                |
| blockDim.x  | block size               |
| blockIdx.x  | from 0 to `gridDim.x-1`  |
| threadIdx.x | from 0 to `blockDim.x-1` |

**Remarks**: Every block in the grid is independent of each other

### 3.1 Thread ID

the one-dimensional index `tid` of a thread is related to the multi-dimensional indices of the thread via the the following relation:

```cpp
int tid = threadIdx.z * blockDim.x * blockDim.y + threadIdx.y * blockDim.x + threadIdx.x;
```

### 3.2 Multi-dimensional grids and blocks

- `gridDim` and `blockDim` are of type `dim3`
- Use constructors of the struct `dim3` to define multi-dimensional grids and blocks:

```cpp
dim3 gridSize(Gx, Gy, Gz);
dim3 blockSize(Bx, By, Bz);
```

### 3.3 Limits

Grid size limit:

```cpp
gridDim.x <= 2^{31}-1
gridDim.y <= 2^{16}-1 = 65535
gridDim.z <= 2^{16}-1 = 65535
```

Block size limit:

```cpp
blockDim.x <= 1024
blockDim.y <= 1024
blockDim.z <= 64

blockDim.x * blockDim.y * blockDim.z <= 1024
```
