## BFS and DFS

### BFS
A standard BFS implementation puts each vertex of the graph into one of two categories:
1. visited
2. not visited

The purpose of the algorithm is to mark each vertex as visited while avoiding cycles.

The algorithm works as follows:
1. start by putting any one of the graph's vertices at the back of a queue.
2. take the front item of the queue and add it to the visited list.
3. create a list of that vertex's adjacent nodes. Add the ones which aren't in the visited list to the back of the queue.
4. keep repeating steps 2 and 3 until the queue is empty.

BFS illustration:
1. undirected graph with 5 vertices

![image](https://user-images.githubusercontent.com/95273765/195517463-2e5e3720-b1c6-4904-af18-f46d7d92dd2c.png)

2. visit start vertex and add its adjacent vertices to queue

![image](https://user-images.githubusercontent.com/95273765/195518656-239f6327-1e5c-4b50-b7fc-6d49849bf6ae.png)

3. Next, we visit the element at the front of the queue and add its adjacent nodes to the queue if it is not added.

![image](https://user-images.githubusercontent.com/95273765/195518989-1856f20f-09eb-4714-891d-049ae2272d18.png)

4. visit 2 and add its adjacent nodes

![image](https://user-images.githubusercontent.com/95273765/195519190-33312394-23ba-4c70-9177-38425be21300.png)

![image](https://user-images.githubusercontent.com/95273765/195519224-a81eb03e-2648-4784-a76f-9d6ab15e1a78.png)

5. visit the last remaining item in the queue to check if it has unvisited neighbors

![image](https://user-images.githubusercontent.com/95273765/195519327-8e60796f-041a-4922-aa3b-33651afe725d.png)

``` python
# BFS algorithm in Python


import collections

# BFS algorithm
def bfs(graph, root):

    visited, queue = set(), collections.deque([root])
    visited.add(root)

    while queue:

        # Dequeue a vertex from queue
        vertex = queue.popleft()
        print(str(vertex) + " ", end="")

        # If not visited, mark it as visited, and
        # enqueue it
        for neighbour in graph[vertex]:
            if neighbour not in visited:
                visited.add(neighbour)
                queue.append(neighbour)


if __name__ == '__main__':
    graph = {0: [1, 2], 1: [2], 2: [3], 3: [1, 2]}
    print("Following is Breadth First Traversal: ")
    bfs(graph, 0)
```

The time complexity of BFS is O(V+E).

The space complexity of BFS is O(V).

### DFS
The DFS algorithm works as follows:
1. Start by putting any one of the graph's vertices on top of a stack.
2. Take the top item of the stack and add it to the visited list.
3. Create a list of that vertex's adjacent nodes. Add the ones which aren't in the visited list to the top of the stack.
4. Keep repeating steps 2 and 3 until the stack is empty.

DFS example:
1. Undirected graph with 5 vertices

![image](https://user-images.githubusercontent.com/95273765/195520130-bfba8fc2-3d4c-4694-856b-cfdd6a0a0647.png)

2. visit the element and put it in the visited list

![image](https://user-images.githubusercontent.com/95273765/195520259-8710df0d-3f23-439b-a225-eea5fbf32318.png)

3. visit the element at the top of stack

![image](https://user-images.githubusercontent.com/95273765/195520345-41b5d5c0-b563-4e49-a893-f92c6f459a88.png)

4. visit the next vertex and its adjacent nodes

![image](https://user-images.githubusercontent.com/95273765/195520620-f2548291-5612-4e18-833d-66a85ba3db9b.png)

![image](https://user-images.githubusercontent.com/95273765/195520646-77a6e1ae-0534-49d5-91f6-81611ba57036.png)

5. finally visit the rest nodes in the stack

![image](https://user-images.githubusercontent.com/95273765/195520771-27f07b4f-1fd3-4064-866c-7090dd0835c1.png)

``` python
# DFS algorithm in Python

# DFS algorithm
def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()
    visited.add(start)

    print(start)

    for next in graph[start] - visited:
        dfs(graph, next, visited)
    return visited

graph = {'0': set(['1', '2']),
         '1': set(['0', '3', '4']),
         '2': set(['0']),
         '3': set(['1']),
         '4': set(['2', '3'])}

dfs(graph, '0')
```

The time complexity of BFS is O(V+E).

The space complexity of BFS is O(V).

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

### Bellman Ford's Algorithm
It is similar to Dijkstra's algorithm but it can work with graphs in which edges can have negative weights.

How Bellman Ford's algorithm works
Bellman Ford algorithm works by overestimating the length of the path from the starting vertex to all over vertices.
Then it iteratively relaxes those estimates by finding new paths that are shorter than the previously overestimated paths.

1. start with the weighted graph

![image](https://user-images.githubusercontent.com/95273765/195522971-0bf70f03-6050-4030-96c1-98a6cf36797f.png)

2. choose a starting vertex and assign infinity path values to all other vertices

![image](https://user-images.githubusercontent.com/95273765/195523135-cb7b37ca-201c-4592-b869-8c69123c5e4a.png)

3. visit each edge and relax the path distance if they are inaccurate

![image](https://user-images.githubusercontent.com/95273765/195523471-a61d9361-ebb1-434a-8a42-0adfecc8194b.png)

4. we need to do this V times because in the worst case, a vertex's path length might need to be readjusted V times.

![image](https://user-images.githubusercontent.com/95273765/195523617-3760f98b-7dab-4b95-8024-66c951ddc4af.png)

5. Notice how the vertex at the top right corner had its path length adjusted

![image](https://user-images.githubusercontent.com/95273765/195523898-aa193255-6667-4b7f-acdc-0ec6cfacec54.png)

6. After all the vertices have their path lengths, we check if a negative cycle is present

![image](https://user-images.githubusercontent.com/95273765/195523995-e399c1f5-ca25-4c0c-948b-07f0c1d6a339.png)

``` python
# Bellman Ford Algorithm in Python

class Graph:

    def __init__(self, vertices):
        self.V = vertices   # Total number of vertices in the graph
        self.graph = []     # Array of edges

    # Add edges
    def add_edge(self, s, d, w):
        self.graph.append([s, d, w])

    # Print the solution
    def print_solution(self, dist):
        print("Vertex Distance from Source")
        for i in range(self.V):
            print("{0}\t\t{1}".format(i, dist[i]))

    def bellman_ford(self, src):

        # Step 1: fill the distance array and predecessor array
        dist = [float("Inf")] * self.V
        # Mark the source vertex
        dist[src] = 0

        # Step 2: relax edges |V| - 1 times
        for _ in range(self.V - 1):
            for s, d, w in self.graph:
                if dist[s] != float("Inf") and dist[s] + w < dist[d]:
                    dist[d] = dist[s] + w

        # Step 3: detect negative cycle
        # if value changes then we have a negative cycle in the graph
        # and we cannot find the shortest distances
        for s, d, w in self.graph:
            if dist[s] != float("Inf") and dist[s] + w < dist[d]:
                print("Graph contains negative weight cycle")
                return

        # No negative weight cycle found!
        # Print the distance and predecessor array
        self.print_solution(dist)


g = Graph(5)
g.add_edge(0, 1, 5)
g.add_edge(0, 2, 4)
g.add_edge(1, 3, 3)
g.add_edge(2, 1, 6)
g.add_edge(3, 2, 2)

g.bellman_ford(0)
```

The time complexity in worst case is O(VE).

The space complexity is O(V).

## Minimum Spanning Tree

## Backtracking

## Maximum Flow
