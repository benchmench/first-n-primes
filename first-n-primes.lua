-- Lua v5.4.1
--
-- $ time lua first-n-primes.lua 10000
-- real	0m0.061s
-- user	0m0.053s
-- sys	0m0.007s
--
-- $ time lua first-n-primes.lua 100000
-- real	0m1.275s
-- user	0m1.242s
-- sys	0m0.031s
--
-- $ time lua first-n-primes.lua 1000000
-- real	0m36.486s
-- user	0m36.072s
-- sys	0m0.337s

-- LuaJIT v5.4.1
--
-- $ time luajit first-n-primes.lua 10000
-- real	0m0.031s
-- user	0m0.013s
-- sys	0m0.011s
--
-- $ time luajit first-n-primes.lua 100000
-- real	0m0.302s
-- user	0m0.235s
-- sys	0m0.044s
--
-- $ time luajit first-n-primes.lua 1000000
-- real	0m6.257s
-- user	0m5.882s
-- sys	0m0.343s
-- 
-- $ time luajit first-n-primes.lua 10000000 > /dev/null
-- real	2m54.039s
-- user	2m53.819s
-- sys	0m0.017s

function is_prime (n)
   if n < 4 then return n > 1 end
   if n % 2 == 0 or n % 3 == 0 then return false end

   local sqr = math.floor(math.sqrt(n))
   
   for i = 5, sqr, 6 do
      if n % i == 0 or n % (i + 2) == 0 then return false end
   end

   return true
end

buff = {}
buff_cursor = 1
function buff_print (str)
   buff[buff_cursor] = str
   buff_cursor = buff_cursor + 1

   if buff_cursor == 10000 then
      print(table.concat(buff, '\n'))
      buff_cursor = 1
   end
end

function buff_flush ()
   if buff_cursor == 1 then return end

   for i = 1, buff_cursor - 1 do
      print(buff[i])
   end
   
   buff_cursor = 1
end

function disp_first_n_primes (cnt)
   local i = 2
   while true do
      if is_prime(i) then
         -- print(i)
         buff_print(i)
         cnt = cnt - 1
         if cnt == 0 then break end
      end
      i = i + 1
   end
   buff_flush()
end

disp_first_n_primes(arg[1] + 0)
