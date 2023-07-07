# This Makefile updates the source and documentation for the
# greek-fontenc LateX package
#
# © 2019 Günter Milde
# 
# SRCDIR (and the other variables) can be easily modified as parameters
# while calling `make', e.g.
#
#   make install SRCDIR=~/texmf/tex/latex/

# Global variables
# =================

# for installation into a users local texmf tree
DESTDIR = ~/texmf/tex/latex/greek/greek-fontenc
DOCDIR = ~/texmf/doc/latex/greek/greek-fontenc

CHDIR = cd
COPY = cp -u
SH = sh

# programs
PYLIT = pylit         # text <-> source converter for literal programming
RST2HTML = rst2html5 --stylesheet=minimal.css,responsive.css # text -> HTML converter, see docutils.sf.net
RUBBER = rubber -f --pdf -m hyperref # wrapper around `latex`, run until references resolved
LATEX = pdflatex -interaction batchmode

# LaTeX source files
# ==================

.PHONY: all font-encodings packages

all: font-encodings packages

# font encoding definition files
font-encodings: greek-fontenc.def lgrenc.def tuenc-greek.def greek-euenc.def 

tuenc-greek.def: tuenc-greek.def.txt
	$(PYLIT) $@.txt

greek-fontenc.def: greek-fontenc.def.txt
	$(PYLIT) $@.txt

lgrenc.def: lgrenc.def.txt
	$(PYLIT) $@.txt

# LaTeX packages
packages: textalpha.sty alphabeta.sty alphabeta-tuenc.def alphabeta-lgr.def

textalpha.sty: textalpha.sty.txt
	$(PYLIT) $@.txt

alphabeta.sty: alphabeta.sty.txt
	$(PYLIT) $@.txt

alphabeta-tuenc.def: alphabeta-tuenc.def.txt
	$(PYLIT) $@.txt

alphabeta-lgr.def: alphabeta-lgr.def.txt
	$(PYLIT) $@.txt

# Experimental files
lgr2licr.lua: lgr2licr.lua.txt
	$(PYLIT) $@.txt

# Documentation
# =============

.PHONY: doc html pdf

doc: html pdf

html: greek-fontenc.html lgrenc.def.html puenc-greek.def.html \
      tuenc-greek.def.html greek-fontenc.def.html \
      textalpha.sty.html alphabeta.sty.html \
      alphabeta-tuenc.def.html alphabeta-lgr.def.html lgr2licr.lua.html

greek-fontenc.html: README
	$(RST2HTML) README greek-fontenc.html

greek-fontenc.def.html: greek-fontenc.def
	$(PYLIT) greek-fontenc.def
	$(RST2HTML) greek-fontenc.def.txt greek-fontenc.def.html

lgrenc.def.html: lgrenc.def
	$(PYLIT) lgrenc.def
	$(RST2HTML) lgrenc.def.txt lgrenc.def.html

tuenc-greek.def.html: tuenc-greek.def
	$(PYLIT) tuenc-greek.def
	$(RST2HTML) tuenc-greek.def.txt tuenc-greek.def.html

puenc-greek.def.html: puenc-greek.def
	$(PYLIT) puenc-greek.def
	$(RST2HTML) puenc-greek.def.txt puenc-greek.def.html

textalpha.sty.html: textalpha.sty
	$(PYLIT) textalpha.sty
	$(RST2HTML) textalpha.sty.txt textalpha.sty.html

alphabeta.sty.html: alphabeta.sty
	$(PYLIT) alphabeta.sty
	$(RST2HTML) alphabeta.sty.txt alphabeta.sty.html

alphabeta-tuenc.def.html: alphabeta-tuenc.def
	$(PYLIT) alphabeta-tuenc.def
	$(RST2HTML) alphabeta-tuenc.def.txt alphabeta-tuenc.def.html

alphabeta-lgr.def.html: alphabeta-lgr.def
	$(PYLIT) alphabeta-lgr.def
	$(RST2HTML) alphabeta-lgr.def.txt alphabeta-lgr.def.html

lgr2licr.lua.html: lgr2licr.lua
	$(PYLIT) lgr2licr.lua
	$(RST2HTML) lgr2licr.lua.txt lgr2licr.lua.html

# User documentation
# ==================

pdf: alphabeta-doc.pdf alphabeta-tu.pdf diacritics.pdf \
     textalpha-doc.pdf textalpha-tu.pdf hyperref-with-greek.pdf \
     test-inputenc.pdf test-lgrenc.pdf test-tuenc-greek.pdf 

TEXTALPHA = textalpha.sty greek-fontenc.def lgrenc.def tuenc-greek.def puenc-greek.def
ALPHABETA = $(TEXTALPHA) alphabeta.sty

alphabeta-doc.pdf: alphabeta-doc.tex $(ALPHABETA)
	$(RUBBER) alphabeta-doc.tex

alphabeta-tu.pdf: alphabeta-doc.tex $(ALPHABETA)
	$(RUBBER) -m xelatex --jobname=alphabeta-tu alphabeta-doc.tex

textalpha-doc.pdf: textalpha-doc.tex $(TEXTALPHA)
	$(RUBBER) textalpha-doc.tex

textalpha-tu.pdf: textalpha-doc.tex lgrenc.def $(TEXTALPHA)
	$(RUBBER) -m xelatex --jobname=textalpha-tu textalpha-doc.tex

diacritics.pdf: diacritics.tex lgrenc.def greek-fontenc.def
	$(LATEX) diacritics.tex

hyperref-with-greek.pdf: hyperref-with-greek.tex $(ALPHABETA)
	$(RUBBER) hyperref-with-greek.tex

test-lgrenc.pdf: test-lgrenc.tex lgrenc.def greek-fontenc.def
	$(LATEX) test-lgrenc.tex

test-tuenc-greek.pdf: test-tuenc-greek.tex tuenc-greek.def greek-fontenc.def
	$(RUBBER) -m xelatex test-tuenc-greek.tex

test-inputenc.pdf: test-inputenc.tex $(TEXTALPHA)
	$(RUBBER) test-inputenc.tex

test-inputenc-tu.pdf: test-inputenc.tex lgrenc.def $(TEXTALPHA)
	$(RUBBER) -m lualatex --jobname=test-inputenc-tu test-inputenc.tex


# Installation
# ------------

install: all
	$(COPY) *.def $(DESTDIR)
	$(COPY) *.sty $(DESTDIR)

install-doc: doc
	$(COPY) README $(DOCDIR)
	$(COPY) *.def $(DOCDIR)
	$(COPY) *.sty $(DOCDIR)
	$(COPY) *.lua $(DOCDIR)
	$(COPY) *.html $(DOCDIR)
	$(COPY) *.tex $(DOCDIR)
	$(COPY) *.pdf $(DOCDIR)
	$(COPY) Makefile $(DOCDIR)

# Cleanup
# -------
 
.PHONY: clean

clean:
	rm -f *.aux *.log *.toc *.out *~
	
