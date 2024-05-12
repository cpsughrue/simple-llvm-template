// RUN: rm -rf %t
// RUN: split-file %s %t

//--- add_8bit.c
#include <stdint.h>
#include <stdlib.h>

int8_t foo(int8_t a, int8_t b, int8_t c, int8_t d) {
    int8_t e = a + b;
    int8_t f = c + d;

    return e + f;
}

int main(int argc, char *argv[]) {

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    int c = atoi(argv[3]);
    int d = atoi(argv[4]);

    int8_t ret = foo(a, b, c, d);
    return ret;
}

// RUN: clang -emit-llvm -S -O1 %t/add_8bit.c -o %t/add_8bit.ll
// RUN: opt -load-pass-plugin %shlibdir/libHelloWorld%shlibext -passes=hello-world,hello-world -f -disable-output %t/add_8bit.ll

// CHECK: Visiting: foo (takes 4 args)
// CHECK-NEXT: Visiting: foo (takes 4 args)
// CHECK-NEXT: Visiting: main (takes 2 args)
// CHECK-NEXT: Visiting: main (takes 2 args)
