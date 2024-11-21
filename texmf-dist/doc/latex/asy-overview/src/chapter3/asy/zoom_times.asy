// zoom_times.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph; 

unitsize(1cm);
real xmin = 0; real xmax = 5;  
real ymin = 0; real ymax = 2.5;

path f = shift(0,1.5)*GENERIC_FCN_PLOT;  // Shift it up by 1.5 y units

draw(f, BOLD_COLOR);

dotfactor = 4;
real[] times = {1, 2, 2.5, 3, 4};  // Array of reals
for (real t : times) {
  pair pt_t = point(f, t);  // Point on curve at that time
  dot(format("$%0.02f$",t), pt_t, S, HIGHLIGHT_COLOR);
}

xaxis(xmin=xmin-0.2, xmax=xmax+0.2, Arrows(TeXHead));
yaxis(ymin=ymin-0.2, ymax=ymax+0.2, Arrows(TeXHead)); 
