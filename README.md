### Introduction

This R function is able to cache potentially time-consuming computations 
by caching the inverse of a matrix rather than computing it repeatedly.  

### Functions

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

We assume that the matrix supplied is **always invertible**.

### Use examples

Creating a random test matrix
```
> testmat <- matrix(rnorm(9, 2), nrow = 3)
> testmat
          [,1]     [,2]      [,3]
[1,] 0.1399913 3.779324 4.4677439
[2,] 0.8911275 2.126815 1.6399917
[3,] 2.5544707 2.966642 0.5110814
```

Checking if our matrix is invertible - just in case!  
```
> det(testmat)
[1] 1.121016
```
Creating a cached matrix
```
> specialmat <- makeCacheMatrix(testmat)
```
Computing inverse matrix. Since it's the first time, no cached info is available and cacheSolve will really compute the inverse
```
> cacheSolve(specialmat)
          [,1]       [,2]      [,3]
[1,] -3.370420  10.100355 -2.947333
[2,]  3.330794 -10.116874  3.346737
[3,] -2.488128   8.241515 -2.738698
```
Running cacheSolve once again, cached inverse matrix is retrieved, a 
message is displayed
```
> resultmat <- cacheSolve(specialmat)
getting cached data
```
Checking if result is correct
```
> testmat %*% resultmat
              [,1] [,2]          [,3]
[1,]  1.000000e+00    0  0.000000e+00
[2,]  0.000000e+00    1 -8.881784e-16
[3,] -2.220446e-16    0  1.000000e+00
```
If we want to modify our matrix, we can use `get` and `set`
```
> specialmat$set(specialmat$get()*3)
```
Computing inverse matrix again: `cacheSolve` will find out the matrix has changed and will compute the inverse without retrieving 
cached result. In fact, no "getting cached data" is displayed.
```
> cacheSolve(specialmat)
           [,1]      [,2]       [,3]
[1,] -1.1234732  3.366785 -0.9824442
[2,]  1.1102646 -3.372291  1.1155791
[3,] -0.8293761  2.747172 -0.9128995
```
