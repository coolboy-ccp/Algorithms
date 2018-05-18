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
}Node;

typedef struct LinkedStack {
    Node *head;
    int size;
}LinkedStack;

Node *initNode(char *content) {
    Node *node = malloc(sizeof(Node));
    if (node) {
        strcat(node->data, content);
        node->next = NULL;
    }
    return node;
}

LinkedStack *initLinkedStack() {
    LinkedStack *stack = malloc(sizeof(LinkedStack));
    if (stack) {
        stack->size = 0;
        stack->head = NULL;
    }
    return stack;
}

void linked_push(LinkedStack **stack,char *content) {
    Node *node = initNode(content);
    if ((*stack)->size > max) return;
    if (node == NULL) return;
    if ((*stack) == NULL) {
        (*stack) = initLinkedStack();
        (*stack)->head = node;
    }
    else {
        Node *tmp = (*stack)->head;
        while (tmp->next) tmp = tmp->next;
        tmp->next = node;
    }
    (*stack)->size ++;
}

Node *linked_pop(LinkedStack **stack) {
    if ((*stack) == NULL) return NULL;
    Node *top = (*stack)->head;
    Node *last = (*stack)->head;
    while (top->next) top = top->next;
    while (last->next->next) last->next = NULL;
    (*stack)->size --;
    return top;
}

