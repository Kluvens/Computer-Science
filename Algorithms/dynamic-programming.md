Dynamic programming is an optimization approach that transforms a complex problem into a sequence of simpler problems.

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

### Longest Increasing Subsequence
The Longest Increasing Subsequence (LIS) problem is to find the length of the longest subsequence of a given sequence such that all elements of the subsequence are sorted in increasing order. 
For example, the length of LIS for {10, 22, 9, 33, 21, 50, 41, 60, 80} is 6 and LIS is {10, 22, 33, 50, 60, 80}. 

Problem: Given a sequence of n real numbers A[1..n], determine a subsequence (not necessarily contiguous) of maximum length in which the values in the subsequence are strictly increasing.

Subproblem: Let P(i) be the subproblem, finding a subsequence of the sequence A[1..i], and that we have put in a table S the values S[j] = lenj which are the lengths lenj of maximal increasing sequences which end with A[j].

Recurrence: Assume we have solved the subproblems for all j < i, and that we have put in a table S the values S[j] = lenj which are the lengths lenj of maximal increasing sequences which end with A[j].

Base case: S(1) = 1

We are going to solve this problem in a bottom-up manner.
In the bottom-up approach, solve smaller subproblems first,
then solve larger subproblems from them.
The following bottome-up approach computes `L[i]`, for each 0 <= i < n, which stores the length of the longest increasing subsequence of subarray `arr[0..i]` that ends with `arr[i]`.
To calculate `L[i]`, consider longest increasing sequence of all smaller values of `i` already computed and pick maximum `L[j]`, where `arr[j]` is less than the current element `arr[i]`.

For example, consider array `arr = [ 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]`.
The longest increasing subsequence of subarray `arr[0…i]` that ends with `arr[i]` are:
```
LIS[0] — 0
LIS[1] — 0 8
LIS[2] — 0 4
LIS[3] — 0 8 12
LIS[4] — 0 2
LIS[5] — 0 8 10
LIS[6] — 0 4 6
LIS[7] — 0 8 12 14
LIS[8] — 0 1
LIS[9] — 0 4 6 9
LIS[10] — 0 4 5
LIS[11] — 0 4 6 9 13
LIS[12] — 0 2 3
LIS[13] — 0 4 6 9 11
LIS[14] — 0 4 6 7
LIS[15] — 0 4 6 9 13 15
```

Time complexity: There are O(n) many subproblems and each of them takes O(n) to solve.
Therefore, the overall time complexity is O(n^2).
However, there's another algorithm that can solve this problem by O(n\*logn).

### Coin change-making problem
Given an unlimited supply of coins of given denominations, find the minimum number of coins required to get the desired change.

We solve smaller subproblems first, then solve larger subproblems from them.
It computes T[i] for each `1 <= i <= target`, which stores the minimum number of coins needed to get a total of `i`.

Let v(i) denotes the value of the coin, we consider optimal solutions opt(i − v(k)) for every amount of th form i − v(k), where k ranges from 1 to n.

Among all of these optimal solutions, we pick one which uses the fewest number of coins, say this is opt(i − v(m)) for some m, 1 <= m <= n.

We obtain an optimal solution opt(i) for amount i by adding to opt(i − v(m)) one coin of denomination v(m).

```
opt(i) = min{opt(i − v(k)) : 1 ≤ k ≤ n} + 1
```

The time complexity of this algorithm is O(n\*target) where n is the total number of coins and target is the total change required.

### 0-1 Knapsack Problem
We can solve this problem in a bottom-up manner. 
In the bottom-up approach, we solve smaller subproblems first, then solve larger subproblems from them. 
The following bottom-up approach computes `T[i][j]`, for each `1 <= i <= n` and `0 <= j <= W`, which is the maximum value that can be attained with weight less than or equal to j and using items up to first i items. 
It uses the value of smaller values i and j already computed.

```
if opt(i − 1, c − wi) + vi > opt(i − 1, c)
then opt(i, c) = opt(i − 1, c − wi) + vi;
else opt(i, c) = opt(i − 1, c).
```

The time complexity of this algorithm is O(n\*W) where n is the total number of items, and K is the knapsack's capacity.

### Partition problem
Given a set of positive integers, check if it can be divided into two subsets with equal sum.

The partition problem is a special case of the subset sum problem, which itself is a speical case of the Knapsack problem.

The idea is to calculate the sum of all elements in the set, say `sum`.
If `sum` is odd, we can't divide the array into two sets.
If `sum` is even, check if a subset with `sum/2` exists or not.

Dynamic programming can solve this problem by saving subproblem solutions in memory rather than computing them again and again.
The idea is to solve smaller subproblems first, then solve larger subproblems from them.
The following bottom-up approach computes `T[i][j]`, for each `1 <= i <= n` and `1 <= j <= sum`, which is true if subset with sum j can be found using items up to first i items. 
It uses the value of smaller values i and j already computed.

The time complexity of this algorithm is O(n\*sum) where n is the size of the input, and sum is the sum of all elements in the input.

### Assembly Line Scheduling

### Matrix Chain Multiplication
Question: determine the optimal parenthesization of a product of n matrices.

Matrix chain multiplication is an optimization problem that to find the most efficient way to multiply a given sequence of matrices.
The problem is not actually to perform the multiplications but merely to decide the sequence of the matrix multiplication involved.

The matrix multiplication is associative as no matter how the product is parenthesized, the result obtained will remain the same.

However, the order in which the product is parenthesized affects the number of simple arithmetic operations needed to compute the product.

The bottom-up approach computes, for each `2 <= k <= n`, the minimum costs of all subsequences of length k, using the prices of smaller subsequences already computed. 

The subproblem P(i, j) is “group matrices AiAi+1...Aj−1Aj in such a way as to minimise the total
number of multiplications needed to find the product matrix”.

Let `m(i, j)` denote the minimal number of multiplications needed to compute the
product `AiAi+1...Aj−1Aj` ; let also the size of matrix Ai be `si−1 × si`.

Therefore, the recursion is:
`m(i, j) = min{m(i, k) + m(k + 1, j) + si−1*sj*sk : i ≤ k ≤ j − 1}`

The time complexity of this algorithm is O(n^3).

### Longest Common Subsequence
Different from longest common substring.
Subsequences are not required to occupy conscutive positions within the original string.

Few steps to do this:
1. create a table of dimension `n+1*m+1` where n and m are the lengths of X and Y respectively.
The first row and the first column are filled with zeros.
2. Fill each cell of the table using the following logic.
3. if the character corresponding to the current row and current column are matching, then fill current cell by adding one to the diagonal element. Point an arrow to the diagonal cell.
4. Else take the maximum value from the previous column and previous row element for filling the current cell. Point an arrow to the cell with maximum value. If they are equal, point to any of them.
5. Step 2 is repeated until the table is filled.
6. The value in the last row and the last column is the length of the longest common subsequence.

![image](https://user-images.githubusercontent.com/95273765/201849097-8370ee34-2979-4477-8165-fb9b89d29549.png)

7. In order to find the longest common subsequence, start from the last element and follow the direction of the arrow. The elements corresponding to () symbol form the longest common subsequence.

![image](https://user-images.githubusercontent.com/95273765/201849670-aeb44df4-9aeb-4830-a438-7a52765eff8a.png)

### Shortest Common Supersequence
Instance: Two sequences s = ⟨a1, a2, . . . an⟩ and s∗ = ⟨b1, b2, . . . , bm⟩.

Task: Find a shortest common super-sequence S of s, s∗, i.e., the shortest possible sequence S such that both s and s∗ are subsequences of S.

Solution: Find the longest common subsequence LCS(s, s*) of s and s*, and then add differing elements of the two sequences at the right places, in any order

Example:
s = abacada
s* = xbycazd
LCS(s, s∗) =bcad
shortest super-sequence S =axbyacazda

### Edit Distance
Given two text strings A of length n and B of length m, you want to transform A into B.
You are allowed to insert a character, delete a character and replace a character with another one.
All of operations have a unit cost.
The number is called the edit distance between A and B.

Subproblems: Let C(i, j) be the minimum cost of transforming the sequence A[1..i] into the sequence B[1..j] for all i ≤ n and all j ≤ m.

Recursion: we again fill the table of solutions C(i, j) for subproblems P(i, j) row by row:
```
C(i,j) = min(C(i-1,j) + 1(delete), C(i,j-1) + 1(insert), (C(i−1, j−1) if A[i] = B[j], C(i−1, j−1) + 1(replace) if A[i] ̸= B[j]))
```

1. cost (delete) + C(i − 1, j) corresponds to the option if you recursively transform A[1..i − 1] into B[1..j] and then delete A[i];
2. cost C(i, j − 1) + (insert) corresponds to the option if you first transform A[1..i] to B[1..j − 1] and then append B[j] at the end;
3. the third option corresponds to first transforming A[1..i − 1] to B[1..j − 1] and
     1. if A[i] is already equal to B[j] do nothing, thus incurring a cost of only C(i − 1, j − 1);
     2. if A[i] is not equal to B[j] replace A[i] by B[j] with a total cost of C(i − 1, j − 1) + (replace).

### Maximizing an expression
You are given a boolean expression consisting of a string of the symbols true (T) and false (F) and with exactly one operation of and (∧), or (∨) or xor (⊕) between any two consecutive symbols(truth values). 
Count the number of ways to place brackets in the expression such that it will evaluate to true.

Solution: we start by defining some notations, let s1,..., sn denote the given n symbols and let o1,..., on−1 denote the given n − 1 operations.

Subproblem: then we can solve this problem by considering the 2 subproblems
1. P(l, r): how many ways are there to make the expression starting from at the sl and ending at sr (including all operations in between sl and sr) evaluate to T?
2. Q(l, r): by inheriting the setup of l, r from above, how many ways evaluates to F?

We then now let p(l, r) denote the solution of P(l, r) and q(l, r) for the solution of Q(l, r).

Example (Definition of p). For T ∧ F ⊕ T, P(1, 2) will denote the number of ways of making T ∧ F evaluate to T with the correct bracketing, which in this case p(1, 2) = 0.

Base case: we can now define our base case, note that if l = r, then p(·) and q(·) can be easily determined basing on the value of the symbol, hence ∀i : l = r = i, then
p(i, i) = (1 if si = T and 0 if si = F);
q(i, i) = (1 if si = F and 0 if si = T)
if we consider p(·) and q(·)’s value on a grid in N^2m then our base case will fill the value for the diagonal of our grid.
Also, note that we will only be filling for values l < r, hence our grid will be upper-triangular.

Recurrence: For each subproblem, we also notice that as each of the operators is binary, we can split the expression around an operator om so that everything to the left of the operator is in its own bracket, and everything to the right of the operator is in its own bracket to form 2 smaller expressions.
We give an illustration via (s1 o1 ... sm-1 om-1 sm) om (sm+1 om+1 ... on-1 sn).

Order of computation: however, we should be careful of 2 things:
1. to ensure that the recurrence can be given correct, we need to compute p(l, r) and q(l, r) in parallel
2. order that we compute our subproblems is also important as each p(l, r) requires all of p(l, l+1), ... , p(l, r−1) and p(r − 1, r), ... , p(l + 1, r) (same for q(l, r)). 
Therefore, one valid order of computation is solving our subproblem column by column from down to up (with no values considered below the diagonal) on our grid.

Final answer: By our problem construction, the final solution is just the quantity p(1, n).

Time complexity: Lastly, we see that the time complexity of our algorithm is O(n^3) as there are n^2 different ranges that l and r could cover, and each needs the evaluations of Γp(·) or Γq(·) at up to n different splitting points

### Turtle Tower

### Bellman-Ford Algorithm

### Floyd-Warshall Algorithm

