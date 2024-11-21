// unit_circle.asy
settings.outformat="pdf";  // Output PDF file

import graph; // Module for plotting routines, including xaxis() and yaxis()

unitsize(1.5cm);  // One x unit or y unit will be 1.5cm.

// Draw a unit circle
draw(unitcircle);

// Draw a generic angle
real theta = radians(35);
pair generic_pt = (cos(theta), sin(theta));
draw((0,0)--generic_pt);
dot("$(\cos\theta,\sin\theta)$",generic_pt,E);

// Draw the axes
xaxis("$x$",xmin=-1.2,xmax=1.2,Arrows(TeXHead));
yaxis("$y$",ymin=-1.2,ymax=1.2,Arrows(TeXHead));
