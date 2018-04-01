
library(tidyverse)

# Download dataset from rstats-tartu/datasets repo
transactions <- read_csv(file = "https://raw.githubusercontent.com/rstats-tartu/datasets/master/transactions_residential_apartments.csv")

# Change to numeric months
transactions <- transactions %>% 
  mutate(month = as_factor(month, levels = month.abb),
         month = as.integer(month))

# We might want also consumer index data
consumer_index <- read_csv(file = "https://raw.githubusercontent.com/rstats-tartu/datasets/master/consumer_index.csv")

consumer_index <- consumer_index %>% 
  select(-X1) %>% 
  gather(month, consumer_index, -year) %>% 
  mutate(month = as_factor(month, levels = month.abb),
         month = as.integer(month))

# Merge consumer index to transactions
transactions <- left_join(transactions, consumer_index)

# Save local copy as csv
write_csv(transactions, path = "data/transactions.csv")

# Save local copy as csv
write_csv(consumer_index, path = "data/consumer_index.csv")
