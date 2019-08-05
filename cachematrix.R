## These two functions are used to create a special object that stores a numeric 
## matrix and computes & caches its inverse
##
## Usage: run makeCacheMatrix first to create a cached matrix  
## Always use 'set' to modify chached matrix
## call cacheSolve on the cached matrix to retrieve/compute inverse


## Creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) 
{
    m <- NULL
    set <- function(y) 
    {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) m <<- inverse
    getinverse <- function() m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## Computes the inverse of the special "matrix" returned by makeCacheMatrix. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve will retrieve the inverse from the cache.
##
## Preconditions:  the square matrix x is always invertible
cacheSolve <- function(x, ...) 
{
    m <- x$getinverse()
    if(!is.null(m)) 
    {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}
