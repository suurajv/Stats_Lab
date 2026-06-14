# =========================================================
# Experiment 5
# Baggage Complaints Dataset Analysis
# =========================================================

# Load libraries
library(dplyr)
library(ggplot2)

# Load dataset
# Change file path according to your system

df <- read.csv("baggagecomplaints.csv")

# Create Complaint Rate
df <- df %>%
  mutate(Rate = (Baggage / Enplaned) * 100)

# =========================================================
# Summary Statistics
# =========================================================

cat("Summary Statistics:\n")

print(summary(df[, c("Baggage", "Rate")]))

# =========================================================
# Airline-wise Summary
# =========================================================

summary_airline <- df %>%
  group_by(Airline) %>%
  summarise(
    
    Total_Months = n(),
    
    Total_Passengers = sum(Enplaned),
    
    Mean_Complaints = mean(Baggage),
    
    Median_Complaints = median(Baggage),
    
    SD_Complaints = sd(Baggage),
    
    Mean_Rate = mean(Rate),
    
    Median_Rate = median(Rate),
    
    SD_Rate = sd(Rate),
    
    Min_Rate = min(Rate),
    
    Max_Rate = max(Rate)
  )

cat("\nAirline-wise Summary:\n")

print(summary_airline)

# =========================================================
# Yearly Average Complaints
# =========================================================

yearly_avg <- df %>%
  group_by(Year, Airline) %>%
  summarise(
    Avg_Complaints = mean(Baggage),
    .groups = "drop"
  )

# =========================================================
# Line Plot
# =========================================================

ggplot(yearly_avg,
       aes(x = Year,
           y = Avg_Complaints,
           color = Airline)) +
  
  geom_line(linewidth = 1.2) +
  
  geom_point(size = 2) +
  
  labs(
    title = "Yearly Average Baggage Complaints",
    x = "Year",
    y = "Average Complaints"
  ) +
  
  theme_minimal() 

# =========================================================
# Interpretation
# =========================================================

cat("\nInterpretation:\n")

cat("\n1. Airlines with lower complaint rate have better baggage handling performance.\n")

cat("2. Airlines with higher complaint rate have poorer performance.\n")

cat("3. Complaint trends over years help identify improvement or decline in service quality.\n")