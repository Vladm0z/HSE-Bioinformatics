# Load required packages
if (!require("ape")) {
  install.packages("ape")
  library(ape)
}

system.time({

# Set the working directory
setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")

# Read the genome using read.dna from ape
genome <- read.dna("E_coli.fasta", format = "fasta", as.character = TRUE)

# Convert genome to a single string
genome_string <- paste(genome, collapse = "")

# Define the length of the k-mer (6-mer)
k <- 6

# Create an environment to store k-mer counts (acts like a hash map)
kmer_counts <- new.env(hash = TRUE, parent = emptyenv())

# Function to count k-mers using a sliding window
count_kmers <- function(sequence, k) {
  seq_len <- nchar(sequence)
  
  for (i in 1:(seq_len - k + 1)) {
    # Extract the k-mer
    kmer <- substr(sequence, i, i + k - 1)
    
    # Increment the count for the k-mer
    if (exists(kmer, envir = kmer_counts)) {
      kmer_counts[[kmer]] <- kmer_counts[[kmer]] + 1
    } else {
      kmer_counts[[kmer]] <- 1
    }
  }
}

# Count all 6-mers from the genome
count_kmers(genome_string, k)

# Convert environment to named vector for sorting
kmer_count_vector <- as.list(kmer_counts)

# Sort the k-mers by their counts
sorted_kmers <- sort(unlist(kmer_count_vector), decreasing = TRUE)

# Find the most common and rarest k-mers
most_common_kmers <- names(sorted_kmers)[1:2]
rarest_kmers <- names(sorted_kmers)[(length(sorted_kmers) - 1):length(sorted_kmers)]

# Output the results
cat("Most common 6-mers: ", most_common_kmers, "\n")
cat("Rarest 6-mers: ", rarest_kmers, "\n")
})