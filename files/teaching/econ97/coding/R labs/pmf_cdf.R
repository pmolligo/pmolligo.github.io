rm(list = ls())
library(ggplot2)
library(gridExtra)

support_x <- 1:5

pmf_1 <- data.frame(x = support_x, p =support_x/sum(support_x))
pmf_2 <- data.frame(x = support_x, p = c(1, 2, 3, 2, 1)/sum(c(1, 2, 3, 2, 1)))
pmf_3 <- data.frame(x = support_x, p = c(rep(1, 5))/5)

cdf_1 <- data.frame(cdf = cumsum(pmf_1$p))
cdf_2 <- data.frame(cdf = cumsum(pmf_2$p))
cdf_3 <- data.frame(cdf = cumsum(pmf_3$p))

rv_1 <- data.frame(pmf_1, cdf_1)
rv_2 <- data.frame(pmf_2, cdf_2)
rv_3 <- data.frame(pmf_3, cdf_3)


grid.arrange(
ggplot(rv_1, aes(x = x, y = p)) +
  geom_col(width = 0.6, alpha = 0.5, fill="blue") +
  labs(title = "PMF: Increasing Distribution",
       x = "x", y = "P(X = x)") +
  theme_minimal(),
ggplot(rv_1, aes(x = x, y = cdf)) +
  geom_col(width = 0.6, alpha = 0.5, fill="red") +
  geom_line(size = 1.5) +
  labs(title = "CDF: Increasing Distribution",
       x = "x", y = "P(X \u2264 x)") +
  theme_minimal(),
ncol=2
)

grid.arrange(
ggplot(rv_3, aes(x = x, y = p)) +
  geom_col(width = 0.6, alpha = 0.5, fill="blue") +
  labs(title = "PMF: Uniform Distribution",
       x = "x", y = "P(X = x)") +
  theme_minimal(),
ggplot(rv_3, aes(x = x, y = cdf)) +
  geom_col(width = 0.6, alpha = 0.5, fill="red") +
  geom_line(size = 1.5) +
  labs(title = "CDF: Uniform Distribution",
       x = "x", y = "P(X = x)") +
  theme_minimal(),
ncol = 2
)


grid.arrange(
  ggplot(rv_2, aes(x = x, y = p)) +
    geom_col(width = 0.6, alpha = 0.5, fill="blue") +
    labs(title = "PMF: Symmetric Distribution",
         x = "x", y = "P(X = x)") +
    theme_minimal(),
  ggplot(rv_2, aes(x = x, y = cdf)) +
    geom_col(width = 0.6, alpha = 0.5, fill="red") +
    geom_line(size = 1.5) +
    labs(title = "CDF: Symmetric Distribution",
         x = "x", y = "P(X \u2264 x)") +
    theme_minimal(),
  ncol=2
)
