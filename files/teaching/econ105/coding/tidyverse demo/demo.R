rm(list = ls())
setwd("~/ucla/2025-2026/Fall/Econ 105/lecture/week8/tidyverse demo")

# Remember to install these packages before trying to load them
# install.packages("tidyverse")
# install.packages("palmerpenguins")

library("tidyverse")
library("palmerpenguins")

data("penguins")

?penguins
glimpse(penguins)

summary(penguins$island)

ggplot(data=penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  

ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(color=species, shape = species)) +
  geom_smooth(method = "lm")
  



