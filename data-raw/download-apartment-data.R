
library(tidyverse)
library(lubridate)

# Download dataset from rstats-tartu/datasets repo
transactions <- read_csv(file = "data/transactions_residential_apartments.csv")

# Extract numeric months (kuu) and year (aasta) from kuupäev (date)
transactions <- transactions %>%
  rename_all(str_to_lower) %>%
  rename(kuupäev = kuu) %>%
  mutate(
    kuu = month(kuupäev),
    aasta = year(kuupäev)
  )

# We might want also consumer index data
consumer_index <- read_csv(file = "data/consumer_price_index.csv")

months <- data_frame(kuu_nimi = month(ymd(080101) + months(0:11), label = TRUE, abbr = FALSE), kuu = 1:12)

consumer_index <- consumer_index %>%
  gather(kuu_nimi, indeks, jaanuar:detsember) %>%
  left_join(months) %>%
  select(aasta, kuu, indeks)

# Merge consumer index to transactions
transactions <- left_join(transactions, consumer_index)

# Save local copy as csv
write_csv(transactions, path = "data/transactions.csv")
