//
//  BitSet.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/11.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "BitSet.h"

void setBitSet(int val, char *bitset) {
    int char_pos = val / 8;
    int bit_pos = val % 8;
    int temp = 1 << bit_pos;
    char *cur_char = &bitset[char_pos];
    *cur_char |= temp;
}

bool hasNumber(int val, char *bitset) {
    int char_pos = val / 8;
    int bit_pos = val % 8;
    int temp = 1 << bit_pos;
    char cur_char = bitset[char_pos];
    return temp &= cur_char;
}

void testBitSet() {
    char bitset[1024 * 1024 * 2];
    for (int i = 0; i < 10000000; i++) {
        int val = arc4random() % 9999999;
        setBitSet(val, bitset);
    }
    for (int i = 0; i < 10000000; i++) {
        if (hasNumber(i, bitset)) {
            printf("testBitSet: %d", i);
        }
    }
}

void setMultiBitSet(int val, char *bitset, int repeatCount) {
    int char_pos = val / 2;
    int bit_pos = val % 2;
    int temp = 1 <<  4 * bit_pos;
    char *cur_char = &bitset[char_pos];
    if (temp & *cur_char) {
        *cur_char = *cur_char + bit_pos * 15 + 1;
    }
    else {
        *cur_char |=  temp;
    }
}

void multiHasNumber(int val, char *bitset, int repeatCount) {
    int char_pos = val / 2;
    int bit_pos = val % 2;
    int rCount = 1;
    char cur_char = bitset[char_pos];
    if (bit_pos) {
        rCount = cur_char / 16;
    }
    else {
        rCount = cur_char % 16;
    }
    printf("rcount-----%d\n", rCount);
    while (rCount) {
        printf("multiHasNumber-----------%d\n", val);
        rCount --;
    }
}

/*
 * 使用位图需要耗费的内存大小计算
 * x是数据总大小
 * y是允许出现的最大重复
 * size = x / (1024 * 1024 * 8) * ceil(log 2 y) MB
 */

void testMultiBitSet() {
    char bitset[1024 * 1024 * 8];
    const int max = 100;
    const int repeat = 10;
    int array[] = {0,1,0,1,1,1,1,2,2,4,4,5};
    for (int i = 0; i < 12; i ++) {
        int val = arc4random() % max;
        setMultiBitSet(array[i], bitset, repeat);
    }
    for (int i = 0; i < 5; i ++) {
        multiHasNumber(i, bitset, repeat);
    }
}
