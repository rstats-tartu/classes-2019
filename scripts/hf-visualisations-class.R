#'---
#' title: Visualisation excercises
#' author: taavi Päll
#' date: 2019-10-01
#'---


#' Loading libraries.
#+ libs
library(tidyverse)
library(here)

#' Importing data.
#+ import
hf_summary <- read_csv(here("output/summary.csv"))
hf_summary

#'
#' Plot age ~ post-acute_LOS scatterplot
#+ fig.cap=""
ggplot(data = hf_summary) +
  geom_point(aes(x = age, y = acute_LOS, color = county))


#' Modify previous plot so that county will be on facets!
#+
ggplot(data = hf_summary) +
  geom_point(aes(x = age, y = acute_LOS)) +
  facet_wrap(~county) +
  scale_y_log10()

#' Let's create line graph with loess smooth
ggplot(data = hf_summary) +
  geom_smooth(aes(x = age, y = acute_LOS)) +
  facet_wrap(~county) +
  scale_y_log10()

#' Linear regression line:
ggplot(data = hf_summary) +
  geom_smooth(aes(x = age, y = acute_LOS), method = "lm") +
  facet_wrap(~county) +
  scale_y_log10()

#' 
ggplot(data = hf_summary, aes(x = age, y = acute_LOS)) +
  geom_point(size = 0.3, alpha = 0.3, position = position_jitter(0.5)) +
  geom_smooth(aes(color = fracture_type), method = "lm") +
  facet_wrap(~county, scales = "free_y") +
  scale_y_log10()

#' Plot mean length of stay +/- 1SD per county, preferably use stat_summary!!
ggplot(data = hf_summary) +
  stat_summary(aes(x = str_to_title(county), y = acute_LOS), 
               fun.data = mean_sdl, 
               fun.args = list(mult = 1)) +
  labs(y = "Acute length of stay\nafter hip fracture, days",
       x = "County", 
       title = "Hip fracture dataset",
       caption = "Error bars, standard deviation.") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
  
#' Number of fracture types in hf_summary dataset:
#+ fig.cap="My figure cation"
ggplot(data = hf_summary) + 
  geom_bar(aes(fracture_type))
  
#' Proportion of each fracture type in hf_summary dataset:
ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, y = ..prop.., group = 1))


#' Proportion of each fracture type in hf_summary dataset
ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, fill = sex), position = "identity")


ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, fill = sex), position = "fill")

ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, fill = sex), position = "dodge")

ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, fill = sex), position = position_dodge(width = 0.95))

