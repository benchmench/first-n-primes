/* Mono v6.10.0
 * $ mcs FirstNPrimes.cs
 *
 * $ time mono FirstNPrimes.exe 100000
 * real	0m0.257s
 * user	0m0.152s
 * sys	0m0.050s
 *
 * $ time mono FirstNPrimes.exe 1000000
 * real	0m4.864s
 * user	0m3.648s
 * sys	0m0.406s
 *
 * $ time mono FirstNPrimes.exe 1000000 > /dev/null
 * real	0m3.662s
 * user	0m3.629s
 * sys	0m0.023s
 *
 * $ time mono FirstNPrimes.exe 10000000 > /dev/null
 * real	1m50.669s
 * user	1m50.287s
 * sys	0m0.230s
 */

using System.Text;
using System;

class FirstNPrimes
{
	static void Main(string[] args)
	{
		StringBuilder sb = new StringBuilder();	
		int cnt = Int32.Parse(args[0]);

		for (int i = 2;; i++)
		{
			if (!IsPrime(i)) continue;
			sb.Append(i);
			sb.Append("\n");
			if (--cnt == 0) break;
		}

		Console.Write(sb.ToString());
	}

	static bool IsPrime(int num)
	{
		if (num < 4) return num > 1;
		if (num % 2 == 0 || num % 3 == 0) return false;

		int sqr = (int) Math.Sqrt(num);
		for (int i = 5; i <= sqr; i += 6)
		{
			if (num % i == 0 || num % (i + 2) == 0)
			{
				return false;
			}
		}

		return true;
	}
}
