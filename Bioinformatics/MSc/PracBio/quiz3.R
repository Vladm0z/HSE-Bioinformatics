setwd("C:\\Users\\vlad2\\Downloads")

data <- read.csv("dt4.csv")

data$time <- 1:nrow(data)

library(ggplot2)

ggplot(data, aes(x = time)) +
  geom_line(aes(y = Prey, color = "Prey"), size = 1) +
  geom_line(aes(y = Predator, color = "Predator"), size = 1) +
  labs(title = "Changes in Predator and Prey Populations Over Time",
       x = "Time", y = "Population Size") +
  scale_color_manual(values = c("Prey" = "blue", "Predator" = "red")) +
  theme_minimal()

ggplot(data, aes(x = Prey, y = Predator)) +
  geom_path(color = "red", size = 1) +
  geom_point(color = "black", size = 1) +
  labs(title = "Phase Portrait of Predator and Prey",
       x = "Prey Population", y = "Predator Population") +
  theme_minimal()