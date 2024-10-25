# Load libraries
library(dplyr)
library(ggplot2)

# Load the baseball dataset (assuming it is already available)
# For this example, we'll assume the dataset is called 'baseball_data'
# Example structure: baseball_data <- read.csv("path_to_baseball_data.csv")

# Filter teams with at least 200 records
teams_with_200_records <- baseball_data %>%
  group_by(Team) %>%
  filter(n() >= 200)

# Create a matrix of player transitions between teams
team_pairs <- expand.grid(unique(teams_with_200_records$Team), unique(teams_with_200_records$Team))
transition_matrix <- matrix(0, nrow = length(unique(teams_with_200_records$Team)), ncol = length(unique(teams_with_200_records$Team)))
rownames(transition_matrix) <- unique(teams_with_200_records$Team)
colnames(transition_matrix) <- unique(teams_with_200_records$Team)

# Fill the matrix with the number of players who played for both teams in each pair
for(i in 1:nrow(team_pairs)) {
  team1 <- team_pairs[i, 1]
  team2 <- team_pairs[i, 2]
  players_team1 <- teams_with_200_records %>% filter(Team == team1) %>% pull(Player)
  players_team2 <- teams_with_200_records %>% filter(Team == team2) %>% pull(Player)
  transition_matrix[team1, team2] <- length(intersect(players_team1, players_team2))
}

# Normalize the transition matrix by dividing by the size of the smaller team
team_sizes <- teams_with_200_records %>%
  group_by(Team) %>%
  summarise(team_size = n())

for(i in 1:nrow(team_pairs)) {
  team1 <- team_pairs[i, 1]
  team2 <- team_pairs[i, 2]
  size_team1 <- team_sizes %>% filter(Team == team1) %>% pull(team_size)
  size_team2 <- team_sizes %>% filter(Team == team2) %>% pull(team_size)
  smaller_team_size <- min(size_team1, size_team2)
  transition_matrix[team1, team2] <- transition_matrix[team1, team2] / smaller_team_size
}

# Subtract the normalized transition matrix from 1 to get the distance matrix
distance_matrix <- 1 - transition_matrix

# Perform multidimensional scaling
mds <- cmdscale(distance_matrix, k = 2)

# Plot the results
plot(mds, pch = 19)
text(mds, labels = rownames(mds), adj = c(1.2, 1.2), col = 'red')

# Modify the plot with dot sizes proportional to team sizes
team_sizes_vector <- team_sizes$team_size[match(rownames(mds), team_sizes$Team)]
plot(mds, pch = 19, cex = sqrt(team_sizes_vector) / 2)
text(mds, labels = rownames(mds), adj = c(1.2, 1.2), col = 'red')
