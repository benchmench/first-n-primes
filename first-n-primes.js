/* Nodejs v15.0.1
 *
 * $ time node first-n-primes.js 100000
 * real	0m0.335s
 * user	0m0.244s
 * sys	0m0.040s
 * 
 * $ time node first-n-primes.js 1000000
 * real	0m7.078s
 * user	0m5.677s
 * sys	0m0.417s
 *
 * $ time node first-n-primes.js 10000000 > /dev/null
 * real	2m59.557s
 * user	2m59.542s
 * sys	0m0.435s
 */

/* QuickJS version 2020-11-08
 * $ qjsc first-n-primes.js -flto -o fnp-qjs
 * 
 * $ time ./fnp-qjs 100000
 * real	0m1.125s
 * user	0m1.007s
 * sys	0m0.037s
 *
 * $ time ./fnp-qjs 100000 > /dev/null
 * real	0m1.036s
 * user	0m1.030s
 * sys	0m0.003s
 *
 * $ time ./fnp-qjs 1000000 > /dev/null
 * real	0m30.124s
 * user	0m30.081s
 * sys	0m0.007s
 */

/* GJS v1.66.1
 *
 * $ time gjs first-n-primes.js 100000
 * real	0m0.600s
 * user	0m0.528s
 * sys	0m0.049s
 *
 * $ time gjs first-n-primes.js 1000000
 * real	0m11.056s
 * user	0m9.514s
 * sys	0m0.439s
 *
 * $ time gjs first-n-primes.js 1000000 > /dev/null
 * real	0m9.836s
 * user	0m9.499s
 * sys	0m0.097s
 */

main();

function main () {
    var nprimes = parseArg();
    var primes = createArray(nprimes);

    for (var found = 0, i = 5; found < nprimes; i++) {
        if (isPrime(i)) {
            primes[found++] = i;
        }
    }

    var log = loggerFunction();
    log(primes.join('\n'));    
}

function loggerFunction () {
    // Node.js:
    if (typeof process === 'object'
        && process.stdout
        && process.stdout.write) {
        return process.stdout.write.bind(process.stdout);
    }

    // QuickJS:
    if (typeof std === 'object'
        && std.out
        && std.out.puts) {
        return std.out.puts.bind(std.out);
    }

    // GJS:
    if (typeof print === 'function') {
        return print;
    }

    // Anywhere else that supports console.log:
    if (typeof console === 'object'
        && console.log) {
        return console.log.bind(console);
    }

    // Fallback to noop :)
    return function noop () {};
}

function parseArg () {
    // Node.js:
    if (typeof process === 'object'
        && Array.isArray(process.argv)) {
        return process.argv[2] | 0;
    }

    // QuickJS:
    if (typeof scriptArgs === 'object'
        && Array.isArray(scriptArgs)) {
        return scriptArgs[1] | 0;
    }

    // GJS
    if (typeof ARGV === 'object'
        && Array.isArray(ARGV)) {
        return ARGV[0] | 0;
    }

    // Use 1000,000 as default big-enough argument!
    return 1000000;
}

function createArray (len) {
    return typeof Int32Array === 'function' ? new Int32Array(len) : Array(len);
}

function isPrime (n) {
    //if (n < 4) { return n > 1; }
    if (n % 2 === 0 || n % 3 === 0) { return false; }

    const sqr = Math.sqrt(n) | 0;
    for (let i = 5; i <= sqr; i += 6) {
        if (n % i === 0 || n % (i + 2) === 0) {
            return false;
        }
    }

    return true;
}
