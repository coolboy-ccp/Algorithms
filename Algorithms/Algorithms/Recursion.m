//
//  Recursion.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/4.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "Recursion.h"

//n!
int factorial(int n) {
    if (n == 0) {
        return 1;
    }
    return n * factorial(n - 1);
}

//Fibonacci series
int fibonacci(int n) {
    if (n < 2) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int fibonacci_tail(int n, int ret1, int ret2) {
    if (n == 0) {
        return ret1;
    }
    return fibonacci_tail(n-1, ret2, ret2 + ret1);
}

int fibonacci_while(int n) {
    int num1 = 1;
    int num2 = 1;
    int num3 = 1;
    while (n > 2) {
        num3 = num1 + num2;
        num1 = num2;
        num2 = num3;
        n--;
    }
    return num3;
}

//hanoi
void hanoi(int n, char p1, char p2, char p3, int *sum) {
    if (n == 1) {
        printf("圆盘%d从%c移动到%c\n",n,p1,p3);
        *sum += 1;
        printf("总共移动了%d\n次",*sum);
    }
    else {
        hanoi(n-1, p1, p3, p2, sum);
        printf("圆盘%d从%c移动到%c\n",n,p1,p3);
        *sum += 1;
        hanoi(n-1, p2, p1, p3, sum);
    }
}

void testHanoi() {
    int a = 0;
    hanoi(5, 'A', 'B', 'C', &a);
}

void testFibonacci_while() {
    printf("Fibonacci_while：%d\n",fibonacci_while(10));
}

void testFibonacci_tail() {
    printf("Fibonacci_tail：%d\n",fibonacci_tail(10, 0, 1));
}

void testFibonacci() {
    printf("Fibonacci：%d\n",fibonacci(10));
}

void testFactorial() {
    printf("factorial:%d\n",factorial(10));
}
