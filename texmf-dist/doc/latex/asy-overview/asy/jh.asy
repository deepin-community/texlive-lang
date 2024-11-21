// Common definitions for asy_tut

// Set up LaTeX for each label
texpreamble("\usepackage{mathtools}
             \usepackage[utf8]{inputenc}
             \usepackage[osf,scaled=.92,loosest]{heuristica}
             \usepackage[heuristica,vvarbb,bigdelims]{newtxmath}
             \usepackage[T1]{fontenc}
             \renewcommand*\oldstylenums[1]{\textosf{#1}}");
// Change default size of fonts
import fontsize;
defaultpen(fontsize(9pt));  // Like LaTeX \small

// Colors: Morning in Vermont muted by Michelle Delapenha
pen HIGHLIGHT_COLOR = rgb("A6121F"); // Ecstatic Red
pen BACKGROUND_COLOR = rgb("8FB6D9"); // Blue Bell
pen BOLD_COLOR = rgb("677319"); // Fern Frond
pen LIGHT_COLOR =rgb("A1A60F"); // Fistfull of Green
pen NEUTRAL_COLOR = rgb("BDBFAA"); // New Neutral

// Generic 2D function
path GENERIC_FCN_PLOT = (-0.25,0)..(1,0.35)..(2,0)..(3,-0.25)..(4,0)..(5.25,0.25);

// Default materials for 3D surfaces
import three;
material figure_material = material(diffusepen=BOLD_COLOR+opacity(0.5),
				 emissivepen=BOLD_COLOR+white,
				 specularpen=BOLD_COLOR+white);
material slice_material = material(diffusepen=BACKGROUND_COLOR+opacity(0.25),
				   emissivepen=BACKGROUND_COLOR,
				   specularpen=BACKGROUND_COLOR);
pen boundary_pen = gray(0.2)+opacity(0.5);
