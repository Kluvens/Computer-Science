## Kadane’s Algorithm
Kadane’s Algorithm is an iterative dynamic programming algorithm. 
It calculates the maximum sum subarray ending at a particular position by using the maximum sum subarray ending at the previous position.

## Find the Majority Elements in a List (Boyer–Moore Majority Vote Algorithm)
The Boyer–Moore majority vote algorithm is an algorithm for finding the majority of a sequence of elements using linear time and constant space.

## Sum of All Odd Length Subarrays
In total, there are `k = (i + 1) * (n - i)` subarrays, that contains `A[i]`.
And there are `(k + 1) / 2` subarrays with odd length, that contains `A[i]`.
And there are `k / 2` subarrays with even length, that contains `A[i]`.

`A[i]` will be counted `((i + 1) * (n - i) + 1) / 2` times for our question.

``` java
class Solution {
    public int sumOddLengthSubarrays(int[] A) {
        int res = 0, n = A.length;
        for (int i = 0; i < n; ++i) {
            res += ((i + 1) * (n - i) + 1) / 2 * A[i];
        }
        return res;
    }
}
```
