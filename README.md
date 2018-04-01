# Data transformation using dplyr (aka five verbs)

## Intro
I our previous classes we have been working with small cleaned up dataset to go through steps of creating some of the most common visualization types. 

In your workflow you are going to need data visualization at two points, namely during exploratory data analysis where you learn to know your dataset and during report preparation when you try to communicate what have you found. And this is not two stop trip, it's more like a roundabout, an iterative process, where you pass these two point multiple times after you have done some "tweaking" of your data. By "tweaking" I mean here data transformation and/or modeling. 

You need to transform your data during analysis, because in real life you rarely start with a dataset that is in the right form for visualization and modeling. So, often you will need to:

- summarise your data or to 
- create new variables, 
- rename variables, or 
- reorder the observations. 

We are going to use the dplyr library from tidyverse to learn how to carry out these tasks. 

## Sources
Again, we are going to follow closely R4DS book chapter "Data transformation" available from http://r4ds.had.co.nz/transform.html. More examples are available from https://rstats-tartu.github.io/lectures/tidyverse.html#dplyr-ja-selle-viis-verbi

## Datasets

### transactions - Transactions of residential apartments
The source of this dataset is Estonian Land Board transactions database: http://www.maaamet.ee/kinnisvara/htraru/FilterUI.aspx. Dataset was downloaded and processed using 'R/maaamet.R' script. 

Load this file to your project from data folder:
```
transactions <- read_csv(file = "data/transactions.csv")
```



