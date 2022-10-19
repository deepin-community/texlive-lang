The Not So Short Introduction to LaTeX2e (Korean Translation)
================================================================

About
-------

Version: 6.4, March 09, 2021
  by Tobias Oetiker, et. al.

Korean translation:
  LaTeX2e 입문: 143분 동안 익히는 LaTeX2e (한국어판 2021/03/16)
  by Kangsoo Kim and In-Sung Cho <ischo at ktug.org>

License
-------

Permission is granted to copy, distribute and/or modify this document 
under the terms of the GNU Free Documentation License, 
Version 1.2 or any later version published by the Free Software Foundation. 
http://www.gnu.org/copyleft/fdl.html

Fonts
------

`lshort-ko` uses the KoPubWorld font for Hangul characters, which is not redistributable.
To compile the document from source code, you need to install the KoPubWorld truetype font (from [kopub website](http://www.kopus.org/biz/electronic/font.aspx)) by yourself and uncomment the lines for font setting in `kopubworldfont.sty`.
Otherwise the result PDF file contains UnFonts shipped in the TeXLive distribution.


How to compile
--------------

   * `pygmentize` (Python pygments) is required.
   * run `xelatex` with `--shell-escape` option.
   * to make indices, run `komkindex` on the `.idx` file.

```
cd src && make
```
