// plot.asy
settings.outformat="pdf";

texpreamble("\usepackage[utf8]{inputenc}
  \usepackage[osf,scaled=.92,loosest]{heuristica}
  \usepackage[heuristica,vvarbb,bigdelims]{newtxmath}
  \usepackage[T1]{fontenc}
  \renewcommand*\oldstylenums[1]{\textosf{#1}}");

import graph; 

// Function to be plotted
real fcn(real x) {
  return( x+(1/(x-1)) );
}

unitsize(1cm);  // One x unit or y unit will be 1cm.

// Nominal plot boundaries
real xmin = -2; real xmax = 3;
real ymin = -5; real ymax = 5;

// Get the graph
real left_x = 2*sqrt(2)-2;   // From solving -5=x+(1/(x-1))
real right_x = 3-sqrt(3);    // From 5=x+(1/(x-1))
path f_left = graph(fcn, xmin, left_x);
path f_right = graph(fcn, right_x, xmax);

// Draw 
draw((1,ymin)--(1,ymax), dashed); // Vert asymptote
draw(f_left, red);
draw(f_right, red);

// Draw the axes, with ticks
xaxis(xmin=xmin-0.2, xmax=xmax+0.2,
      RightTicks(Step=1),
      Arrows(TeXHead));
yaxis(ymin=ymin-0.2, ymax=ymax+0.2,
      LeftTicks(Step=1),
      Arrows(TeXHead));
