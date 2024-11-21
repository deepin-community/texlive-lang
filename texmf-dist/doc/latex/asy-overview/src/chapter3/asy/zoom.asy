// zoom.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph; 

path generic_fcn_plot = (-0.25,0)..(1,0.35)..(2,0)..(3,-0.25)..(4,0)..(5.25,0.25);

unitsize(1cm);
real xmin = 0; real xmax = 5;  
real ymin = 0; real ymax = 2.5;

path f = shift(0,1.5)*generic_fcn_plot; // Transform curve by shifting upwards
real c = 3.1;    // x location of tangency
real c_time = times(f, c)[0];
pair c_point = point(f,c_time);  // Point of tangency
pair d = dir(f, c_time);    // Direction of tangent line
real t_line_fcn(real x) { return (d.y/d.x)*(x-c_point.x) + c_point.y; }
path t_line = graph(t_line_fcn, c-0.75, c+0.75);

draw(f, BOLD_COLOR);
draw(t_line, HIGHLIGHT_COLOR);
dotfactor = 4;
dot("$y-f(c)=f'(c)\cdot(x-c)$", c_point, 2*S, HIGHLIGHT_COLOR);

real[] T = {c};
xaxis(xmin=xmin-0.2, xmax=xmax+0.2,
      RightTicks("%", T, Size=2pt),  
      Arrows(TeXHead));
labelx("$c$", c);
yaxis(ymin=ymin-0.2, ymax=ymax+0.2,  
      Arrows(TeXHead)); 
