#include <stdio.h>
#include "./math/mymath.h"
int main()
{
    int a = 4, b = 2;
    printf("a + b = %d", my_add(a, b));
    printf("a - b = %d", my_sub(a, b));
    printf("a * b = %d", my_mul(a, b));
    printf("a / b = %d", my_div(a, b));

    return 0;
}