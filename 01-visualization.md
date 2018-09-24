Data visualisation using ggplot2
================
Taavi Päll
19 3 2018

Class I
=======

Visualization of your analysis results or data is not only the matter of taste but must be effective and present your results and data honestly.

Numerical summaries, like arithmetic mean or correlation coefficient, can be deceiving when shape of the data is not known or shown, think of average salary or **datasaurus**.

Therefore, data visualization is natural starting point of every data analysis workflow.

``` r
library(datasauRus)
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.3.0
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ───────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
ggplot2::ggplot(datasaurus_dozen) +
  ggplot2::geom_point(ggplot2::aes(x, y)) +
  ggplot2::facet_wrap(~ dataset) +
  ggplot2::labs(title = "Datasurus: these 12 datasets are equal in standard measures:\nmean, standard deviation, and Pearson's correlation")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-1-1.png)

Here we get started with R from the standpoint of visualization. (Luckily for you it's not data structures or subsetting. We leave these topics for later, so don't be worried.)

Sources
-------

-   This tutorial is heavily based on "Data visualization with ggplot2" chapter in [R4DS](http://r4ds.had.co.nz/data-visualisation.html) by G. Grolemund and H. Wickham.
-   [lectures/graafilised-lahendused](https://rstats-tartu.github.io/lectures/graafilised-lahendused.html) and [learn-r/ggplot2](https://tpall.github.io/learn-r/#ggplot2) by Ülo Maiväli and Taavi Päll

ggplot2
-------

**ggplot2** is an R package for producing statistical graphics based on the grammar of graphics (hence the gg!).

Let's start by loading tidyverse (meta) library which provides us with set of necessary packages to start with data analysis and visualizations.

``` r
library(tidyverse)
```

As you can see, running this line of code loads eight different packages (libraries) and warns that some of the functions (filter(), lag()) that were just loaded into namespace have identical name to functions that were already present in namespace. These new functions masked old ones and, in case you want to use these masked functions, you need to call them explicitly by using package where it comes from `stats::filter()`.

If you get error message "there is no package called 'tidyverse'", then you need to install this package and run again `library()`:

``` r
install.packages("tidyverse")
library(tidyverse)
```

First steps
-----------

We need data to create plots! As for start, let's use ggplot2 built in dataset **mpg** with fuel economy data from 1999 and 2008 for 38 models of car:

``` r
mpg # aka ggplot::mpg
```

    ## # A tibble: 234 x 11
    ##    manufacturer model    displ  year   cyl trans   drv     cty   hwy fl   
    ##    <chr>        <chr>    <dbl> <int> <int> <chr>   <chr> <int> <int> <chr>
    ##  1 audi         a4        1.80  1999     4 auto(l… f        18    29 p    
    ##  2 audi         a4        1.80  1999     4 manual… f        21    29 p    
    ##  3 audi         a4        2.00  2008     4 manual… f        20    31 p    
    ##  4 audi         a4        2.00  2008     4 auto(a… f        21    30 p    
    ##  5 audi         a4        2.80  1999     6 auto(l… f        16    26 p    
    ##  6 audi         a4        2.80  1999     6 manual… f        18    26 p    
    ##  7 audi         a4        3.10  2008     6 auto(a… f        18    27 p    
    ##  8 audi         a4 quat…  1.80  1999     4 manual… 4        18    26 p    
    ##  9 audi         a4 quat…  1.80  1999     4 auto(l… 4        16    25 p    
    ## 10 audi         a4 quat…  2.00  2008     4 manual… 4        20    28 p    
    ## # ... with 224 more rows, and 1 more variable: class <chr>

If you worry where this dataset comes from, then there is no magic -- it's bundled with ggplot2 package and will be invisibly loaded every time when ggplot2 library is loaded. mpg invisibility means that, differently from your own R objects, it will not show up in your Environment panel.

For us, key variables in mpg dataset are:

-   `displ` -- engine displacement (L),
-   `hwy` -- highway miles per gallon

Creating a ggplot
-----------------

Simple scatter plot to explore relationship between fuel consumption in highway traffic (hwy) and engine size (displ) is created like this. Here we put displ on the x-axis and hwy on the y-axis:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  labs(x = "Engine displacement",
       y = "Miles per gallon")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-5-1.png)

Here you can see negative relationship between engine size and fuel consumption. It's probably no news to anyone that cars with big engines guzzle more fuel.

-   **ggplot2 works iteratively** -- you start with a layer showing the raw data and then add layers of geoms, annotations, and statistical summaries.

To compose plots, you have to supply minimally:

-   **Data** that you want to visualize and
-   **aes**thetic **mappings** -- what's on x-axis, what's on y-axis, and how to you want to group and color your data. Mapped arguments must be found in your data!
-   **Layers** made up of **geom**etric elements: points, lines, boxes, etc. What's shown on plot.

Visualization of these three components within ggplot context looks like this:

    ggplot(data = <DATA>) +
      <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

### Excercises

1.  Run ggplot(data = mpg). What do you see?

``` r
ggplot(data = mpg)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-6-1.png)

1.  How many rows are in mtcars dataset? How many columns?

``` r
mpg
```

    ## # A tibble: 234 x 11
    ##    manufacturer model    displ  year   cyl trans   drv     cty   hwy fl   
    ##    <chr>        <chr>    <dbl> <int> <int> <chr>   <chr> <int> <int> <chr>
    ##  1 audi         a4        1.80  1999     4 auto(l… f        18    29 p    
    ##  2 audi         a4        1.80  1999     4 manual… f        21    29 p    
    ##  3 audi         a4        2.00  2008     4 manual… f        20    31 p    
    ##  4 audi         a4        2.00  2008     4 auto(a… f        21    30 p    
    ##  5 audi         a4        2.80  1999     6 auto(l… f        16    26 p    
    ##  6 audi         a4        2.80  1999     6 manual… f        18    26 p    
    ##  7 audi         a4        3.10  2008     6 auto(a… f        18    27 p    
    ##  8 audi         a4 quat…  1.80  1999     4 manual… 4        18    26 p    
    ##  9 audi         a4 quat…  1.80  1999     4 auto(l… 4        16    25 p    
    ## 10 audi         a4 quat…  2.00  2008     4 manual… 4        20    28 p    
    ## # ... with 224 more rows, and 1 more variable: class <chr>

``` r
class(mpg)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

1.  What does the drv variable describe? Read help for ?mpg to find out.

``` r
?mpg
```

1.  Make scatterplot of *hwy* vs *cyl* using mpg data:

``` r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-10-1.png)

1.  What happens when you make a scatterplot of *class* versus *drv* using mpg data:

``` r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-11-1.png)

Is it useful?

Aesthetic mappings
------------------

hwy ~ displ scatter plot tells us that there is linear relationship between engine size and fuel consumption: bigger engines use more fuel and are therefore less efficient. Nevertheless, if we look at the cars with huge engines (&gt;5L), it's apparent that there are some outliers (plot below) that perform better than cars in this engine class in general.

What are those cars? Do they have something in common?

``` r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = (hwy > 20 & displ > 5)))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-12-1.png)

To get a clue about the nature of these outliers, we would like add more info present in our mpg dataset to plot. To add more variables to 2D scatterplot, we can use additional aesthetic mappings.

Aesthetics like color, shape, fill, and size can be used to add additional variables to a plot.

Let's map color of the points to class variable in mpg dataset to reveal the class of each car:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-13-1.png)

We can see that most of the cars with large motors with better fuel efficiency belong to sports cars (2seaters).

Let's recreate previous plot with class mapped to size of each point:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
```

    ## Warning: Using size for a discrete variable is not advised.

![](01-visualization_files/figure-markdown_github/unnamed-chunk-14-1.png)

Ouch, we get warning... seems its not a good idea. Why? What's wrong with the next plot where we have four, let's say diameter, categories ("tiny", "small", "big", "very big") and we want to map size aesthetic to diameter

``` r
ggplot(data = data_frame(x = c(1:4), y = 1, diameter = c("tiny", "small", "big", "very big"))) +
  geom_point(mapping = aes(x = x, y = y, size = diameter))
```

    ## Warning: Using size for a discrete variable is not advised.

![](01-visualization_files/figure-markdown_github/unnamed-chunk-15-1.png) Maybe this plot explains why it's generally not a good idea to map categorical variable to size aesthetic.

Excercise
---------

Map **alpha** aesthetic to class:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-16-1.png)

Map **size** aesthetic to class:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
```

    ## Warning: The shape palette can deal with a maximum of 6 discrete values
    ## because more than 6 becomes difficult to discriminate; you have 7.
    ## Consider specifying shapes manually if you must have them.

    ## Warning: Removed 62 rows containing missing values (geom_point).

![](01-visualization_files/figure-markdown_github/unnamed-chunk-17-1.png)

Is everything OK with shapes?

> When you set your aesthetic via mapping, ggplot automatically takes care of the rest: it finds best scale to display selected aesthetic and draws a legend. Note that this happens only when you map aesthetic within aes() function.

### Set aesthetic manually

You can change the appearance of your plot also manually: change the color or shape of all the points.

For example, let's suppose you want to make all points in plot blue:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue") # try HEX code "#0000ff" or rgb(0,0,1)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-18-1.png)

Here, the color is not connected to the variable in your dataset, but just changes the appearance of the plot. Therefore, to change the appearance of the plot, you need to assign value to aesthetic **outside** aes() in geom function.

You just have to pick a value that makes sense for that aesthetic:

-   the name/code of the color as a character string ("blue", "\#0000ff")
-   size of a point in mm
-   shape of a point as a number

### Shape codes

While colors and sizes are intuitive, it seems impossible to remember available point shape codes in R. The quickest way out of this is to know how to generate an example plot of the first 25 shapes quickly. Numbers next to shapes denote R shape number.

``` r
ggplot(data = data_frame(x = rep(1:5, 5), y = rep(5:1, each = 5), shape = c(0:24))) + 
  geom_point(mapping = aes(x = x, y = y, shape = shape), fill = "green", color = "blue", size = 3) +
  geom_text(mapping = aes(x = x, y = y, label = shape), hjust = 1.7) +
  scale_shape_identity() +
  theme(axis.text = element_blank(),
        axis.title = element_blank())
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-19-1.png)

Let's use more than 6 shapes:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class), position = position_jitter(0.1)) +
  scale_shape_manual(values = 0:6)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-20-1.png)

Here, we used fill="green", color="blue", to change the appearance of the points, and also adjusted size of the points (size=3) for better visibility. Note the differences how fill and color work on different point shapes! Which is the default point shape in ggplot?

### Excercises

1.  What's wrong with this plot? Why are points not blue? Can you fix the code?

``` r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-21-1.png)

1.  Which variables in mpg are categorical? Which variables are continuous? (type ?mpg to read the documentation for the dataset). How can you see when you run mpg?

``` r
mpg
```

    ## # A tibble: 234 x 11
    ##    manufacturer model    displ  year   cyl trans   drv     cty   hwy fl   
    ##    <chr>        <chr>    <dbl> <int> <int> <chr>   <chr> <int> <int> <chr>
    ##  1 audi         a4        1.80  1999     4 auto(l… f        18    29 p    
    ##  2 audi         a4        1.80  1999     4 manual… f        21    29 p    
    ##  3 audi         a4        2.00  2008     4 manual… f        20    31 p    
    ##  4 audi         a4        2.00  2008     4 auto(a… f        21    30 p    
    ##  5 audi         a4        2.80  1999     6 auto(l… f        16    26 p    
    ##  6 audi         a4        2.80  1999     6 manual… f        18    26 p    
    ##  7 audi         a4        3.10  2008     6 auto(a… f        18    27 p    
    ##  8 audi         a4 quat…  1.80  1999     4 manual… 4        18    26 p    
    ##  9 audi         a4 quat…  1.80  1999     4 auto(l… 4        16    25 p    
    ## 10 audi         a4 quat…  2.00  2008     4 manual… 4        20    28 p    
    ## # ... with 224 more rows, and 1 more variable: class <chr>

Homework
--------

1.  Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?

2.  What happens if you map the same variable to multiple aesthetics?

3.  What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom\_point)

4.  What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ &lt; 5)?

Class II
========

Adding (more) variables by facet\_wrap
--------------------------------------

We used color, shape and alpha (transparency) to display additional subset in a two-dimensional graph. Using different colours allows visual inference of the distribution of the groups under comparison. But there is apparent limit how much of such information can be accommodated onto one graph before it gets too cluttered.

In addition to reducing visual clutter and overplotting, we can use small subplots just as an another way to bring out subsets from our data. Series of small subplots (multiples) use same scale and axes allowing easier comparisons and are considered very efficient design. Fortunately, ggplot has easy way to do this: facet\_wrap() and facet\_grid() functions split up your dataset and generate multiple small plots arranged in an array. facet\_wrap() works with one variable and facet\_grid() can use two variables.

> At the heart of quantitative reasoning is a single question: Compared to what? Small multiple designs.. answer directly by visually enforcing comparisons of changes, of the differences among objects, of the scope of alternatives. For a wide range of problems in data presentation, small multiples are the best design solution. Edward Tufte (Envisioning Information, p. 67).

Here, we plot each class of cars on a separate subplot and we arrange plots into 2 rows:

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap("class", nrow = 2)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-23-1.png)

To plot combination of two variables, we use facet\_grid():

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-24-1.png)

Note that the variables, used for splitting up data and arranging facets row and column-wise, are specified in facet\_grid() by formula: facet\_grid(rows ~ columns).

If you want to omit rows or columns in facet\_grid() use `. ~ var` or `var ~ .`, respectively.

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-25-1.png)

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl, scales = "free")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-26-1.png)

Exercises
---------

1.  What happens if you facet on a continuous variable?

``` r
mpg
```

    ## # A tibble: 234 x 11
    ##    manufacturer model    displ  year   cyl trans   drv     cty   hwy fl   
    ##    <chr>        <chr>    <dbl> <int> <int> <chr>   <chr> <int> <int> <chr>
    ##  1 audi         a4        1.80  1999     4 auto(l… f        18    29 p    
    ##  2 audi         a4        1.80  1999     4 manual… f        21    29 p    
    ##  3 audi         a4        2.00  2008     4 manual… f        20    31 p    
    ##  4 audi         a4        2.00  2008     4 auto(a… f        21    30 p    
    ##  5 audi         a4        2.80  1999     6 auto(l… f        16    26 p    
    ##  6 audi         a4        2.80  1999     6 manual… f        18    26 p    
    ##  7 audi         a4        3.10  2008     6 auto(a… f        18    27 p    
    ##  8 audi         a4 quat…  1.80  1999     4 manual… 4        18    26 p    
    ##  9 audi         a4 quat…  1.80  1999     4 auto(l… 4        16    25 p    
    ## 10 audi         a4 quat…  2.00  2008     4 manual… 4        20    28 p    
    ## # ... with 224 more rows, and 1 more variable: class <chr>

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ displ)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-28-1.png) Each raw value is contverted to categorical value and gets its own facet?

1.  What do the empty cells in plot with facet\_grid(drv ~ cyl) mean? How do they relate to this plot?

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-29-1.png)

1.  What plots does the following code make? What does . do?

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-30-1.png)

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-30-2.png)

1.  Read ?facet\_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? Why doesn't facet\_grid() have nrow and ncol argumentt.

2.  When using facet\_grid() you should usually put the variable with more unique levels in the columns. Why?

Geometric objects aka geoms
---------------------------

To change the geom in your plot, change the **geom function** that you add to ggplot().

For instance, to create already familiar dot plot use geom\_point():

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-31-1.png)

To create line graph with loess smooth line fitted to these dots use geom\_smooth():

``` r
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-32-1.png)

Every geom function in ggplot2 takes a mapping argument.

However, note that **not every aesthetic works with every geom.**

-   You could set the shape of a point, but you couldn't set the "shape" of a line.
-   On the other hand, you could set the linetype of a line.

We can tweak the above plot by mapping each type of drivetrain (drv) to different linetype.

``` r
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-33-1.png)

Here, 4 stands for four-wheel drive, f for front-wheel drive, and r for rear-wheel drive.

Four-wheel cars are mapped to "solid" line, front-wheel cars to "dashed" line, and rear-wheel cars to "longdash" line.

For more linetypes and their numeric codes please have a look at R cookbook: <http://www.cookbook-r.com/Graphs/Shapes_and_line_types/>.

Currently, ggplot2 provides over 40 geoms:

``` r
gg2 <- lsf.str("package:ggplot2")
gg2[grep("^geom", gg2)]
```

    ##  [1] "geom_abline"     "geom_area"       "geom_bar"       
    ##  [4] "geom_bin2d"      "geom_blank"      "geom_boxplot"   
    ##  [7] "geom_col"        "geom_contour"    "geom_count"     
    ## [10] "geom_crossbar"   "geom_curve"      "geom_density"   
    ## [13] "geom_density_2d" "geom_density2d"  "geom_dotplot"   
    ## [16] "geom_errorbar"   "geom_errorbarh"  "geom_freqpoly"  
    ## [19] "geom_hex"        "geom_histogram"  "geom_hline"     
    ## [22] "geom_jitter"     "geom_label"      "geom_line"      
    ## [25] "geom_linerange"  "geom_map"        "geom_path"      
    ## [28] "geom_point"      "geom_pointrange" "geom_polygon"   
    ## [31] "geom_qq"         "geom_quantile"   "geom_raster"    
    ## [34] "geom_rect"       "geom_ribbon"     "geom_rug"       
    ## [37] "geom_segment"    "geom_smooth"     "geom_spoke"     
    ## [40] "geom_step"       "geom_text"       "geom_tile"      
    ## [43] "geom_violin"     "geom_vline"

To learn more about any single geom, use help, like: ?geom\_smooth.

Many geoms, like **geom\_smooth(), use a single geometric object to display multiple rows of data**. For these geoms, **you can set the group aesthetic to a categorical variable to draw multiple objects**.

Note that in case of the group aesthetic ggplot2 does not add a legend or distinguishing features to the geoms.

You can plot for example all your bootstrapped linear model fits on one plot to visualize uncertainty, whereas all these lines are of the same color/type.

``` r
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-35-1.png)

Other aestheic mappings (color, alpha etc) similarily group your data for display but also add by default legend to the plot. To hide legend, set show.legend to FALSE:

``` r
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-36-1.png)

To display multiple geoms in the same plot, add multiple geom functions to ggplot():

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-37-1.png)

Probably you notice, that if we go with aethetic mappings as we used to, by specifing them within geom function, we introduce some code duplication. This can be easily avoided by moving aes() part from geom\_ to the ggplot():

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-38-1.png)

Now, ggplot2 uses this mapping globally in all geoms.

If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer. It will use these mappings to extend or overwrite the global mappings for that layer only. This way it's possible to use different aesthetics in different layers (for example, if you wish to plot model fit over data points).

Here, we map color to the class of cars, whereas geom\_smooth still plots only one line:

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-39-1.png)

Importantly, you can use the same idea to specify different data for each layer:

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-40-1.png) Above, our smooth line displays just a subset of the mpg dataset, the subcompact cars. The local data argument in geom\_smooth() overrides the global data argument in ggplot() for that layer only.

Exercises
---------

1.  What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?

2.  Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-41-1.png)

1.  What does show.legend = FALSE do? What happens if you remove it?

2.  What does the se argument to geom\_smooth() do?

3.  Will these two graphs look different? Why/why not?

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-42-1.png)

``` r
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

    ## `geom_smooth()` using method = 'loess'

![](01-visualization_files/figure-markdown_github/unnamed-chunk-42-2.png)

Plotting statistical transformations - bar graph tricks
-------------------------------------------------------

Bar graphs are special among ggplot geoms. This is because by default they do some calculations with data before plotting. To get an idea, please have a look at the following bar graph, created by geom\_bar() function.

The chart below displays the total number of diamonds in the **diamonds** dataset, grouped by cut.

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-43-1.png)

Let's have a look at the diamonds dataset, containing the prices and other attributes of ~54000 diamonds.

``` r
diamonds
```

    ## # A tibble: 53,940 x 10
    ##    carat cut       color clarity depth table price     x     y     z
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
    ##  1 0.230 Ideal     E     SI2      61.5   55.   326  3.95  3.98  2.43
    ##  2 0.210 Premium   E     SI1      59.8   61.   326  3.89  3.84  2.31
    ##  3 0.230 Good      E     VS1      56.9   65.   327  4.05  4.07  2.31
    ##  4 0.290 Premium   I     VS2      62.4   58.   334  4.20  4.23  2.63
    ##  5 0.310 Good      J     SI2      63.3   58.   335  4.34  4.35  2.75
    ##  6 0.240 Very Good J     VVS2     62.8   57.   336  3.94  3.96  2.48
    ##  7 0.240 Very Good I     VVS1     62.3   57.   336  3.95  3.98  2.47
    ##  8 0.260 Very Good H     SI1      61.9   55.   337  4.07  4.11  2.53
    ##  9 0.220 Fair      E     VS2      65.1   61.   337  3.87  3.78  2.49
    ## 10 0.230 Very Good H     VS1      59.4   61.   338  4.00  4.05  2.39
    ## # ... with 53,930 more rows

Variable count is nowhere to be found... it's quite different from other plot types, like scatterplot, that plot raw values.

Other graphs, like bar charts, calculate new values to plot:

-   bar charts, histograms, and frequency polygons bin your data and then plot bin counts, the number of points that fall in each bin.

-   smoothers fit a model to your data and then plot predictions from the model.

-   boxplots compute a robust summary of the distribution and then display a specially formatted box.

The algorithm used to calculate new values for a graph is called a stat, short for statistical transformation.

You can learn which stat a geom uses by inspecting the default value for the stat argument in geom\_ function.

For example, ?geom\_bar shows that the default value for stat is "count".

![geom\_bar](plots/stat_count.png)

You can use geoms and stats interchangeably. For example, you can recreate the previous plot using stat\_count() instead of geom\_bar():

``` r
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-45-1.png)

This works because every geom has a default stat; and every stat has a default geom, meaning that you can use geoms without worrying about its underlying statistical transformation.

There are three cases when you might want to specify stat explicitly:

1.  You might want to override the default stat. For example you have alredy summarised counts or means or whatever, then you need to change the default stat in geom\_bar() to "identity": Let's create summarized dataset (don't worry about this code yet, we are going to this in the next classes):

``` r
diamonds_summarised <- diamonds %>% 
  group_by(cut) %>% 
  summarise(N = n())
diamonds_summarised
```

    ## # A tibble: 5 x 2
    ##   cut           N
    ##   <ord>     <int>
    ## 1 Fair       1610
    ## 2 Good       4906
    ## 3 Very Good 12082
    ## 4 Premium   13791
    ## 5 Ideal     21551

Here we (re)create diamond counts plot using summary data. Note that here we need to use also y-aesthetic!

``` r
ggplot(data = diamonds_summarised) +
  geom_bar(mapping = aes(x = cut, y = N), stat = "identity")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-47-1.png)

1.  You might want to override the default mapping from transformed variables to aesthetics. For example, you might want to display a bar chart of proportion, rather than count:

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-48-1.png)

To find the variables computed by the stat, look for the help section titled "computed variables".

1.  You might want to draw greater attention to the statistical transformation in your code. Meaning basically, that you want to plot some summary statistics like median and min/max or mean +/- SE.

Median and min/max:

``` r
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-49-1.png)

Mean and SE:

``` r
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.data = mean_se
  )
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-50-1.png)

If you want to use mean +/- SD like this, you need mean\_sdl() function from Hmisc package (meaning, that you need to install Hmisc).

### Homework 2

Position adjustments - how to get those bars side-by-side
---------------------------------------------------------

There is more you need to know about bar charts. You can easily update diamonds cut counts by mapping cut additonally either to color or fill (whereas fill seems to be more useful):

``` r
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut, fill = cut))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-51-1.png)

But what happens when we map fill to another variable in diamonds data, like clarity:

``` r
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut, fill = clarity))
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-52-1.png)

Wow, bars are automatically **stacked** showing the proportions of different diamond clarity classes within cut quality classes.

If you want to get these stacked bars side-by-side, you need to change the **position adjustment** argument, which is set to "stacked" by default. There are three other options: "identity", "dodge" and "fill".

-   position = "identity" will place each object exactly where it falls in the context of the graph. Its generally not useful with bar graphs, as all bars are behind each other and this plot can be easily mixed up with position = "stacked":

``` r
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut, fill = clarity), position = "identity")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-53-1.png)

Position "stacked" is naturally default in scatterplot.

-   position = "fill" works like stacking, but makes each set of stacked bars the same height. This makes it easier to compare proportions across groups.

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-54-1.png)

-   position = "dodge" places overlapping objects directly beside one another. This makes it easier to compare individual values.

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-55-1.png)

There is another position adjustment function for scatterplots that helps mitigate overplotting: position = "jitter":

``` r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-56-1.png)

"jitter" adds small amount of random noise to your raw data, so that each point gets moved away from its original position. This way you can reveal very similar data points that fall into same place in plot grid.

To learn more about a position adjustment, look up the help page associated with each adjustment: ?position\_dodge, ?position\_fill, ?position\_identity, ?position\_jitter, and ?position\_stack.

### Exercises

1.  What is the problem with this plot? How could you improve it?

``` r
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-57-1.png)

1.  What parameters to geom\_jitter() control the amount of jittering?

2.  What’s the default position adjustment for geom\_boxplot()? Create a visualisation of the mpg dataset that demonstrates it.

Coordinate systems - flip your plot
-----------------------------------

The default coordinate system of ggplot2 is the Cartesian coordinate system where the x and y positions act independently to determine the location of each point.

There are a number of other coordinate systems that are occasionally helpful.

-   coord\_flip() witches the x and y axes. This is useful if you want horizontal boxplots. It's also very useful for long labels: it's hard to get them to fit without overlapping on the x-axis.

``` r
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
```

![](01-visualization_files/figure-markdown_github/unnamed-chunk-58-1.png)

Try to make this plot without flipping... x-axis labels are a mess!

-   coord\_quickmap() sets the aspect ratio correctly for maps. This is very important if you’re plotting spatial data with ggplot2.

``` r
# install.packages("sp")
# level 0 map data was downloaded from http://www.gadm.org/country
est <- read_rds("data/EST_adm0.rds")
ggplot(est, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
```

    ## Loading required package: sp

    ## Regions defined for each Polygons

![](01-visualization_files/figure-markdown_github/unnamed-chunk-59-1.png)

``` r
ggplot(est, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
```

    ## Regions defined for each Polygons

![](01-visualization_files/figure-markdown_github/unnamed-chunk-59-2.png)

### Excercises

1.  What does labs() do? Read the documentation.

2.  What’s the difference between coord\_quickmap() and coord\_map()?

Grammar of graphics summary
---------------------------

Constructing ggplot graphs can be reduced to the following template, at minimum you need data and one geom to produce a plot.

``` r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
     mapping = aes(<MAPPINGS>),
     stat = <STAT>, 
     position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
```
