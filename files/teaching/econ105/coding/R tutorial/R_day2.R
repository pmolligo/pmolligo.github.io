rm(list=ls())

# Put your working folder here
setwd("~/ucla/2025-2026/Fall/Econ 105/R tutorial")

# Only install one time per computer
#install.packages("tidyverse")

library(tidyverse)
library(palmerpenguins)
data("penguins")

glimpse(penguins)

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(colour = species, shape = species)) +
  geom_smooth(method = "lm") +
  xlab("Flipper Length (mm)") + ylab("Body Mass (g)") +
  labs(title = "Penguin Stuff")
  




