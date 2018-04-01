Data transformation using dplyr (aka five verbs)
================
Taavi Päll
1.  April 2018

Introduction
------------

I our previous classes we have been working with small cleaned up dataset to go through steps of creating some of the most common visualization types.

In your workflow you are going to need data visualization at two points, namely during exploratory data analysis where you learn to know your dataset and during report preparation when you try to communicate what have you found. And this is not two stop trip, it's more like a roundabout, an iterative process, where you pass these two point multiple times after you have done some "tweaking" of your data. By "tweaking" I mean here data transformation and/or modeling.

You need to transform your data during analysis, because in real life you rarely start with a dataset that is in the right form for visualization and modeling. So, often you will need to:

-   summarise your data or to
-   create new variables,
-   rename variables, or
-   reorder the observations.

We are going to use the dplyr library from tidyverse to learn how to carry out these tasks.

Sources
-------

Again, we are going to follow closely R4DS book chapter "Data transformation" available from <http://r4ds.had.co.nz/transform.html>. More examples are available from <https://rstats-tartu.github.io/lectures/tidyverse.html#dplyr-ja-selle-viis-verbi>

Class III
---------

Load libraries and datasets:

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
    ## ✔ tibble  1.4.2          ✔ dplyr   0.7.4     
    ## ✔ tidyr   0.8.0          ✔ stringr 1.3.0     
    ## ✔ readr   1.1.1          ✔ forcats 0.2.0

    ## ── Conflicts ───────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(nycflights13)
```

However, instead of nycflights13 data we are going to use Estonian apartment transactions data. Transactions data contain monthly apartment sales data from January 2005 to January 2017 split up by counties and size of apartments. Price info is available when at least five transactions has been carried out.

``` r
(transactions <- read_csv(file = "data/transactions.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   year = col_integer(),
    ##   month = col_integer(),
    ##   county = col_character(),
    ##   area = col_character(),
    ##   transactions = col_integer(),
    ##   area_total = col_double(),
    ##   area_mean = col_double(),
    ##   price_total = col_integer(),
    ##   price_min = col_double(),
    ##   price_max = col_double(),
    ##   price_unit_area_min = col_double(),
    ##   price_unit_area_max = col_double(),
    ##   price_unit_area_median = col_double(),
    ##   price_unit_area_mean = col_double(),
    ##   price_unit_area_sd = col_double(),
    ##   title = col_character(),
    ##   subtitle = col_character(),
    ##   consumer_index = col_double()
    ## )

    ## # A tibble: 12,172 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005     1 Harju … 10-2…           65     1419        21.8     1135773
    ##  2  2005     1 Harju … 30-4…          155     5432        35.0     4009365
    ##  3  2005     1 Harju … 41-5…          253    12044        47.6     8674474
    ##  4  2005     1 Harju … 55-6…          230    14516        63.1    10115291
    ##  5  2005     1 Harju … 70-2…          118    10905        92.4     9952072
    ##  6  2005     1 Hiiu m… 41-5…            1       51.2      51.2          NA
    ##  7  2005     1 Hiiu m… 55-6…            1       67.6      67.6          NA
    ##  8  2005     1 Ida-Vi… 10-2…           12      329        27.4       28602
    ##  9  2005     1 Ida-Vi… 30-4…           48     1721        35.8      117529
    ## 10  2005     1 Ida-Vi… 41-5…           35     1668        47.6      169411
    ## # ... with 12,162 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

dplyr basics
------------

Most of the data transformation tasks can be carried out using five verbs from dplyr library:

-   Pick observations by their values (filter()).
-   Reorder the rows (arrange()).
-   Pick variables by their names (select()).
-   Create new variables with functions of existing variables (mutate()).
-   Collapse many values down to a single summary (summarise()).

-   These can all be used in conjunction with group\_by() which changes the scope of each function from operating on the entire dataset to operating on it group-by-group.

These six functions provide the verbs for a language of data manipulation.

All verbs work similarly:

The first argument is a data frame.

The subsequent arguments describe what to do with the data frame, using the variable names (without quotes).

The result is a new data frame.

Together these properties make it easy to chain together multiple simple steps to achieve a complex result. Let’s dive in and see how these verbs work.

Filter rows with filter()
-------------------------

filter() allows you to subset observations based on their values. The first argument is the name of the data frame. The second and subsequent arguments are the expressions that filter the data frame.

For example, we can select data on January 2005 with:

``` r
filter(transactions, year == 2005, month == 1)
```

    ## # A tibble: 65 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005     1 Harju … 10-2…           65     1419        21.8     1135773
    ##  2  2005     1 Harju … 30-4…          155     5432        35.0     4009365
    ##  3  2005     1 Harju … 41-5…          253    12044        47.6     8674474
    ##  4  2005     1 Harju … 55-6…          230    14516        63.1    10115291
    ##  5  2005     1 Harju … 70-2…          118    10905        92.4     9952072
    ##  6  2005     1 Hiiu m… 41-5…            1       51.2      51.2          NA
    ##  7  2005     1 Hiiu m… 55-6…            1       67.6      67.6          NA
    ##  8  2005     1 Ida-Vi… 10-2…           12      329        27.4       28602
    ##  9  2005     1 Ida-Vi… 30-4…           48     1721        35.8      117529
    ## 10  2005     1 Ida-Vi… 41-5…           35     1668        47.6      169411
    ## # ... with 55 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

dplyr runs the filtering operation and returns a new data frame. dplyr functions never modify their inputs, so if you want to save the result, you'll need to use the assignment operator, &lt;-:

``` r
jan2005 <- filter(transactions, year == 2005, month == 1)
```

### Comparisons

What is this == operator above? Why not use = to check equality:

``` r
filter(transactions, year = 2005)
```

It appears that = is another assignment operator besides -&gt;

There’s another common problem you might encounter when using ==: floating point numbers. Although, theoretically TRUE, following comparisons return FALSE!

``` r
sqrt(2) ^ 2 == 2
```

    ## [1] FALSE

``` r
1/49 * 49 == 1
```

    ## [1] FALSE

This is because computers and R use finite precision arithmetic and cannot store an infinite number of digits.

This can be overcome by using near() function instead of ==:

``` r
near(sqrt(2) ^ 2,  2)
```

    ## [1] TRUE

``` r
near(1 / 49 * 49, 1)
```

    ## [1] TRUE

### Logical operators

Multiple comparisons within filter() function are combined with comma "," which means "and" (&). In case of "and" all comparisons must evaluate to TRUE for observations to be returned.

Together, logical (boolean) operators are:

-   & is AND,
-   | is OR,
-   ! is NOT

The following code finds all transactions in November OR December:

``` r
filter(transactions, month == 11 | month == 12)
```

    ## # A tibble: 1,889 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005    11 Harju … 10-2…          166     3340        20.1     3732962
    ##  2  2005    11 Harju … 30-4…          278     9786        35.2    10232826
    ##  3  2005    11 Harju … 41-5…          530    25558        48.2    24595849
    ##  4  2005    11 Harju … 55-6…          461    28860        62.6    26653174
    ##  5  2005    11 Harju … 70-2…          338    32617        96.5    34664200
    ##  6  2005    11 Hiiu m… 30-4…            2       76.1      38.0          NA
    ##  7  2005    11 Hiiu m… 41-5…            3      134        44.8          NA
    ##  8  2005    11 Hiiu m… 55-6…            1       59.9      59.9          NA
    ##  9  2005    11 Ida-Vi… 10-2…           23      617        26.8      117442
    ## 10  2005    11 Ida-Vi… 30-4…           83     2987        36.0      505379
    ## # ... with 1,879 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

You can’t write filter(flights, month == "Nov" | "Dec") and in case of numeric months this will give you wrong answer instead of Error, so be careful:

``` r
filter(transactions, month == 11 | 12)
```

A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values in y:

``` r
(nov_dec <- filter(transactions, month %in% c(11, 12)))
```

    ## # A tibble: 1,889 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005    11 Harju … 10-2…          166     3340        20.1     3732962
    ##  2  2005    11 Harju … 30-4…          278     9786        35.2    10232826
    ##  3  2005    11 Harju … 41-5…          530    25558        48.2    24595849
    ##  4  2005    11 Harju … 55-6…          461    28860        62.6    26653174
    ##  5  2005    11 Harju … 70-2…          338    32617        96.5    34664200
    ##  6  2005    11 Hiiu m… 30-4…            2       76.1      38.0          NA
    ##  7  2005    11 Hiiu m… 41-5…            3      134        44.8          NA
    ##  8  2005    11 Hiiu m… 55-6…            1       59.9      59.9          NA
    ##  9  2005    11 Ida-Vi… 10-2…           23      617        26.8      117442
    ## 10  2005    11 Ida-Vi… 30-4…           83     2987        36.0      505379
    ## # ... with 1,879 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

Sometimes you can simplify complicated subsetting by remembering De Morgan’s law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. For example, if you wanted to find flights that weren’t delayed (on arrival or departure) by more than two hours, you could use either of the following two filters:

``` r
filter(transactions, !(price_min > 1000 | price_max > 1000))
```

    ## # A tibble: 2 x 18
    ##    year month county   area  transactions area_total area_mean price_total
    ##   <int> <int> <chr>    <chr>        <int>      <dbl>     <dbl>       <int>
    ## 1  2009     4 Valga m… 41-5…            6        278      46.3        3019
    ## 2  2012     3 Rapla m… 10-2…            7        145      20.7          NA
    ## # ... with 10 more variables: price_min <dbl>, price_max <dbl>,
    ## #   price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

``` r
filter(transactions,  price_min <= 1000, price_max <= 1000)
```

    ## # A tibble: 2 x 18
    ##    year month county   area  transactions area_total area_mean price_total
    ##   <int> <int> <chr>    <chr>        <int>      <dbl>     <dbl>       <int>
    ## 1  2009     4 Valga m… 41-5…            6        278      46.3        3019
    ## 2  2012     3 Rapla m… 10-2…            7        145      20.7          NA
    ## # ... with 10 more variables: price_min <dbl>, price_max <dbl>,
    ## #   price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

### Missing values

One important feature of R that can make comparison tricky are missing values, or NAs ("not availables"). NA represents an unknown value so missing values are "contagious": almost any operation involving an unknown value will also be unknown.

``` r
NA > 5
```

    ## [1] NA

``` r
10 == NA
```

    ## [1] NA

``` r
NA + 10
```

    ## [1] NA

``` r
NA / 2
```

    ## [1] NA

As Rsudio already might suggest, if you want to determine if a value is missing, use is.na():

``` r
x <- NA
is.na(x)
```

    ## [1] TRUE

Let's use is.na() within filter to remove rows with missing price info:

``` r
filter(transactions, is.na(price_total))
```

    ## # A tibble: 5,216 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005     1 Hiiu m… 41-5…            1       51.2      51.2          NA
    ##  2  2005     1 Hiiu m… 55-6…            1       67.6      67.6          NA
    ##  3  2005     1 Jõgeva… 30-4…            2       69.8      34.9          NA
    ##  4  2005     1 Jõgeva… 55-6…            5      313        62.5          NA
    ##  5  2005     1 Järva … 10-2…            1       26.6      26.6          NA
    ##  6  2005     1 Järva … 30-4…            1       40.4      40.4          NA
    ##  7  2005     1 Järva … 41-5…            3      148        49.2          NA
    ##  8  2005     1 Järva … 55-6…            2      118        59.0          NA
    ##  9  2005     1 Järva … 70-2…            1       77.7      77.7          NA
    ## 10  2005     1 Lääne … 55-6…            3      200        66.8          NA
    ## # ... with 5,206 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

Ok. Now we got all rows with missing price\_total... how would you change this code to really exclude these rows with missing data:

There is another function that works with data frames to find rows with complete set of observations - complete.cases():

``` r
filter(transactions, complete.cases(transactions))
```

    ## # A tibble: 12,172 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005     1 Harju … 10-2…           65     1419        21.8     1135773
    ##  2  2005     1 Harju … 30-4…          155     5432        35.0     4009365
    ##  3  2005     1 Harju … 41-5…          253    12044        47.6     8674474
    ##  4  2005     1 Harju … 55-6…          230    14516        63.1    10115291
    ##  5  2005     1 Harju … 70-2…          118    10905        92.4     9952072
    ##  6  2005     1 Hiiu m… 41-5…            1       51.2      51.2          NA
    ##  7  2005     1 Hiiu m… 55-6…            1       67.6      67.6          NA
    ##  8  2005     1 Ida-Vi… 10-2…           12      329        27.4       28602
    ##  9  2005     1 Ida-Vi… 30-4…           48     1721        35.8      117529
    ## 10  2005     1 Ida-Vi… 41-5…           35     1668        47.6      169411
    ## # ... with 12,162 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

### Exercises

1.  Find all transactions that

-   Had an area\_mean more than one hundred square meters
-   Took place in Saare maakond
-   Were done during summer (July, August, and September)
-   Another useful dplyr filtering helper is between(). What does it do?

1.  How many rows have a missing total\_price? What other variables are missing?

2.  Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA not missing? Can you figure out the general rule? (NA \* 0 is a tricky counterexample!)

``` r
NA ^ 0
```

    ## [1] 1

``` r
NA | TRUE
```

    ## [1] TRUE

Arrange rows with arrange()
---------------------------

arrange() works similarly to filter() except that instead of selecting rows, it changes their order. It takes a data frame and a set of column names to order by. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:

``` r
arrange(transactions, price_unit_area_max)
```

    ## # A tibble: 12,172 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2009     4 Valga … 41-5…            6        278      46.3        3019
    ##  2  2012     3 Rapla … 10-2…            7        145      20.7          NA
    ##  3  2014     4 Valga … 41-5…            7        322      46.0        7827
    ##  4  2014     4 Valga … 41-5…            7        322      46.0        7827
    ##  5  2011     4 Järva … 55-6…            6        400      66.7        8798
    ##  6  2009     6 Võru m… 30-4…           11        351      31.9       18748
    ##  7  2011     5 Järva … 70-2…            5        434      86.8       19070
    ##  8  2005     1 Valga … 30-4…            5        187      37.3        6519
    ##  9  2009     4 Järva … 55-6…            5        339      67.9        6647
    ## 10  2015     1 Jõgeva… 30-4…            5        188      37.5        5600
    ## # ... with 12,162 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

Use desc() to re-order by a column in descending order:

``` r
arrange(transactions, desc(price_unit_area_max))
```

    ## # A tibble: 12,172 x 18
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <int> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2017     1 Harju … 41-5…          260      12485      48.0    21694322
    ##  2  2006     9 Harju … 55-6…          343      21452      62.5    29543210
    ##  3  2013     7 Lääne … 41-5…           10        459      45.9     1094856
    ##  4  2016    11 Harju … 30-4…          164       5797      35.3     9526844
    ##  5  2006     9 Harju … 70-2…          271      26075      96.2    37365431
    ##  6  2006    10 Harju … 10-2…          121       2547      21.0     4011778
    ##  7  2007     2 Harju … 55-6…          297      18510      62.3    27815836
    ##  8  2016    11 Harju … 41-5…          288      13608      47.2    21897902
    ##  9  2006     7 Harju … 10-2…           84       1816      21.6     2628157
    ## 10  2008    10 Harju … 10-2…           69       1437      20.8     2156159
    ## # ... with 12,162 more rows, and 10 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>,
    ## #   consumer_index <dbl>

Missing values are always sorted at the end, even with desc() function:

``` r
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
```

    ## # A tibble: 3 x 1
    ##       x
    ##   <dbl>
    ## 1  2.00
    ## 2  5.00
    ## 3 NA

``` r
arrange(df, desc(x))
```

    ## # A tibble: 3 x 1
    ##       x
    ##   <dbl>
    ## 1  5.00
    ## 2  2.00
    ## 3 NA

### Exercises

1.  How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).

2.  Sort transactions to find the busiest months in each county.

3.  Sort transactions to find the months with highest mean price payed for price\_unit\_area\_mean.

4.  Which apartements (size) sold the best in 2017? Which sold worst in 2017?

Select columns with select()
----------------------------

select() allows you to rapidly zoom in on a useful subset of columns using operations based on the names of the variables.

Select three columns:

``` r
select(transactions, year, month, transactions)
```

    ## # A tibble: 12,172 x 3
    ##     year month transactions
    ##    <int> <int>        <int>
    ##  1  2005     1           65
    ##  2  2005     1          155
    ##  3  2005     1          253
    ##  4  2005     1          230
    ##  5  2005     1          118
    ##  6  2005     1            1
    ##  7  2005     1            1
    ##  8  2005     1           12
    ##  9  2005     1           48
    ## 10  2005     1           35
    ## # ... with 12,162 more rows

Select columns from year to transactions:

``` r
select(transactions, year:transactions)
```

    ## # A tibble: 12,172 x 5
    ##     year month county           area      transactions
    ##    <int> <int> <chr>            <chr>            <int>
    ##  1  2005     1 Harju maakond    10-29,99            65
    ##  2  2005     1 Harju maakond    30-40,99           155
    ##  3  2005     1 Harju maakond    41-54,99           253
    ##  4  2005     1 Harju maakond    55-69,99           230
    ##  5  2005     1 Harju maakond    70-249,99          118
    ##  6  2005     1 Hiiu maakond     41-54,99             1
    ##  7  2005     1 Hiiu maakond     55-69,99             1
    ##  8  2005     1 Ida-Viru maakond 10-29,99            12
    ##  9  2005     1 Ida-Viru maakond 30-40,99            48
    ## 10  2005     1 Ida-Viru maakond 41-54,99            35
    ## # ... with 12,162 more rows

Exlude columns from area\_total to title:

``` r
select(transactions, -(area_total:title))
```

    ## # A tibble: 12,172 x 7
    ##     year month county           area  transactions subtitle consumer_index
    ##    <int> <int> <chr>            <chr>        <int> <chr>             <dbl>
    ##  1  2005     1 Harju maakond    10-2…           65 Kõik ma…           97.5
    ##  2  2005     1 Harju maakond    30-4…          155 Kõik ma…           97.5
    ##  3  2005     1 Harju maakond    41-5…          253 Kõik ma…           97.5
    ##  4  2005     1 Harju maakond    55-6…          230 Kõik ma…           97.5
    ##  5  2005     1 Harju maakond    70-2…          118 Kõik ma…           97.5
    ##  6  2005     1 Hiiu maakond     41-5…            1 Kõik ma…           97.5
    ##  7  2005     1 Hiiu maakond     55-6…            1 Kõik ma…           97.5
    ##  8  2005     1 Ida-Viru maakond 10-2…           12 Kõik ma…           97.5
    ##  9  2005     1 Ida-Viru maakond 30-4…           48 Kõik ma…           97.5
    ## 10  2005     1 Ida-Viru maakond 41-5…           35 Kõik ma…           97.5
    ## # ... with 12,162 more rows

There are a number of **helper functions you can use within select()**:

-   starts\_with("abc"): matches names that begin with "abc".

-   ends\_with("xyz"): matches names that end with "xyz".

-   contains("ijk"): matches names that contain "ijk".

-   matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You’ll learn more about regular expressions in strings.

-   num\_range("V", 1:3) matches V1, V2 and V3.

-   everything() is useful if you have a handful of variables you'd like to move to the start of the data frame.

See ?select for more details.

Move column "title" to the start of the data frame.

``` r
select(transactions, title, everything())
```

    ## # A tibble: 12,172 x 18
    ##    title       year month county   area  transactions area_total area_mean
    ##    <chr>      <int> <int> <chr>    <chr>        <int>      <dbl>     <dbl>
    ##  1 Korteriom…  2005     1 Harju m… 10-2…           65     1419        21.8
    ##  2 Korteriom…  2005     1 Harju m… 30-4…          155     5432        35.0
    ##  3 Korteriom…  2005     1 Harju m… 41-5…          253    12044        47.6
    ##  4 Korteriom…  2005     1 Harju m… 55-6…          230    14516        63.1
    ##  5 Korteriom…  2005     1 Harju m… 70-2…          118    10905        92.4
    ##  6 Korteriom…  2005     1 Hiiu ma… 41-5…            1       51.2      51.2
    ##  7 Korteriom…  2005     1 Hiiu ma… 55-6…            1       67.6      67.6
    ##  8 Korteriom…  2005     1 Ida-Vir… 10-2…           12      329        27.4
    ##  9 Korteriom…  2005     1 Ida-Vir… 30-4…           48     1721        35.8
    ## 10 Korteriom…  2005     1 Ida-Vir… 41-5…           35     1668        47.6
    ## # ... with 12,162 more rows, and 10 more variables: price_total <int>,
    ## #   price_min <dbl>, price_max <dbl>, price_unit_area_min <dbl>,
    ## #   price_unit_area_max <dbl>, price_unit_area_median <dbl>,
    ## #   price_unit_area_mean <dbl>, price_unit_area_sd <dbl>, subtitle <chr>,
    ## #   consumer_index <dbl>

### Exercises

1.  What happens if you include the name of a variable multiple times in a select() call?

2.  What does the one\_of() function do? Why might it be helpful in conjunction with this vector?

``` r
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
```

1.  Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?

``` r
select(transactions, contains("PRICE"))
```

    ## # A tibble: 12,172 x 8
    ##    price_total price_min price_max price_unit_area_min price_unit_area_max
    ##          <int>     <dbl>     <dbl>               <dbl>               <dbl>
    ##  1     1135773       959    124628               81.2                 4499
    ##  2     4009365       639     62633               16.5                 1606
    ##  3     8674474      1314    127823               29.1                 2834
    ##  4    10115291       639    137410               10.6                 2114
    ##  5     9952072       639    370688                3.79                2913
    ##  6          NA        NA        NA               NA                     NA
    ##  7          NA        NA        NA               NA                     NA
    ##  8       28602       192      4793                6.97                 175
    ##  9      117529       192      9587                6.01                 266
    ## 10      169411       192     15978                3.96                 348
    ## # ... with 12,162 more rows, and 3 more variables:
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>

Add new variables with mutate()
-------------------------------

Mutate creates new variables/columns from existing variables/columns.

Let's adjust median price per unit area by consumer index. First, select smaller subset of columns:

``` r
(transactions_price <- select(transactions, 
  year:transactions, 
  ends_with("median"), 
  consumer_index
))
```

    ## # A tibble: 12,172 x 7
    ##     year month county  area   transactions price_unit_area… consumer_index
    ##    <int> <int> <chr>   <chr>         <int>            <dbl>          <dbl>
    ##  1  2005     1 Harju … 10-29…           65            717             97.5
    ##  2  2005     1 Harju … 30-40…          155            746             97.5
    ##  3  2005     1 Harju … 41-54…          253            713             97.5
    ##  4  2005     1 Harju … 55-69…          230            663             97.5
    ##  5  2005     1 Harju … 70-24…          118            852             97.5
    ##  6  2005     1 Hiiu m… 41-54…            1             NA             97.5
    ##  7  2005     1 Hiiu m… 55-69…            1             NA             97.5
    ##  8  2005     1 Ida-Vi… 10-29…           12             71.8           97.5
    ##  9  2005     1 Ida-Vi… 30-40…           48             41.0           97.5
    ## 10  2005     1 Ida-Vi… 41-54…           35             53.2           97.5
    ## # ... with 12,162 more rows

Consumer index is expressed as percent relative to 2005:

``` r
mutate(transactions_price,
  consumer_index = consumer_index / 100,
  adj_price = price_unit_area_median * consumer_index
)
```

    ## # A tibble: 12,172 x 8
    ##     year month county  area   transactions price_unit_area… consumer_index
    ##    <int> <int> <chr>   <chr>         <int>            <dbl>          <dbl>
    ##  1  2005     1 Harju … 10-29…           65            717            0.975
    ##  2  2005     1 Harju … 30-40…          155            746            0.975
    ##  3  2005     1 Harju … 41-54…          253            713            0.975
    ##  4  2005     1 Harju … 55-69…          230            663            0.975
    ##  5  2005     1 Harju … 70-24…          118            852            0.975
    ##  6  2005     1 Hiiu m… 41-54…            1             NA            0.975
    ##  7  2005     1 Hiiu m… 55-69…            1             NA            0.975
    ##  8  2005     1 Ida-Vi… 10-29…           12             71.8          0.975
    ##  9  2005     1 Ida-Vi… 30-40…           48             41.0          0.975
    ## 10  2005     1 Ida-Vi… 41-54…           35             53.2          0.975
    ## # ... with 12,162 more rows, and 1 more variable: adj_price <dbl>
