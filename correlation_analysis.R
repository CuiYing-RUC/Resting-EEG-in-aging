# correlation_demo.R
# Demo script for computing Pearson correlations between cognitive measures and EEG features,
# including FDR-corrected p-values and significance indicators.

# Load required package
library(dplyr)

# Load example data (replace with actual path)
data <- read.csv("example_data.csv")

# Define generic cognitive predictors and EEG outcomes
cog_vars <- c("Cog1", "Cog2", "Cog3", "Cog4", "Cog5")       # e.g., working memory, inhibition...
eeg_vars <- c("EEG1", "EEG2", "EEG3", "EEG4", "EEG5")        # e.g., power, duration, transition...

# Calculate correlation matrix (pairwise complete)
cor_mat <- cor(data[, cog_vars], data[, eeg_vars], use = "pairwise.complete.obs")

# Calculate p-values via cor.test
p_mat <- matrix(nrow = length(cog_vars), ncol = length(eeg_vars))
for (i in seq_along(cog_vars)) {
  for (j in seq_along(eeg_vars)) {
    test <- cor.test(data[[cog_vars[i]]], data[[eeg_vars[j]]])
    p_mat[i, j] <- test$p.value
  }
}

# Flatten to data frame
cor_df <- as.data.frame(as.table(cor_mat))
names(cor_df) <- c("Cognitive", "EEG", "r")

cor_df$p_value <- as.vector(p_mat)
cor_df$p_fdr   <- p.adjust(cor_df$p_value, method = "fdr")


# Print result
print(cor_df[, c("Cognitive", "EEG", "r", "p_value", "p_fdr", "signif")])
