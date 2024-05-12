BASE=/home/cpsughrue/llvm-project/build/bin

# must use -01 to keep additions 8-bit
$BASE/clang -emit-llvm -S -O1 add_8bit.c -o add_8bit.ll

# opt must be debug build to use `-debug`
$BASE/opt -debug -stats -load-pass-plugin build/libMBAAdd.so -passes=mba-add add_8bit.ll -S -o add_8bit_out.ll
