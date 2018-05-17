//
//  LinkedList.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/5/16.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "LinkedList.h"
#include <stdio.h>


/*****单向链表*******/
typedef struct SinglyListNote {
    int lid;
    char data[20];
    struct SinglyListNote *next;
}SinglyListNote;

static SinglyListNote *list_head = NULL;

static int list_id = 0;

//从尾部插入
static void insert(SinglyListNote **head, SinglyListNote *list) {
    SinglyListNote *temp;
    if (NULL == *head) {
        *head = list;
        (*head)->next = NULL;
    }
    else {
        temp = *head;
        while (temp) {
            if (NULL == temp->next) {
                temp -> next = list;
                list->next = NULL;
            }
            temp = temp->next;
        }
    }
}

static void print(SinglyListNote *head) {
    SinglyListNote *temp;
    temp = head;
    while (temp) {
        printf("lid:%d data:%s\n",temp->lid,temp->data);
        temp = temp->next;
    }
}

static int delete_list(SinglyListNote **head, int lid) {
    SinglyListNote *temp = *head, *p = *head;
    if (NULL == temp) {
        return -1;
    }
    else {
        if (lid == temp->lid) {
            *head = temp -> next;
            return 0;
        }
        else {
            while (temp -> next) {
                p = temp;
                temp = temp->next;
                if (lid == temp->lid) {
                    p->next = temp->next;
                    return 0;
                }
            }
        }
    }
    return -1;
}

static int change(SinglyListNote *head, int lid, char *content) {
    SinglyListNote *temp = head;
    while (temp) {
        if (lid == temp->lid) {
            memset(temp->data, 0, sizeof(temp->data));
            sprintf(temp->data, "%s", content);
            temp->data[strlen(content)] = '\0';
            printf("lid:%d change: %s",temp->lid,temp->data);
            return 0;
        }
        temp = temp->next;
    }
    return -1;
}

static SinglyListNote *find(SinglyListNote *head, int lid) {
    SinglyListNote *temp = head;
    while (temp) {
        if (lid == temp->lid) {
            return temp;
        }
        temp = temp->next;
    }
    printf("can't find a note with lid at %d\n",lid);
    return NULL;
}

static void reverse(SinglyListNote *head, int lid) {
    SinglyListNote *q, *p, *r;
    q = NULL;
    p = head;
    while (p) {
        r = q;
        q = p;
        p = p->next;
        q->next = r;
    }
}

void createSinglyList() {
    list_head = NULL;
    SinglyListNote *list = malloc(sizeof(SinglyListNote) * 10);
    for (int i = 0; i < 10; i ++) {
        list[i].lid = list_id++;
        sprintf(list[i].data,"singly_list:%d",i);
        insert(&list_head, &list[i]);
    }
    print(list_head);
}

void testSLChange() {
    createSinglyList();
    change(list_head, 7, "testSLChange\n");
}

void testSLDelete() {
    createSinglyList();
    delete_list(&list_head, 6);
    print(list_head);
}

void testSLFind() {
    createSinglyList();
    SinglyListNote *note = find(list_head, 4);
    if (note) {
        printf("testSLFind: lid: %d  data: %s\n", note->lid,note->data);
    }
}

/***双向链表***/
typedef struct DoubleListNote {
    char *data;
    struct DoubleListNote *last;
    struct DoubleListNote *next;
}DoubleListNote;

typedef struct DoubleList {
    int size;
    DoubleListNote *head;
    DoubleListNote *tail;
}DoubleList;

DoubleListNote *note(char *data) {
    DoubleListNote *note = malloc(sizeof(DoubleListNote));
    if (NULL != note) {
        note->data = data;
        note->last = NULL;
        note->next = NULL;
    }
    else {
        printf("note: insufficient memeory space.");
    }
    return NULL;
}

DoubleList *dlist() {
    DoubleList *list = malloc(sizeof(DoubleList));
    if (list != NULL) {
        list->head = NULL;
        list->tail = NULL;
        list->size = 0;
    }
    else {
        printf("dlist: insufficient memeory space.");
    }
    return list;
}

void double_add(DoubleList *list, DoubleListNote *note) {
    if (NULL == note) {
        printf("double_add: a NULL note is invalide \n");
        return;
    }
    if (NULL == list) {
        list = dlist();
    }
    if (NULL == list) {
        return;
    }
    
    if (list->size == 0) {
        list->head = note;
        list->tail = note;
        note->last = NULL;
        note->next = NULL;
    }
    else {
        note->next = NULL;
        note->last = list->tail;
        list->tail->next = note;
        list->tail = note;
    }
    list->size ++;
}

bool isEmptyNode(DoubleList *list) {
    return list == NULL || list->size == 0;
}

void double_insert(DoubleList *list, DoubleListNote *note, int pos) {
    if (isEmptyNode(list)) {
        printf("double_insert: null list is invalid\n");
    }
    if (note == NULL) {
        printf("double_insert: null note is invalid\n");
    }
    if (pos < 0 || pos > list->size) {
        double_add(list, note);
    }
    else {
        DoubleListNote *last, *next;
        next = list->head;
        int startPos = 0;
        while (startPos < pos) {
            startPos ++;
            next = next->next;
        }
        if (next == list->head) {
            note->next = list->head;
            note->last = NULL;
            list->head->last = note;
            list->head = note;
        }
        else {
            last = next->last;
            note->last = last;
            note->next = next;
            last->next = note;
            next->last = note;
        }
    }
}

void print_double(DoubleList *list) {
    if (isEmptyNode(list) || list->size == 0) {
        printf("empty list\n");
        return;
    }
    printf("print_double:\n");
    DoubleListNote *currentNote = list->head;
    printf("%s\n",currentNote->data);
    while (currentNote->next) {
        currentNote = currentNote->next;
        printf("%s\n", currentNote->data);
    }
}

void deleteNode(DoubleList *list, int pos) {
    if (isEmptyNode(list)) {
        printf("null list\n");
        return;
    }
    if (pos < 0 || pos > list->size) {
        printf("out of bounds");
        return;
    }
    DoubleListNote *currentNote = list->head;
    if (list->size == 1) {
        list->head = NULL;
        list->tail = NULL;
        free(currentNote);
        free(list);
        list = NULL;
        return;
    }
    int startPos = 0;
    while (startPos < pos) {
        currentNote = currentNote->next;
        startPos++;
    }
    if (currentNote->last == NULL) {//head
        list->head = list->head->next;
        list->head->last = NULL;
        free(currentNote);
        currentNote = NULL;
    }
    else if(currentNote->next == NULL) {//tail
        list->tail = list->tail->last;
        list->tail->next = NULL;
        free(currentNote);
        currentNote = NULL;
    }
    else {
        DoubleListNote *last = currentNote->last;
        DoubleListNote *next = currentNote->next;
        last->next = next;
        next->last = last;
        free(currentNote);
        currentNote = NULL;
    }
    list->size--;
}

void double_change(DoubleList *list, int pos, char *content) {
    if (isEmptyNode(list)) {
        printf("double_change: null list\n");
        return;
    }
    if (pos < 0 || pos > list->size) {
        printf("double_change: out of bounds\n");
        return;
    }
    
    DoubleListNote *currentNote = list->head;
    int startPos = 0;
    while (startPos < pos) {
        currentNote = currentNote->next;
        startPos++;
    }
    currentNote->data = content;
}

DoubleListNote *double_find(DoubleList *list, int pos) {
    if (isEmptyNode(list)) {
        printf("double_find: null list\n");
        return NULL;
    }
    if (pos < 0 || pos > list->size) {
        printf("double_find: out of bounds");
        return NULL;
    }
    DoubleListNote *currentNote = list->head;
    int startPos = 0;
    while (startPos < pos) {
        currentNote = currentNote->next;
        startPos ++;
    }
    return currentNote;
}
