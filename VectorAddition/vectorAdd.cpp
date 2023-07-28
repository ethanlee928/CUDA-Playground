#include "vectorAdd.h"

#define N 10000000

void vectorAdd(float *out, float *x1, float *x2, int n) {
  for (int i = 0; i < n; i++) {
    out[i] = x1[i] + x2[i];
  }
}

int main() {
  float *out = (float *)malloc(sizeof(float) * N);
  float *x1 = (float *)malloc(sizeof(float) * N);
  float *x2 = (float *)malloc(sizeof(float) * N);

  for (int i = 0; i < N; i++) {
    x1[i] = i;
    x2[i] = i * i;
  }

  vectorAdd(out, x1, x2, N);
  testCase(out, x1, x2, N);
  return 0;
}
