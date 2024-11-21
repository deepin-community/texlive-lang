// planes.asy
settings.outformat="pdf";
settings.tex="pdflatex";  
settings.prc = true;
settings.render = 0;
import "../../../asy/jh.asy" as jh;

import graph3;
projection default_projection = orthographic(3,1.5,0.5,up=Z);
currentprojection = default_projection;
currentlight = nolight;

size3(0,5cm,0,keepAspect=true);  // Make y=5cm tall

// Define surfaces
real rotation_degs = 30;
path3 xy_edge = (0,0,0)--(3,0,0)--(3,4,0)--(0,4,0)--cycle;
surface xy = surface(xy_edge);
transform3 p_t = shift((0,2,0))*rotate(rotation_degs, X)*shift((0,-2,0));
path3 p_edge = p_t*xy_edge;
surface p = p_t*xy;

// Draw surfaces
draw(xy, surfacepen=figure_material);
draw(xy_edge, boundary_pen);
draw(p, surfacepen=figure_material);
draw(p_edge, boundary_pen);

// Draw the line of intersection
draw((0,2,0)--(3,2,0), boundary_pen);

// Normal vectors
path3 n = (0,0,0)--(0,0,1.5);
path3 n_xy = shift((3,2,0))*n;
path3 n_p = p_t*shift((3,2,0))*n;
draw(n_xy, HIGHLIGHT_COLOR, Arrow3(DefaultHead2));
draw(n_p, HIGHLIGHT_COLOR, Arrow3(DefaultHead2));

// Arc showing angle between normals
triple v1 = (0,0,0.4);   // Radius of the arc
triple v2 = rotate(rotation_degs,X)*(v1);
path3 n_angle_arc = arc(O, v1, v2);
draw("$\theta$", shift((3,2,0))*n_angle_arc,
     HIGHLIGHT_COLOR, Arrow3(DefaultHead2));  // Angle between normals
draw("$\theta$", shift((3,2,0))*rotate(-90,X)*n_angle_arc,
     HIGHLIGHT_COLOR, Arrow3(DefaultHead2)); // Angle between planes
