REF 参数的使用
================
Jiaxiang Li
2019-03-18

``` r
suppressMessages(library(tidyverse))
```

需求是在
[github](https://github.com/JiaxiangBU/learn_git/blob/master/conda/command-not-found-error.md)

``` r
"CommandNotFoundError" %>% 
    str_replace_all('([:lower:])([:Upper:])','\\1-\\2') %>% 
    str_to_lower()
```

    ## [1] "command-not-found-error"

``` r
"CommandNotFoundError" %>% 
    str_replace_all('([:lower:])([:Upper:])','\\1 \\2')
```

    ## [1] "Command Not Found Error"
