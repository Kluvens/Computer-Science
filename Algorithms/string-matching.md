## Rabin - Karp Algorithm
We compute a hash value for the string B = b0b1b2 ... bm in the following way.

We will assume that strings A and B are in an alphabet Alpha with d many symbols in total.

Thus, we can identify each string with a sequence of integers by mapping each symbol si into a corresponding integer i:
Alpha = {s0, s1, s2, ... , sd−1} −→ {0, 1, 2, ... , d − 1}.

To any string B = b0b1b2 ... bm-1 we can now associate an integer whose digits in base d are integers corresponding to each symbol in B:
h(B) = h(b0b1b2 ... bm-1) = d^(m-1)bo + d^(m-2)b1 + ... + d\*bm-2 + bm-1

This can be done efficiently using the Horner's rule:
h(B) = bm−1 + d(bm−2 + d(bm−3 + d(bm−4 + ... + d(b1 + d · b0)))...).

Next we choose a large prime number p such that  (d + 1) p still fits into a single register and define the hash value of B as H(B) = h(B) mod p.

Recall that A = a0a1a2a3 ...... asas+1 ... as+m−1 ...... aN−1 where N >> m.

We want to find efficiently all s such that the string of length m of the form asas+1 ... as+m−1 and string b0b1 ... bm−1 are equal.

For each contiguous substring As = asas+1 ... as+m−1 of string A we also compute its hash value as
H(As) = (d^(m−1)as + d^(m−2)as+1 + ... + d\*as+m−2 + as+m−1) mod p.

We can now compare the hash values H(B) and H(As) and do a symbol-by-symbol matching only if H(B) = H(As).

Clearly, such an algorithm would be faster than the native symbol-by-symbol comparison only if we can compute the hash values of substrings As faster than what it takes to compare strings B and As character by character.

This is where recursion comes into play:
we do not have compute the hash values H(As+1) of As+1 = as+1as+2 ... as+m 'from scratch', but we can compute it efficiently from the hash value H(As) of As = asas+1 ... as+m−1 as follows.

Since H(As) = (d^(m−1)as + d^(m−2)as+1 + ... d\*as+m−2 + as+m−1) mod p
by multiplying both sides by d we obtain
d · H(As)) mod p = (d^(m)as + d^(m−1)as+1 + ... d · as+m−1) mod p
= (d^(m)as + (d^(m−1)as+1 + ... d^(2)as+m−2 + d as+m−1 + as+m) mod p − as+m) mod p
= (d^(m)as + H(As+1) − as+m) mod p

Consequently, H(As+1) = (d · H(As) − d^(m)as + as+m) mod p.

Note that (d^(m)as) mod p = ((d^(m) mod p)as) mod p
and that the value d^m mod p can be precomputed and stored.

Also, (−d^(m)as + as+m) mod p < p

Thus, since H(As) < p we obtain  d · H(As) + (−d^(m)as + as+m) mod p < (d + 1)p

Thus, since we chose p such that (d + 1) p fits in a register, all the values
and the intermediate results for the above expression also fit in a single
register.

Thus, for every s except s = 0 the value of H(As) can be computed in
constant time independent of the length of the strings A and B.

Thus, we first compute H(B) and H(A0) using the Horner’s rule.

Subsequent values of H(As) for s > 0 are computed in constant time using the above recursion.

H(As) is compared with H(B) and if they are equal the strings As and B are compared by brute force character by character to see if they are equal.

Since p was chosen large, the false positives when H(As) = H(B) but As ̸= B are very unlikely, which makes the algorithm run fast in practice

However, as always when we use hashing, we cannot guarantee the worst
case performance.

So we now look for algorithms whose worst case performance can be guaranteed.

The basic idea of this algorithm is that if two strings are the same, their hash values must also be the same.\

**Example**: given string 'Geeksforgeeks' and we want to check if 'geek' matches in the given string.

The length of 'geek' is 4 and we calculate hash('geek').

The window size is 4 and every time we move the window to the right a bit.
Every time we check hash('geek') and hash(window).

That is, Geek, eeks, eksf, ksfo, sfor, forg ...

## String Matching Finite Automata

## The Knuth-Morris-Pratt Algorithm
```
1: function
Compute − Prefix − Function(B)
2:  m ← length[B]
3:  let π[1..m] be a new array
4:  π[1] = 0
5:  k = 0
6:  for q = 2 to m do
7:    while k > 0 and
        B[k + 1] ̸= B[q]
8:    k = π[k]
9:    if B[k + 1] == B[q]
10:     k = k + 1
11:   π[q] = k
12:   end for
13:   return π
14: end function
```

![image](https://user-images.githubusercontent.com/95273765/202318708-910631a4-23d1-46ce-819c-1b1c932ed95c.png)

Assume that length of B is m and that
we have already found that π[q − 1] =
k; to compute π[q] we check if B[q] =
B[k + 1]; if true then π[q] = k + 1; if
not true then we find π[k] = p; if now
B[q] = B[p + 1] then π[q] = p + 1.
