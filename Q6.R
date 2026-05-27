# =========================================================
# Experiment 6
# Medical Malpractice Dataset Analysis
# =========================================================

# Load libraries
library(dplyr)
library(ggplot2)
library(readr)

# Load dataset
# Change file path according to your system

data <- read.csv("medicalmalpractice.csv")

# =========================================================
# Summary Statistics
# =========================================================

cat("Summary Statistics of Claim Amount:\n")

print(summary(data$Amount))

# =========================================================
# Histogram of Claim Amounts
# =========================================================

ggplot(data, aes(x = log10(Amount))) +
  
  geom_histogram(
    bins = 20,
    fill = "skyblue",
    color = "black"
  ) +
  
  labs(
    title = "Histogram of Claim Amounts (Log Scale)",
    x = "Log10(Claim Amount)",
    y = "Frequency"
  ) +
  
  theme_minimal() +
  
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )

# =========================================================
# Top 3 Specialties
# =========================================================

top3_specialty <- data %>%
  count(Specialty, name = "Count") %>%
  slice_max(Count, n = 3) %>%
  pull(Specialty)

# =========================================================
# Boxplot for Top Specialties
# =========================================================

data %>%
  filter(Specialty %in% top3_specialty) %>%
  
  ggplot(aes(x = Specialty,
             y = Amount,
             fill = Specialty)) +
  
  geom_boxplot() +
  
  coord_flip() +
  
  labs(
    title = "Claim Amount by Specialty",
    x = "Specialty",
    y = "Claim Amount"
  ) +
  
  theme_minimal() +
  
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )

# =========================================================
# Percentage of Specific Specialties
# =========================================================

total_cases <- nrow(data)

specialty_percent <- data %>%
  group_by(Specialty) %>%
  summarise(
    Count = n(),
    Percentage = (Count / total_cases) * 100
  ) %>%
  filter(Specialty %in%
           c("Anesthesiology",
             "Dermatology",
             "Orthopedic Surgery"))

cat("\nPercentage of Claims by Specialty:\n")

print(specialty_percent)

# =========================================================
# Correlation Between Age and Amount
# =========================================================

correlation_result <- cor.test(data$Age,
                               data$Amount)

cat("\nCorrelation Test Between Age and Amount:\n")

print(correlation_result)

# =========================================================
# Interpretation
# =========================================================

cat("\nInterpretation:\n")

cat("\n1. Claim amounts vary widely across cases.\n")

cat("2. Some specialties have higher malpractice payments.\n")

cat("3. Correlation helps determine relationship between age and payment amount.\n")