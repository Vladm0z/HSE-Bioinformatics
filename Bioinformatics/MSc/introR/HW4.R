if (!require("ape")) {
  install.packages("ape")
  library(ape)
}

setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")

# Read the genome using read.dna from ape
genome <- read.dna("E_coli.fasta", format = "fasta", as.character = TRUE)

# Convert genome to a single string
genome_string <- paste(genome, collapse = "")

k <- 6

# Generate all k-mers
get_kmers <- function(sequence, k) {
  kmers <- sapply(1:(nchar(sequence) - k + 1), function(i) {
    substr(sequence, i, i + k - 1)
  })
  return(kmers)
}

# Get all 6-mers
kmers <- get_kmers(genome_string, k)

# Count the occurrences of each k-mer
kmer_counts <- table(kmers)

# Find the most common and rarest k-mers
most_common_kmers <- names(sort(kmer_counts, decreasing = TRUE)[1:2])
rarest_kmers <- names(sort(kmer_counts, decreasing = FALSE)[1:2])

# Outpuе
cat("Most common 6-mers: ", most_common_kmers, "\n")
cat("Rarest 6-mers: ", rarest_kmers, "\n")