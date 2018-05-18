//
//  Stack.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/18.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "Stack.h"


int max = 100;

/******用数组实现*******/
typedef struct Person {
    char name[20];
    int age;
    int sex;
}Person;

typedef struct stack {
    int size;
    Person *persons[];
}stack;

bool isEmpty(stack *sta) {
    bool isEmpty = sta == NULL || sta->size == 0;
    if (isEmpty) {
        printf("empty stack\n");
    }
    return isEmpty;
}

stack *initStack() {
    stack *sta = malloc(sizeof(stack));
    if (sta) {
        sta->size = 0;
        (sta->persons)[0] = NULL;
    }
    return sta;
}

Person *initPerson(char *name, int age, int sex) {
    Person *p = malloc(sizeof(Person));
    if (p) {
        strcat(p->name, name);
        p->age = age;
        p->sex = sex;
    }
    return p;
}

bool push(stack **sta, char *name, int age, int sex) {
    Person *p = initPerson(name, age, sex);
    if ((*sta) == NULL) {
        (*sta) = initStack();
    }
    if (p == NULL) {
        return false;
    }
    if ((*sta)->size > 100) {
        return false;
    }
    (*sta)->persons[(*sta)->size] = p;
    (*sta)->size ++;
    return true;
}

Person *pop(stack **sta) {
    if (!isEmpty(*sta)) {
        Person *person = (*sta)->persons[(*sta)->size - 1];
        (*sta)->size--;
        printf("pop: \n name: %s, age: %d sex: %d\n",person->name, person->age, person->sex);
        return person;
    }
    return NULL;
}

void printStack(stack *sta) {
    if (!isEmpty(sta)) {
        printf("printStack:\n");
        for (int i = sta->size - 1; i >= 0; i--) {
            Person *person = sta->persons[i];
            printf("person: name = %s, age = %d, sex = %d\n",person->name, person->age, person->sex);
        }
    }
}

void createStack() {
    stack *sta = NULL;
    for (int i = 0; i < 10; i ++) {
        char *str = "";
        sprintf(str, "stack_by_array:%d",i);
        push(&sta, str, 100 + i, i / 2);
    }
    printStack(sta);
    pop(&sta);
    printStack(sta);
}

/*******用链表实现******/
typedef struct Node {
    char data[10];
    struct Node *next;
}Node, *List;

void initNode(char *content) {
    
}

