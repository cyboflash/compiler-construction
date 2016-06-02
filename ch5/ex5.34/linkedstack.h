/*
 * File:    stack.h
 * Author:  zentut.com
 * Purpose: linked stack header file
 */
#ifndef LINKEDSTACK_H_INCLUDED
#define LINKEDSTACK_H_INCLUDED

typedef struct __node__
{
    int data;
    struct __node__* next;
} node;

int empty(node *s);
node* push(node *s,int data);
node* pop(node *s,int *data);
void init(node* s);
void display(node* head);
void destroy(node* head);
#endif // LINKEDSTACK_H_INCLUDED
