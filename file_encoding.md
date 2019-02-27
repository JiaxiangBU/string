查询文件的编码
================

参考 learn\_httr/pkgdown/intro

``` r
suppressMessages(library(tidyverse))
library(stringi)
library(fs)
```

``` r
dir_info(".") %>% 
    filter(path %>% str_detect("\\.Rmd$"),
           type == 'file'
           ) %>% 
    mutate(
        encoding = map(path,~stri_enc_detect(read_file(.))[[1]])
    ) %>% 
    unnest() %>% 
    group_by(path) %>% 
    filter(Confidence == max(Confidence)) %>% 
    select(path,Encoding)
```

    ## # A tibble: 10 x 2
    ## # Groups:   path [10]
    ##    path                Encoding  
    ##    <fs::path>          <chr>     
    ##  1 a20190221121451.Rmd ISO-8859-1
    ##  2 a20190227103642.Rmd UTF-8     
    ##  3 ch1.Rmd             UTF-8     
    ##  4 ch2.Rmd             UTF-8     
    ##  5 ch3.Rmd             UTF-8     
    ##  6 ch4.Rmd             UTF-8     
    ##  7 ch5.Rmd             UTF-8     
    ##  8 chr-trim-pad.Rmd    UTF-8     
    ##  9 file_encoding.Rmd   UTF-8     
    ## 10 README.Rmd          ISO-8859-1

2019-02-27 10:43:01

1.  fs method
2.  完善函数，因为 encoding 只会给一个可能性 list，这里反馈最可能性项目
