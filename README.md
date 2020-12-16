# First N Primes

An amateur testing of different languages calculating First N Prime numbers

## Results

<center>

|Languages/Compiler</br>Transpiler/Version|1000|10000|100000|1000000|10000000|
|:--------|:--------:|:--------:|:--------:|:--------:|--------:|
|Python v3.8.6||**0m0.105s**|0m2.543s</br>0m2.492s[*](#Note)|1m24.183s[*](#Note)||
|bc v1.07.1||0m1.074s</br>0m1.059s[*](#Note)|0m31.413s[*](#Note)|||
|Bash - bash v5.0.18|0m0.560s</br>**0m0.559s[*](#Note)**|0m6.848s</br>0m6.862s[*](#Note)|1m36.289s[*](#Note)|||
|NectarJS v0.7.108|||0m0.949s|0m25.448s</br>0m24.228s[*](#Note)||
|C - GCC v10.2.0|||**0m0.178s**|0m4.335s|1m54.527s</br>1m43.337s[*](#Note)|
|C - Clang v11.0.0||||0m5.255s</br>**0m4.178s[*](#Note)**|2m16.067s[*](#Note)|
|JS - Nodejs v15.0.1|||0m0.335s|0m7.078s|2m59.557s[*](#Note)|
|JS - QuickJS v2020-11-08|||0m1.125s</br>0m1.036s[*](#Note)|0m30.124s[*](#Note)||
|JS - GJS v1.66.1|||0m0.600s|0m11.056s</br>0m9.836s[*](#Note)||
|Lisp - SBCL v2.0.10|||0m0.771s|0m23.121s</br>0m21.864s[*](#Note)||
|Php v7.14.13||0m0.241s|0m7.288s</br>0m7.148s[*](#Note)|||
|C# - Mono v6.10.0|||0m0.257s|0m4.864s</br>0m3.662s[*](#Note)|1m50.669s[*](#Note)|
|Java - OpenJDK v11.0.8|||0m0.329s|0m4.694s|1m51.349s[*](#Note)|
|Java - Eclipse OpenJ9 (OpenJDK v1.8.0_275)|||0m0.352s|0m4.397s|**1m34.567s[*](#Note)**|

</center>

### Note

 * \* Means that the output is redirected to /dev/null (```command > /dev/null```)
 * Bold items are the best results