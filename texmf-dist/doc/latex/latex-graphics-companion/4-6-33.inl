\usepackage {pstricks,pst-node}
\psset{framearc=.2}
\begin{psmatrix}[rowsep=1cm,colsep=-10pt]
 [name=A]\psframebox{requirements}\\
 &[name=B]\psframebox{design}\\
 &&[name=C]\psframebox{coding}\\
 &&&[name=D]\psframebox{testing}\\
 &&&&[name=E]\psframebox{operations}
 \psset{arrows=->,armA=0,angleB=90}
 \ncangle{A}{B}       \ncangle{B}{C}
 \ncangle{C}{D}       \ncangle{D}{E}
 \psset{angleB=-90,angleA=180}
 \ncangle{B}{A}       \ncangle{C}{B}
 \ncangle{D}{C}       \ncangle{E}{D}
\end{psmatrix}
