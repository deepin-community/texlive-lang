// washer.asy
settings.tex = "pdflatex";  
settings.outformat = "pdf";
settings.render = 8;  // Tweaked this until poster pic looked better
settings.prc = true;
import "../../../asy/jh.asy" as jh;

import graph3;
projection default_projection = orthographic(3,1.5,0.5,up=Z);
currentprojection = default_projection;
currentlight = nolight;

size3(0,5cm,0,keepAspect=true);

real square(real x) {return x^2;}
real ident(real x) {return x;}
path f = graph(square, 0, 1);
path fa = graph(ident, 0, 1);

real c = 0.4;  // Pt on y axis where slice is taken
real delta_y = 0.2;  // Thickness of washer

// Make the washer
transform3 washer_t = shift(0,c,0)*rotate(90, X);
surface washer = washer_t*surface(reverse(scale(sqrt(c))*unitcircle) ^^ scale(c)*unitcircle);

// Draw the washer
draw(washer_t*scale3(c)*unitcircle3, HIGHLIGHT_COLOR);
draw(washer_t*scale3(sqrt(c))*unitcircle3,  HIGHLIGHT_COLOR);
draw(washer, surfacepen=slice_material, light=nolight);

// Draw the xy-plane area
path3 pth = path3(fa&f);  // Two paths joined with `&' 
draw(pth, gray(0.5));
draw((c,c,0)--(sqrt(c),c,0),  HIGHLIGHT_COLOR);
draw(circle((0,1,0), 1, normal=Y), gray(0.5));

// Draw surface of revolution formed by xy-plane area
surface region = surface(pth, c=O, axis=Y);
draw(region, surfacepen=figure_material, light=nolight);

// Axes
xaxis3(Label("$x$",position=EndPoint, align=W),
       0,1.5, black, Arrow3(TeXHead2));
yaxis3(Label("$y$"),
       0,1.75, black, Arrow3(TeXHead2));
zaxis3(Label(""),\
       0,1.25, black, Arrow3(TeXHead2));
