str\_wrap 自动换行
================

``` r
library(stringr)
thanks_path <- file.path(R.home("doc"), "THANKS")
thanks <- str_c(readLines(thanks_path), collapse = "\n")
thanks <- word(thanks, 1, 3, fixed("\n\n"))
```

``` r
args(str_wrap)
```

    ## function (string, width = 80, indent = 0, exdent = 0) 
    ## NULL

``` r
str_wrap(thanks, width = 80) %>% cat
```

    ## R would not be what it is today without the invaluable help of these people
    ## outside of the R core team, who contributed by donating code, bug fixes and
    ## documentation: Valerio Aimale, Suharto Anggono, Thomas Baier, Henrik Bengtsson,
    ## Roger Bivand, Ben Bolker, David Brahm, G"oran Brostr"om, Patrick Burns, Vince
    ## Carey, Saikat DebRoy, Matt Dowle, Brian D'Urso, Lyndon Drake, Dirk Eddelbuettel,
    ## Claus Ekstrom, Sebastian Fischmeister, John Fox, Paul Gilbert, Yu Gong, Gabor
    ## Grothendieck, Frank E Harrell Jr, Peter M. Haverty, Torsten Hothorn, Robert
    ## King, Kjetil Kjernsmo, Roger Koenker, Philippe Lambert, Jan de Leeuw, Jim
    ## Lindsey, Patrick Lindsey, Catherine Loader, Gordon Maclean, John Maindonald,
    ## David Meyer, Ei-ji Nakama, Jens Oehlschaegel, Steve Oncley, Richard O'Keefe,
    ## Hubert Palme, Roger D. Peng, Jose' C. Pinheiro, Tony Plate, Anthony Rossini,
    ## Jonathan Rougier, Petr Savicky, Guenther Sawitzki, Marc Schwartz, Arun
    ## Srinivasan, Detlef Steuer, Bill Simpson, Gordon Smyth, Adrian Trapletti, Terry
    ## Therneau, Rolf Turner, Bill Venables, Gregory R. Warnes, Andreas Weingessel,
    ## Morten Welinder, James Wettenhall, Simon Wood, and Achim Zeileis. Others have
    ## written code that has been adopted by R and is acknowledged in the code files,
    ## including

``` r
str_wrap(thanks, width = 40) %>% cat
```

    ## R would not be what it is today
    ## without the invaluable help of these
    ## people outside of the R core team, who
    ## contributed by donating code, bug fixes
    ## and documentation: Valerio Aimale,
    ## Suharto Anggono, Thomas Baier, Henrik
    ## Bengtsson, Roger Bivand, Ben Bolker,
    ## David Brahm, G"oran Brostr"om, Patrick
    ## Burns, Vince Carey, Saikat DebRoy, Matt
    ## Dowle, Brian D'Urso, Lyndon Drake, Dirk
    ## Eddelbuettel, Claus Ekstrom, Sebastian
    ## Fischmeister, John Fox, Paul Gilbert,
    ## Yu Gong, Gabor Grothendieck, Frank E
    ## Harrell Jr, Peter M. Haverty, Torsten
    ## Hothorn, Robert King, Kjetil Kjernsmo,
    ## Roger Koenker, Philippe Lambert, Jan
    ## de Leeuw, Jim Lindsey, Patrick Lindsey,
    ## Catherine Loader, Gordon Maclean, John
    ## Maindonald, David Meyer, Ei-ji Nakama,
    ## Jens Oehlschaegel, Steve Oncley, Richard
    ## O'Keefe, Hubert Palme, Roger D. Peng,
    ## Jose' C. Pinheiro, Tony Plate, Anthony
    ## Rossini, Jonathan Rougier, Petr Savicky,
    ## Guenther Sawitzki, Marc Schwartz, Arun
    ## Srinivasan, Detlef Steuer, Bill Simpson,
    ## Gordon Smyth, Adrian Trapletti, Terry
    ## Therneau, Rolf Turner, Bill Venables,
    ## Gregory R. Warnes, Andreas Weingessel,
    ## Morten Welinder, James Wettenhall, Simon
    ## Wood, and Achim Zeileis. Others have
    ## written code that has been adopted by R
    ## and is acknowledged in the code files,
    ## including

``` r
str_wrap(thanks, width = 60, indent = 4) %>% cat
```

    ##     R would not be what it is today without the invaluable help
    ## of these people outside of the R core team, who contributed
    ## by donating code, bug fixes and documentation: Valerio
    ## Aimale, Suharto Anggono, Thomas Baier, Henrik Bengtsson,
    ## Roger Bivand, Ben Bolker, David Brahm, G"oran Brostr"om,
    ## Patrick Burns, Vince Carey, Saikat DebRoy, Matt Dowle,
    ## Brian D'Urso, Lyndon Drake, Dirk Eddelbuettel, Claus
    ## Ekstrom, Sebastian Fischmeister, John Fox, Paul Gilbert,
    ## Yu Gong, Gabor Grothendieck, Frank E Harrell Jr, Peter M.
    ## Haverty, Torsten Hothorn, Robert King, Kjetil Kjernsmo,
    ## Roger Koenker, Philippe Lambert, Jan de Leeuw, Jim Lindsey,
    ## Patrick Lindsey, Catherine Loader, Gordon Maclean, John
    ## Maindonald, David Meyer, Ei-ji Nakama, Jens Oehlschaegel,
    ## Steve Oncley, Richard O'Keefe, Hubert Palme, Roger D. Peng,
    ## Jose' C. Pinheiro, Tony Plate, Anthony Rossini, Jonathan
    ## Rougier, Petr Savicky, Guenther Sawitzki, Marc Schwartz,
    ## Arun Srinivasan, Detlef Steuer, Bill Simpson, Gordon
    ## Smyth, Adrian Trapletti, Terry Therneau, Rolf Turner, Bill
    ## Venables, Gregory R. Warnes, Andreas Weingessel, Morten
    ## Welinder, James Wettenhall, Simon Wood, and Achim Zeileis.
    ## Others have written code that has been adopted by R and is
    ## acknowledged in the code files, including
