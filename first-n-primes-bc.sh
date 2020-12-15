#!/usr/bin/env bash

# bc v1.07.1
#
# $ time ./first-n-primes-bc.sh 10000
# real	0m1.074s
# user	0m1.020s
# sys	0m0.052s
#
# $ time ./first-n-primes-bc.sh 10000 > /dev/null
# real	0m1.059s
# user	0m1.038s
# sys	0m0.017s
#
# $ time ./first-n-primes-bc.sh 100000 > /dev/null
# real	0m31.413s
# user	0m31.209s
# sys	0m0.064s

read -r -d '' BC_SCRIPT <<EOF
define isprime (n) {
  /* if (n < 4) { return n > 1; }
   * if (n % 2 == 0) { return 0; }
   * if (n % 3 == 0) { return 0; }
   */
  
  sqr = sqrt(n);
  for (j = 5; j <= sqr; j += 6) {
    if (n % j == 0 || n % (j + 2) == 0) {
      return 0
    }
  }

  return 1
}

define printprimes (cnt) {
  if (cnt-- >= 1) { print "2\n"; }
  if (cnt-- >= 1) { print "3\n"; }
  if (cnt <= 0) { return; }

  for (i = 5;; i += 6) {
    if (isprime(i)) {
      print i; print "\n";
      if (!--cnt) { return; }
    }
    if (isprime(i + 2)) {
      print i + 2; print "\n";
      if (!--cnt) { return; }
    }
  }
}
EOF

BC_SCRIPT="$BC_SCRIPT; ignore_zero = printprimes($1);"
echo "$BC_SCRIPT" | bc
