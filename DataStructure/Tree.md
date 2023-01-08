## Tree Data Strcuture
A tree is a non-linear hierarchical data structure that consists of nodes connected by edges.

![image](https://user-images.githubusercontent.com/95273765/211179138-46fc85f9-ddff-4022-b763-8fa364c09982.png)

Types of Tree:
1. binary tree
2. binary search tree
3. AVL tree
4. B-Tree

## Tree Traversal
Traversing a tree means visiting every node in the tree.
A hierarchical data structure like a tree can be traversed in different ways.

Three types of traversal:
1. inorder traversal
2. preorder traversal
3. postorder traversal

### Inorder traversal
1. First, visit all the nodes in the left subtree
2. Then the root node
3. Visit all the nodes in the right subtree

```
inorder(root->left)
display(root->data)
inorder(root->right)
```

### Preorder traversal
1. Visit root node
2. Visit all the nodes in the left subtree
3. Visit all the nodes in the right subtree

```
display(root->data)
preorder(root->left)
preorder(root->right)
```

### Postorder traversal
1. Visit all the nodes in the left subtree
2. Visit all the nodes in the right subtree
3. Vist the root node

```
postorder(root->left)
postorder(root->right)
display(root->data)
```

### Implementation
Implementation in Java:
``` java
// Tree traversal in Java

class Node {
  int item;
  Node left, right;

  public Node(int key) {
  item = key;
  left = right = null;
  }
}

class BinaryTree {
  // Root of Binary Tree
  Node root;

  BinaryTree() {
  root = null;
  }

  void postorder(Node node) {
  if (node == null)
    return;

  // Traverse left
  postorder(node.left);
  // Traverse right
  postorder(node.right);
  // Traverse root
  System.out.print(node.item + "->");
  }

  void inorder(Node node) {
  if (node == null)
    return;

  // Traverse left
  inorder(node.left);
  // Traverse root
  System.out.print(node.item + "->");
  // Traverse right
  inorder(node.right);
  }

  void preorder(Node node) {
  if (node == null)
    return;

  // Traverse root
  System.out.print(node.item + "->");
  // Traverse left
  preorder(node.left);
  // Traverse right
  preorder(node.right);
  }

  public static void main(String[] args) {
  BinaryTree tree = new BinaryTree();
  tree.root = new Node(1);
  tree.root.left = new Node(12);
  tree.root.right = new Node(9);
  tree.root.left.left = new Node(5);
  tree.root.left.right = new Node(6);

  System.out.println("Inorder traversal");
  tree.inorder(tree.root);

  System.out.println("\nPreorder traversal ");
  tree.preorder(tree.root);

  System.out.println("\nPostorder traversal");
  tree.postorder(tree.root);
  }
}
```
