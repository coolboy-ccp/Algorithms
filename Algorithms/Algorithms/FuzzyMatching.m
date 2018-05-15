//
//  FuzzyMatching.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/14.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "FuzzyMatching.h"
/*
 * brute force,BF算法，蛮力算法
 * 从目标字符串T的第一个字符串与模式串P的第一个字符比较
   若相等，则继续对字符串进行后续比较，否则，从T的第二个字符开始与P的第一个字符串比较
   直到P中的每个字符和T中的一个连续的字符序列相等为止，此时匹配成功
 * 时间复杂度O(mn)
 */


/*
 * Knuth-Morris-Pratt,KMP算法
 * 利用已知的信息，跳过前面已经比较过的位置，继续向后移动，以提高效率
 * 要点：
   计算跳转位置信息，获得部分匹配表
   后移到指定位置，重新开始匹配
 */

/*
           | Max(k):P(0 ... k-1) == P(j - k ... j-1) 0 < k < j
 next[j] = | -1                                      j = 0
           | 0                                       other
 
 */
int *getNext(NSString *pStr) {
    const char *cp = [pStr UTF8String];
    int count = (int)strlen(cp);
    int *next = malloc(sizeof(int) * count);
    int j = 0, k = -1;
    next[0] = k;
    while (j < count - 1) {
        if (k == -1 || cp[k] == cp[j]) {
            j ++;
            k ++;
            next[j] = k;
            printf("%d:%d\n",j,next[j]);
        }
        else {
            k = next[k];
        }
    }
    return next;
}

int KMPMatch(NSString *target, NSString *pattern) {
    int i = 0, j = 0, idx = -1;
    int *next = getNext(pattern);
    const char *cT = [target UTF8String];
    const char *cP = [pattern UTF8String];
    while (i < (int)target.length && j < (int)pattern.length) {
        if (j == -1 || cT[i] == cP[j]) {
            i ++;
            j ++;
        }
        else {
            j = next[j];
        }
    }
    if (j >= pattern.length) {
        idx = i - (int)pattern.length;
    }
    return idx;
}

/*
 * Boyer-Moore,BM算法
 eg.
 target: here is a simple example
 pattern: example
 1. target头部和pattern头部对齐，从尾部开始比较
 2.s, e不匹配，s被称为bad character(坏字符)
 3.pattern不包含s，将pattern直接移动到s的后一位
 4.继续从尾部开始比较，p, e不匹配，p是 bad charater
 5.pattern后移两位，p对齐
 坏字符规则：后移位数 = 坏字符位置 - 搜索词中上一次出现的位置，如果pattern不包含坏字符，上一次出现的位置为-1
 6.继续后移，mple匹配，所有尾部匹配的字符串，称为good suffix(好后缀)(mple, ple,le,e)
 好后缀规则：后移位数 = 好后缀位置 - 搜索词中上一次出现的位置。好后缀的位置以最后一个后缀为准，若上一次没有出现，则搜索词中上一次出现的位置为-1
 7.后移位置 = MAX(坏字符， 好后缀)
 
 */

#define ALPHABET_LEN 256
#define NOT_FOUND patlen
#define max(a, b) ((a < b) ? b : a)

void make_delta1(int *delta1, uint8_t *pat, int32_t patlen) {
    int i;
    for (i=0; i < ALPHABET_LEN; i++) {
        delta1[i] = NOT_FOUND;
    }
    for (i=0; i < patlen-1; i++) {
        delta1[pat[i]] = patlen-1 - i;
    }
}

int is_prefix(uint8_t *word, int wordlen, int pos) {
    int i;
    int suffixlen = wordlen - pos;
    // could also use the strncmp() library function here
    for (i = 0; i < suffixlen; i++) {
        if (word[i] != word[pos+i]) {
            return 0;
        }
    }
    return 1;
}

int suffix_length(uint8_t *word, int wordlen, int pos) {
    int i;
    for (i = 0; (word[pos-i] == word[wordlen-1-i]) && (i < pos); i++);
    return i;
}
void make_delta2(int *delta2, uint8_t *pat, int32_t patlen) {
    int p;
    int last_prefix_index = patlen-1;
    
    // first loop
    for (p=patlen-1; p>=0; p--) {
        if (is_prefix(pat, patlen, p+1)) {
            last_prefix_index = p+1;
        }
        delta2[p] = last_prefix_index + (patlen-1 - p);
    }
    
    // second loop
    for (p=0; p < patlen-1; p++) {
        int slen = suffix_length(pat, patlen, p);
        if (pat[p - slen] != pat[patlen-1 - slen]) {
            delta2[patlen-1 - slen] = patlen-1 - p + slen;
        }
    }
}

uint8_t* boyer_moore (uint8_t *string, uint32_t stringlen, uint8_t *pat, uint32_t patlen) {
    int i;
    int delta1[ALPHABET_LEN];
    int *delta2 = (int *)malloc(patlen * sizeof(int));
    make_delta1(delta1, pat, patlen);
    make_delta2(delta2, pat, patlen);
    
    // The empty pattern must be considered specially
    if (patlen == 0) {
        free(delta2);
        return string;
    }
    
    i = patlen-1;
    while (i < stringlen) {
        int j = patlen-1;
        while (j >= 0 && (string[i] == pat[j])) {
            --i;
            --j;
        }
        if (j < 0) {
            free(delta2);
            return (string + i+1);
        }
        
        i += max(delta1[string[i]], delta2[j]);
    }
    free(delta2);
    return NULL;
}


void testKMFMatch() {
    NSString *target = @"abcjabcdabckabcmabclabckkjjjfffabcmmabclisooabcll";
    NSString *pattern = @"abcll";
    int idx = KMPMatch(target, pattern);
    printf("testKMFMatch: %d\n",idx);
}

void testGetNext() {
    NSString *str = @"abcdabcl";
    int *arr = getNext(str);
    for (int i = 0; i < str.length; i ++) {
        printf("testGetNext: %d\n",arr[i]);
    }
}


