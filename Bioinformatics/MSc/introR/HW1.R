# Set working directory
setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")
getwd()

# 1. Load the data
# Reading the data from a text file
data <- read.table("hw1.txt", header = TRUE)
print(colnames(data))  # Check column names

# Rename columns for easier access
colnames(data) <- c("CPY14", "RMD4", "htVWQ")

# 2. Correlation analysis between gene pairs
# Compute the Pearson and Spearman correlation matrices
cor_matrix_pearson <- cor(data, method = "pearson")
cor_matrix_spearman <- cor(data, method = "spearman")

# Print correlation matrices
print("Pearson Correlation Matrix:")
print(cor_matrix_pearson)

print("Spearman Correlation Matrix:")
print(cor_matrix_spearman)

# Since the distributions are not normal, Spearman's correlation was used to assess 
# the degree of monotonic dependence between pairs of genes.

# Find significant correlations (|correlation| > 0.7, excluding self-correlations)
significant_correlations_pearson <- which(abs(cor_matrix_pearson) > 0.7 & cor_matrix_pearson != 1, arr.ind = TRUE)
significant_correlations_spearman <- which(abs(cor_matrix_spearman) > 0.7 & cor_matrix_spearman != 1, arr.ind = TRUE)

# Output significant correlations
cat("\nSignificant Pearson correlations:\n")
if (nrow(significant_correlations_pearson) > 0) {
  for (i in 1:nrow(significant_correlations_pearson)) {
    row <- significant_correlations_pearson[i, 1]
    col <- significant_correlations_pearson[i, 2]
    cat(paste("Significant correlation between", colnames(data)[row], "and", colnames(data)[col], 
              ": cor =", round(cor_matrix_pearson[row, col], 3), "\n"))
  }
} else {
  cat("No significant Pearson correlations found.\n")
}

cat("\nSignificant Spearman correlations:\n")
if (nrow(significant_correlations_spearman) > 0) {
  for (i in 1:nrow(significant_correlations_spearman)) {
    row <- significant_correlations_spearman[i, 1]
    col <- significant_correlations_spearman[i, 2]
    cat(paste("Significant correlation between", colnames(data)[row], "and", colnames(data)[col], 
              ": cor =", round(cor_matrix_spearman[row, col], 3), "\n"))
  }
} else {
  cat("No significant Spearman correlations found.\n")
}

# === Conclusion: Correlation Analysis ===
# From both Pearson and Spearman tests:
# - There is a significant positive correlation between CPY14 and RMD4, 
#   with Pearson = 0.83 and Spearman = 0.835.
# - There is no significant correlation between RMD4 and htVWQ, and between CPY14 and htVWQ.

# 3. Paired t-tests for differences in gene expression
t_test_CPY14_RMD4 <- t.test(data$CPY14, data$RMD4, paired = TRUE)
t_test_CPY14_htVWQ <- t.test(data$CPY14, data$htVWQ, paired = TRUE)
t_test_RMD4_htVWQ <- t.test(data$RMD4, data$htVWQ, paired = TRUE)

# Paired t-tests were used to assess differences in average gene expression levels
# between pairs of genes under different conditions.

# Print paired t-test results
cat("\nPaired t-tests results:\n")
cat("CPY14 vs RMD4: p-value =", t_test_CPY14_RMD4$p.value, "\n")
cat("CPY14 vs htVWQ: p-value =", t_test_CPY14_htVWQ$p.value, "\n")
cat("RMD4 vs htVWQ: p-value =", t_test_RMD4_htVWQ$p.value, "\n")

# === Conclusion: Paired t-tests ===
# The paired t-tests indicate:
# - A highly significant difference in average expression between CPY14 and RMD4 (p-value < 0.00001).
# - A significant difference between CPY14 and htVWQ (p-value ≈ 0.0005).
# - No significant difference between RMD4 and htVWQ (p-value ≈ 0.27).

# 4. Visualize relationships with scatter plots
library(ggplot2)

plot_CPY14_RMD4 <- ggplot(data, aes(x = CPY14, y = RMD4)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("CPY14 vs RMD4")

plot_CPY14_htVWQ <- ggplot(data, aes(x = CPY14, y = htVWQ)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("CPY14 vs htVWQ")

plot_RMD4_htVWQ <- ggplot(data, aes(x = RMD4, y = htVWQ)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("RMD4 vs htVWQ")

# Scatter plots with linear regression lines show the relationship between pairs of genes.

# Display scatter plots
print(plot_CPY14_RMD4)
print(plot_CPY14_htVWQ)
print(plot_RMD4_htVWQ)

# Save scatter plots
ggsave("CPY14_vs_RMD4.png", plot_CPY14_RMD4)
ggsave("CPY14_vs_htVWQ.png", plot_CPY14_htVWQ)
ggsave("RMD4_vs_htVWQ.png", plot_RMD4_htVWQ)

# 5. Boxplot and density plots for gene expression
library(reshape2)
boxplot_data <- melt(data)
boxplot_avg <- ggplot(boxplot_data, aes(x = variable, y = value, fill = variable)) + 
  geom_boxplot() +
  ggtitle("Boxplot of Gene Expression Levels")

# Boxplots visualize the distribution of gene expression levels for each gene.

# Display boxplot
print(boxplot_avg)

# Save boxplot
ggsave("boxplot_avg_expression.png", boxplot_avg)

# Density plots for each gene on the same plot
density_plot <- ggplot(data, aes(x = CPY14)) +
  geom_density(aes(y = ..density.., color = "CPY14")) +
  geom_density(aes(x = RMD4, y = ..density.., color = "RMD4")) +
  geom_density(aes(x = htVWQ, y = ..density.., color = "htVWQ")) +
  ggtitle("Density Plot of Gene Expression Levels") +
  labs(color = "Gene")

# Density plots show the distribution of gene expression values and can help assess normality.

# Display density plot
print(density_plot)

# Save density plot
ggsave("gene_expression_density.png", density_plot)

# 6. Save analysis results in text files
# Create data frame for correlation and t-test results
results_corr <- data.frame(
  gene_1 = c("CPY14", "RMD4", "htVWQ"),
  gene_2 = c("RMD4", "htVWQ", "CPY14"),
  pearson_correlation = c(cor_matrix_pearson[1,2], cor_matrix_pearson[2,3], cor_matrix_pearson[3,1]),
  spearman_correlation = c(cor_matrix_spearman[1,2], cor_matrix_spearman[2,3], cor_matrix_spearman[3,1])
)

results_t_test <- data.frame(
  gene_1 = c("CPY14", "RMD4", "htVWQ"),
  gene_2 = c("RMD4", "htVWQ", "CPY14"),
  t_test_p_value = c(t_test_CPY14_RMD4$p.value, t_test_CPY14_htVWQ$p.value, t_test_RMD4_htVWQ$p.value)
)

# Save results to files
write.table(results_corr, file="gene_pairs_corr_results.txt", sep="\t", row.names=FALSE, col.names=TRUE)
write.table(results_t_test, file="gene_pairs_ttest_results.txt", sep="\t", row.names=FALSE, col.names=TRUE)

print("Results saved to gene_pairs_corr_results.txt and gene_pairs_ttest_results.txt")

# 7. Cleanup environment
rm(list = ls())  # Clear all variables
dev.off(dev.list()["RStudioGD"])  # Close any open graphical windows