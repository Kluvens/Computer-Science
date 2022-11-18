## The Huffman Code
Huffman code is a way to encode information using variable-length strings to represent symbols depending on how frequently they appear.
(a data compression algorithm)

Goal: reduce the code tree

1. take the 2 characters with the lowest frequency
2. make a 2 leaf node tree from them

![image](https://user-images.githubusercontent.com/95273765/202588427-eaa0d1d8-5f2d-4a87-93c2-68e466304867.png)

3. create a new internal with a frequency equal to the sum of the two nodes frequencies.
Make the first extracted node as its left child and the other extracted node as its right child.
4. repeat step 2 and step 3 until the heap contains only on node. The remaining node is the root node and the tree is complete.

![image](https://user-images.githubusercontent.com/95273765/202588782-106bacd6-980c-447c-a139-ebe843007d79.png)

![image](https://user-images.githubusercontent.com/95273765/202588834-a22982bd-6d08-47cd-b61f-72c078ba738a.png)

![image](https://user-images.githubusercontent.com/95273765/202589035-4a5ee3d7-7968-4b17-a6ba-062c4c56366d.png)

Video: https://www.youtube.com/watch?v=dM6us854Jk0

