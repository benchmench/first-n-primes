#!/usr/bin/env php
<?php

/* PHP v7.14.13
 *
 * $ time ./first-n-primes.php 10000
 * real	0m0.241s
 * user	0m0.220s
 * sys	0m0.010s
 *
 * $ time ./first-n-primes.php 100000
 * real	0m7.288s
 * user	0m7.188s
 * sys	0m0.037s
 *
 * $ time ./first-n-primes.php 100000 > /dev/null
 * real	0m7.148s
 * user	0m7.125s
 * sys	0m0.010s
 */

count(debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS)) or main(@$argv);

function main ($argv) {
    $desired_count = (int) @$argv[1];
    $desired_count or die();

    ob_start();
    display_first_n_primes($desired_count);
    ob_end_flush();
}

function is_prime (int $n)
{
    // if ($n < 4) { return $n > 1; }
    // if ($n % 2 === 0 || $n % 3 === 0) { return false; }

    $sqr = sqrt($n) | 0;
    for ($i = 5; $i <= $sqr; $i++) {
        if ($n % $i === 0 || $n % ($i + 2) === 0) {
            return false;
        }
    }

    return true;
}

function display_first_n_primes (int $desired_count)
{
    $desired_count-- >= 1 and print "2\n";
    $desired_count-- >= 1 and print "3\n";
    if ($desired_count <= 0) { return; }
    
    for ($i = 5, $j = 0;; $i += 6) {
        if (is_prime($i)) {
            echo $i; echo "\n";
            if (!--$desired_count) { return; }
        }

        $j = $i + 2;
        if (is_prime($j)) {
            echo $j; echo "\n";
            if (!--$desired_count) { return; }
        }
    }
}
