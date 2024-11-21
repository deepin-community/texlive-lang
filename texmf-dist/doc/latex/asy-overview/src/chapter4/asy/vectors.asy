// vectors.asy
settings.outformat = "pdf";
settings.tex = "pdflatex";  // For compiling in-pic text
settings.prc = true;  // Manipulable in a PDF file
settings.render = 0;  // Needed for "poster" image, i.e., picture to click on
import "../../../asy/jh.asy" as jh;

import fontsize;

import graph3;
projection default_projection = orthographic(1,2,0.5,up=Z);
currentprojection = default_projection;
currentlight = nolight;  // Avoid shadows

unitsize(0.5cm);
real xmin = 0; real xmax = 5;  
real ymin = 0; real ymax = 5;
real zmin = 0; real zmax = 5;

// Randomize: uncomment these to get a good seed, then use it in srand(..seed..).
// int secs = seconds();
// write(format("Seed for srand is %d",secs));
// srand(secs);
srand(1716139271);

// Draw the vector in canonical position
triple displacement = (2,1,1);
draw((0,0,0)--displacement, HIGHLIGHT_COLOR, Arrow3(DefaultHead2));

// Draw more of the same vector, offset from the origin
int num_vector_target = 8;
int num_vectors = 0;
while (num_vectors < num_vector_target) {
  real x_init = xmin+(xmax-xmin)*unitrand();
  real y_init = ymin+(ymax-ymin)*unitrand();
  real z_init = ymin+(ymax-ymin)*unitrand();
  if ((x_init+displacement.x <= xmax)  // Only draw if vector falls in picture
      && (y_init+displacement.y <= ymax)
      && (z_init+displacement.z <= ymax)) {
    num_vectors = num_vectors+1;
    triple init = (x_init,y_init,z_init);
    draw(init--(init+displacement), BOLD_COLOR, Arrow3(DefaultHead2));
  }
}

// Axes; note it says OutTicks instead of LeftTicks or RightTicks
xaxis3("{\scriptsize $x$}", xmin=xmin, xmax=xmax+0.2,
       OutTicks(Step=1, OmitTick(0), Size=2pt),  
       Arrow3(TeXHead2));
yaxis3("{\scriptsize $y$}", ymin=ymin, ymax=ymax+0.2,
       OutTicks(Step=1, OmitTick(0), Size=2pt),  
       Arrow3(TeXHead2));
zaxis3("{\scriptsize $z$}", zmin=zmin, zmax=zmax+0.2,
       OutTicks(Step=1, OmitTick(0), Size=2pt),  
       Arrow3(TeXHead2));
