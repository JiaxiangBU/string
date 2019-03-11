str\_which
================
Jiaxiang Li
2019-03-11

str\_which = str\_detect %\>% which

``` r
suppressMessages(library(tidyverse))
mtcars_names <- mtcars %>% row.names()
```

``` r
mtcars_names %>% str_which("4")
```

    ## [1]  1  2  4  8 12 13 14 27 32

``` r
mtcars_names %>% str_detect("4") %>% which
```

    ## [1]  1  2  4  8 12 13 14 27 32
