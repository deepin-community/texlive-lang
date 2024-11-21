#!/bin/bash

xelatex suanpan-l3.tex &&\
makeindex -s gind.ist -o suanpan-l3.ind suanpan-l3.idx &&\
makeindex -s gglo.ist -o suanpan-l3.gls suanpan-l3.glo &&\
xelatex suanpan-l3.tex &&\
xelatex suanpan-l3.tex &&\
xelatex suanpan-l3.tex
