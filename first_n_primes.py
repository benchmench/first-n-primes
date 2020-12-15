#!/usr/bin/env python3

# Python v3.8.6
#
# $ time ./first_n_primes.py 10000
# real	0m0.105s
# user	0m0.080s
# sys	0m0.013s
#
# $ time ./first_n_primes.py 100000
# real	0m2.543s
# user	0m2.462s
# sys	0m0.040s
#
# $ time ./first_n_primes.py 100000 > /dev/null
# real	0m2.492s
# user	0m2.488s
# sys	0m0.000s
#
# $ time ./first_n_primes.py 1000000 > /dev/null
# real	1m24.183s
# user	1m24.057s
# sys	0m0.037s

from itertools import count
from array import array
from math import isqrt
from sys import argv


def is_prime(n):
    # if n < 4:
    #     return n > 1
    # if n % 2 == 0 or n % 3 == 0:
    #     return False
    sqr = isqrt(n)

    for i in range(5, sqr + 1, 6):
        if n % i == 0 or n % (i + 2) == 0:
            return False
    return True


def first_n_primes(required_primes):
    # results = np.zeros(required_primes)
    results = array('I', [0]) * required_primes
    results[0] = 2
    results[1] = 3
    nfound = 2

    j = None
    for i in count(start=5, step=6):
        if is_prime(i):
            results[nfound] = i
            nfound += 1
            if nfound == required_primes:
                return results

        j = i + 2
        if is_prime(j):
            results[nfound] = j
            nfound += 1
            if nfound == required_primes:
                return results


if __name__ == '__main__':
    required_primes = int(argv[1])
    primes = first_n_primes(required_primes)
    primes = '\n'.join(map(str, primes))
    print(primes)
