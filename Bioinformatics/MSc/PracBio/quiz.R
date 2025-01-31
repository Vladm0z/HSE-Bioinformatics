library(ggplot2)
library(dplyr)
setwd("C:\\Users\\vlad2\\Downloads")

data <- read.csv("dt3.csv")

correlation <- cor(data$gestation..mo., data$newborn..g., method = "pearson")
print(paste("Pearson's correlation coefficient:", round(correlation, 3)))

plot(data$gestation..mo., data$newborn..g.,
     xlab = "Gestation Duration (months)",
     ylab = "Newborn Weight (g)",
     main = "Newborn Weight vs. Gestation Duration")
abline(lm(newborn..g. ~ gestation..mo., data = data), col = "red")

ggplot(data, aes(x = gestation..mo., y = newborn..g.)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(x = "Gestation Duration (months)", y = "Newborn Weight (g)",
       title = "Newborn Weight vs. Gestation Duration") +
  theme_minimal()