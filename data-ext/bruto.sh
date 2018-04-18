#! /bin/bash

# brutopalk
cd data
wget https://www.stat.ee/public/valmistabelid/palk_ja_toojoukulu/Keskmine%20brutokuupalk%2C%20kuud.xls?uuendatud=1519884052
mv Keskmine\ brutokuupalk\,\ kuud.xls\?uuendatud\=1519884052 keskmine_brutokuupalk.xls

# transactions
cd data
wget https://raw.githubusercontent.com/rstats-tartu/datasets/master/transactions_residential_apartments.csv
mv transactions_residential_apartments.csv transactions.csv
