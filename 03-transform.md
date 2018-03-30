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

    ## ── Attaching packages ──────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
    ## ✔ tibble  1.4.2          ✔ dplyr   0.7.4     
    ## ✔ tidyr   0.8.0          ✔ stringr 1.3.0     
    ## ✔ readr   1.1.1          ✔ forcats 0.2.0

    ## ── Conflicts ─────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
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
    ##   month = col_character(),
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
    ##   subtitle = col_character()
    ## )

    ## # A tibble: 12,172 x 17
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <chr> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005 Jan   Harju … 10-2…           65     1419        21.8     1135773
    ##  2  2005 Jan   Harju … 30-4…          155     5432        35.0     4009365
    ##  3  2005 Jan   Harju … 41-5…          253    12044        47.6     8674474
    ##  4  2005 Jan   Harju … 55-6…          230    14516        63.1    10115291
    ##  5  2005 Jan   Harju … 70-2…          118    10905        92.4     9952072
    ##  6  2005 Jan   Hiiu m… 41-5…            1       51.2      51.2          NA
    ##  7  2005 Jan   Hiiu m… 55-6…            1       67.6      67.6          NA
    ##  8  2005 Jan   Ida-Vi… 10-2…           12      329        27.4       28602
    ##  9  2005 Jan   Ida-Vi… 30-4…           48     1721        35.8      117529
    ## 10  2005 Jan   Ida-Vi… 41-5…           35     1668        47.6      169411
    ## # ... with 12,162 more rows, and 9 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>

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

### Filter rows with filter()

filter() allows you to subset observations based on their values. The first argument is the name of the data frame. The second and subsequent arguments are the expressions that filter the data frame.

For example, we can select data on January 2005 with:

``` r
filter(transactions, year == 2005, month == "Jan")
```

    ## # A tibble: 65 x 17
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <chr> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005 Jan   Harju … 10-2…           65     1419        21.8     1135773
    ##  2  2005 Jan   Harju … 30-4…          155     5432        35.0     4009365
    ##  3  2005 Jan   Harju … 41-5…          253    12044        47.6     8674474
    ##  4  2005 Jan   Harju … 55-6…          230    14516        63.1    10115291
    ##  5  2005 Jan   Harju … 70-2…          118    10905        92.4     9952072
    ##  6  2005 Jan   Hiiu m… 41-5…            1       51.2      51.2          NA
    ##  7  2005 Jan   Hiiu m… 55-6…            1       67.6      67.6          NA
    ##  8  2005 Jan   Ida-Vi… 10-2…           12      329        27.4       28602
    ##  9  2005 Jan   Ida-Vi… 30-4…           48     1721        35.8      117529
    ## 10  2005 Jan   Ida-Vi… 41-5…           35     1668        47.6      169411
    ## # ... with 55 more rows, and 9 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>

dplyr runs the filtering operation and returns a new data frame. dplyr functions never modify their inputs, so if you want to save the result, you'll need to use the assignment operator, &lt;-:

``` r
jan2005 <- filter(transactions, year == 2005, month == "Jan")
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
filter(transactions, month == "Nov" | month == "Dec")
```

    ## # A tibble: 1,889 x 17
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <chr> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005 Nov   Harju … 10-2…          166     3340        20.1     3732962
    ##  2  2005 Nov   Harju … 30-4…          278     9786        35.2    10232826
    ##  3  2005 Nov   Harju … 41-5…          530    25558        48.2    24595849
    ##  4  2005 Nov   Harju … 55-6…          461    28860        62.6    26653174
    ##  5  2005 Nov   Harju … 70-2…          338    32617        96.5    34664200
    ##  6  2005 Nov   Hiiu m… 30-4…            2       76.1      38.0          NA
    ##  7  2005 Nov   Hiiu m… 41-5…            3      134        44.8          NA
    ##  8  2005 Nov   Hiiu m… 55-6…            1       59.9      59.9          NA
    ##  9  2005 Nov   Ida-Vi… 10-2…           23      617        26.8      117442
    ## 10  2005 Nov   Ida-Vi… 30-4…           83     2987        36.0      505379
    ## # ... with 1,879 more rows, and 9 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>

You can’t write filter(flights, month == "Nov" | "Dec") and in case of numeric months this will give you wrong answer instead of Error, so be careful:

``` r
filter(transactions, month == "Nov" | "Dec")
```

A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values in y:

``` r
(nov_dec <- filter(transactions, month %in% c("Nov", "Dec")))
```

    ## # A tibble: 1,889 x 17
    ##     year month county  area  transactions area_total area_mean price_total
    ##    <int> <chr> <chr>   <chr>        <int>      <dbl>     <dbl>       <int>
    ##  1  2005 Nov   Harju … 10-2…          166     3340        20.1     3732962
    ##  2  2005 Nov   Harju … 30-4…          278     9786        35.2    10232826
    ##  3  2005 Nov   Harju … 41-5…          530    25558        48.2    24595849
    ##  4  2005 Nov   Harju … 55-6…          461    28860        62.6    26653174
    ##  5  2005 Nov   Harju … 70-2…          338    32617        96.5    34664200
    ##  6  2005 Nov   Hiiu m… 30-4…            2       76.1      38.0          NA
    ##  7  2005 Nov   Hiiu m… 41-5…            3      134        44.8          NA
    ##  8  2005 Nov   Hiiu m… 55-6…            1       59.9      59.9          NA
    ##  9  2005 Nov   Ida-Vi… 10-2…           23      617        26.8      117442
    ## 10  2005 Nov   Ida-Vi… 30-4…           83     2987        36.0      505379
    ## # ... with 1,879 more rows, and 9 more variables: price_min <dbl>,
    ## #   price_max <dbl>, price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>

Sometimes you can simplify complicated subsetting by remembering De Morgan’s law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. For example, if you wanted to find flights that weren’t delayed (on arrival or departure) by more than two hours, you could use either of the following two filters:

``` r
filter(transactions, !(price_min > 1000 | price_max > 1000))
```

    ## # A tibble: 2 x 17
    ##    year month county   area  transactions area_total area_mean price_total
    ##   <int> <chr> <chr>    <chr>        <int>      <dbl>     <dbl>       <int>
    ## 1  2009 Apr   Valga m… 41-5…            6        278      46.3        3019
    ## 2  2012 Mar   Rapla m… 10-2…            7        145      20.7          NA
    ## # ... with 9 more variables: price_min <dbl>, price_max <dbl>,
    ## #   price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>

``` r
filter(transactions,  price_min <= 1000, price_max <= 1000)
```

    ## # A tibble: 2 x 17
    ##    year month county   area  transactions area_total area_mean price_total
    ##   <int> <chr> <chr>    <chr>        <int>      <dbl>     <dbl>       <int>
    ## 1  2009 Apr   Valga m… 41-5…            6        278      46.3        3019
    ## 2  2012 Mar   Rapla m… 10-2…            7        145      20.7          NA
    ## # ... with 9 more variables: price_min <dbl>, price_max <dbl>,
    ## #   price_unit_area_min <dbl>, price_unit_area_max <dbl>,
    ## #   price_unit_area_median <dbl>, price_unit_area_mean <dbl>,
    ## #   price_unit_area_sd <dbl>, title <chr>, subtitle <chr>

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
