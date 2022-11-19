## Master's Theorem
![image](https://user-images.githubusercontent.com/95273765/202820317-54395f4f-7f02-4b3e-9bc1-e8880dd2cdc4.png)


## Karatsuba's Trick
Karatsuba's trick is a method used for fast integer multiplication by a divide and conquer approach.

This happens to be the first algorithm to demonstrate that multiplication can be performed at a lower complexity less than O(n^2) which is by following the classical multiplication technique.

If we divide the given numbers in two halves, we can write as following:
```
X =  Xl*2n/2 + Xr    [Xl and Xr contain leftmost and rightmost n/2 bits of X]
Y =  Yl*2n/2 + Yr    [Yl and Yr contain leftmost and rightmost n/2 bits of Y]
```

The product XY can be written as following:
```
XY = (Xl*2n/2 + Xr)(Yl*2n/2 + Yr)
   = 2n XlYl + 2n/2(XlYr + XrYl) + XrYr
```

If we take a look at the above formula, there are four multiplications of size n/2, so we basically divided the problem of size n into four sub-problems of size n/2.

But that doesn't help because solution of recurrence T(n) = 4T(n/2) + O(n) is O(n^2).

The tricky part of this algorithm is to change the middle two terms to some other form so that only extra multiplication would be sufficient.

The following is tricky expression for middle two terms:
```
XlYr + XrYl = (Xl + Xr)(Yl + Yr) - XlYl- XrYr
```

So the final value of XY becomes
```
XY = 2n XlYl + 2n/2 * [(Xl + Xr)(Yl + Yr) - XlYl - XrYr] + XrYr
```

With the above trick, the recurrence becomes T(n) = 3T(n/2) + O(n) and solution of this recurrence is O(n^(log2 3)).

### Generalizing Karatsuba's Algorithm
By slicing the number into 3 pieces, the time complexity now becomes O(n^(log3 5)) which is better than slicing into two pieces.

The general case: slicing the input number A,B into p+1 many slices
1. For simplicity, let us assume that A and B have exactly (p+1)k bits
2. slice A,B into p+1 pieces
3. trying to find the recursion
4. we get T(n) = (2p+1)T(n/(p+1)+s)+c/(p+1)n
5. since s is constant, its impact can be neglected
6. T(n) = O(n^(logb a)) = O(n^(log(p+1) (2p+1)))

Video: https://www.youtube.com/watch?v=yWI2K4jOjFQ
