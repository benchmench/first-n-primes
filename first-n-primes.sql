-- SQLite v3.33.0
--
-- $ time sh -c 'cat first-n-primes.sql | sed "s/\/\*\*\/1\/\*\*\//$1/g" | sqlite3' -- 1000
-- real	0m0.045s
-- user	0m0.047s
-- sys	0m0.003s
--
-- $ time sh -c 'cat first-n-primes.sql | sed "s/\/\*\*\/1\/\*\*\//$1/g" | sqlite3' -- 10000
-- real	0m0.967s
-- user	0m0.947s
-- sys	0m0.007s
--
-- $ time sh -c 'cat first-n-primes.sql | sed "s/\/\*\*\/1\/\*\*\//$1/g" | sqlite3' -- 100000
-- real	0m31.652s
-- user	0m31.481s
-- sys	0m0.042s
--
-- $ time sh -c 'cat first-n-primes.sql | sed "s/\/\*\*\/1\/\*\*\//$1/g" | sqlite3' -- 100000 > /dev/null
-- real	0m31.733s
-- user	0m31.475s
-- sys	0m0.024s

WITH RECURSIVE
odds (o) AS (
  SELECT 3 UNION ALL
  SELECT o + 2 FROM odds
),

probable_primes (pp, is_prime) AS (
  SELECT 2, TRUE UNION ALL
  SELECT 3, TRUE UNION ALL
  SELECT
    o1.o,
    (SELECT
       o1.o < o2.o * o2.o
     FROM odds AS o2
       WHERE o1.o < o2.o * o2.o OR NOT o1.o % o2.o
       LIMIT 1)
  FROM odds AS o1
    WHERE o1.o % 3
),

primes (p) AS (
  SELECT pp AS p FROM probable_primes WHERE is_prime
)

--SELECT p FROM primes LIMIT /**/1/**/;
SELECT GROUP_CONCAT(p, CHAR(10)) FROM (SELECT p FROM primes LIMIT /**/1/**/);
