#include <stdio.h>
#include "mymath.h"
int my_add(int a, int b)
{
    return a + b;
}

int my_sub(int a, int b)
{
    return a - b;
}

int my_mul(int a, int b)
{
    return a * b;
}

int my_div(int a, int b)
{
    if (b == 0)
    {
        printf("error param");
        return -1;
    }
    return a / b;
}