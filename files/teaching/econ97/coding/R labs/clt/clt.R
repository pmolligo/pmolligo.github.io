rm(list=ls())
library(tidyverse)
library(gridExtra)

set.seed(33)

pop_size    <- 500000
sample_size <- 50
num_samples <- 5000

population_unif <- runif(pop_size)
population_exp  <- rexp(pop_size)
population_norm <- rnorm(pop_size, mean = 5, sd = 3)
population_bin  <- rbinom(pop_size, size = 5, prob = 0.3)


#----------------------------------------------
# Plot functions
#----------------------------------------------
plot_pop <- function(pop_dist, binwidth, dist_name, ann_x=NULL, ann_y=NULL) {
  
  pop_mean <- round(mean(pop_dist), 3)
  pop_sd   <- round(sd(pop_dist), 3)
  pop_N    <- length(pop_dist) 
  
  ann_x <- ifelse(is.null(ann_x), 0.7, ann_x)
  ann_y <- ifelse(is.null(ann_y), 0.7, ann_y)
  
  data.frame(val = pop_dist) |>
    ggplot(aes(x = val)) +
      geom_histogram(binwidth = binwidth, alpha = 0.5, color="black") +
      xlab("Value") + ylab(NULL) +
      labs(title = paste0(dist_name, " Distribution")) +
      theme_bw() +
      annotate("label", x = I(ann_x), y = I(ann_y),
               label = paste("Mean:", pop_mean, 
                             "\nSD:", pop_sd, 
                             "\nPop. Size", pop_N),
               color = "black", hjust = "left") 
}

plot_means <- function(pop_dist, num_samples, sample_size, 
                       binwidth, dist_name, ann_x=NULL, ann_y=NULL) {
  
  mean_draws <- replicate(num_samples, 
                          mean(sample(pop_dist, sample_size, replace = TRUE)))
  
  s_mean <- round(mean(mean_draws), 3)
  s_sd   <- round(sd(mean_draws), 3)
  
  ann_x <- ifelse(is.null(ann_x), 0.7, ann_x)
  ann_y <- ifelse(is.null(ann_y), 0.7, ann_y)
  
  data.frame(val = mean_draws) |>
    ggplot(aes(x = val)) +
    geom_histogram(binwidth = binwidth, alpha = 0.5, color="black") +
    xlab("Value") + ylab(NULL) +
    labs(title = paste0("Sample Means from ", dist_name, " Distribution")) +
    theme_bw() +
    annotate("label", x = I(ann_x), y = I(ann_y),
             label = paste("Mean:", s_mean, 
                           "\nSD:", s_sd, 
                           "\nNum. Samples", num_samples),
             color = "black", hjust = "left") 
}
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------


grid.arrange(
  plot_pop(population_exp, binwidth = 0.5, dist_name = "Exponential"),
  plot_pop(population_norm, binwidth = 1, dist_name = "Normal"), 
  plot_pop(population_unif, binwidth = 0.1, dist_name = "Uniform"), 
  plot_pop(population_bin, binwidth = 0.1, dist_name = "Binomial"),
  ncol = 2)

grid.arrange(
  plot_means(population_exp, num_samples = num_samples, 
             sample_size = sample_size, binwidth = 0.1, 
             dist_name = "Exponential"),
  plot_means(population_norm, num_samples = num_samples, 
             sample_size = sample_size, binwidth = 0.1, 
             dist_name = "Normal"), 
  plot_means(population_unif, num_samples = num_samples, 
             sample_size = sample_size, binwidth = 0.01, 
             dist_name = "Uniform"), 
  plot_means(population_bin, num_samples = num_samples, 
             sample_size = sample_size, binwidth = 0.05, 
             dist_name = "Binomial"),
  ncol = 2)


