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

Time complexity: There are O(n\*m) subproblems if we are given n group of intersections and each group has m intersections.
Each subproblem is solved by constant time.
Thus, the overall time complexity is O(n\*m).
