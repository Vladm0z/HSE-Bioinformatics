# Set working directory
setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")
getwd()

# Load required libraries
library(dplyr)

# Load the data
data <- read.csv("CaseStudy2_Bean_MutantProteinContent_Data.csv")

# Inspect the data
head(data)
summary(data)

# Calculate the total sum of squares (SST)
total_mean <- mean(data$ProteinContent)
sst <- sum((data$ProteinContent - total_mean)^2)
cat("Total Sum of Squares (SST):", sst, "\n")

# Group data by Mutant and calculate means and sample sizes
group_means <- data %>%
  group_by(Mutant) %>%
  summarize(mean_protein = mean(ProteinContent), n = n())

cat("Group Means and Sample Sizes:\n")
print(group_means)

# Calculate the sum of squares between groups (SSG)
ssg <- sum(group_means$n * (group_means$mean_protein - total_mean)^2)
cat("Sum of Squares Between Groups (SSG):", ssg, "\n")

# Calculate the residual sum of squares (SSR)
ssr <- sst - ssg
cat("Residual Sum of Squares (SSR):", ssr, "\n")

# Degrees of freedom
df_between <- length(unique(data$Mutant)) - 1
df_within <- nrow(data) - length(unique(data$Mutant))

# Mean squares
ms_between <- ssg / df_between
ms_within <- ssr / df_within

# F-statistic
f_stat <- ms_between / ms_within
cat("F-statistic:", f_stat, "\n")

# Fit a linear model and perform ANOVA
model <- lm(ProteinContent ~ Mutant, data = data)
anova_results <- anova(model)
cat("ANOVA Results:\n")
print(anova_results)