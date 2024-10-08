# Part 1

# 1. What type is the variable mtcars?
typeof(mtcars)   # data.frame

# 2. What type is the second column of mtcars?
typeof(mtcars[, 2])  # 'double'

# 3. How many cylinders does a Fiat 128 have? Print all cars that have the same number of cylinders.
fiat_cylinders <- mtcars["Fiat 128", "cyl"]
same_cylinders <- mtcars[mtcars$cyl == fiat_cylinders, ]
print(same_cylinders)

# 4. What is the minimum number of cylinders? Select all cars with the minimum number of cylinders.
min_cylinders <- min(mtcars$cyl)
min_cyl_cars <- mtcars[mtcars$cyl == min_cylinders, ]
print(min_cyl_cars)

# 5. Calculate the correlation between all car properties using cor(mtcars)
correlation_matrix <- cor(mtcars)
print(correlation_matrix)

# 6. What type is the result of the cor function?
typeof(correlation_matrix)  # 'double'

# 7. With which properties of gasoline consumption is the correlation coefficient less than -0.7 observed?
# Gasoline consumption is measured by mpg (miles per gallon)
negative_corr <- correlation_matrix[,"mpg"]
print(negative_corr[negative_corr < -0.7])



# Part 2

# 1. Create a vector of length 100 filled with random normally distributed values with mean 40 and variance 10
vector <- rnorm(100, mean = 40, sd = sqrt(10))
print(vector)

# 2. Take a subvector with every third value of the original vector
subvector_third <- vector[seq(1, length(vector), by = 3)]
print(subvector_third)

# 3. Take a subvector not containing every fifth value of the original vector
subvector_without_fifth <- vector[-seq(5, length(vector), by = 5)]
print(subvector_without_fifth)

# 4. Take a subvector containing only numbers with an even integer part
even_subvector <- vector[floor(vector) %% 2 == 0]
print(even_subvector)



# Part 3

# 1. Design a structure (list) to store information about the tree
tree <- list(
  left = list(
    left = "A",
    right = list(
      left = "B",
      right = "C"
    )
  ),
  right = list(
    left = "D",
    right = "E"
  )
)

# 2. Get from this structure a vector with the names of all leaves
get_leaves <- function(node) {
  if (is.character(node)) {
    return(node)
  } else {
    return(c(get_leaves(node$left), get_leaves(node$right)))
  }
}

all_leaves <- get_leaves(tree)
print(all_leaves)

# 3. Extract the left subtree
left_subtree <- tree$left
print(left_subtree)

# 4. Extract the node with leaves 'B' and 'C'
bc_node <- tree$left$right
print(bc_node)

