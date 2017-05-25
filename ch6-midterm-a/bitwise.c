#include <stdio.h>
#include <stdlib.h>

int main () {
    printf("2 & 1 = %d\n", (2 & 1));
    printf("2 | 1 = %d\n", (2 | 1));
    printf("2 ^ 3 = %d\n", (2 ^ 3));
    printf("~ 2 = %d\n", (2 ^ 31)); // (5bits) 11111 = 31
    printf("1 << 3 = %d\n", (1 << 3));
    printf("15 >> 3 = %d\n", (15 >> 3));

    printf("3 & 2 | 1 = %d\n", (3 & 2) | 1);
    printf("~ 1 = %d\n", ~ 1);
    return 0;
}