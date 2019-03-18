ch4 - rebus
================

# Capturing

配合`str_match`使用

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
library(rebus)
```

    ## 
    ## Attaching package: 'rebus'

    ## The following object is masked from 'package:stringr':
    ## 
    ##     regex

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     alpha

``` r
hero_contacts <- 
    c("(wolverine@xmen.com)","wonderwoman@justiceleague.org","thor@avengers.com")
capture(one_or_more(WRD)) %R% 
    "@" %R% 
    capture(one_or_more(WRD)) %R% 
    DOT %R% 
    capture(one_or_more(WRD)) %>% 
    str_match(hero_contacts,.)
```

    ##      [,1]                            [,2]          [,3]            [,4] 
    ## [1,] "wolverine@xmen.com"            "wolverine"   "xmen"          "com"
    ## [2,] "wonderwoman@justiceleague.org" "wonderwoman" "justiceleague" "org"
    ## [3,] "thor@avengers.com"             "thor"        "avengers"      "com"

capture 的特性也见于 impala 的函数 `regexp_extract`

但是邮箱正则化很难提取，见
[讨论](https://stackoverflow.com/questions/201323/how-to-validate-an-email-address-using-a-regular-expression/201378#201378)

<details>

<summary>另外一个例子</summary>

``` r
narratives <- 
c("19YOM-SHOULDER STRAIN-WAS TACKLED WHILE PLAYING FOOTBALL W/ FRIENDS ","31 YOF FELL FROM TOILET HITITNG HEAD SUSTAINING A CHI ","ANKLE STR. 82 YOM STRAINED ANKLE GETTING OUT OF BED ","TRIPPED OVER CAT AND LANDED ON HARDWOOD FLOOR. LACERATION ELBOW, LEFT. 33 YOF*","10YOM CUT THUMB ON METAL TRASH CAN DX AVULSION OF SKIN OF THUMB ","53 YO F TRIPPED ON CARPET AT HOME. DX HIP CONTUSION ","13 MOF TRYING TO STAND UP HOLDING ONTO BED FELL AND HIT FOREHEAD ON RADIATOR DX LACERATION","14YR M PLAYING FOOTBALL; DX KNEE SPRAIN ","55YOM RIDER OF A BICYCLE AND FELL OFF SUSTAINED A CONTUSION TO KNEE ","5 YOM ROLLING ON FLOOR DOING A SOMERSAULT AND SUSTAINED A CERVICAL STRA IN")
```

``` r
# narratives has been pre-defined
narratives
```

    ##  [1] "19YOM-SHOULDER STRAIN-WAS TACKLED WHILE PLAYING FOOTBALL W/ FRIENDS "                      
    ##  [2] "31 YOF FELL FROM TOILET HITITNG HEAD SUSTAINING A CHI "                                    
    ##  [3] "ANKLE STR. 82 YOM STRAINED ANKLE GETTING OUT OF BED "                                      
    ##  [4] "TRIPPED OVER CAT AND LANDED ON HARDWOOD FLOOR. LACERATION ELBOW, LEFT. 33 YOF*"            
    ##  [5] "10YOM CUT THUMB ON METAL TRASH CAN DX AVULSION OF SKIN OF THUMB "                          
    ##  [6] "53 YO F TRIPPED ON CARPET AT HOME. DX HIP CONTUSION "                                      
    ##  [7] "13 MOF TRYING TO STAND UP HOLDING ONTO BED FELL AND HIT FOREHEAD ON RADIATOR DX LACERATION"
    ##  [8] "14YR M PLAYING FOOTBALL; DX KNEE SPRAIN "                                                  
    ##  [9] "55YOM RIDER OF A BICYCLE AND FELL OFF SUSTAINED A CONTUSION TO KNEE "                      
    ## [10] "5 YOM ROLLING ON FLOOR DOING A SOMERSAULT AND SUSTAINED A CERVICAL STRA IN"

``` r
# Add capture() to get age, unit and sex
pattern <- optional(DGT) %R% DGT %R%  
  optional(SPC) %R% capture(or("YO", "YR", "MO")) %R%
  optional(SPC) %R% capture(or("M", "F"))

# Pull out from narratives
str_match(narratives,pattern)
```

    ##       [,1]      [,2] [,3]
    ##  [1,] "19YOM"   "YO" "M" 
    ##  [2,] "31 YOF"  "YO" "F" 
    ##  [3,] "82 YOM"  "YO" "M" 
    ##  [4,] "33 YOF"  "YO" "F" 
    ##  [5,] "10YOM"   "YO" "M" 
    ##  [6,] "53 YO F" "YO" "F" 
    ##  [7,] "13 MOF"  "MO" "F" 
    ##  [8,] "14YR M"  "YR" "M" 
    ##  [9,] "55YOM"   "YO" "M" 
    ## [10,] "5 YOM"   "YO" "M"

</details>

。
