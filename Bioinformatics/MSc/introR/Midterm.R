# Problem 4
pairwise_distance_matrix <- function(words) {
  n <- length(words)
  
  # <2 words
  if (n == 0) {
    return(matrix(nrow = 0, ncol = 0))
  } else if (n == 1) {
    return(matrix(0, nrow = 1, ncol = 1))
  }
  # NA matrix
  distance_matrix <- matrix(NA, n, n)
  
  # Pairwise distances
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      mismatches <- sum(strsplit(words[i], "")[[1]] != strsplit(words[j], "")[[1]])
      distance_matrix[i, j] <- mismatches / nchar(words[i])
      distance_matrix[j, i] <- distance_matrix[i, j]  # Symmetric matrix
    }
  }
  diag(distance_matrix) <- 0
  return(distance_matrix)
}

# Tests
words <- c("test", "test", "text", "tabt", "aaaa", "aaba")
pairwise_distance_matrix(words)

words <- c("test")
pairwise_distance_matrix(words)

words <- c()
pairwise_distance_matrix(words)






# Problem 6
moon_trajectory <- function(r1, r2, v1, v2, t) {
  x_moon <- numeric(length(t))
  y_moon <- numeric(length(t))
  
  for (i in 1:length(t)) {
    # Earth's position relative to the Sun
    x_earth <- r1 * cos(v1 * t[i])
    y_earth <- r1 * sin(v1 * t[i])
    
    # Moon's position relative to the Earth
    x_moon[i] <- x_earth + r2 * cos(v2 * t[i])
    y_moon[i] <- y_earth + r2 * sin(v2 * t[i])
  }
  
  # Plot the trajectory
  plot(x_moon, y_moon, type = "l", xlab = "X Position", ylab = "Y Position", main = "Moon Trajectory Relative to the Sun")
}

# Tests
t1 <- seq(0, 10, by = 0.1)

# Normal
moon_trajectory(r1 = 1, r2 = 0.1, v1 = 1, v2 = 10, t = t1)

# High-speed
moon_trajectory(r1 = 1, r2 = 0.1, v1 = 2, v2 = 20, t = t1)

# Small r
moon_trajectory(r1 = 0.1, r2 = 0.01, v1 = 1, v2 = 10, t = seq(0, 5, by = 0.05))

# Large t
moon_trajectory(r1 = 1, r2 = 0.1, v1 = 1, v2 = 5, t = t3 <- seq(0, 20, by = 0.01))

# Small t
moon_trajectory(r1 = 1, r2 = 0.1, v1 = 1, v2 = 10, t = seq(0, 1, by = 0.01))