verbatimtex
%&platex-sjis
\documentclass{jarticle}
\begin{document}
etex;
beginfig(1);
u=40;
v=40;
r=30;
draw (u+r,v)..(u,v+r)..(u-r,v)..(u,v-r)..cycle withcolor red;
label(btex ???P?????g?B etex, (u,v));
u:=u+46;
draw (u+r,v)..(u,v+r)..(u-r,v)..(u,v-r)..cycle withcolor blue;
label(btex \tate ???P?????g?B etex, (u,v));
u:=u-23;
v:=v+40;
draw (u+r,v)..(u,v+r)..(u-r,v)..(u,v-r)..cycle withcolor green;
label(btex ?ʐς? $\pi r^2$ etex, (u,v));
endfig;
end.
