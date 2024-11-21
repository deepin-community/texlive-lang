# Makefile for asy_tut
#
# Usage: This works for me.
# For initial compilation, from my Linux command line I run this.
#   $ make all LATEX_TWICE=yes
# I have TeX Live with Asymptote installed.

# 2024-May-14 Jim Hefferon  CC-BY-SA
#
# TODO

SHELL=/bin/bash

LATEX:=pdflatex -shell-escape  # Need -shell-escape to get minted to run
LATEXNONSTOP:=pdflatex -interaction=nonstopmode -shell-escape  
ASYMPTOTE:=asy
ASYMPTOTE3D:=asy -inlineimage 

MAIN_FILE:=asy_tut

all: asy_tut.pdf  


# =============================
# Main document
asy_tut.pdf: ../asy_sty/asy_tut.sty ../asy/jh.asy  \
    asy_tut.tex \
    cover/cover.tex cover/pp.jpg \
    preface/preface.tex \
    chapter1/chapter1.tex \
      chapter1/main.tex chapter1/main.pdf \
      chapter1/asy/unit_circle.pdf chapter1/asy/unit_circle_after.pdf \
    chapter2/chapter2.tex chapter2/asy/plot.pdf \
      chapter2/asy/plot_after.pdf chapter2/asy/cos.pdf \
      chapter2/asy/exponential.pdf \
    chapter3/chapter3.tex chapter3/asy/zoom.pdf chapter3/asy/zoom_times.pdf \
      chapter3/asy/zoom_iterate000.pdf chapter3/asy/integral.pdf \
    chapter4/chapter4.tex chapter4/asy/vectors.asy chapter4/asy/vectors.tex \
      chapter4/asy/planes.asy chapter4/asy/planes.tex \
      chapter4/asy/washer.asy chapter4/asy/washer.tex \
      chapter4/main_3d.tex chapter4/main_3d.pdf \
    appendix/appendix.tex
ifdef LATEX_TWICE
	cd $(@D); \
	$(LATEX) $(basename $(notdir $(@))); \
	$(LATEX) $(basename $(notdir $(@)));
else
	cd $(@D); \
	$(LATEX) $(basename $(notdir $(@)));
endif


# Chapter1
chapter1/asy/unit_circle.pdf: chapter1/asy/unit_circle.asy 
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

chapter1/main.pdf: chapter1/asy/unit_circle_after.pdf chapter1/main.tex  
	cd $(@D); \
	$(LATEX) $(basename $(notdir $(@)));

chapter1/asy/unit_circle_after.pdf: chapter1/asy/unit_circle_after.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));  

# Chapter2
chapter2/asy/plot.pdf: chapter2/asy/plot.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

chapter2/asy/plot_after.pdf: chapter2/asy/plot_after.asy  ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

chapter2/asy/cos.pdf: chapter2/asy/cos.asy  ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

chapter2/asy/exponential.pdf: chapter2/asy/exponential.asy  ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

# Chapter3
chapter3/asy/zoom.pdf: chapter3/asy/zoom.asy ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

chapter3/asy/zoom_times.pdf: chapter3/asy/zoom_times.asy ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

chapter3/asy/zoom_iterate000.pdf: chapter3/asy/zoom_iterate.asy ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) zoom_iterate;  # no substring fcn?

chapter3/asy/integral.pdf: chapter3/asy/integral.asy ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE) $(basename $(notdir $(@)));

# Chapter4
chapter4/asy/vectors.tex: chapter4/asy/vectors.asy  ../asy/jh.asy 
	cd $(@D); \
	$(ASYMPTOTE3D) $(basename $(notdir $(@)));

chapter4/asy/planes.tex: chapter4/asy/planes.asy  ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE3D) $(basename $(notdir $(@))); 

chapter4/asy/washer.tex: chapter4/asy/washer.asy  ../asy/jh.asy
	cd $(@D); \
	$(ASYMPTOTE3D) $(basename $(notdir $(@))); 

chapter4/main_3d.pdf: chapter4/main_3d.tex chapter4/asy/vectors.asy chapter4/asy/vectors.tex ../asy/jh.asy
	cd $(@D); \
	$(LATEX) $(basename $(notdir $(@))); 


# Help
.PHONY: help
help:  ## Display this help
	@echo "make <target>" 
	@echo "  all: make the Asymptote tutorial" 
	@echo "  help: show this help"
	@echo "To make the document from scratch: make all LATEX_TWICE=yes"


