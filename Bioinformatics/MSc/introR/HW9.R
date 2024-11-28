setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")
getwd()

library(dplyr)

data <- read.csv("CaseStudy2_Bean_MutantProteinContent_Data.csv")
head(data)
summary(data)

total_mean <- mean(data$ProteinContent)
sst <- sum((data$ProteinContent - total_mean)^2)
cat("Total Sum of Squares:", sst, "\n")

# Group by Mutant
group_means <- data %>%
  group_by(Mutant) %>%
  summarize(mean_protein = mean(ProteinContent), n = n())

cat("Group Means and Sample Sizes:\n")
print(group_means)

ssg <- sum(group_means$n * (group_means$mean_protein - total_mean)^2)
cat("Sum of Squares Between Groups (SSG):", ssg, "\n")
ssr <- sst - ssg
cat("Residual Sum of Squares (SSR):", ssr, "\n")

df_between <- length(unique(data$Mutant)) - 1
df_within <- nrow(data) - length(unique(data$Mutant))

ms_between <- ssg / df_between
ms_within <- ssr / df_within

f_stat <- ms_between / ms_within
cat("F-statistic:", f_stat, "\n")

model <- lm(ProteinContent ~ Mutant, data = data)
anova_results <- anova(model)
cat("ANOVA Results:\n")
print(anova_results)