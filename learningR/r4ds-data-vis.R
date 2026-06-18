library(ggplot2)
library(ggthemes)
library(palmerpenguins)
library(dplyr)
library(janitor)
glimpse(penguins)

ggplot(data = penguins,mapping = aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(mapping = aes(color = bill_depth_mm)) + 
  geom_smooth() +
  scale_color_gradient(low = '#001e63', high = '#00ccfe', na.value = 'NA')

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = island)) +
  geom_smooth(se = FALSE)


ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth()

ggplot(penguins, aes(x = species)) +
  geom_bar()

ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) + 
  geom_density()


ggplot(penguins, aes(y = body_mass_g, x = species)) + 
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)
