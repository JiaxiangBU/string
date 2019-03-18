ch2 - stringr
================

# str\_c 更好的处理 NA

1.  str\_c 当发现有 `NA`进行合并和 collapse 时，保留 NA 不做其他修改
2.  这点比 `paste` 和 `paste0` 更好

<!-- end list -->

``` r
library(stringr)
library(tidyverse)
```

    ## -- Attaching packages ---------------------------------------------- tidyverse 1.2.1 --

    ## √ ggplot2 3.1.0     √ readr   1.2.1
    ## √ tibble  1.4.2     √ purrr   0.2.5
    ## √ tidyr   0.8.2     √ dplyr   0.7.8
    ## √ ggplot2 3.1.0     √ forcats 0.3.0

    ## -- Conflicts ------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
my_toppings <- c("cheese", NA, NA)
my_toppings_and <- paste(c("", "", "and "), my_toppings, sep = "")

# Print my_toppings_and
my_toppings_and
```

    ## [1] "cheese" "NA"     "and NA"

``` r
# Use str_c() instead of paste(): my_toppings_str
my_toppings_str <- str_c(c("", "", "and "), my_toppings)

# Print my_toppings_str
my_toppings_str
```

    ## [1] "cheese" NA       NA

``` r
# paste() my_toppings_and with collapse = ", "
paste(my_toppings_and,collapse = ", ")
```

    ## [1] "cheese, NA, and NA"

``` r
# str_c() my_toppings_str with collapse = ", "
str_c(my_toppings_str,collapse = ", ")
```

    ## [1] NA

``` r
str_c(my_toppings_str,collapse = ", ") %>% str_replace_na('There is no value.')
```

    ## [1] "There is no value."

# str\_length

`str_length` 对 factor 变量同样有效。

``` r
str_length(factor('haha'))
```

    ## [1] 4

# 英文名特点

``` r
library(babynames)
data(babynames)
```

``` r
babynames %>% dim
```

    ## [1] 1858689       5

``` r
babynames_sub <- 
    babynames %>% 
    filter(year >= 1990)
```

<input type="checkbox" id="checkbox1" class="styled">找不到 year 报错

``` r
babynames_sub %>% 
    transmute(
        first_letter = str_sub(name,1,1)
        ,last_letter = str_sub(name,-1,-1)
    ) %>% 
    {
        list(
            first_letter = table(.$first_letter)
            ,last_letter = table(.$last_letter)
        )
            
    }
```

    ## $first_letter
    ## 
    ##     A     B     C     D     E     F     G     H     I     J     K     L 
    ## 92350 29989 46805 53859 28753  9035 16287 16608 12637 72538 71396 38640 
    ##     M     N     O     P     Q     R     S     T     U     V     W     X 
    ## 63574 27820  7352 11052  3655 35884 59618 47717  1624  7881  5537  2039 
    ##     Y     Z 
    ## 11974 14562 
    ## 
    ## $last_letter
    ## 
    ##      a      b      c      d      e      f      g      h      i      j 
    ## 200019   2700   2896  12558 108905   1654   2744  46282  46890   1285 
    ##      k      l      m      n      o      p      q      r      s      t 
    ##   8470  35362  10046 156160  21918   1004    556  27105  29357  10848 
    ##      u      v      w      x      y      z 
    ##   3094   1306    986   1905  51082   4054

因此以a开头和结尾的名字在90后和00后挺多的。

# str\_count

``` r
babynames_sub %>% 
    mutate(contain_n_a = str_count(name,'A|a')) %>% 
    summarise(
        mean(contain_n_a)
        ,sum(contain_n_a>0)
        ,sum(contain_n_a>1)
        ,sum(contain_n_a>2)
        ,sum(contain_n_a>3)
        ,sum(contain_n_a>4)
        ,sum(contain_n_a>5)
    ) %>% 
    gather
```

    ## # A tibble: 7 x 2
    ##   key                      value
    ##   <chr>                    <dbl>
    ## 1 mean(contain_n_a)         1.09
    ## 2 sum(contain_n_a > 0) 592224   
    ## 3 sum(contain_n_a > 1) 229623   
    ## 4 sum(contain_n_a > 2)  40774   
    ## 5 sum(contain_n_a > 3)   1477   
    ## 6 sum(contain_n_a > 4)      9   
    ## 7 sum(contain_n_a > 5)      0

可以发现字母a挺常用的。

# str\_split

`simplify = TRUE`转换成矩阵，由于是统一数据类型，因此转换成矩阵，更加计算有效率。

``` r
both_names <- c("Box, George", "Cox, David")

# Split both_names into first_names and last_names
both_names_split <- str_split(both_names,", ",n=2,simplify = T)
both_names_split
```

    ##      [,1]  [,2]    
    ## [1,] "Box" "George"
    ## [2,] "Cox" "David"

``` r
# Get first names
both_names_split[,2]
```

    ## [1] "George" "David"

``` r
# Get last names
both_names_split[,1]
```

    ## [1] "Box" "Cox"

# lapply

``` r
lines <- 
    c(
        "The table was a large one, but the three were all crowded together at one corner of it:"
        ,"\"No room! No room!\" they cried out when they saw Alice coming."
        ,"\"There’s plenty of room!\" said Alice indignantly, and she sat down in a large arm-chair at one end of the table."
    )
```

``` r
# Split lines into words
words <- str_split(lines,' ')

# Number of words per line
lapply(words,length)
```

    ## [[1]]
    ## [1] 18
    ## 
    ## [[2]]
    ## [1] 12
    ## 
    ## [[3]]
    ## [1] 21

``` r
# Number of characters in each word
word_lengths <- lapply(words,str_length)
  
# Average word length per line
lapply(word_lengths,mean)
```

    ## [[1]]
    ## [1] 3.888889
    ## 
    ## [[2]]
    ## [1] 4.25
    ## 
    ## [[3]]
    ## [1] 4.380952

# 实现需求 首名首字母提取

``` r
# Define some full names
names <- c("Diana Prince", "Clark Kent")

# Split into first and last names
names_split <- str_split(names, fixed(" "), simplify = TRUE)

# Extract the first letter in the first name
abb_first <- str_sub(names_split[, 1], 1, 1)

# Combine the first letter ". " and last name
str_c(abb_first, ". ", names_split[, 2])
```

    ## [1] "D. Prince" "C. Kent"

# rebus 包

1.  方便管理复杂的正则化表达，因为**支持缩进**。
2.  支持共同部分的设定变量去调用

<!-- end list -->

``` r
library(rebus)
```

    ## 
    ## Attaching package: 'rebus'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     alpha

    ## The following object is masked from 'package:stringr':
    ## 
    ##     regex

1.  Alternation `or()`
    1.  `or('aaa','bbb')` -\> (?:aaa|bbb)
    2.  `"gr" %R% or("e", "a") %R% "y"` -\> gr(?:e|a)y
2.  Character classes `char_class()`
    1.  `char_class("ae")` -\> \[ae\]
    2.  `negated_char_class("ae")` -\> \[^ae\]
3.  Repetition `optional()`, `one_or_more()`,
    `zero_or_more()`,`repeated(lo,hi)`不支持`%R%`
4.  `exactly()` = `START %R% ... %R% END`
5.  Shortcuts
    1.  `DGT` = \\d
    2.  `SPC` = 
    3.  `WRD` = `[a-zA-Z0-9_]`
6.  Special characters
    1.  BACKSLASH = \\
    2.  CARET = ^
    3.  DOLLAR = $
    4.  DOT = .
    5.  PIPE = |
    6.  QUESTION = ?
    7.  STAR = \*
    8.  PLUS = +
    9.  OPEN\_PAREN = (
    10. CLOSE\_PAREN = )
    11. OPEN\_BRACKET = \[
    12. CLOSE\_BRACKET = \]
    13. OPEN\_BRACE = {

<!-- end list -->

  - `str_view()`中的`match = TRUE`  
    this will only display elements that had a match, which is useful
    when you are searching over many strings.
    且只展示第一个字母，全展示使用`str_view_all`
    使用去查看自己的规则是否正确
