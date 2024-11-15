# Step 1: Generate random data for healthy samples
set.seed(123) # For reproducibility
healthy <- matrix(rnorm(10000 * 5, mean = 0, sd = 1), nrow = 10000, ncol = 5)

# Step 2: Generate random data for cancer samples
cancer <- matrix(rnorm(10000 * 5, mean = 0, sd = 1), nrow = 10000, ncol = 5)
cancer[1:500, ] <- matrix(rnorm(500 * 5, mean = 3, sd = 1), nrow = 500, ncol = 5)

# Step 3: Combine matrices and create PCA, correlation heatmap, and MDS
combined_data <- cbind(healthy, cancer)

# Calculate correlation matrix manually
cor_matrix <- cor(combined_data)

# Heatmap of correlation matrix
heatmap(cor_matrix, main = "Correlation Heatmap")

# Perform MDS manually
distance_matrix <- as.dist(1 - cor_matrix)
mds <- cmdscale(distance_matrix, eig = TRUE, k = 2)
plot(mds$points, col = rep(c("blue", "red"), each = 5), pch = 19,
     main = "MDS Plot", xlab = "Dimension 1", ylab = "Dimension 2")

# Step 4: Perform t-test for each gene
p_values <- numeric(nrow(healthy))
for (i in 1:nrow(healthy)) {
  t_stat <- (mean(healthy[i, ]) - mean(cancer[i, ])) /
    sqrt(var(healthy[i, ]) / ncol(healthy) + var(cancer[i, ]) / ncol(cancer))
  df <- (var(healthy[i, ]) / ncol(healthy) + var(cancer[i, ]) / ncol(cancer))^2 /
    ((var(healthy[i, ]) / ncol(healthy))^2 / (ncol(healthy) - 1) +
       (var(cancer[i, ]) / ncol(cancer))^2 / (ncol(cancer) - 1))
  p_values[i] <- 2 * pt(-abs(t_stat), df)
}

# Step 5: Significant genes and false discovery rate (FDR)
sig_genes <- which(p_values < 0.05)
num_sig <- length(sig_genes)
true_sig_genes <- intersect(sig_genes, 1:500)
false_discoveries <- length(setdiff(sig_genes, 1:500))
fdr <- false_discoveries / num_sig

# Step 6: FDR threshold with BH correction
ranked_pvalues <- rank(p_values)
adjusted_pvalues_bh <- p_values * length(p_values) / ranked_pvalues
adjusted_pvalues_bh[adjusted_pvalues_bh > 1] <- 1
sig_genes_bh <- which(adjusted_pvalues_bh <= 0.05)
num_sig_bh <- length(sig_genes_bh)
true_false_bh <- length(setdiff(sig_genes_bh, 1:500)) / num_sig_bh

# Step 7: Bonferroni correction
adjusted_pvalues_bonf <- p_values * length(p_values)
adjusted_pvalues_bonf[adjusted_pvalues_bonf > 1] <- 1
sig_genes_bonf <- which(adjusted_pvalues_bonf <= 0.05)
num_sig_bonf <- length(sig_genes_bonf)
true_false_bonf <- length(setdiff(sig_genes_bonf, 1:500)) / num_sig_bonf

# Step 8: Distribution of effect sizes for BH correction
effect_sizes <- rowMeans(cancer) - rowMeans(healthy)
effect_sizes_sig <- effect_sizes[sig_genes_bh]
hist(effect_sizes_sig, breaks = 50, col = "blue", main = "Effect Size Distribution for BH-Corrected Significant Genes",
     xlab = "Effect Size", ylab = "Frequency")

# Step 9: Reproducibility
set.seed(321)
healthy2 <- matrix(rnorm(10000 * 5, mean = 0, sd = 1), nrow = 10000, ncol = 5)
cancer2 <- matrix(rnorm(10000 * 5, mean = 0, sd = 1), nrow = 10000, ncol = 5)
cancer2[1:500, ] <- matrix(rnorm(500 * 5, mean = 3, sd = 1), nrow = 500, ncol = 5)

p_values2 <- numeric(nrow(healthy2))
for (i in 1:nrow(healthy2)) {
  t_stat <- (mean(healthy2[i, ]) - mean(cancer2[i, ])) /
    sqrt(var(healthy2[i, ]) / ncol(healthy2) + var(cancer2[i, ]) / ncol(cancer2))
  df <- (var(healthy2[i, ]) / ncol(healthy2) + var(cancer2[i, ]) / ncol(cancer2))^2 /
    ((var(healthy2[i, ]) / ncol(healthy2))^2 / (ncol(healthy2) - 1) +
       (var(cancer2[i, ]) / ncol(cancer2))^2 / (ncol(cancer2) - 1))
  p_values2[i] <- 2 * pt(-abs(t_stat), df)
}

adjusted_pvalues2_bh <- p_values2 * length(p_values2) / rank(p_values2)
adjusted_pvalues2_bh[adjusted_pvalues2_bh > 1] <- 1
sig_genes2_bh <- which(adjusted_pvalues2_bh <= 0.05)

# Reproducibility
reproducibility <- length(intersect(sig_genes_bh, sig_genes2_bh)) / length(sig_genes_bh)

# Print results
list(
  SignificantGenesAt05 = num_sig,
  FDR = fdr,
  SignificantGenesBH = num_sig_bh,
  TrueFalseBH = true_false_bh,
  SignificantGenesBonf = num_sig_bonf,
  TrueFalseBonf = true_false_bonf,
  Reproducibility = reproducibility
)
