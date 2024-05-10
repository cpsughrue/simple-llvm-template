/opt/llvm-project/build/bin/clang -emit-llvm -S -O0 add.c -o add.ll

/opt/llvm-project/build/bin/opt -load-pass-plugin ./build/libHelloWorld.so -passes=hello-world,hello-world -f -disable-output add.ll

