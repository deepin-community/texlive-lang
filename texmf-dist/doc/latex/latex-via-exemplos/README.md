LaTeX2e Via Exemplos
====================

This is the LaTeX2e course written in brazilian portuguese
language.

How to compile
--------------
To compile, need to use XeLaTeX or LuaLaTeX.

First, compile the following files, using pdflatex, xelatex, ou lualatex:
latex-via-exemplos-fig.tex,
latex-via-exemplos-poster.tex,
latex-via-exemplos-slides.tex,
latex-via-exemplos-certificado.tex,
latex-via-exemplos-cracha.tex,
latex-via-exemplos-folder,
latex-via-exemplos-todonotes
    
For example, will compile using pdflatex as

    pdflatex latex-via-exemplos-fig
    pdflatex latex-via-exemplos-poster
    pdflatex latex-via-exemplos-slides
    pdflatex latex-via-exemplos-slides
    pdflatex latex-via-exemplos-certificado
    pdflatex latex-via-exemplos-cracha
    pdflatex latex-via-exemplos-folder
    pdflatex latex-via-exemplos-todonotes
    pdflatex latex-via-exemplos-todonotes
    
Note that latex-via-exemplos-slides.tex and latex-via-exemplos-todonotes.tex are compiled twice.

The next step is to compile latex-via-exemplos.tex 
using XeLaTeX (or LuaLaTeX) as

    xelatex latex-via-exemplos
    bibtex latex-via-exemplos
    makeindex latex-via-exemplos
    xelatex latex-via-exemplos
    xelatex latex-via-exemplos

The latex-via-exemplos is one sided document.

To generate two sided version, compile latex-via-exemplos-twosides.tex
using XeLaTeX (or LuaLaTeX) as

    xelatex latex-via-exemplos-twosides
    bibtex latex-via-exemplos-twosides
    makeindex latex-via-exemplos-twosides
    xelatex latex-via-exemplos-twosides
    xelatex latex-via-exemplos-twosides

**Note:** 
The linux user will use shell script "makedoc.sh" to compile at once as

    bash makedoc.sh
    
Remark
------
The latex-via-exemplos.tex require japanese font in way to compile,
due to example of multilingual features of XeLaTeX/LuaLaTeX.

It requires several packages available on CTAN, used on their examples.

Author
------
Sadao Massago

DFQM-UFSCar

License
-------
All files are distributed as GNU GPL version 2, or (at your option)
any latter version.

https://opensource.org/licenses/gpl-license
