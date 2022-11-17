## Ford-Fulkerson Algorithm
A flow network G = (V, E) is a directed graph in which each edge e = (u, v) ∈ E has a positive integer capacity c(u, v) > 0.

There are two distinguished vertices: a source s and a sink t;
no edge leaves the sink and no edge enters the source.

A flow in G is a function f : E → R+, f(u, v) ≥ 0, which satisfies
1. capacity constraint: for all edges e(u, v) ∈ E we require f(u, v) ≤ c(u, v).
2. flow conservation: For all v ∈ V − {s, t} we require

![image](https://user-images.githubusercontent.com/95273765/202355255-35458481-cb46-407d-9125-c1327e8edfc8.png)

The residual flow network for a flow network with some flow in it:
the network with the leftover capacities.

Each edge of the original network has a leftover capcity for more flow which is equal to the capacity of the edge minus the flow through the edge.

If the flow through an edge is equal to the capacity of the edge, this edge disappears in the residual network.

New 'virtual' edges appear in opposite direction of an original edge with some flow in it.

Residual flow network can be used to increase the total flow through the network by adding an augmenting path.

![image](https://user-images.githubusercontent.com/95273765/202356052-b2fdd433-f2f1-4d6e-8dbe-6bcdc665f2a8.png)

The capacity of an augmenting path is the capacity of its bottleneck edge, which is the smallest value of the path.

We can now recalculate the flow through all edges along the augmenting path by adding the additional flow through the path if
the flow through the augmenting path is in the same direction as the original flow, and subtracting if in opposite direction.

Ford-Fulkerson algorithm for finding maximal flow in the flow network
1. keep adding flow through new augmenting paths for as long as it is possible
2. when there are no more augmenting paths, you have achieved the largest possible flow in the network
3. if all the capacities are integers, then each augmenting path increases the flow through the network for at least 1 unit.
4. the total flow cannot be larger than the sum of all capacities of all edges leaving the source, so eventually the process must terminate.

A cut in a flow network is any partition of the vertices of the underlying graph into two subsets S and T such that:
1. S ∪ T = V
2 S ∩ T = ∅
3 s ∈ S and t ∈ T

The capacity c(S, T) of a cut (S, T) is the sum of capacities of all edges leaving S and entering T

![image](https://user-images.githubusercontent.com/95273765/202358892-a16320b6-5af5-4199-8117-d98127cf6bb9.png)

The flow through a cut f(S, T) is the total flow through edges from S to T
minus the total flow through edges from T to S:

![image](https://user-images.githubusercontent.com/95273765/202358997-81991edc-280d-4fe3-9c1c-4cfbe30141ea.png)

Clearly, f(S, T) ≤ c(S, T) because for every edge (u, v) ∈ E we assumed
f(u, v) ≤ c(u, v), and f(u, v) ≥ 0.

**Theorem (max-flow min-cut)**:
The maximal amount of flow in a flow network is equal to the capacity of the cut of minimal capacity.

Since any flow has to cross every cut, any flow must be smaller than the
capacity of any cut: f = f(S, T) ≤ c(S, T).

Thus, if we find a flow f which equals the capacity of some cut (S, T), then
such flow must be maximal and the capacity of such a cut must be minimal.

We now show that when the Ford - Fulkerson algorithm terminates, it
produces a flow equal to the capacity of an appropriately defined cut.

## Edmonds-Karp Max Flow Algorithm
The Edmonds-Karp algorithm improves the Ford Fulkerson algorithm in a
simple way: always choose the shortest path from the source s to the sink t,
where the “shortest path” means the fewest number of edges, regardless of
their capacities (i.e., each edge has the same unit weight).

Note that this choice is somewhat counter intuitive: we preferably take edges
with small capacities over edges with large capacities, for as long as they are
along a shortest path from s to t.

Why does such a choice speed up the Ford - Fulkerson algorithm? To see this,
one needs a tricky mathematical proof, see the textbook. One can prove that
such algorithm runs in time O(|V|\*|E|^2).

## Max flow with vertex capacities

