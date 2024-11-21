// zoom_iterate.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph; 

path f = GENERIC_FCN_PLOT;  // Shorter to type 
real c = 3.1;

// Find f(c) on f and get f'(c)
real c_time = times(f, c)[0];
pair c_point = point(f,c_time);
pair d = dir(f, c_time);
real t_line_fcn(real x) { return (d.y/d.x)*(x-c_point.x) + c_point.y; }

string OUTPUT_FN = "zoom_iterate%03d";
for (int i=0; i<4; ++i) {
  picture pic;  // Generate a new picture    
  size(pic, 3cm, 0); // Will be 3cm wide, scaling units to make it so

  // Zoomed-in window spans c minus delta to c plus delta
  real delta = 1/2^(i);
  real xmin = c-delta; real xmax = c+delta;  

  // Limits of f and tangent line to show
  real left_time = times(f, xmin)[0];
  real right_time = times(f, xmax)[0];
  path f_shown = subpath(f, left_time, right_time);
  path t_line = graph(t_line_fcn, xmin, xmax);

  // Shift f and tangent line close to x-axis, then draw   
  transform f_trans = shift(0, 0.5*delta)*shift(0, -1*c_point.y);
  draw(pic, f_trans*f_shown, BOLD_COLOR);
  draw(pic, f_trans*t_line, HIGHLIGHT_COLOR);
  dotfactor = 3;
  dot(pic, f_trans*c_point, HIGHLIGHT_COLOR);

  // Just the x axis
  real[] T = {xmin, xmax};
  xaxis(pic, xmin=xmin, xmax=xmax,
	RightTicks("%", T, Size=2pt));
  labelx(pic, format("$c-%03f$",delta), xmin);
  labelx(pic, format("$c+%03f$",delta), xmax);

  // Produce PDF output file
  shipout(format(OUTPUT_FN,i), pic);
}
