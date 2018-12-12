ch3 - rebus
================

# rebus 包

1.  方便管理复杂的正则化表达，因为**支持缩进**。
2.  支持共同部分的设定变量去调用

<!-- end list -->

``` r
library(rebus)
```

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
7.  Date-time regexes

<!-- end list -->

  - `str_view()`中的`match = TRUE`  
    this will only display elements that had a match, which is useful
    when you are searching over many
    strings.
    且只展示第一个字母，全展示使用`str_view_all`
    使用去查看自己的规则是否正确

<!-- end list -->

``` r
library(tidyverse)
```

    ## -- Attaching packages ---------------------------------------------- tidyverse 1.2.1 --

    ## √ ggplot2 3.1.0     √ purrr   0.2.5
    ## √ tibble  1.4.2     √ dplyr   0.7.8
    ## √ tidyr   0.8.2     √ stringr 1.3.1
    ## √ readr   1.2.1     √ forcats 0.3.0

    ## -- Conflicts ------------------------------------------------- tidyverse_conflicts() --
    ## x ggplot2::alpha() masks rebus::alpha()
    ## x dplyr::filter()  masks stats::filter()
    ## x dplyr::lag()     masks stats::lag()
    ## x stringr::regex() masks rebus::regex()

``` r
contact <- 
c('Call me at 555-555-0191','123 Main St','(555) 555 0191','Phone: 555.555.0191 Mobile: 555.555.0192')

optional('(') %R%
    repeated(DGT,3) %R%
    optional(')') %R%
    char_class("-.() ") %R%
    repeated(DGT,3) %R%
    char_class("-.() ") %R%
    repeated(DGT,4) %>% 
    str_extract_all(contact,.)
```

    ## [[1]]
    ## [1] "555-555-0191"
    ## 
    ## [[2]]
    ## character(0)
    ## 
    ## [[3]]
    ## [1] "(555) 555 0191"
    ## 
    ## [[4]]
    ## [1] "555.555.0191" "555.555.0192"

分段写函数，方便管理

``` r
narratives <- 
c("19YOM-SHOULDER STRAIN-WAS TACKLED WHILE PLAYING FOOTBALL W/ FRIENDS ","31 YOF FELL FROM TOILET HITITNG HEAD SUSTAINING A CHI ","ANKLE STR. 82 YOM STRAINED ANKLE GETTING OUT OF BED ","TRIPPED OVER CAT AND LANDED ON HARDWOOD FLOOR. LACERATION ELBOW, LEFT. 33 YOF*","10YOM CUT THUMB ON METAL TRASH CAN DX AVULSION OF SKIN OF THUMB ","53 YO F TRIPPED ON CARPET AT HOME. DX HIP CONTUSION ","13 MOF TRYING TO STAND UP HOLDING ONTO BED FELL AND HIT FOREHEAD ON RADIATOR DX LACERATION","14YR M PLAYING FOOTBALL; DX KNEE SPRAIN ","55YOM RIDER OF A BICYCLE AND FELL OFF SUSTAINED A CONTUSION TO KNEE ","5 YOM ROLLING ON FLOOR DOING A SOMERSAULT AND SUSTAINED A CERVICAL STRA IN")
```

``` r
# Use these patterns
age <- dgt(1,2)
unit <- optional(SPC) %R% or("YO", "YR", "MO")
gender <- optional(SPC) %R% or("M", "F")

# Extract age, unit, gender
age_gender <- str_extract(narratives,age %R% unit %R% gender)
age_gender
```

    ##  [1] "19YOM"   "31 YOF"  "82 YOM"  "33 YOF"  "10YOM"   "53 YO F" "13 MOF" 
    ##  [8] "14YR M"  "55YOM"   "5 YOM"

``` r
# 之后还可以利用规则，进行变量提取

age_gender %>% 
    tibble() %>% 
    set_names('raw') %>% 
    mutate(
        gender = str_extract(raw,gender)
    ) %>% 
    mutate(
        is_year = str_extract(raw,unit) %>% str_trim %>% str_sub(1,1)
        ,age_num = str_extract(raw,age)
        ,age = 
            if (is_year == 'Y') {
                as.numeric(age_num)
            } else {
                as.numeric(age_num)/12
            }
    ) %>% 
    select(raw,gender,age)
```

    ## Warning in if (is_year == "Y") {: 条件的长度大于一，因此只能用其第一元素

    ## # A tibble: 10 x 3
    ##    raw     gender   age
    ##    <chr>   <chr>  <dbl>
    ##  1 19YOM   M         19
    ##  2 31 YOF  F         31
    ##  3 82 YOM  M         82
    ##  4 33 YOF  F         33
    ##  5 10YOM   M         10
    ##  6 53 YO F " F"      53
    ##  7 13 MOF  " M"      13
    ##  8 14YR M  " M"      14
    ##  9 55YOM   M         55
    ## 10 5 YOM   M          5

`ls.str()`还可以看具体的结构。
