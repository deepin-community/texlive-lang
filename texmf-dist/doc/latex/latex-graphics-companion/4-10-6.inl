\usepackage {pstcol}
\begin{pspicture}(0,0)(2,1)\showgrid
\pscustom{%
 \pscurve(0,.6)(1,.9)(2,.6)
 \gsave
   \pscurve[liftpen=1](2,.4)(1,.1)(0,.4)
   \fill[fillstyle=solid,fillcolor=lightgray]
 \grestore
}
  \pscurve[liftpen=2](2,.4)(1,.1)(0,.4)
\end{pspicture}
