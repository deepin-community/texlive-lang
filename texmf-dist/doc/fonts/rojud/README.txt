The 'rojud' package (version 1.2) provides a Type-1 Font for the 42 counties of Romania.

I started from an administrative map of the country (a .shp file, from https://gadm.org/); using R (https://www.r-project.org/) and 'sp' package, extracted the counties contours (in geographic coordinates) and projected them to the cartezian plane (by UTM zones); these contours were excesively long, so I used the 'mapshaper' library (https://github.com/mbloch/mapshaper) to simplify them. 

With a R program, these simplified contours were transformed in PS procedures for producing the glyphs; then I collected and adapted these procedures in a "Type1"-format raw file, transformed in final in the '.pfb' font-file by using the 't1asm' program (https://ctan.org/pkg/t1utils). 

This work is subject to the LaTeX Project Public License (http://www.latex-project.org/lppl.txt).


Vlad Bazon
vlad.bazon@gmail.com


