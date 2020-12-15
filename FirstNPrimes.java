/* OpenJDK v11.0.8 (2020-07-14)
 * $ javac FirstNPrimes.java
 *
 * $ time java FirstNPrimes 100000
 * real	0m0.329s
 * user	0m0.375s
 * sys	0m0.074s
 *
 * $ time java FirstNPrimes 1000000
 * real	0m4.694s
 * user	0m3.708s
 * sys	0m0.365s
 *
 * $ time java FirstNPrimes 10000000 > /dev/null
 * real	1m51.349s
 * user	1m50.483s
 * sys	0m0.299s
 */

/* Eclipse OpenJ9 (OpenJDK v1.8.0_275)
 * $ javac FirstNPrimes.java
 *
 * $ time java FirstNPrimes 100000
 * real	0m0.352s
 * user	0m0.336s
 * sys	0m0.066s
 *
 * $ time java FirstNPrimes 1000000
 * real	0m4.397s
 * user	0m3.635s
 * sys	0m0.387s
 *
 * $ time java FirstNPrimes 10000000 > /dev/null
 * real	1m34.567s
 * user	1m34.814s
 * sys	0m0.197s
 */

public final class FirstNPrimes {
  
  private FirstNPrimes() { }

  public static void main (String[] args) {
    StringBuilder sb = new StringBuilder();
    int cnt = parseArg(args);

    if (--cnt >= 0) { sb.append("2\n"); }
    if (--cnt >= 0) { sb.append("3\n"); }
    if (cnt <= 0) {
      System.out.print(sb);
      return;
    }

    for (int i = 5;; i += 6) {
      if (isPrime(i)) {
        sb.append(i).append('\n');
        if (--cnt == 0) { break; }
      }

      if (isPrime(i + 2)) {
        sb.append(i + 2).append('\n');
        if (--cnt == 0) { break; }
      }
    }
    
    System.out.print(sb);
  }
  
  private static boolean isPrime (int num) {
    if (num < 4) { return num > 1; }
    if (num % 2 == 0 || num % 3 == 0) { return false; }

    int sqr = (int) Math.sqrt(num);

    for (int i = 5; i <= sqr; i += 6) {
      if (num % i == 0 || num % (i + 2) == 0) {
        return false;
      }
    }

    return true;
  }

  private static int parseArg (String[] args) {
    if (args.length == 0) { usage(); }

    try {
      return Integer.parseInt(args[0]);
    } catch (NumberFormatException __) {}

    usage();
    return -1;
  }

  private static void usage () {
    System.out.println("Usage: java FirstNPrimes [N]");
    System.exit(1);
  }
}
