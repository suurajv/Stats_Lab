# =========================================================
# Experiment 12
# ANOVA and Non-Parametric Tests
# =========================================================

# Load dataset
data(iris)

# Display first few rows
cat("First Six Records:\n")
print(head(iris))

# =========================================================
# ANOVA Test
# =========================================================

anova_result <- aov(
  Sepal.Length ~ Species,
  data = iris
)

cat("\nANOVA Test Result:\n")
print(summary(anova_result))

# =========================================================
# Mann-Whitney Test
# =========================================================

# Extract Sepal Length values
setosa <- subset(
  iris,
  Species == "setosa"
)$Sepal.Length

versicolor <- subset(
  iris,
  Species == "versicolor"
)$Sepal.Length

# Mann-Whitney Test
mann_whitney_result <- wilcox.test(
  setosa,
  versicolor
)

cat("\nMann-Whitney Test Result:\n")
print(mann_whitney_result)

# =========================================================
# Kruskal-Wallis Test
# =========================================================

kruskal_result <- kruskal.test(
  Sepal.Length ~ Species,
  data = iris
)

cat("\nKruskal-Wallis Test Result:\n")
print(kruskal_result)

# =========================================================
# Boxplot
# =========================================================

boxplot(
  Sepal.Length ~ Species,
  data = iris,
  
  col = c("skyblue",
          "lightgreen",
          "pink"),
  
  main = "Sepal Length by Species",
  
  xlab = "Species",
  
  ylab = "Sepal Length"
)

# =========================================================
# Interpretation
# =========================================================

cat("\nInterpretation:\n")

cat("\n1. ANOVA checks whether group means differ significantly.\n")

cat("2. Mann-Whitney test compares two independent groups.\n")

cat("3. Kruskal-Wallis test compares more than two groups.\n")