/* GCC v10.2.0
 * $ gcc -Ofast first-n-primes.c -o fnp-gcc
 *
 * $ time ./fnp-gcc 100000
 * real	0m0.178s
 * user	0m0.102s
 * sys	0m0.040s
 *
 * $ time ./fnp-gcc 1000000
 * real	0m4.335s
 * user	0m3.156s
 * sys	0m0.337s
 *
 * $ time ./fnp-gcc 10000000
 * real	1m54.527s
 * user	1m42.228s
 * sys	0m3.435s
 *
 * $ time ./fnp-gcc 10000000 > /dev/null
 * real	1m43.337s
 * user	1m41.040s
 * sys	0m0.286s
 */

/* Clang v11.0.0
 * $ clang -Ofast first-n-primes.c -o fnp-clang
 *
 * $ time ./fnp-clang 1000000
 * real	0m5.255s
 * user	0m4.132s
 * sys	0m0.342s
 *
 * $ time ./fnp-clang 1000000 > /dev/null
 * real	0m4.178s
 * user	0m4.155s
 * sys	0m0.007s
 * 
 * $ time ./fnp-clang 10000000 > /dev/null
 * real	2m16.067s
 * user	2m15.736s
 * sys	0m0.030s
 */

#include <stdlib.h>
#include <stdio.h>

#define TRUE 1
#define FALSE 0

typedef int32_t natural;
typedef int32_t boolean;

char* append (char* str, natural n) {
  if (n > 9) {
    natural m = n / 10;
    n -= m * 10;
    str = append(str, m);
  }

  *str = '0' + n;
  return str + 1;
}

int digit_count (natural n) {
  register int i = 1;
  while ((n /= 10) >= 1) { i++; }
  return i;
}

size_t joined_len (size_t len, natural arr[len]) {
  size_t res = len;

  for (; len; len--, arr++) {
    res += digit_count(*arr);
  }
  
  return res;
}

char* join (size_t len, natural arr[len], char delim) {
  char *result, *p;
  p = result = calloc(joined_len(len, arr), sizeof(char));

  for(size_t i = len--; i; i--, arr++) {
    p = append(p, *arr);
    *(p++) = delim;
  }
  
  *(p - 1) = '\0';
  return result;
}

boolean is_prime (natural n) {
  if (n < 4) { return n > 1; }
  if (n % 2 == 0 || n % 3 == 0) { return FALSE; }

  for (register int i = 5; i * i <= n; i += 6) {
    if (n % i == 0 || n % (i + 2) == 0) {
      return FALSE;
    }
  }
  
  return TRUE;
}

int main (int argc, char* argv[]) {
  if (argc != 2) {
    printf("Usage: first-n-primes [N]\n");
    printf("  [N]: Number of desired prime numbers");
    return 1;
  }
  
  char buff[50000];
  setvbuf(stdout, buff, _IOFBF, sizeof(buff));
  
  register natural nprimes = atoi(argv[1]);
  natural* primes = calloc(nprimes, sizeof(natural));

  for (register natural found = 0, i = 2; found < nprimes; i++) {
    if (!is_prime(i)) { continue; }
    primes[found++] = i;
  }

  char* output = join(nprimes, primes, '\n');
  puts(output);

  free(primes);
  free(output);
  
  fclose(stdout);
  return 0;
}
