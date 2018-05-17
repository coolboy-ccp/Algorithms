//
//  SequenceList.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/4/23.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "SequenceList.h"

typedef struct {
    int data[10];
    int length;
} SQList;


void initList(SQList *list) {
    list -> length = 0;
}

bool createList(SQList *list, int datas[], uint size) {
    int i = 0;
    if (size > 10) {
        return false;
    }
    for (; i < size; i ++) {
        list -> data[i] = datas[i];
    }
    list -> length = size;
    return true;
}

void printList(SQList list) {
    int i = 0;
    if (0 == list.length) {
        printf("list is empty\n");
        return;
    }
    printf("list:\n");
    printf("lenght:%d",list.length);
    for (; i < list.length; i++) {
        printf("%d, ", list.data[i]);
    }
    printf("\n");
}

void create(SQList *sqlist) {
    int array[5] = {1,2,3,4,5};
    SQList list = {0};
    initList(&list);
    printList(list);
    printf("init sqlist");
    int size = sizeof(array)/sizeof(int);
    createList(&list, array, size);
    printList(list);
    *sqlist = list;
}

//insert
bool insertElement(SQList *p, uint pos, int element) {
    if (pos > p -> length) {
        return false;
    }
    p -> length += 1;
    int i = p -> length - 1;
    for ( ;i > pos; i--) {
        p -> data[i] = p -> data[i - 1];
    }
    p -> data[pos] = element;
    return true;
}

//delete
bool deleteAt(SQList *p, uint pos, int *pElement) {
    if (pos > p -> length) {
        return false;
    }
    *pElement = p -> data[pos];
    p -> length -= 1;
    for (int i = pos; i < p -> length; i++) {
        p -> data[i] = p -> data[i + 1];
    }
    return true;
}

bool elementAt(SQList list, uint pos, int *p) {
    if (pos > list.length - 1) {
        return false;
    }
    *p = list.data[pos];
    return true;
}

int locateElement(SQList list, int element) {
    for (int i = 0; i < list.length; i++) {
        if (element == list.data[i]) {
            return i;
        }
    }
    return -1;
}

void testInsert() {
    SQList list = {0};
    create(&list);
    insertElement(&list, 5, 10000000);
    printList(list);
    insertElement(&list, 0, -1);
    printList(list);
    insertElement(&list, 3, 100);
    printList(list);
}

void testDelete() {
    printf("\ndelete: \n");
    SQList list = {0};
    create(&list);
    int element = 0;
    deleteAt(&list, 0, &element);
    printList(list);
    deleteAt(&list, list.length - 1, &element);
    printList(list);
    deleteAt(&list, 1, &element);
    printList(list);
    create(&list);
}

void testElementAt() {
    printf("\nelementAt: \n");
    SQList list = {0};
    create(&list);
    printList(list);
    int element = -1;
    elementAt(list, 3, &element);
    printf("%d",element);
}

void testLocateElement() {
    printf("\nlocateElement: \n");
    SQList list = {0};
    create(&list);
    printList(list);
    printf("%d",locateElement(list, 3));
}



