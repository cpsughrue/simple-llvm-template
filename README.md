#### Based on 2019 LLVM Developers’ Meeting: A. Warzynski “Writing an LLVM Pass: 101”

#### Notes
* `HelloWorld.cpp` is a analysis pass which prints the name of a function and its number of arguments
* `MBAAdd.cpp` is a tranformation pass which modifies `a + b` to `(((a ^ b) + 2 * (a & b)) * 39 + 23) * 151 + 111`
  * `a + b` is only transformed if `a` and `b` are of size `uint8_t` 


#### Build
```
cmake -S . -B build
cd build
make
```

#### Run Tests
```
llvm-lit build/test -vv
```
