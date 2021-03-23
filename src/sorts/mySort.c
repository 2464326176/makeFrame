#include <stdio.h>
#include "mySort.h"

void my_swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

void bubble_sort(int arr[], int len)
{
    int j = len - 1, i = 0, flag = 0;
    for (; j >= 0; --j)
    {
        for (i = 0; i < j; ++i)
        {
            if (arr[i] > arr[i + 1])
            {
                flag = 1;
                my_swap(&arr[i], &arr[i + 1]);
            }
        }
        if (!flag)
        {
            return;
        }
    }
}

void quick_sort(int arr[], int low, int high)
{
    int i = low, j = high;
    int tmp;

    if (low < high)
    {
        tmp = arr[i];
        while (i < j)
        {
            while (i < j && arr[j] >= tmp)
            {
                --j;
            }

            if (i < j)
            {
                arr[i] = arr[j];
                ++i;
            }

            while (i < j && arr[i] <= tmp)
            {
                ++i;
            }

            if (i < j)
            {
                arr[j] = arr[i];
                --j;
            }
        }

        arr[i] = tmp;
        quick_sort(arr, low, i - 1);
        quick_sort(arr, i + 1, high);
    }
}

void select_sort(int arr[], int len)
{
    int i, j, tmp;
    for (i = 0; i < len; ++i)
    {
        int k = i;
        for (j = i + 1; j < len; ++j)
        {
            if (arr[k] > arr[j])
            {
                k = j;
            }
        }
        if (k != i)
        {
            tmp = arr[i];
            arr[i] = arr[k];
            arr[k] = tmp;
        }
    }
}

void insert_sort(int arr[], int len)
{
    int i, j, tmp;
    for (i = 1; i < len; ++i)
    {
        tmp = arr[i];
        for (j = i; j > 0 && tmp < arr[j - 1]; --j)
        {
            arr[j] = arr[j - 1];
        }
        arr[j] = tmp;
    }
}

void for_echo(int arr[], int len)
{
    for (int i = 0; i < len; ++i)
    {
        printf("%d ", arr[i]);
    }
}

int main()
{
    int a[] = {3, 4, 2, 1};
    insert_sort(a, 4);
    for_echo(a, 4);
    return 0;
}