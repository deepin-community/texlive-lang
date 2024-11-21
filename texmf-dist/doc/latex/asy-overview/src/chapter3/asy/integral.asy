// integral.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph; 

unitsize(1cm);
real xmin = 0; real xmax = 5;  
real ymin = 0; real ymax = 2.5;

path f = shift(0,1.5)*GENERIC_FCN_PLOT; 
real a = 1; real b = 4; // Limits of integration
real x = 2.85;    // Location of dx-thick slice
real x_time = times(f, x)[0];

// Give the sides of the region of interest
path left_side = (a,0)--(a,ymax);
path right_side = (b,0)--(b,ymax);
path bottom = (0,0)--(xmax,0);
path region = buildcycle(left_side, f, right_side, bottom);  // Return the boundary

// Draw those 
fill(region, NEUTRAL_COLOR+opacity(0.5));
draw(f, BOLD_COLOR);
draw((x,0)--point(f,x_time), HIGHLIGHT_COLOR+squarecap);

// Make the axes
real[] T = {a, b, x};
xaxis(xmin=xmin-0.2, xmax=xmax+0.2,
      RightTicks("%", T, Size=2pt),  
      Arrows(TeXHead));
labelx("$a$", a);
labelx("$x$", x);
labelx("$b$", b);
yaxis(ymin=ymin-0.2, ymax=ymax+0.2,  
      Arrows(TeXHead)); 
