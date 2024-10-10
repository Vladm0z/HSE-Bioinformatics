
# Load Rcpp
if (!require("Rcpp")) {
  install.packages("Rcpp")
  library(Rcpp)
}
# Set working directory and read the genome
setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")

system.time({
  
  # Rcpp function to count 6-mers
  cppFunction('
  NumericVector count_6mers_cpp(std::vector<char> sequence, int k) {
    int n = sequence.size();
    NumericVector kmer_counts(4096);  // Preallocate for 4096 possible 6-mers
    for (int i = 0; i <= n - k; i++) {
      int index = 0;
      for (int j = 0; j < k; j++) {
        char nucleotide = sequence[i + j];
        if (nucleotide == \'A\') {
          index = index * 4;
        } else if (nucleotide == \'C\') {
          index = index * 4 + 1;
        } else if (nucleotide == \'G\') {
          index = index * 4 + 2;
        } else if (nucleotide == \'T\') {
          index = index * 4 + 3;
        } else {
          stop("Invalid nucleotide");
        }
      }
      kmer_counts[index] += 1;
    }
    return kmer_counts;
  }
')
  
  # Use the Rcpp function to count 6-mers
  six_mer_counts_cpp <- count_6mers_cpp(genome_sequence, 6)
  
})
