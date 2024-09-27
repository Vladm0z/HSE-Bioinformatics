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

# 3. Paired t-tests for differences in gene expression
t_test_CPY14_RMD4 <- t.test(data$CPY14, data$RMD4, paired = TRUE)
t_test_CPY14_htVWQ <- t.test(data$CPY14, data$htVWQ, paired = TRUE)
t_test_RMD4_htVWQ <- t.test(data$RMD4, data$htVWQ, paired = TRUE)

# Print paired t-test results
cat("\nPaired t-tests results:\n")
cat("CPY14 vs RMD4: p-value =", t_test_CPY14_RMD4$p.value, "\n")
cat("CPY14 vs htVWQ: p-value =", t_test_CPY14_htVWQ$p.value, "\n")
cat("RMD4 vs htVWQ: p-value =", t_test_RMD4_htVWQ$p.value, "\n")

# 4. Visualize relationships with scatter plots using base R functions
# Save scatter plot for CPY14 vs RMD4
png("CPY14_vs_RMD4.png")
plot(data$CPY14, data$RMD4, main = "CPY14 vs RMD4", xlab = "CPY14", ylab = "RMD4", pch = 19, col = "blue")
abline(lm(data$RMD4 ~ data$CPY14), col = "red")  # Add linear regression line
dev.off()

# Save scatter plot for CPY14 vs htVWQ
png("CPY14_vs_htVWQ.png")
plot(data$CPY14, data$htVWQ, main = "CPY14 vs htVWQ", xlab = "CPY14", ylab = "htVWQ", pch = 19, col = "green")
abline(lm(data$htVWQ ~ data$CPY14), col = "red")  # Add linear regression line
dev.off()

# Save scatter plot for RMD4 vs htVWQ
png("RMD4_vs_htVWQ.png")
plot(data$RMD4, data$htVWQ, main = "RMD4 vs htVWQ", xlab = "RMD4", ylab = "htVWQ", pch = 19, col = "purple")
abline(lm(data$htVWQ ~ data$RMD4), col = "red")  # Add linear regression line
dev.off()

# 5. Boxplot and density plots for gene expression using base R functions
# Save boxplot for gene expression levels
png("boxplot_avg_expression.png")
boxplot(data, main = "Boxplot of Gene Expression Levels", names = c("CPY14", "RMD4", "htVWQ"), col = c("blue", "green", "purple"))
dev.off()

# Save density plot for gene expression levels
png("gene_expression_density.png")
plot(density(data$CPY14), col = "blue", main = "Density Plot of Gene Expression Levels", xlab = "Expression Levels")
lines(density(data$RMD4), col = "green")
lines(density(data$htVWQ), col = "purple")
legend("topright", legend = c("CPY14", "RMD4", "htVWQ"), fill = c("blue", "green", "purple"))
dev.off()

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
