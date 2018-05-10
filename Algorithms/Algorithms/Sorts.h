//
//  Sorts.h
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/7.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^Compare)(NSNumber *e1, NSNumber *e2);
extern Compare descending;
extern Compare ascending;

void fastSorting(NSMutableArray <NSNumber *> *array, Compare compare);
void bubbleSort(NSMutableArray<NSNumber *> *array, Compare compare);
void insertionSort(NSMutableArray <NSNumber *> *array, Compare compare);
void selectSort(NSMutableArray <NSNumber *> *array, Compare compare);
void heapSort(NSMutableArray <NSNumber *> *array, Compare compare);
void mergeSort(NSMutableArray <NSNumber *> *array, Compare compare);
void radixSort(NSMutableArray <NSNumber *> *array, Compare compare);
void shellSort(NSMutableArray <NSNumber *> *array, Compare compare);

void testBubbleSort(void);
void testFastSort(void);
void testInsertionSort(void);
void testShellSort(void);
void testSelectSort(void);
void testHeapSort(void);
void testMergeSort(void);
void testRadixSort(void);

