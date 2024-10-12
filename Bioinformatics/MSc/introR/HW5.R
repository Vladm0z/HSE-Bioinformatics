# Part 1
nth_largest <- function(vec, n) {
  # Empty -> NA
  if (length(vec) == 0) {
    return(NA)
  }
  
  sorted_vec <- sort(vec, decreasing = TRUE)
  
  # out of bounds -> NA 
  if (n < 1 || n > length(sorted_vec)) {
    return(NA)
  }
  
  return(sorted_vec[n])
}

# Example test cases
print(nth_largest(c(10, 5, 3, 8, 15), 2))
print(nth_largest(c(5, 5, 1, 5, 2), 2))
print(nth_largest(c(3, 2, 1, 4), 5))
print(nth_largest(c(), 1))



# Part 2
# Create x0 and y0 matrices
x0 <- matrix(seq(-2, 1, length.out = 1000), nrow = 1000, ncol = 1000, byrow = TRUE)
y0 <- t(matrix(seq(-1, 1, length.out = 1000), nrow = 1000, ncol = 1000, byrow = TRUE))

# Initialize x and y matrices
x <- x0
y <- y0

# Iteratively update x and y for 20 iterations
for (i in 1:20) {
  x_new <- x^2 - y^2 + x0
  y <- 2 * x * y + y0
  x <- x_new
}

# Calculate z matrix
z <- t(abs(x^2 + y^2))

# Rank the non-NA values in z
z[!is.na(z)] <- rank(z[!is.na(z)])

# Visualize the Mandelbrot set
image(z^3, col = rev(terrain.colors(1000)))
