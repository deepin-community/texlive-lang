#!/bin/bash

# To compile latex-via-exemplos

# compile auxiliar files
pdflatex latex-via-exemplos-fig
pdflatex latex-via-exemplos-poster
pdflatex latex-via-exemplos-slides
pdflatex latex-via-exemplos-slides
pdflatex latex-via-exemplos-certificado
pdflatex latex-via-exemplos-slides
pdflatex latex-via-exemplos-cracha
pdflatex latex-via-exemplos-folder
pdflatex latex-via-exemplos-todonotes
pdflatex latex-via-exemplos-todonotes
    
# compile documento (one sided)
xelatex latex-via-exemplos
bibtex latex-via-exemplos
makeindex latex-via-exemplos
xelatex latex-via-exemplos
xelatex latex-via-exemplos

# compile document (two sided)
xelatex latex-via-exemplos-twosides
bibtex latex-via-exemplos-twosides
makeindex latex-via-exemplos-twosides
xelatex latex-via-exemplos-twosides
xelatex latex-via-exemplos-twosides

# clean up
rm *.aux
rm *.bbl
rm *.blg
rm *.idx
rm *.ilg
rm *.ind
rm *.log
rm *.lol
rm *.out
rm *.synctex.gz
rm *.tmp
rm *.toc

rm *.nav
rm *.snm
rm *.vrb

rm *.tdo

# rm *.csv

# remove automatic created auxiliar tex and txt files
rm latex-via-exemplos-tabela.txt
rm latex-via-exemplos-ans.tex
rm latex-via-exemplos-twosides-ans.tex

# rm latex-via-exemplos-*-exercise-body.tex

# remove auxiliar pdf files
rm latex-via-exemplos-fig.pdf
rm latex-via-exemplos-poster.pdf
rm latex-via-exemplos-slides.pdf
rm latex-via-exemplos-certificado.pdf
rm latex-via-exemplos-cracha.pdf
rm latex-via-exemplos-folder.pdf
rm latex-via-exemplos-todonotes.pdf

#end

