# microstate_lmm_template.R
# Template script: Linear Mixed Model (LMM) analysis for one EEG microstate feature
# Demonstrates model structure and post-hoc tests using lme4 and emmeans

library(lme4)
library(lmerTest)
library(emmeans)

# -------------------------------
# Load and prepare data
# -------------------------------
data <- read.csv("example_microstate_data.csv")  # Replace with actual file

data$subject <- as.factor(data$subject)
data$group <- factor(data$group, levels = c("GroupA", "GroupB"))  
data$Map <- factor(data$Map, levels = c("Map1", "Map2", "Map3", "Map4"))  
data$education <- as.numeric(data$education)  # covariate

# -------------------------------
# Example: Analyze microstate duration
# -------------------------------
model_dur <- lmer(Duration ~ Map * group + education + (1 | subject), data)
summary(model_dur)

# Post-hoc pairwise comparisons
emmeans(model_dur, pairwise ~ Map | group, adjust = "bonferroni")
emmeans(model_dur, pairwise ~ group | Map, adjust = "bonferroni")

# -------------------------------
# Note:
# Analyses for other outcome variables (e.g., TimeCov, SegDensity, GEV, Transition) follow
# the same model structure and procedure as above.
# -------------------------------
