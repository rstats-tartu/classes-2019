
# Download dataset from rstats-tartu/datasets repo 
transactions <- read_csv(file = "https://raw.githubusercontent.com/rstats-tartu/datasets/master/transactions_residential_apartments.csv")

# Save local copy as csv
write_csv(transactions, path = "data/transactions.csv")

# We might want also consumer index data
consumer_index <- read_csv(file = "https://raw.githubusercontent.com/rstats-tartu/datasets/master/consumer_index.csv")

# Save local copy as csv
write_csv(consumer_index, path = "data/consumer_index.csv")
