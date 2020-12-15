#!/usr/bin/env bash

# bash v5.0.18(1)-release
#
# $ time ./first-n-primes.sh 1000
# real	0m0.560s
# user	0m0.412s
# sys	0m0.182s
#
# $ time ./first-n-primes.sh 1000 > /dev/null
# real	0m0.559s
# user	0m0.429s
# sys	0m0.167s
#
# $ time ./first-n-primes.sh 10000
# real	0m6.848s
# user	0m5.069s
# sys	0m2.150s
#
# $ time ./first-n-primes.sh 10000 > /dev/null
# real	0m6.862s
# user	0m5.087s
# sys	0m2.109s
#
# $ time ./first-n-primes.sh 100000 > /dev/null
# real	1m36.289s
# user	1m14.251s
# sys	0m26.270s

function is_prime ()
{
    local N=$1

    [ $N -lt 2 ] && return
    [ $N -lt 4 ] && echo 1 && return
    [ $((N % 2)) -eq 0 ] && return
    [ $((N % 3)) -eq 0 ] && return

    for ((i = 5; i * i <= N; i += 6)); do
        [ 0 -eq $((N % i)) ] && return
        [ 0 -eq $((N % (i + 2))) ] && return
    done

    echo 1
}

function disp_first_primes ()
{
    local cnt=$1

    [ $cnt -ge 1 ] && let cnt-- && echo 2
    [ $cnt -ge 1 ] && let cnt-- && echo 3
    [ $cnt -le 0 ] && return

    for ((i = 5;; i += 6)); do
        if [ -n $(is_prime $i) ]; then
            echo $i
            let cnt--
            [ 0 -eq $cnt ] && return
        fi

        if [ -n $(is_prime $((i + 2))) ]; then
            echo $((i + 2))
            let cnt--
            [ 0 -eq $cnt ] && return
        fi
    done
}

function main ()
{
    local cnt="$1"

    [ -z "$cnt" ] && return
    [[ "$cnt" =~ ^[0-9]+$ ]] || return
    [ $cnt -le 0 ] && return

    echo "$(disp_first_primes $1)"
}

main "$1"


