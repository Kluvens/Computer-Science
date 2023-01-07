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
![image](https://user-images.githubusercontent.com/95273765/211024568-a3b1b9da-9ef4-494a-9dbb-95bf391e5bc2.png)

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
A queue is defined as a linear data structure that is open at both ends and the operations are performed in First In First Out (FIFO) order.

![image](https://user-images.githubusercontent.com/95273765/211128005-5e7fde01-685d-4af8-83cd-fb495be327b1.png)

There are four different types of queues:
1. simple queue
2. circular queue
3. priority queue
4. double ended queue

### Simple Queue
Implementation of queue in Java:
``` java
// Queue implementation in Java

public class Queue {
  int SIZE = 5;
  int items[] = new int[SIZE];
  int front, rear;

  Queue() {
    front = -1;
    rear = -1;
  }

  boolean isFull() {
    if (front == 0 && rear == SIZE - 1) {
      return true;
    }
    return false;
  }

  boolean isEmpty() {
    if (front == -1)
      return true;
    else
      return false;
  }

  void enQueue(int element) {
    if (isFull()) {
      System.out.println("Queue is full");
    } else {
      if (front == -1)
        front = 0;
      rear++;
      items[rear] = element;
      System.out.println("Inserted " + element);
    }
  }

  int deQueue() {
    int element;
    if (isEmpty()) {
      System.out.println("Queue is empty");
      return (-1);
    } else {
      element = items[front];
      if (front >= rear) {
        front = -1;
        rear = -1;
      } /* Q has only one element, so we reset the queue after deleting it. */
      else {
        front++;
      }
      System.out.println("Deleted -> " + element);
      return (element);
    }
  }

  void display() {
    /* Function to display elements of Queue */
    int i;
    if (isEmpty()) {
      System.out.println("Empty Queue");
    } else {
      System.out.println("\nFront index-> " + front);
      System.out.println("Items -> ");
      for (i = front; i <= rear; i++)
        System.out.print(items[i] + "  ");

      System.out.println("\nRear index-> " + rear);
    }
  }

  public static void main(String[] args) {
    Queue q = new Queue();

    // deQueue is not possible on empty queue
    q.deQueue();

    // enQueue 5 elements
    q.enQueue(1);
    q.enQueue(2);
    q.enQueue(3);
    q.enQueue(4);
    q.enQueue(5);

    // 6th element can't be added to because the queue is full
    q.enQueue(6);

    q.display();

    // deQueue removes element entered first i.e. 1
    q.deQueue();

    // Now we have just 4 elements
    q.display();

  }
}
```

The complexity of enqueue and dequeue operations in a queue using an array is O(1).

### Circular Queue
A circular queue is the extended version of a regular queue where the last element is connected to the first element.

![image](https://user-images.githubusercontent.com/95273765/211128310-613f1311-5d4c-46b0-a355-80561ac144fd.png)

Circular queue works by the process of circular increment i.e. 
when we try to increment the pointer and we reach the end of the queue, we start from the beginning of the queue.

Implementation in Java:
``` java
// Circular Queue implementation in Java

public class CQueue {
  int SIZE = 5; // Size of Circular Queue
  int front, rear;
  int items[] = new int[SIZE];

  CQueue() {
    front = -1;
    rear = -1;
  }

  // Check if the queue is full
  boolean isFull() {
    if (front == 0 && rear == SIZE - 1) {
      return true;
    }
    if (front == rear + 1) {
      return true;
    }
    return false;
  }

  // Check if the queue is empty
  boolean isEmpty() {
    if (front == -1)
      return true;
    else
      return false;
  }

  // Adding an element
  void enQueue(int element) {
    if (isFull()) {
      System.out.println("Queue is full");
    } else {
      if (front == -1)
        front = 0;
      rear = (rear + 1) % SIZE;
      items[rear] = element;
      System.out.println("Inserted " + element);
    }
  }

  // Removing an element
  int deQueue() {
    int element;
    if (isEmpty()) {
      System.out.println("Queue is empty");
      return (-1);
    } else {
      element = items[front];
      if (front == rear) {
        front = -1;
        rear = -1;
      } /* Q has only one element, so we reset the queue after deleting it. */
      else {
        front = (front + 1) % SIZE;
      }
      return (element);
    }
  }

  void display() {
    /* Function to display status of Circular Queue */
    int i;
    if (isEmpty()) {
      System.out.println("Empty Queue");
    } else {
      System.out.println("Front -> " + front);
      System.out.println("Items -> ");
      for (i = front; i != rear; i = (i + 1) % SIZE)
        System.out.print(items[i] + " ");
      System.out.println(items[i]);
      System.out.println("Rear -> " + rear);
    }
  }

  public static void main(String[] args) {

    CQueue q = new CQueue();

    // Fails because front = -1
    q.deQueue();

    q.enQueue(1);
    q.enQueue(2);
    q.enQueue(3);
    q.enQueue(4);
    q.enQueue(5);

    // Fails to enqueue because front == 0 && rear == SIZE - 1
    q.enQueue(6);

    q.display();

    int elem = q.deQueue();

    if (elem != -1) {
      System.out.println("Deleted Element is " + elem);
    }
    q.display();

    q.enQueue(7);

    q.display();

    // Fails to enqueue because front == rear + 1
    q.enQueue(8);
  }

}
```

### Priority Queue

### Double Ended Queue

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
