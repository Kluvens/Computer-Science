## Data Structure
A data structure is a storage that is used to store and organize data.
It is a way of arranging data on a computer so that it can be accessed and updated efficiently.

Classification of data structure:
- linear data structure: data structure in which data elements are arranged sequentially or linearly, where each element is attached to its previous and next adjacent elements
  - static data structure: has a fixed memory size, such as an array
  - dynamic data structure: the size is not fixed, such as queue and stack
- non-linear data structure: data structures where data elements are not placed sequentially or linearly are called non-linear data structures. We can't traverse all the elements in a single run only. Examples are trees and graphs.

## Array
An array is a collection of items stored at contiguous memory locations.
The idea is to store multiple items of the same type together.
This makes it easier to calculate the position of each element by simply adding an offset to a base value.

![image](https://user-images.githubusercontent.com/95273765/211014377-3e583887-8987-4df3-ab49-afd314cfde2d.png)

## Linked List
A linked list is a linear data structure that includes a series of connected nodes.

![image](https://user-images.githubusercontent.com/95273765/211014576-c36c7e5d-96b2-4f86-b34c-472dbfc997df.png)

There are three common types of linked list:
1. singly linked list
2. doubly linked list
3. circular linked list

### Singly linked list
![image](https://user-images.githubusercontent.com/95273765/211015388-11451244-b407-408b-a215-d8238051c2e0.png)

Node is represented as:
``` c
struct node {
  int data;
  struct node *next;
}
```

A three-member singly linked list can be created as:
``` c
/* Initialize nodes */
struct node *head;
struct node *one = NULL;
struct node *two = NULL;
struct node *three = NULL;

/* Allocate memory */
one = malloc(sizeof(struct node));
two = malloc(sizeof(struct node));
three = malloc(sizeof(struct node));

/* Assign data values */
one->data = 1;
two->data = 2;
three->data = 3;

/* Connect nodes */
one->next = two;
two->next = three;
three->next = NULL;

/* Save address of first node in head */
head = one;
```

### Doubly linked list
![image](https://user-images.githubusercontent.com/95273765/211016113-a2d68311-ef68-477f-90ef-25a3decd0665.png)

A node is represented as:
``` c
struct node {
  int data;
  struct node *next;
  struct node *prev;
}
```

A three-member doubly linked list can be created as:
``` c
/* Initialize nodes */
struct node *head;
struct node *one = NULL;
struct node *two = NULL;
struct node *three = NULL;

/* Allocate memory */
one = malloc(sizeof(struct node));
two = malloc(sizeof(struct node));
three = malloc(sizeof(struct node));

/* Assign data values */
one->data = 1;
two->data = 2;
three->data = 3;

/* Connect nodes */
one->next = two;
one->prev = NULL;

two->next = three;
two->prev = one;

three->next = NULL;
three->prev = two;

/* Save address of first node in head */
head = one;
```

### Circular linked list
![image](https://user-images.githubusercontent.com/95273765/211016199-efadbf29-ab8d-4a89-a390-f3184511a6e2.png)

A circular linked list can be either singly linked or doubly linked.

A three-member circular singly linked list can be created as:
``` c
/* Initialize nodes */
struct node *head;
struct node *one = NULL;
struct node *two = NULL;
struct node *three = NULL;

/* Allocate memory */
one = malloc(sizeof(struct node));
two = malloc(sizeof(struct node));
three = malloc(sizeof(struct node));

/* Assign data values */
one->data = 1;
two->data = 2;
three->data = 3;

/* Connect nodes */
one->next = two;
two->next = three;
three->next = one;

/* Save address of first node in head */
head = one;
```

## Stack
Stack is a linear data structure that follows a particular order in which the operations are performed.
More specifically, it follows the principle of Last In First Out (LIFO).
This means that the last element inserted inside the stack is removed first.

LIFO principle of stack:
![image](https://user-images.githubusercontent.com/95273765/211024151-37a4cb4b-bec5-42a4-b67e-6c0c847ae257.png)

Stack implementation in Java:
``` java
// Stack implementation in Java

class Stack {
  private int arr[];
  private int top;
  private int capacity;

  // Creating a stack
  Stack(int size) {
    arr = new int[size];
    capacity = size;
    top = -1;
  }

  // Add elements into stack
  public void push(int x) {
    if (isFull()) {
      System.out.println("OverFlow\nProgram Terminated\n");
      System.exit(1);
    }

    System.out.println("Inserting " + x);
    arr[++top] = x;
  }

  // Remove element from stack
  public int pop() {
    if (isEmpty()) {
      System.out.println("STACK EMPTY");
      System.exit(1);
    }
    return arr[top--];
  }

  // Utility function to return the size of the stack
  public int size() {
    return top + 1;
  }

  // Check if the stack is empty
  public Boolean isEmpty() {
    return top == -1;
  }

  // Check if the stack is full
  public Boolean isFull() {
    return top == capacity - 1;
  }

  public void printStack() {
    for (int i = 0; i <= top; i++) {
      System.out.println(arr[i]);
    }
  }

  public static void main(String[] args) {
    Stack stack = new Stack(5);

    stack.push(1);
    stack.push(2);
    stack.push(3);
    stack.push(4);

    stack.pop();
    System.out.println("\nAfter popping out");

    stack.printStack();

  }
}
```

For the array-based implementation of a stack, the push and pop operations take constant time, i.e. O(1).

## Queue

## Hash Table

## Heap

## Trie

## Union Find
A disjoint-set (union find) data structure is defined as a data structure that keeps track of a set of elements partitioned into a number of disjoint (non-overlapping) subsets. 

It has two main operations:
- Find: determine which subset a particular element is in.
This can be used for determining if two elements are in the same subset.
- Union: join two subsets into a single subset. Usually keep one representative and then make another as a subset.

Video for understanding union find: https://www.youtube.com/watch?v=ayW5B2W9hfo
