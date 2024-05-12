BASE=/home/cpsughrue/llvm-project/build/bin

$BASE/clang -emit-llvm -S -O0 add_8bit.c -o add_8bit.ll

$BASE/opt -load-pass-plugin ./build/libHelloWorld.so -passes=hello-world,hello-world -f -disable-output add_8bit.ll
