//
//  SearchLinearList.h
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/10.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sorts.h"

void testOrderSearch(void);
void testBinarySearch(void);
void testBlockSearch(void);

int orderSearch(NSMutableArray <NSNumber *> *array, NSNumber *element);
int binarySearch(NSMutableArray <NSNumber *> *array, NSNumber *element, Compare compare);
int blockSearch(NSMutableArray <NSNumber *> *array, NSNumber *element, int gap);
