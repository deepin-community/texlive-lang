% This is an Arabic document class. It is used to produce a book.
% Copyright 2021, Mohammed Obaid Alziyadi

% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public Licenese, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%  http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX  version 2005/12/01 or later.

% This work has the LPPL maintenance status `maintained'.

% The current maintainer of this work is Mohammed Alziyadi.
% Contact mo_9009@hotmail.com for bug reports.

% document class version :
% version 1.0

% Here is a history of changes:

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arabic-book}[2021-06-14]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass{book}
\usepackage{polyglossia}
%\usepackage[utf8]{inputenc}
\usepackage[linktocpage,breaklinks,linktoc=all,hidelinks]{hyperref}
\usepackage[top=1in,bottom=1in,left=1in,right=1in,letterpaper]{geometry}
\usepackage{amsmath}
\usepackage{enumitem}
\usepackage{tikz}
\usepackage[doublespacing]{setspace}
\usepackage{titling}
\usepackage{ifthen}
\usepackage{titlesec}
\usepackage{indentfirst}
\usepackage[titles]{tocloft}
\usepackage{etoolbox}
\usepackage[figure,table]{totalcount}
\usepackage[nottoc]{tocbibind}
\usepackage[within=chapter]{newfloat}
\usepackage[labelsep=period]{caption}
\usetikzlibrary{matrix,arrows,decorations.pathmorphing}
\usepackage{collcell}
\usepackage{float}
\usepackage[printwatermark]{xwatermark}


%set fonts
%\setmainfont[Scale=1.5]{Amiri-Regular.ttf}
\setmainlanguage[locale=mashriq,calendar=hijri]{arabic}
\setotherlanguage{english}

\newfontfamily\arabicfont[Script=Arabic,Scale=1.5]{Amiri-Regular.ttf}
\setmonofont{Amiri-Regular.ttf}
\let\arabicfonttt\ttfamily

% Basic spacing
\setlength{\parindent}{.5in}
\setcounter{secnumdepth}{5}
\setlength{\intextsep}{\baselineskip}
\openup 0.5em

%------------------------------------

\addto\captionsarabic{
	\renewcommand{\contentsname}{الفهرس}
	\renewcommand{\listtablename}{قائمةالجداول }
	\renewcommand{\listfigurename}{قائمة الاشكال }
	\renewcommand{\chaptername}{}
	\renewcommand{\cftchapfont}{\normalfont}
	\renewcommand{\cftchappagefont}{\normalfont}
	\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftfigaftersnum}{.}
\renewcommand{\cfttabaftersnum}{.}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsubsecaftersnum}{.}
\setlength{\cftbeforesecskip}{.5\baselineskip}
\setlength{\cftbeforesubsecskip}{0.5\baselineskip}
\setlength{\cftbeforetabskip}{0.5\baselineskip}
\setlength{\cftbeforefigskip}{0.5\baselineskip}
\setlength{\cftfigindent}{0em}
\setlength{\cfttabindent}{0em}
\setlength{\cftfignumwidth}{3.5em}
\cftsetindents{section}{1em}{3.5em}
\cftsetindents{chapter}{1em}{2.5em}
\renewcommand{\bibname}{المراجع}
\DeclareTotalCounter{appendixfigure}
\DeclareTotalCounter{appendixtable}
\DeclareFloatingEnvironment[fileext=loaf,placement={ht},listname={جدول الملحقات },name=Figure]{appendixfigure}
\DeclareFloatingEnvironment[fileext=loat,placement={ht},listname={جدول الملحقات },name=Table]{appendixtable}

% Fix table captions
\captionsetup[table]{position=top,skip=\baselineskip}
\captionsetup[appendixtable]{position=top,skip=\baselineskip}
%----------------------abstract
\newcommand\abstract[1]{\def\@abstract{#1}}
\let\@abstract=\@empty

\renewcommand\title[1]{\def\@title{\uppercase{#1}}}
\let\@title=\@empty


\newcommand{\makeabstract}{
	\chapter*{المقدمة} \@abstract
	\addcontentsline{toc}{chapter}{المقدمة}
}

%--------------------------Header
\AtBeginDocument{\frontmatter
	\def\thepage{\alph{page}} \maketitle\thispagestyle{empty}\makeabstract
	\begin{singlespace}\tableofcontents\end{singlespace}
	\iftotaltables
	\begingroup
	\renewcommand*{\addvspace}[1]{}
	\begin{singlespace}\listoftables\end{singlespace}
	\endgroup
	\fi
	\iftotalfigures
	\begingroup
	\renewcommand*{\addvspace}[1]{}
	\begin{singlespace}\listoffigures\end{singlespace}
	\endgroup
	\fi
	\iftotalappendixtables\begin{singlespace}\listofappendixtables\end{singlespace}\fi
	\iftotalappendixfigures\begin{singlespace}\listofappendixfigures\end{singlespace}\fi
	\mainmatter}

% Format table of contents	
\pagestyle{plain}
\addtocontents{lot}{\noindent\underline{Table}\hfill \underline{صفحة}\par}
\addtocontents{lof}{\noindent\underline{أشكال}\hfill \underline{صفحة}\par}
\addtocontents{loat}{\noindent\underline{Table}\hfill \underline{Page}\par}
\addtocontents{loaf}{\noindent\underline{صفحة}\hfill \underline{أشكال}\par}

% Labels chapters correctly
\titleformat{\chapter}
{\centering\normalfont\bfseries}{{\LARGE\MakeUppercase{{\chaptertitlename}} \thechapter.}}{1em}{\LARGE\MakeUppercase}
\titlespacing*{\chapter}{0pt}{-0.5\baselineskip}{\baselineskip}

\titleformat{\section}
{\Large\bfseries}{\thesection}{0.6em}{}
\titlespacing*{\section}{0pt}{*0}{0pt}

\titleformat{\subsection}
{\normalfont\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{*0}{0pt}

\titleformat{\subsubsection}
{\normalfont\bfseries}{\thesubsubsection.}{0.5em}{}
\titlespacing*{\subsubsection}{0pt}{*0}{0pt}

% Generate appendices with the correct numbering
\renewcommand{\appendix}{
	\chapter*{الملحقات}
	\setcounter{appendixfigure}{0}
	\renewcommand{\theappendixfigure}{A.\arabic{appendixfigure}}
	\setcounter{appendixtable}{0}
	\renewcommand{\theappendixtable}{A.\arabic{appendixtable}}
	\addcontentsline{toc}{chapter}{الملحقات}
	\renewcommand{\theequation}{A.\arabic{equation}}
}
\newcommand{\namedappendix}[1]{
	\chapter*{الملحقات. #1}
	\setcounter{appendixfigure}{0}
	\renewcommand{\theappendixfigure}{A.\arabic{appendixfigure}}
	\setcounter{appendixtable}{0}
	\renewcommand{\theappendixtable}{A.\arabic{appendixtable}}
	\addcontentsline{toc}{chapter}{ الملحقات . \LARGE{#1}}
	\renewcommand{\theequation}{A.\arabic{equation}}
}


%------------------ Labels equations correctly

\makeatletter
\def\maketag@@@#1{\hbox{\m@th\normalfont\LRE{#1}}}
\def\tagform@#1{\maketag@@@{(\ignorespaces#1\unskip)}}
\makeatother

%--------------------Labels equations correctly
\def\SepMark#1{\gdef\@SepMark{\if@RTL\fi#1\if@RTL\fi}} 
\makeatletter
\renewcommand{\SepMark}[1]{\def\@SepMark{#1}}
\makeatother
\SepMark{-}

%-------------------- size the equations correctly
\DeclareMathSizes{10}{15}{15}{15}

\widowpenalty=10000
\clubpenalty=10000