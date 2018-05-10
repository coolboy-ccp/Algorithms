//
//  SearchLinearList.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/10.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "SearchLinearList.h"

@interface BlockIndex: NSObject
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, assign) NSInteger start;
@end
@implementation BlockIndex
@end

typedef NSArray <BlockIndex *> * BlockIndexs;

int orderSearch(NSMutableArray <NSNumber *> *array, NSNumber *element) {
    for (int i = 0; i < array.count; i ++) {
        if (element == array[i]) {
            return i;
        }
    }
    return -1;
}

int binarySearch(NSMutableArray <NSNumber *> *array, NSNumber *element, Compare compare) {
    NSInteger low = 0;
    NSInteger mid = 0;
    NSInteger high = array.count - 1;
    while (low <= high) {
        mid = (low + high) / 2;
        if (array[mid] == element) {
            return (int)mid;
        }
        else if (compare(array[mid], element)) {
            low = mid + 1;
        }
        else {
            high = mid - 1;
        }
    }
    return -1;
}


BlockIndexs createIndex(NSMutableArray <NSNumber *> *array, int gap) {
    int i = 0, j = 0;
    NSNumber *max = 0;
    NSInteger num = array.count / gap;
    NSMutableArray <BlockIndex *> *indexs = [NSMutableArray arrayWithCapacity:num];
    for (int y = 0; y < num; y ++) {
        [indexs addObject:[BlockIndex new]];
    }
    while (i < num) {
        j = 0;
        indexs[i].start = gap * i;
        while (j < gap) {
            if (max < array[gap * i + j]) {
                max = array[gap * i + j];
            }
            j ++;
        }
        indexs[i].maxValue = max;
        i ++;
    }
    return indexs.copy;
}

int blockSearch(NSMutableArray <NSNumber *> *array, NSNumber *element, int gap) {
    BlockIndexs indexs = [NSMutableArray arrayWithArray:createIndex(array, gap)];
    int low = 0, mid = 0, high = (int)indexs.count - 1;
    while (low <= high) {
        mid = (low + high) / 2;
        if (indexs[mid].maxValue > element) {
            high = mid - 1;
        }
        else {
            low = mid + 1;
        }
    }
    if (low < array.count - 1) {
        for (int i = (int)indexs[low].start; i < indexs[low].start + gap; i++) {
            if (array[i] == element) {
                return i;
            }
        }
    }
    return -1;
}

void testOrderSearch() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    int idx = orderSearch(array, @(999));
    NSLog(@"testOrderSearch-%d", idx);
}

void testBinarySearch() {
    NSMutableArray *array = @[@(6), @(100), @(8), @(19), @(1), @(999), @(2), @(7)].mutableCopy;
    shellSort(array, descending);
    int idx = binarySearch(array, @(19), descending);
    NSLog(@"testBinarySearch-%d", idx);
}

void testBlockSearch() {
    NSMutableArray *array = @[@(2), @(6), @(8), @(9), @(19), @(99)].mutableCopy;
    int idx = blockSearch(array, @(19), 3);
    NSLog(@"testBlockSearch-%d", idx);
}
