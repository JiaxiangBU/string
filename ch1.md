ch1
================

String Manipulation in R with stringr
<https://www.datacamp.com/courses/string-manipulation-in-r-with-stringr>
Charlotte Wickham

# Quotes

  - `\`  
    escape sequence
    backslash type
    `\\`

<!-- end list -->

``` r
library(tidyverse)
```

    ## ─ Attaching packages ──────────────────────────────── tidyverse 1.2.1 ─

    ## ✔ ggplot2 3.0.0     ✔ purrr   0.2.5
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.6
    ## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ─ Conflicts ────────────────────────────────── tidyverse_conflicts() ─
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
"\"There's plenty of room!\" said Alice indignantly, and she sat down in a large arm-chair at one end of the table." %>% cat
```

    ## "There's plenty of room!" said Alice indignantly, and she sat down in a large arm-chair at one end of the table.

``` r
'"There\'s plenty of room!" said Alice indignantly, and she sat down in a large arm-chair at one end of the table.' %>% cat
```

    ## "There's plenty of room!" said Alice indignantly, and she sat down in a large arm-chair at one end of the table.

# Emoji

``` r
cat("hello\n\U1F30D")
```

    ## hello
    ## 🌍

`\U` followed by up to 8 hex digits sequence denotes a particular
Unicode character.

1.  using base 16 and the digits 0-9 and A-F.
    <http://www.unicode.org/charts/>
2.  four digits for the codepoint, an alternative escape sequence is
    `\u`.

# number

感觉 fixed 和 scientific 好复杂。

1.  有效数字，使用`format(..., digits = n)`，小数点前后取最大数的数位和最小数的数位(解释看例子)
    1.  方便以列展示数据，但是当数据呈现是居中，可以用`trim = TRUE`去除效果。
2.  取消科学计数法，使用`format(..., scientific = FALSE)`

<!-- end list -->

``` r
# Some vectors of numbers
percent_change  <- c(4, -1.91, 3.00, -5.002)
income <-  c(72.19, 1030.18, 10291.93, 1189192.18)
p_values <- c(0.12, 0.98, 0.0000191, 0.00000000002)

# Format c(0.0011, 0.011, 1) with digits = 1
format(c(0.0011, 0.011, 1), digits = 1)
```

    ## [1] "0.001" "0.011" "1.000"

``` r
# Format c(1.0011, 2.011, 1) with digits = 1
format(c(1.0011, 2.011, 1), digits = 1)
```

    ## [1] "1" "2" "1"

``` r
# Format percent_change to one place after the decimal point
format(percent_change, digits = 2)
```

    ## [1] " 4.0" "-1.9" " 3.0" "-5.0"

``` r
# Format income to whole numbers
format(income, digits = 2)
```

    ## [1] "     72" "   1030" "  10292" "1189192"

``` r
# stretch the small number

# Format p_values in fixed format
format(p_values, scientific = FALSE)
```

    ## [1] "0.12000000000" "0.98000000000" "0.00001910000" "0.00000000002"

1.  三位数控制，使用`big.mark = ','`给出分隔符，`big.interval = 3`给出分割距离。

<!-- end list -->

``` r
formatted_income <- format(income, digits = 2)

# Print formatted_income
formatted_income
```

    ## [1] "     72" "   1030" "  10292" "1189192"

``` r
# Call writeLines() on the formatted income
writeLines(formatted_income)
```

    ##      72
    ##    1030
    ##   10292
    ## 1189192

``` r
# Define trimmed_income
trimmed_income <- format(income, digits =2, trim = TRUE)

# Call writeLines() on the trimmed_income
writeLines(trimmed_income)
```

    ## 72
    ## 1030
    ## 10292
    ## 1189192

``` r
# Define pretty_income
pretty_income <- format(income, digits = 2, big.mark = ",",big.interval = 4)
# 中文需要四位分隔符

# Call writeLines() on the pretty_income
writeLines(pretty_income)
```

    ##       72
    ##     1030
    ##   1,0292
    ## 118,9192

# formatC

based on C style syntax

1.  `"f"` for fixed, `digits` is the number of digits after the decimal
    point.

2.  `"e"` for scientific, and

3.  `"g"` for fixed unless scientific saves space

4.  `flag = "+"`表示数据正负号

5.  `format = "g", digits = 2`用最少字母表示小数点后两位

6.  `flag = "0"`前面用0 pad 上，不清晰，使用`str_pad`替代

<!-- end list -->

``` r
# From the format() exercise
x <- c(0.0011, 0.011, 1)
y <- c(1.0011, 2.011, 1)

# formatC() on x with format = "f", digits = 1
formatC(x, format = "f", digits = 1)
```

    ## [1] "0.0" "0.0" "1.0"

``` r
format(x, digits = 1)
```

    ## [1] "0.001" "0.011" "1.000"

``` r
# formatC() on y with format = "f", digits = 1
formatC(y, format = "f", digits = 1) 
```

    ## [1] "1.0" "2.0" "1.0"

``` r
format(y, format = "f", digits = 1)
```

    ## [1] "1" "2" "1"

``` r
# Format percent_change to one place after the decimal point
formatC(percent_change, format = "f", digits = 1)
```

    ## [1] "4.0"  "-1.9" "3.0"  "-5.0"

``` r
# percent_change with flag = "+"
formatC(percent_change, format = "f", digits = 1, flag = "+")
```

    ## [1] "+4.0" "-1.9" "+3.0" "-5.0"

``` r
# Format p_values using format = "g" and digits = 2
formatC(p_values, format = "g", digits = 2)
```

    ## [1] "0.12"    "0.98"    "1.9e-05" "2e-11"

``` r
formatC(income,digits = 0,format = 'f',flag = '0')
```

    ## [1] "72"      "1030"    "10292"   "1189192"

1.  会计格式展示，使用`format`和`paste`完成
2.  `justify = "right"`可以让文本居中或者向左向右。

<!-- end list -->

``` r
# Define the names vector
income_names <- c("Year 0", "Year 1", "Year 2", "Project Lifetime")

# Create pretty_income
pretty_income <- format(income, digit = 2, big.mark = ',')

# Create dollar_income
dollar_income <- paste('$', pretty_income, sep = '')

# Create formatted_names
formatted_names <- format(income_names, justify = "right")

# Create rows
rows <- paste(formatted_names, dollar_income, sep = '   ')

# Write rows
writeLines(rows)
```

    ##           Year 0   $       72
    ##           Year 1   $    1,030
    ##           Year 2   $   10,292
    ## Project Lifetime   $1,189,192

``` r
income %>% 
    round %>% 
    as.character %>% 
    str_pad(string = .,width = max(str_count(.)),pad = '0')
```

    ## [1] "0000072" "0001030" "0010292" "1189192"

1.  可以方便用于文件命名

<!-- end list -->

``` r
0:999 %>% 
    as.character %>% 
    str_pad(string = .,width = max(str_count(.)),pad = '0') %>% 
    head
```

    ## [1] "000" "001" "002" "003" "004" "005"
