// unit_circle_after.asy
settings.outformat="pdf";

texpreamble("\usepackage{mathtools}
  \usepackage[utf8]{inputenc}
  \usepackage[osf,scaled=.92,loosest]{heuristica}
  \usepackage[heuristica,vvarbb,bigdelims]{newtxmath}
  \usepackage[T1]{fontenc}
  \renewcommand*\oldstylenums[1]{\textosf{#1}}");

import graph; // Module for plotting routines, including xaxis() and yaxis()

unitsize(1.5cm);  // One x unit or y unit will be 1.5cm.

// Draw a unit circle
draw(unitcircle);

// Draw a generic angle
real theta = radians(35);
pair generic_pt = (cos(theta), sin(theta));
draw((0,0)--generic_pt);
dotfactor = 4;
dot("$(\cos\theta,\sin\theta)$",generic_pt,E);

// Draw the axes
xaxis("\scriptsize $x$",xmin=-1.2,xmax=1.2,Arrows(TeXHead));
yaxis("\scriptsize $y$",ymin=-1.2,ymax=1.2,Arrows(TeXHead));
