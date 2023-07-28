#include <math.h>
#include <stdio.h>
#include <stdlib.h>

void testCase(float *out, float *x1, float *x2, int n) {
  for (int i = 0; i < n; i++) {
    if (fabs(x1[i] + x2[i] - out[i]) > 1e-5) {
      printf("Result verification failed at element %d\n", i);
      exit(1);
    }
  }
  printf("Passed test!\n");
}