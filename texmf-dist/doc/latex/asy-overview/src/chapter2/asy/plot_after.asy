// plot_after.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph;

// Function to be plotted
real fcn(real x) {
  return( x+(1/(x-1)) );
}

unitsize(1cm);
scale(Linear, Linear(0.5)); // Rescale the y axis by half

// Nominal plot boundaries
real xmin = -2; real xmax = 3;
real ymin = -5; real ymax = 5;

// Get the graph
real left_x = 2*sqrt(2)-2;   // From solving -5=x+(1/(x-1))
real right_x = 3-sqrt(3);    // From 5=x+(1/(x-1))
path f_left = graph(fcn, xmin, left_x);
path f_right = graph(fcn, right_x, xmax);

// Draw
draw(Scale((1,ymin))--Scale((1,ymax)), dashed); // Vert asymptote
draw(f_left, HIGHLIGHT_COLOR);
draw(f_right, HIGHLIGHT_COLOR);

// Draw the axes, with ticks
xaxis(xmin=xmin-0.2, xmax=xmax+0.2,
      RightTicks(Step=1, OmitTick(0,1), Size=3pt),
      Arrows(TeXHead));
yaxis(ymin=ymin-0.4, ymax=ymax+0.4,
      LeftTicks(Step=5, step=1, OmitTick(0), Size=3pt, size=2pt),
      Arrows(TeXHead));
