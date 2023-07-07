Package: begingreek version 1.7 of 2022/05/06
Copyright 2015-2022 Claudio Beccari
Licence: LaTeX Project Public Licence LPPL v.1.3 (or later)

This work has the LPPL maintenance status "author-maintained".

This work consists of the following files
    begingreek.dtx
    README.txt
    
The files derived from the work are the following:

    begingreek.sty
    begingreek.pdf

The begingreek.dtx file is self extracting and self documenting; if you run
pdflatex on it you get at the same time  the .sty file besides and the 
English documented .pdf file.

This little package (module) contains the definition of the environment
greek and the command \greektxt to typeset Greek text with pdfLaTeX
only. In a certain way the environment greek mimics the homonymous 
environment defined by polyglossia (to be used with XeLaTeX or LuaLaTeX).

This module must be loaded after the babel package and after the babel 
option greek has been specified either directly to the babel package, 
or among the class options.

Both the environment and the command accept an optional argument useful
to choose a Greek font family among those that are available for LGR 
encoded real or virtual fonts. This module perform the necessary checks 
in order to control that the NFSS font file .fd does actually exist.

The documentation file shows several examples and, in particular, some
specimens of most, if not all, LGR encoded Greek font families available
with TeX Live.

By running pdfLaTeX on the begingreek.dtx file, both the .sty file
and the PDF documentation are generated.

It is suggested that the various files are stored in the following folders:
the .dtx file, in .../source/latex/begingreek/ 
the .pdf and the README.txt file in .../doc/latex/begingreek/ 
the .sty file in .../tex/latex/begingreek/
