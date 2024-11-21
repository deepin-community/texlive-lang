// exponential.asy
settings.outformat="pdf";
import "../../../asy/jh.asy" as jh;

import graph; 

real fcn(real x) {
  return( exp(x) );  
}
real tangent_fcn(real x) {
  return( 2*(x-log(2))+2 );  
}

unitsize(1cm);
real xmin = -3; real xmax = 1.25;  
real ymin = 0; real ymax = exp(xmax);

path f = graph(fcn, xmin, xmax, n=300);
path tan_line = graph(tangent_fcn, log(2)-0.5, log(2)+0.5);

draw(f);
draw(tan_line, HIGHLIGHT_COLOR);
dotfactor = 4;
dot(Label("$(\ln(2),2)$",filltype=Fill(white)), (log(2),2), 2*E);

// Axes making graph paper
pen GRAPHPAPERPEN=(0.25*LIGHT_COLOR+0.75*white)
  +squarecap;  // For graph paper lines

xaxis(axis=YEquals(ymax+0.2),
      xmin=xmin-0.5, xmax=xmax+0.5,
      p=nullpen,
      ticks=RightTicks("%", Step=1, OmitTick(0), extend=true, pTick=GRAPHPAPERPEN));
xaxis(axis=YEquals(ymin-0.2),
      xmin=xmin-0.5, xmax=xmax+0.5,
      p=nullpen,
      ticks=RightTicks("%", Step=1, OmitTick(0), extend=true, pTick=GRAPHPAPERPEN));

yaxis(axis=XEquals(xmin-0.2),
      ymin=ymin-0.5, ymax=ymax+0.5,
      p=nullpen,
      ticks=LeftTicks("%", Step=1, OmitTick(0), extend=true, pTick=GRAPHPAPERPEN));
yaxis(axis=XEquals(xmax+0.2),
      ymin=ymin-0.5, ymax=ymax+0.5,
      p=nullpen,
      ticks=LeftTicks("%", Step=1, OmitTick(0),  extend=true, pTick=GRAPHPAPERPEN));

// Axes in black with ticks
xaxis(xmin=xmin-0.2, xmax=xmax+0.2,
      RightTicks(Step=1, step=0, Size=2pt),  
      Arrows(TeXHead));
yaxis(ymin=ymin, ymax=ymax+0.2,  
      LeftTicks(Step=1, OmitTick(0), Size=2pt),
      Arrow(TeXHead));  // Arrow singular means no bottom arrow
