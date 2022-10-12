## BFS and DFS

## Cycle in a graph

## Topological ordering

### Kahn’s algorithm for Topological Sorting
Topological sorting for Directed Acyclic Graph (DAG) is a linear ordering of vertices such that for every directed edge uv, vertex u comes before v in the ordering. 
Topological Sorting for a graph is not possible if the graph is not a DAG.

For the following graph:
![image](https://user-images.githubusercontent.com/95273765/195078838-fd36e918-8d44-45d0-b23d-e58a60ba6910.png)

One possible topological ordering would be: 5 4 2 3 1 0.
That is, every node is reachable by the nodes appears before it.
For example, 3 is reachable given 5, 4 and 2 because there's a path from 5 to 2 to 3.

The basis of Kahn’s Algorithm is the following assertion:
A directed acyclic graph (DAG) G has at least one vertex with the indegree zero and one vertex with the out-degree zero.

Essentially, Kahn’s algorithm works by keeping track of the number of incoming edges into each node (indegree). It repeatedly:

1. Finds nodes with no incoming edge, that is, nodes with zero indegree (no dependency).
2. Stores the nodes with zero indegree in a stack/queue and deletes them from the original graph.
3. Deletes the edges originating from the nodes stored in step 2. It is achieved by decrementing the indegree of each node connected to the nodes removed in step 2.

We can now summarize the above steps in the form of an algorithm:
- Step 0: Find indegree for all nodes.
- Step 1: Identify a node with no incoming edges.
- Step 2: Remove the node from the graph and add it to the ordering.
- Step 3: Remove the node’s out-going edges from the graph.
- Step 4: Decrement the indegree where connected edges were deleted.
- Step 5: Repeat Steps 1 to 4 till there are no nodes left with zero indegree.
- Step 6: Check if all elements are present in the sorted order.
- Step 7: If the result of Step 6 is true, we have the sorted order. 
Else, no topological ordering exists.
- Step 8: Exit.

``` python
# A Python program to print topological sorting of a graph
# using indegrees
from collections import defaultdict

# Class to represent a graph
class Graph:
	def __init__(self, vertices):
		self.graph = defaultdict(list) # dictionary containing adjacency List
		self.V = vertices # No. of vertices

	# function to add an edge to graph
	def addEdge(self, u, v):
		self.graph[u].append(v)


	# The function to do Topological Sort.
	def topologicalSort(self):
		
		# Create a vector to store indegrees of all
		# vertices. Initialize all indegrees as 0.
		in_degree = [0]*(self.V)
		
		# Traverse adjacency lists to fill indegrees of
		# vertices. This step takes O(V + E) time
		for i in self.graph:
			for j in self.graph[i]:
				in_degree[j] += 1

		# Create an queue and enqueue all vertices with
		# indegree 0
		queue = []
		for i in range(self.V):
			if in_degree[i] == 0:
				queue.append(i)

		# Initialize count of visited vertices
		cnt = 0

		# Create a vector to store result (A topological
		# ordering of the vertices)
		top_order = []

		# One by one dequeue vertices from queue and enqueue
		# adjacents if indegree of adjacent becomes 0
		while queue:

			# Extract front of queue (or perform dequeue)
			# and add it to topological order
			u = queue.pop(0)
			top_order.append(u)

			# Iterate through all neighbouring nodes
			# of dequeued node u and decrease their in-degree
			# by 1
			for i in self.graph[u]:
				in_degree[i] -= 1
				# If in-degree becomes zero, add it to queue
				if in_degree[i] == 0:
					queue.append(i)

			cnt += 1

		# Check if there was a cycle
		if cnt != self.V:
			print ("There exists a cycle in the graph")
		else :
			# Print topological order
			print (top_order)


g = Graph(6)
g.addEdge(5, 2);
g.addEdge(5, 0);
g.addEdge(4, 0);
g.addEdge(4, 1);
g.addEdge(2, 3);
g.addEdge(3, 1);

print ("Following is a Topological Sort of the given graph")
g.topologicalSort()
```

The time complexity is  O(V+E). 

The space complexity is O(V). 

### All Topological Sorts of a Directed Acyclic Graph
We can go through all possible ordering via backtracking , the algorithm step are as follows : 

1. Initialize all vertices as unvisited.
2. Now choose vertex which is unvisited and has zero indegree and decrease indegree of all those vertices by 1 (corresponding to removing edges) now add this vertex to result and call the recursive function again and backtrack.
3. After returning from function reset values of visited, result and indegree for enumeration of other possibilities.

``` python
# class to represent a graph object
class Graph:

	# Constructor
	def __init__(self, edges, N):

		# A List of Lists to represent an adjacency list
		self.adjList = [[] for _ in range(N)]

		# stores in-degree of a vertex
		# initialize in-degree of each vertex by 0
		self.indegree = [0] * N

		# add edges to the undirected graph
		for (src, dest) in edges:

			# add an edge from source to destination
			self.adjList[src].append(dest)

			# increment in-degree of destination vertex by 1
			self.indegree[dest] = self.indegree[dest] + 1


# Recursive function to find
# all topological orderings of a given DAG
def findAllTopologicalOrders(graph, path, discovered, N):

	# do for every vertex
	for v in range(N):

		# proceed only if in-degree of current node is 0 and
		# current node is not processed yet
		if graph.indegree[v] == 0 and not discovered[v]:

			# for every adjacent vertex u of v,
			# reduce in-degree of u by 1
			for u in graph.adjList[v]:
				graph.indegree[u] = graph.indegree[u] - 1

			# include current node in the path
			# and mark it as discovered
			path.append(v)
			discovered[v] = True

			# recur
			findAllTopologicalOrders(graph, path, discovered, N)

			# backtrack: reset in-degree
			# information for the current node
			for u in graph.adjList[v]:
				graph.indegree[u] = graph.indegree[u] + 1

			# backtrack: remove current node from the path and
			# mark it as undiscovered
			path.pop()
			discovered[v] = False

	# print the topological order if
	# all vertices are included in the path
	if len(path) == N:
		print(path)


# Print all topological orderings of a given DAG
def printAllTopologicalOrders(graph):

	# get number of nodes in the graph
	N = len(graph.adjList)

	# create an auxiliary space to keep track of whether vertex is discovered
	discovered = [False] * N

	# list to store the topological order
	path = []

	# find all topological ordering and print them
	findAllTopologicalOrders(graph, path, discovered, N)

# Driver code
if __name__ == '__main__':

	# List of graph edges as per above diagram
	edges = [(5, 2), (5, 0), (4, 0), (4, 1), (2, 3), (3, 1)]

	print("All Topological sorts")

	# Number of nodes in the graph
	N = 6

	# create a graph from edges
	graph = Graph(edges, N)

	# print all topological ordering of the graph
	printAllTopologicalOrders(graph)
```

Time Complexity: O(V*(V+E)), Here V is the number of vertices and E is the number of edges

Auxiliary Space: O(V), for creating an additional array and recursive stack space.

## Shortest path

### Dijkstra's Shortest Paths Algorithm
Dijkstra's Algorithm works on the basis that any subpath B -> D of the shortest path A -> D between vertices A and D is also the shortest path between vertices B and D.

Example of Dijkstra's algorithm:
1. Start with a weighted graph

![image](https://user-images.githubusercontent.com/95273765/195222603-fc98d022-a97f-4080-82ca-807eed5570a7.png)

2. Choose a starting vertex and assign infinity path values to all other devices

![image](https://user-images.githubusercontent.com/95273765/195222656-4cb77f09-72d5-4297-a9e8-bf0a9ab1b842.png)

3. Go to each vertex and update its path length

![image](https://user-images.githubusercontent.com/95273765/195222710-706c5c16-5eee-4e6e-a97a-298be0116ba6.png)

4. If the path length of the adjacent vertex is lesser than new path length, don't update it

![image](https://user-images.githubusercontent.com/95273765/195222801-b1b64ba4-9d10-4baa-b5b6-5e9df93c218e.png)

5. Avoid updating path lengths of already visited vertices

![image](https://user-images.githubusercontent.com/95273765/195222832-04a86198-d274-4e0e-8b1b-f87aca3568df.png)

6. After each iteration, we pick the unvisited vertex with the least path length. So we choose 5 before 7

![image](https://user-images.githubusercontent.com/95273765/195222872-3f148b14-27ad-4ab0-861b-a176c6c39209.png)

7. Notice how the rightmost vertex has its path length updated twice

![image](https://user-images.githubusercontent.com/95273765/195222910-f90151c9-178c-4a6e-bcfa-9772a76d8fb2.png)

8. Repeat until all the vertices have been visited

![image](https://user-images.githubusercontent.com/95273765/195222941-1af949a1-241e-42b2-b1c2-a4ef1e007cc2.png)

``` python
# Dijkstra's Algorithm in Python


import sys

# Providing the graph
vertices = [[0, 0, 1, 1, 0, 0, 0],
            [0, 0, 1, 0, 0, 1, 0],
            [1, 1, 0, 1, 1, 0, 0],
            [1, 0, 1, 0, 0, 0, 1],
            [0, 0, 1, 0, 0, 1, 0],
            [0, 1, 0, 0, 1, 0, 1],
            [0, 0, 0, 1, 0, 1, 0]]

edges = [[0, 0, 1, 2, 0, 0, 0],
         [0, 0, 2, 0, 0, 3, 0],
         [1, 2, 0, 1, 3, 0, 0],
         [2, 0, 1, 0, 0, 0, 1],
         [0, 0, 3, 0, 0, 2, 0],
         [0, 3, 0, 0, 2, 0, 1],
         [0, 0, 0, 1, 0, 1, 0]]

# Find which vertex is to be visited next
def to_be_visited():
    global visited_and_distance
    v = -10
    for index in range(num_of_vertices):
        if visited_and_distance[index][0] == 0 \
            and (v < 0 or visited_and_distance[index][1] <=
                 visited_and_distance[v][1]):
            v = index
    return v


num_of_vertices = len(vertices[0])

visited_and_distance = [[0, 0]]
for i in range(num_of_vertices-1):
    visited_and_distance.append([0, sys.maxsize])

for vertex in range(num_of_vertices):

    # Find next vertex to be visited
    to_visit = to_be_visited()
    for neighbor_index in range(num_of_vertices):

        # Updating new distances
        if vertices[to_visit][neighbor_index] == 1 and \
                visited_and_distance[neighbor_index][0] == 0:
            new_distance = visited_and_distance[to_visit][1] \
                + edges[to_visit][neighbor_index]
            if visited_and_distance[neighbor_index][1] > new_distance:
                visited_and_distance[neighbor_index][1] = new_distance
        
        visited_and_distance[to_visit][0] = 1

i = 0

# Printing the distance
for distance in visited_and_distance:
    print("Distance of ", chr(ord('a') + i),
          " from source vertex: ", distance[1])
    i = i + 1
```

Time Complexity: O(E Log V)
where, E is the number of edges and V is the number of vertices.
This is done by using heap.
A common method may require O(V^2).

Space Complexity: O(V)

## Minimum Spanning Tree

## Backtracking

## Maximum Flow
