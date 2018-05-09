//
//  Sorts.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/7.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "Sorts.h"

typedef BOOL (^Compare)(NSNumber *e1, NSNumber *e2);

Compare descending = ^BOOL(NSNumber *e1, NSNumber *e2) {
    return [e1 intValue] < [e2 intValue];
};

Compare ascending = ^BOOL(NSNumber *e1, NSNumber *e2) {
    return [e2 intValue] < [e1 intValue];
};


//效率O(n^2) 空间（1）
void bubbleSort(NSMutableArray<NSNumber *> *array, Compare compare) {
    NSNumber *temp;
    BOOL hasChange = false;
    for (int i = 0; i < array.count - 1; i ++) {
        hasChange = false;
        for (int j = 0; j < array.count - 1 - i; j ++) {
            if (compare(array[j],array[j + 1])) {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
                hasChange = true;
            }
        }
      //使用下面循环时，compare的算法与上方循环相反
//        for (int j = (int)array.count - 1; j > i; j --) {
//            if (compare(array[j], array[j - 1])) {
//                temp = array[j];
//                array[j] = array[j - 1];
//                array[j - 1] = temp;
//                hasChange = true;
//            }
//        }
        if (!hasChange) {
            break;
        }
    }
}

//效率O(nlog n)  空间O(n)
void fastSort(NSMutableArray<NSNumber *> *array, NSInteger leftIdx, NSInteger rightIdx, Compare compare) {
    if (leftIdx < rightIdx) {
        NSInteger left = leftIdx;
        NSInteger right = rightIdx;
        NSNumber *base = array[left];
        while (left < right) {
            while (left < right && compare(array[right],base)) {
                right--;
            }
            array[left] = array[right];
            while (left < right && compare(base, array[left])) {
                left++;
            }
            array[right] = array[left];
        }
        array[left] = base;
        fastSort(array, leftIdx, left - 1, compare);
        fastSort(array, left + 1, rightIdx, compare);
    }
    
}

//效率O(n^2) 空间O(1)
void insertionSort(NSMutableArray <NSNumber *> *array, Compare compare) {
    for (int i = 1; i < array.count; i ++) {
        NSNumber *temp = array[i];
        int j = 0;
        for (j = i - 1; j >= 0 && compare(array[j], temp); j --) {
            array[j + 1] = array[j];
        }
        array[j + 1] = temp;
    }
}

//效率O(n^1.5) 空间O(1)
void shellSort(NSMutableArray <NSNumber *> *array, Compare compare) {
    NSInteger gap = array.count / 2;
    while (gap >= 1) {
        for (NSInteger i = gap; i < array.count; i++) {
            NSInteger j = 0;
            NSNumber *temp = array[i];
            for (j = i - gap; j >= 0 && compare(array[j], temp); j = j - gap) {
                array[j + gap] = array[j];
            }
            array[j + gap] = temp;
        }
        gap = gap / 2;
    }
}

//效率O(n^2) 空间O(1)
void selectSort(NSMutableArray <NSNumber *> *array, Compare compare) {
    for (int i = 0; i < array.count - 1; i++) {
        NSNumber *temp;
        int minIdx = i;
        for (int j = i + 1; j < array.count; j ++) {
            if (compare(array[minIdx], array[j])) {
                minIdx = j;
            }
        }
        temp = array[minIdx];
        array[minIdx] = array[i];
        array[i] = temp;
    }
    
}

void toHeap(NSMutableArray <NSNumber *> *array, NSInteger length, NSInteger parent, Compare compare) {
    NSNumber *temp = array[parent];
    NSInteger left = 2 * parent + 1;
    while (left < length) {
        if (left + 1 < length && compare(array[left + 1], array[left])) {
            left++;
        }
        if (compare(temp, array[left])) {
            break;
        }
        array[parent] = array[left];
        parent = left;
        left = 2 * parent + 1;
    }
    array[parent] = temp;
}

//效率O(nlog n) 空间O(1) O(n + klog2n),获取第k个元素之前部分的排序，若k<= n/log2n,则时间复杂度为O(n)
void heapSort(NSMutableArray <NSNumber *> *array, Compare compare) {
    for (NSInteger i = (array.count - 1) / 2; i >= 0; i--) {
        toHeap(array, array.count, i, compare);
    }
    for (NSInteger i = array.count - 1; i > 0; i --) {
        NSNumber *temp = array[i];
        array[i] = array[0];
        array[0] = temp;
        toHeap(array, i, 0, compare);
    }
}

void merge(NSMutableArray <NSNumber *> *array, NSInteger low, NSInteger mid, NSInteger high, Compare compare) {
    NSInteger i = low;
    NSInteger j = mid + 1;
    NSInteger k = 0;
    NSMutableArray <NSNumber *> *tempArray = [NSMutableArray array];
    while (i <= mid && j <= high) {
        if (compare(array[j], array[i])) {
            tempArray[k] = array[i];
            i ++;
            k ++;
        }
        else {
            tempArray[k] = array[j];
            j ++;
            k ++;
        }
    }
    while (i <= mid) {
        tempArray[k] = array[i];
        i ++;
        k ++;
    }
    while (j <= high) {
        tempArray[k] = array[j];
        j ++;
        k ++;
    }
    
    for (k = 0, i = low; i <= high; k++, i++) {
        array[i] = tempArray[k];
    }
}

//O(nlog 2n)  空间：O(n)
void mergeSort(NSMutableArray <NSNumber *> *array, Compare compare) {
    for (int gap = 1; gap < array.count; gap = 2 * gap) {
        NSInteger i = 0;
        for (i = 0; i + 2 * gap - 1 < array.count; i = i + 2 * gap) {
            merge(array, i, i + gap - 1, i + 2 * gap - 1, compare);
        }
        if (i + gap - 1 < array.count) {
            merge(array, i, i + gap - 1, array.count - 1, compare);
        }
    }
    
}

int digit(NSNumber *element, int d, Compare compare) {
    int a = [element intValue];
    int base = 1;
    d = d - 1;
    while (d > 0) {
        base = 10 * base;
        d--;
    }
    return abs(compare(@(1), @(2)) * 9 -  (a / base % 10));
}

//
void radixSort(NSMutableArray <NSNumber *> *array, Compare compare) {
    //获取数组中最大数的位数
    int max = [[array valueForKeyPath:@"@max.intValue"] intValue];
    int count = 1;
    while (max / 10) {
        count ++;
        max = max / 10;
    }
    
    int radix = 10;
    int i, j = 0;
    int counts[radix];
    NSMutableArray <NSNumber *> *buckets = [NSMutableArray arrayWithArray:array.copy];
    for (int d = 1; d <= count; d++) {
        for (int i = 0; i < radix; i++) {
            counts[i] = 0;
        }
        for (i = 0; i < array.count; i ++) {
            j = digit(array[i], d, compare);
            counts[j] ++;
        }
        
        for (i = 1; i < radix; i ++) {
            counts[i] = counts[i] + counts[i - 1];
        }
        for (i = (int)array.count - 1; i >= 0 ; i --) {
            j = digit(array[i], d, compare);
            buckets[counts[j] - 1] = array[i];
            counts[j]--;
        }
        for (i = 0, j = 0; i < array.count; i++, j++) {
            array[i] = buckets[j];
        }
    }
    
}

void testBubbleSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    bubbleSort(array, ascending);
     NSLog(@"testBubbleSort-ascending: %@", array);
    bubbleSort(array, descending);
    NSLog(@"testBubbleSort-descending: %@", array);
}

void testFastSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    fastSort(array, 0, array.count - 1, ascending);
    NSLog(@"testFastSort-ascending: %@", array);
    fastSort(array, 0, array.count - 1, descending);
    NSLog(@"testFastSort-descending: %@", array);
}

void testInsertionSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    insertionSort(array, ascending);
    NSLog(@"testInsertionSort-ascending: %@", array);
    insertionSort(array, descending);
    NSLog(@"testInsertionSort-descending: %@", array);
}

void testShellSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    shellSort(array, ascending);
    NSLog(@"testShellSort-ascending: %@", array);
    shellSort(array, descending);
    NSLog(@"testShellSort-descending: %@", array);
}

void testSelectSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    selectSort(array, ascending);
    NSLog(@"testSelectSort-ascending: %@", array);
    selectSort(array, descending);
    NSLog(@"testSelectSort-descending: %@", array);
}

void testHeapSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    heapSort(array, ascending);
    NSLog(@"testHeapSort-ascending: %@", array);
    heapSort(array, descending);
    NSLog(@"testHeapSort-descending: %@", array);
}

void testMergeSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    mergeSort(array, ascending);
    NSLog(@"testMergeSort-ascending: %@", array);
    mergeSort(array, descending);
    NSLog(@"testMergeSort-descending: %@", array);
}

void testRadixSort() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    radixSort(array, ascending);
    NSLog(@"testRadixSort-ascending: %@", array);
    radixSort(array, descending);
    NSLog(@"testRadixSort-descending: %@", array);
}
