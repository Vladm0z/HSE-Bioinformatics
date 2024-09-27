# Set up parameters
#set.seed(42)  # For reproducibility
n_throws <- 10000  # Number of random throws
inside_circle <- 0  # Counter for points inside the circle

# Function to check if point is within distance 1 from origin
is_inside_circle <- function(x, y) {
  return(x^2 + y^2 <= 1)
}

# Simulate random throws and check how many points fall inside the circle
x <- runif(n_throws, -1, 1)  # Generate random x coordinates
y <- runif(n_throws, -1, 1)  # Generate random y coordinates

for (i in 1:n_throws) {
  if (is_inside_circle(x[i], y[i])) {
    inside_circle <- inside_circle + 1
  }
}

# Empirical estimate of the probability
probability <- inside_circle / n_throws
cat("Empirical Probability:", probability, "\n")

# Estimating pi
pi_estimate <- 4 * probability  # Since area of square is 4, and circle's area is pi
cat("Estimated Pi:", pi_estimate, "\n")

# Plotting the dependence of the pi estimate on the number of throws
n_simulation_throws <- 10000  # Number of throws for simulation
pi_estimates <- numeric(n_simulation_throws)

inside_circle <- 0  # Reset counter for simulation

for (i in 1:n_simulation_throws) {
  x <- runif(1, -1, 1)
  y <- runif(1, -1, 1)
  if (is_inside_circle(x, y)) {
    inside_circle <- inside_circle + 1
  }
  pi_estimates[i] <- 4 * (inside_circle / i)
}

# Plot the estimated Pi values vs. number of throws
plot(1:n_simulation_throws, pi_estimates, type="l", col="blue",
     xlab="Number of Throws", ylab="Estimated Pi",
     main="Pi Estimate vs Number of Throws")
abline(h=pi, col="red", lty=2)  # Add a horizontal line at true pi value
legend("topright", legend=c("Estimated Pi", "True Pi"), col=c("blue", "red"), lty=c(1, 2))
