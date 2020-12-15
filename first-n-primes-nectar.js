/* NectarJS v0.7.108
 * $ nectar first-n-primes-nectar.js -o fnp-nectar
 *
 * $ time ./fnp-nectar 100000
 * real	0m0.949s
 * user	0m0.917s
 * sys	0m0.030s
 *
 * $ time ./fnp-nectar 1000000
 * real	0m25.448s
 * user	0m24.900s
 * sys	0m0.335s
 *
 * $ time ./fnp-nectar 1000000 > /dev/null
 * real	0m24.228s
 * nuser	0m24.113s
 * sys	0m0.000s
 */

var process = require("process");
var nprimes = process.argv[1] | 0;

function isPrime (n) {
    if (n < 4) { return n > 1; }
    if (n % 2 === 0 || n % 3 === 0) { return false; }
    
    var sqr = Math.sqrt(n) | 0;

    for (var i = 5; i <= sqr; i += 6) {
        if (n % i === 0 || n % (i + 2) === 0) {
            return false;
        }
    }

    return true;
}

var buff = [];
var cursor = 0;
function buffPrint (n) {
    buff[cursor++] = n;

    if (cursor === 5000) {
        console.log(buff.join("\n"));
        cursor = 0;
    }
}
function buffFlush () {
    if (cursor) {
        buff.length = cursor;
        console.log(buff.join("\n"));
        cursor = 0;
    }
}


for (var i = 2; nprimes; i++) {
    if (isPrime(i)) {
        buffPrint(i);
        nprimes--;
    }
}

buffFlush();

