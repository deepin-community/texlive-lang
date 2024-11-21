// cos.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph; 

real fcn(real x) {
  return( cos(x) );  // Many real functions such as cosine are built in
}

unitsize(1cm);
real xmin = 0; real xmax = 2*pi;  // Asymptote defines pi as a convenience
real ymin = -1; real ymax = 1;

path f = graph(fcn, xmin, xmax);
draw(f, HIGHLIGHT_COLOR);

// Axes with custom ticks
real[] T = {pi/2, pi, 3*pi/2, 2*pi};  // Array of reals holds tick locations
xaxis(xmin=xmin-0.2, xmax=xmax+0.2,
      RightTicks("%", T, Size=2pt),  // LaTeX % comment means tick label is blank
      Arrows(TeXHead));
labelx("$\frac{\pi}{2}$",pi/2); // Put in a label by hand, rather than a decimal
labelx("$\pi$",pi);
labelx("$\frac{3\pi}{2}$",3*pi/2, NW);
labelx("$2\pi$",2*pi);
yaxis(ymin=ymin-0.2, ymax=ymax+0.2,
      LeftTicks(Step=1, OmitTick(0)),
      Arrows(TeXHead));
