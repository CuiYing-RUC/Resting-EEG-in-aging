# gam_microstate_analysis_demo.R
# This demo illustrates how to use GAMs to examine nonlinear associations
# between EEG microstate metrics and cognitive abilities.

library(mgcv)
library(dplyr)

# Load example dataset
data <- read.csv("example_data.csv")

# Fit GAM: EEG_feature ~ s(Cognitive_ability) + Education
# Example: testing nonlinear effect of one cognitive variable on one EEG outcome
model <- gam(EEG_Feature1 ~ s(Cognitive1, k = 5) + Education, data = data)

# View model summary
summary(model)

# FDR correction and additional comparisons can be applied similarly
# across multiple EEG and cognitive variables following this modeling structure.
