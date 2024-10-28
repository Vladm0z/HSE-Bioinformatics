# Load required libraries
library(plyr)
library(dplyr)
library(ggplot2)
library(viridis)

# Load the baseball dataset
data("baseball")

# Filter teams with at least 200 records
teams_with_200_records <- baseball %>%
  group_by(team) %>%
  filter(n() >= 200)

# Create the matrix of player transitions between teams
team_pairs <- expand.grid(unique(teams_with_200_records$team), unique(teams_with_200_records$team))
transition_matrix <- matrix(0, nrow = length(unique(teams_with_200_records$team)), ncol = length(unique(teams_with_200_records$team)))
rownames(transition_matrix) <- unique(teams_with_200_records$team)
colnames(transition_matrix) <- unique(teams_with_200_records$team)

# Fill the matrix with the number of players who played for both teams
for(i in 1:nrow(team_pairs)) {
  team1 <- team_pairs[i, 1]
  team2 <- team_pairs[i, 2]
  players_team1 <- teams_with_200_records %>% filter(team == team1) %>% pull(id)
  players_team2 <- teams_with_200_records %>% filter(team == team2) %>% pull(id)
  transition_matrix[team1, team2] <- length(intersect(players_team1, players_team2))
}

# Normalize the matrix by dividing each cell by the size of the smaller team in the pair
team_sizes <- teams_with_200_records %>%
  group_by(team) %>%
  summarise(team_size = n())

for(i in 1:nrow(team_pairs)) {
  team1 <- team_pairs[i, 1]
  team2 <- team_pairs[i, 2]
  size_team1 <- team_sizes %>% filter(team == team1) %>% pull(team_size)
  size_team2 <- team_sizes %>% filter(team == team2) %>% pull(team_size)
  smaller_team_size <- min(size_team1, size_team2)
  transition_matrix[team1, team2] <- transition_matrix[team1, team2] / smaller_team_size
}

# Calculate the distance matrix by subtracting the normalized matrix from 1
distance_matrix <- 1 - transition_matrix

# Perform multidimensional scaling and plot the results
mds <- cmdscale(distance_matrix, k = 2)
team_sizes_vector <- team_sizes$team_size[match(rownames(mds), team_sizes$team)]

# Define color gradient based on team size using viridis
size_colors <- viridis::viridis(length(unique(team_sizes_vector)))[rank(team_sizes_vector)]

# Plot with colors based on team size and red labels for team names
plot(mds, pch = 19, col = size_colors, cex = sqrt(team_sizes_vector) / 2,
     main = "Team Transition MDS Plot")
text(mds, labels = rownames(mds), adj = c(1.2, 1.2), col = 'red') # labels as in the task 
text(mds[,1], mds[,2], labels = rownames(mds) col = 'blue', cex = 0.8) # centered labels
