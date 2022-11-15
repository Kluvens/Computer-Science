Dynamic programming is an optimization approach that transforms a complex problem into a sequence of simpler problems.

## Optimization

### Find the shortest path from a group of nodes to another group of nodes
This question is similar but harder than finding the shortest path from one node to another node.
But we still need dynamic programming to solve these problems.

One example of this kind of questions is following:

![image](https://user-images.githubusercontent.com/95273765/201784622-977a3f3d-32b4-4699-afd4-9c6c7858f2ba.png)

This is a steet map connecting homes and downtown parking lots for a group of commuters in a model city.
The arcs correspond to streets and the nodes correspond to intersections.
Every commuter must traverse five streets (the number of group of intersection) in driving from home to downtown.
Numbers within the nodes represent the lengths of the traffic delays.
We are going to find the path from home to downtown with the minimum traffic congestion time.

We can rewrite the diagram to a compact representation of the network and store those values to a matrix M.

![image](https://user-images.githubusercontent.com/95273765/201785203-46bf7449-41a7-4531-945c-ee3b4922103f.png)

Since dynamic programming solves a problem by a sequence of simpler subproblems, we need to identify what are they:
let opt(i, j) represent the minimum congestion time to reach ith group, jth intersection.

The base case is for the first group of intersections, the minimum waiting time is just the time by itself.
That is, opt(1, j) = M[1][j].

Recurrence: every time calculated is based on all the possible times in the previous block of intersections that are able to connect this intersection.
Therefore, opt(i, j) = M[i][j] + min(opt(i-1, k) for k = j and j+1 if i is even and k = j and j-1 if i is odd).

![image](https://user-images.githubusercontent.com/95273765/201788772-d1373df5-2d90-4055-9acf-3a44b23c6203.png)

Order of computation: we apply the forward induction from the left (group of homes) to the rifht (group downtowns).

Final answer: min(opt(n, k) for 1 <= k <= n).

Time complexity: There are O(n\*m) subproblems if we are given n group of intersections and each group has m intersections.
Each subproblem is solved by constant time.
Thus, the overall time complexity is O(n\*m).

### Selection problem
Given a set of activities and the starting and finishing time of each activity, find the maximum number of activities that can be performed by a single person assuming that a person can only work on a single activity at a time.

```
{1, 4}, {3, 5}, {0, 6}, {5, 7}, {3, 8}, {5, 9}, {6, 10}, {8, 11}, {8, 12}, {2, 13}, {12, 14}
```

The idea is first to sort given activities in increasing order of their start time.
Let `jobs[0…n-1]` be the sorted array of activities.
We can define an array `L` such that `L[i]` itself is an array that stores maximum non-conflicting jobs ending at `i'th` job.
Therefore, `L[i]` can be recursively written as:

```
L[i] = jobs[i] + { max(L[j]), where j < i and jobs[j].end < jobs[i].start }
     = jobs[i], if there is no such j
```

Time complexity: There are O(n) subproblems and each of them takes O(n) to solve.
Therefore, the overall time complexity is O(n^2).
