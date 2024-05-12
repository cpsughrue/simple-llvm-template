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
