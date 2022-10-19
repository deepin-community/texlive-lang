%===============================================
%% PfC-Geometrie
%% christophe.poulain@melusine.eu.org
%%===============================================
%------------------------------------------------
% Appel fichier
%------------------------------------------------
%input PfC-Constantes;
%------------------------------------------------
% La figure (debut et fin) JMS/CP
%------------------------------------------------
path feuillet;
numeric _tfig,_nfig;
_tfig:=5cm;
_nfig:=0;
pair coinbg,coinbd,coinhd,coinhg;

string typetrace;
typetrace="normal";

def feuille(expr xa,ya,xb,yb) =
  feuillet := (xa,ya)--(xa,yb)--(xb,yb)--(xb,ya)--cycle;
  coinbg := (xa,ya);
  coinbd := (xb,ya);
  coinhd := (xb,yb);
  coinhg := (xa,yb);
  %modifie le 29.09.04
  z.so=(xpart(coinbg/1cm),ypart(coinbg/1cm));
  z.ne=(xpart(coinhd/1cm),ypart(coinhd/1cm));
  %fin modification
  extra_endfig := "clip currentpicture to feuillet;" & extra_endfig;
enddef;

def Figure(expr xa,ya,xb,yb) =
  feuille(xa,ya,xb,yb);
  _tfig:= if (xb-xa)>(yb-ya): xb-xa else: yb-ya fi;
  _tfig:=2*_tfig;
enddef;

%%-----------------------------------------------
%% Les marques (JMS)
%%-----------------------------------------------
string marque_p;
marque_p := "non";
marque_r := 20;
marque_a := 20;
marque_s := 5;
marque_ang := 10;
m_c := 10 ;%Pour la croix du marquage des points

%------------------------------------------------
% Les tables
%------------------------------------------------
numeric _tn;
_tn:=0;
pair _t[];
color _T[];

%%-----------------------------------------------
%% Procedures d'affichage
%%-----------------------------------------------
def MarquePoint(expr p)=
  if typetrace="3D":
    %JMS
    if marque_p = "plein":
      fill fullcircle scaled (marque_r/5) shifted Projette(p);
    elseif marque_p = "creux":
      fill fullcircle scaled (marque_r/5) shifted (Projette(p)) withcolor white;
      draw fullcircle scaled (marque_r/5) shifted (Projette(p));
        %fin JMS
    elseif marque_p = "croix":
      draw (Projette(p) shifted (-u/10,u/10))--(Projette(p) shifted (u/10,-u/10));
      draw (Projette(p) shifted (-u/10,-u/10))--(Projette(p) shifted (u/10,u/10));
    elseif marque_p = "tiretv":
      draw (Projette(p) shifted (0,u/10))--(Projette(p) shifted(0,-u/10));
    elseif marque_p = "tireth":
      draw (Projette(p) shifted (u/10,0))--(Projette(p) shifted(-u/10,0));
    fi;
  else:
    if marque_p = "plein":
      fill fullcircle scaled (marque_r/5) shifted p;
    elseif marque_p = "creux":
      fill fullcircle scaled (marque_r/5) shifted p withcolor white;
      draw fullcircle scaled (marque_r/5) shifted p;
    elseif marque_p = "croix":
      draw (p shifted (-u/m_c,u/m_c))--(p shifted (u/m_c,-u/m_c));
      draw (p shifted (-u/m_c,-u/m_c))--(p shifted (u/m_c,u/m_c));
    elseif marque_p = "tiretv":
      draw (p shifted (0,u/10))--(p shifted(0,-u/10));
    elseif marque_p = "tireth":
      draw (p shifted (u/10,0))--(p shifted(-u/10,0));
    fi;
  fi;
enddef;

vardef pointe(text t) =
  for p_ = t: if (pair p_) or (color p_): MarquePoint(p_); fi endfor;
enddef;

%------------------------------------------------
% Points
%------------------------------------------------
%JMS
vardef iso(text t) =
  save s,n; numeric n;
  if typetrace="3D":
    color s; s := (0,0,0) ; n := 0;
    for p_ = t: s := s + p_; n := n + 1 ; endfor;
  else:
    pair s; s := (0,0) ; n := 0;
    for p_ = t: s := s + p_; n := n + 1 ; endfor;
  fi;
  if n>0: (1/n)*s fi
enddef;

vardef milieu(expr AA,BB)=
  save $;
  pair $;
  if typetrace="mainlevee":
    $=point((length segment(AA,BB))*(1/2+(-1+uniformdeviate(2))/10)) of segment(AA,BB)
  else:
    $=iso(AA,BB)
  fi;
  $
enddef;

vardef CentreCercleI(expr aa,bb,cc)=
  save $,a,c;
  pair $;
  numeric a,c;
  a=(angle(aa-cc)-angle(bb-cc))/2;
  c=(angle(cc-bb)-angle(aa-bb))/2;
  ($-cc) rotated a shifted cc=whatever[aa,cc];
  ($-bb) rotated c shifted bb=whatever[bb,cc];
  $
enddef;

%------------------------------------------------
% Cercles
%------------------------------------------------
%Cercle connaissant le centre A et le rayon q
vardef cercle(expr aa, q)=fullcircle scaled (2*q) shifted aa
enddef;
%Cercle de centre A et passant par B
vardef cerclepoint(expr aa,bb)=fullcircle scaled (2*abs(aa-bb)) shifted aa
enddef;
%Cercle connaissant le diametre [AB]
vardef cercledia(expr aa,bb)=cercles(iso(aa,bb),bb)
  %fullcircle scaled (2*abs(1/2[aa,bb]-bb)) shifted (1/2[aa,bb])
enddef;
%Cercles complets
vardef cercles(text t)=
  save Cer;
  save n;
  n:=0;
  for p_=t:
    if pair p_:
      n:=n+1;
      _t[n]:=p_;
    fi
    if numeric p_:
      rayon:=p_;
    fi;
    if color p_:
      n:=n+1;
      _T[n]:=p_;
    fi;
  endfor;
  if typetrace="3D":%centre aa passant par bb dans le plan (ccddee) généralement aa=cc
    path Cer;
    color ptcer[];
    for k=0 step 5 until 360 :
      ptcer[k div 5]-_T[1]=Distance(_T[1],_T[2])*((_T[4]-_T[3])*cosd(k)/Distance(_T[3],_T[4])+(_T[5]-_T[3])*sind(k)/Distance(_T[3],_T[5]));
    endfor;
    Cer=Projette(ptcer0)
      for k=0 step 5 until 360 :
      ..Projette(ptcer[k div 5])
    endfor
    ..cycle;
  else:
    path Cer;
    if n=1 : Cer=fullcircle scaled (2*rayon) shifted _t[1];
    elseif n=2 : Cer=fullcircle scaled (2*abs(_t[1]-_t[2])) shifted _t[1];
    elseif n=3 : Cer=cercles(CentreCercleC(_t[1],_t[2],_t[3]),_t[1]);
    fi
  fi
  Cer
enddef;

%Point particulier sur le cercle
vardef pointarc(expr cercla,angle)=
  point(arctime((angle/360)*arclength cercla) of cercla) of cercla
enddef;

%Arc de cercle AB de centre 0(dans le sens direct) : les points A et B doivent etre sur le cercle.
vardef arccercle(expr aa,bb,oo)=
  path tempo;
  path arc;
  tempo=fullcircle scaled (2*abs(aa-oo)) shifted oo;
  if (angle(aa-oo)=0) or (angle(aa-oo)>0) :
    if (angle(bb-oo)=0) or (angle(bb-oo)>0):
      if (angle(aa-oo)<angle(bb-oo)):
	arc=subpath(angle(aa-oo)*(length tempo)/360,angle(bb-oo)*(length tempo)/360) of tempo;
      else:
	arc=subpath(angle(aa-oo)*(length tempo)/360,(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
      fi;
    elseif (angle(bb-oo)<0):
      arc=subpath(angle(aa-oo)*(length tempo)/360,(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
    fi;
  elseif (angle(aa-oo)<0):
    if (angle(bb-oo)=0) or (angle(bb-oo)>0):
      arc=subpath(length tempo+angle(aa-oo)*(length tempo)/360,length tempo+angle(bb-oo)*(length tempo)/360) of tempo;
    elseif (angle(bb-oo)<0):
      if (angle(aa-oo)=angle(bb-oo)) or (angle(aa-oo)<angle(bb-oo)):
	arc=subpath((length tempo)+angle(aa-oo)*(length tempo)/360,(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
      else:
	arc=subpath((length tempo)+angle(aa-oo)*(length tempo)/360,2*(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
      fi;
    fi;
  fi;
  arc
enddef;

vardef coupdecompas(expr ab,ac,ad)=arccercle(pointarc(cercles(ab,ac),angle(ac-ab)-ad),pointarc(cercles(ab,ac),angle(ac-ab)+ad),ab)
enddef;

%------------------------------------------------
% Procedures de codage
%------------------------------------------------
%Codage de l'angle droit de sommet B
vardef codeperp(expr aa,bb,cc,m)=%normalement m=5
  save codep;
  path codep;
  if typetrace="3D":
    codep=(Projette(bb)+m*unitvector(Projette(aa)-Projette(bb)))--(Projette(bb)+m*unitvector(Projette(aa)-Projette(bb))+m*unitvector(Projette(cc)-Projette(bb)))--(Projette(bb)+m*unitvector(Projette(cc)-Projette(bb)));
  else:
    codep=(bb+m*unitvector(aa-bb))--(bb+m*unitvector(aa-bb)+m*unitvector(cc-bb))--(bb+m*unitvector(cc-bb));
  fi;
  codep
enddef;

%Codage d'un milieu
vardef codemil(expr AA,BB, n) =%extremites-angle de codage
  save $,a,b,c,d;
  path $;
  pair a,b,c,d;
  a=1/2[AA,BB];
  b=(a+marque_s*unitvector(BB-AA))-(a-marque_s*unitvector(BB-AA));
  c=b rotated n shifted a;
  d=2[c,a];
  $=c--d;
  $
enddef;
%Codage de deux segments egaux
vardef codesegments(expr aa,bb,cc,dd,n)=%extremites des segments(4)-type de codage
  save $,v,w;
  picture $;
  pair AA,BB,CC,DD;
  $=image(
    if typetrace="3D":
      AA=Projette(aa);      BB=Projette(bb);      CC=Projette(cc);      DD=Projette(dd);
    else:
      AA=aa;BB=bb;CC=cc;DD=dd;
    fi;
    if n=5 :
      draw fullcircle scaled 0.1cm shifted (1/2[AA,BB]);
      draw fullcircle scaled 0.1cm shifted (1/2[CC,DD]);
    elseif n=4 :
      pair v,w;
      v=1/2[AA,BB];
      w=1/2[CC,DD];
      draw codemil(AA,BB,60);
      draw codemil(AA,BB,120);
      draw codemil(CC,DD,60);
      draw codemil(CC,DD,120);
    elseif n=3 :
      draw codemil(AA,BB,60);
      draw codemil(AA,BB,60) shifted (2*unitvector(AA-BB));
      draw codemil(AA,BB,60) shifted (2*unitvector(BB-AA));
      draw codemil(CC,DD,60);
      draw codemil(CC,DD,60) shifted (2*unitvector(CC-DD));
      draw codemil(CC,DD,60) shifted (2*unitvector(DD-CC));
    elseif n=2 :
      draw codemil(AA,BB,60) shifted unitvector(AA-BB);
      draw codemil(AA,BB,60) shifted unitvector(BB-AA);
      draw codemil(CC,DD,60) shifted unitvector(CC-DD);
      draw codemil(CC,DD,60) shifted unitvector(DD-CC);
    elseif n=1 :
      draw codemil(AA,BB,60);
      draw codemil(CC,DD,60);
    fi;
    );
    $
  enddef;

%Codage de plusieurs segments de meme longueur
  vardef Codelongueur(text t)=
  save result;
  picture result;
  pair tt[];
  k:=0;
  for p_=t:
    if pair p_:
      k:=k+1;
      tt[k]=p_;
    elseif color p_:
      k:=k+1;
      tt[k]=Projette(p_);
    elseif numeric p_:
      co:=p_;
    fi;
  endfor;
  result=image(
    if co=5:
      for j=1 upto (k div 2):
	draw fullcircle scaled 0.1cm shifted (1/2[tt[2*j-1],tt[2*j]]);
      endfor;
    elseif co=4:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60);
	draw codemil(tt[2*j-1],tt[2*j],120);
      endfor;
    elseif co=3:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60);
	draw codemil(tt[2*j-1],tt[2*j],60) shifted (2*unitvector(tt[2*j-1]-tt[2*j]));
	draw codemil(tt[2*j-1],tt[2*j],60) shifted (2*unitvector(tt[2*j]-tt[2*j-1]));
      endfor;
    elseif co=2:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60) shifted unitvector(tt[2*j-1]-tt[2*j]);
	draw codemil(tt[2*j-1],tt[2*j],60) shifted unitvector(tt[2*j]-tt[2*j-1]);
      endfor;
    elseif co=1:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60);
      endfor;
    fi;
    );
  result
enddef;

%Codage de l'angle abc non oriente (mais donne dans le sens direct) n fois avec des mesures differentes
vardef codeangle@#(expr aa,bb,cc,nb,nom)=
  save s,p,$;
  path p;
  picture $;
  $=image(
    trace marqueangle(aa,bb,cc,nb);
    label.@#(nom,w);
    );
  $
enddef;

vardef Marqueangle(expr aa,bb,mark)=%codage d'un angle forme par les demi-droites aa et bb dans le sens direct avec la marque mark
  save $;
  picture $;
  path conf,rr;
  pair w,tangent;
  numeric t,tt;
  conf=fullcircle scaled (2*marque_a) shifted (aa intersectionpoint bb);
  numeric te;
  te=angle((conf intersectionpoint aa)-(aa intersectionpoint bb));
  rr=(conf intersectionpoint aa){dir(90+angle((conf intersectionpoint aa)-(aa intersectionpoint bb)))}..(conf intersectionpoint bb);
  t=length rr/2;
  w=point(t) of rr;
  tangent=unitvector(direction t of rr);
  $=image(
    trace rr;
    if mark=1:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90);
    elseif mark=2:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted tangent;
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted(-tangent);
    elseif mark=3:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90);
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted(1.5*tangent);
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted(-1.5*tangent);
    elseif mark=4:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,45);
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,-45);
    fi;
    );
  $
enddef;

vardef marqueangle(expr aa,bb,cc,mark)=%codage d'un angle de sommet bb dans le sens direct par la marque mark.
  save $;
  picture $;
  path conf,rr;
  pair w,tangent;
  numeric t;
  if typetrace="mainlevee":
    conf=fullcircle scaled (2*marque_a) shifted bb;
    rr=(conf intersectionpoint demidroite(bb,aa)){dir(90+angle(aa-bb))}..(conf intersectionpoint demidroite(bb,cc));
    w=rr intersectionpoint droite(bb,CentreCercleI(aa,bb,cc));
    t=length rr/2;
    tangent=unitvector(direction t of rr);
    $=image(
	trace rr;
      if mark=1:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
      elseif mark=2:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted tangent;
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-tangent);
      elseif mark=3:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(1.marque_s*tangent);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-1.marque_s*tangent);
      elseif mark=4:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,45);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,-45);
      fi;
      );
  else:
    rr=arccercle(bb+marque_a*unitvector(aa-bb),bb+marque_a*unitvector(cc-bb),bb);
    w=rr intersectionpoint droite(bb,CentreCercleI(aa,bb,cc));
    t=length rr/2;
    tangent=unitvector(direction t of rr);
    $=image(
	if mark=5:
	drawarrow rr;
      else:
	trace rr;
      fi;
      if mark=1:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
      elseif mark=2:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted tangent;
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-tangent);
      elseif mark=3:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(1.marque_s*tangent);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-1.marque_s*tangent);
      elseif mark=4:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,45);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,-45);
      fi;
      );
  fi;
  $
enddef;

vardef coloreangle(expr aa,bb,cc)=arccercle(bb+marque_a*unitvector(aa-bb),bb+marque_a*unitvector(cc-bb),bb)--bb--cycle
enddef;

vardef Codeangle(expr aa,bb,cc,nb,nom)=
  save s,p,$;
  path p;
  picture $;
  $=image(
    trace marqueangle(aa,bb,cc,nb);
    label(nom,w shifted(marque_ang*unitvector(w-bb)));
    );
  $
enddef;

vardef marquesegment(expr aa,bb)=
  save tr;
  picture tr;
  if typetrace="3D":
    tr=image(%
	typetrace:="normal";
      trace rotation(segment(Projette(aa)-marque_s*unitvector(Projette(bb)-Projette(aa)),Projette(aa)+marque_s*unitvector(Projette(bb)-Projette(aa))),Projette(aa),90);
      trace rotation(segment(Projette(bb)-marque_s*unitvector(Projette(bb)-Projette(aa)),Projette(bb)+marque_s*unitvector(Projette(bb)-Projette(aa))),Projette(bb),90);
      typetrace:="3D";
      );
  else:
    tr=image(%
	trace rotation(segment(aa-marque_s*unitvector(bb-aa),aa+marque_s*unitvector(bb-aa)),aa,90);
      trace rotation(segment(bb-marque_s*unitvector(bb-aa),bb+marque_s*unitvector(bb-aa)),bb,90);
      );
  fi;
  tr
enddef;

vardef marquedemidroite(expr aa,bb)=
  save tr;
  picture tr;
  tr=image(
    trace rotation(segment(aa-marque_s*unitvector(bb-aa),aa+marque_s*unitvector(bb-aa)),aa,90);
    );
  tr
enddef;

%------------------------------------------------
% Transformations
%------------------------------------------------
vardef projection(expr m,a,b) =
  save h; pair h;
  h - m = whatever * (b-a) rotated 90;
  h = whatever [a,b];
  if typetrace="mainlevee":
    h:=h shifted((-2+uniformdeviate(4))*unitvector(a-b))
  fi;
  h
enddef;
  
vardef homothetie(expr objet,CTR,rapport)=
  ((objet shifted (-CTR)) scaled rapport) shifted CTR
enddef;

vardef rotation(expr p,c,a)=
  p rotatedaround(c,a)
enddef;

vardef symetrie(expr x)(text t)=
  save n;
  n:=0;
  for p_=t: if pair p_:
      n:=n+1;
      _t[n]:=p_;
    elseif color p_:
      n:=n+1;
      _T[n]:=p_;
    fi;
  endfor;
  if n=1:
    if typetrace="3D":
      2[x,_T[1]]
    else:
      rotation(x,_t[1],180)
    fi
  elseif n=2:
    x reflectedabout(_t[1],_t[2])
  elseif n=3:%Par rapport a un plan
    2[x,ProjectionsurPlan(x,_T[1],_T[2],_T[3])]
  fi
enddef;

%------------------------------------------------
% Droites
%------------------------------------------------
vardef segment(expr aa,bb)=
  save Seg;
  path Seg;
  if typetrace="mainlevee":
    Seg=aa{dir(angle(bb-aa)+5)}..bb{dir(angle(bb-aa)+5)}
  elseif typetrace="3D":
    Seg=Projette(aa)--Projette(bb)
  else:
    Seg=aa--bb
  fi;
  Seg
enddef;

vardef droite(expr AA,BB)=
  save Dro;
  path Dro;
  if typetrace="mainlevee":
    Dro=(_tfig/abs(AA-BB))[BB,AA]{dir(angle(BB-AA)+10)}..segment(AA,BB)..(_tfig/abs(AA-BB))[AA,BB]{dir(angle(BB-AA)+10)}
  elseif typetrace="3D":
    Dro=(_tfig/abs(Projette(AA)-Projette(BB)))[Projette(BB),Projette(AA)]--(_tfig/abs(Projette(AA)-Projette(BB)))[Projette(AA),Projette(BB)]
  else:
    Dro=(_tfig/abs(AA-BB))[BB,AA]--(_tfig/abs(AA-BB))[AA,BB]
  fi;
  Dro
enddef;
vardef demidroite(expr AA,BB)=
  save Dem;
  path Dem;
  if typetrace="mainlevee":
    Dem=segment(AA,BB)..(_tfig/abs(AA-BB))[AA,BB]{dir(angle(BB-AA)+10)}
  elseif typetrace="3D":
    Dem=Projette(AA)--(_tfig/abs(Projette(AA)-Projette(BB)))[Projette(AA),Projette(BB)]
  else:
    Dem=AA--(_tfig/abs(AA-BB))[AA,BB]
  fi;
  Dem
enddef;

vardef bissectrice(expr AA,BB,CC)=
  save $;
  path $;
  if typetrace="mainlevee":
    $=rotation(demidroite(BB,CentreCercleI(AA,BB,CC)),BB,-5+uniformdeviate(10))
  else:
    $=demidroite(BB,CentreCercleI(AA,BB,CC))
  fi;
  $
enddef;

vardef mediatrice(expr AA,BB)=droite(iso(AA,BB),rotation(BB,iso(AA,BB),90))
enddef;
%main levee : passer par la perpendiculaire passant par le milieu.

vardef perpendiculaire(expr AA,BB,II)=droite(iso(AA,BB),rotation(BB,iso(AA,BB),90)) shifted (II-iso(AA,BB))
enddef;

vardef parallele(expr AA,BB,II)=droite(AA,BB) shifted (II-(projection(II,AA,BB)))
enddef;

%%%%%%%%%%
%Polygone/Ligne brisée
%%%%%%%%%
vardef polygone(text t)=
  pair aaa[];
  j:=0;
  for p_=t: if pair p_:
      j:=j+1;
      aaa[j]=p_;
    elseif color p_:
      j:=j+1;
      aaa[j]=Projette(p_);
    fi;
  endfor;
  aaa[j+1]:=aaa[1];
  save $;
  path $;
  if typetrace="mainlevee":
    $=segment(aaa[1],aaa[2])--
      for k=2 upto (j-1):
      segment(aaa[k],aaa[k+1])--
    endfor
    segment(aaa[j],aaa[1])--cycle;
  else:
    $=aaa1--
      for k=2 upto j:
      aaa[k]--
    endfor
    cycle;
  fi;
  $
enddef;

vardef chemin(text t)=
  pair aaa[];
  j:=0;
  for p_=t: if pair p_:
      j:=j+1;
      aaa[j]=p_;
    elseif color p_:
      j:=j+1;
      aaa[j]=Projette(p_);
    fi;
  endfor;
  if typetrace="mainlevee":
    save $;
    picture $;
    $=image(
      for k=1 upto (j-1):
	trace segment(aaa[k],aaa[k+1]);
      endfor;
      );
  else:
    save $;
    path $;
    $=aaa1
    for k=2 upto j:
      --aaa[k]
    endfor;
  fi;
  $
enddef;

%------------------------------------------------
%Sucres
%------------------------------------------------
vardef hachurage(expr chemin, angle, ecart, trace)=
  save $;
  picture $;
  path support;
  support=((u*(-37,0))--(u*(37,0))) rotated angle;
  if trace=1:
    drawoptions(dashed evenly);
  elseif trace=2:
    drawoptions(dashed dashpattern(on12bp off6bp on3bp off6bp));
  elseif trace=3:
    drawoptions(dashed withdots);
  fi;
  $ = image(
    for j=-200 upto 200:
      if ((support shifted (ecart*j*(u,0))) intersectiontimes chemin)<>(-1,-1):
	draw support shifted (ecart*j*(u,0));
      fi
    endfor;
    );
  clip $ to chemin;
  drawoptions();
  $
enddef;
%fleche pour coter un segment [AB] (Jacques Marot)
vardef cotation(expr aa,bb,ecart,decalage,cote)=
  pair m[] ;
  save $;
  picture $;
  m3=unitvector(bb-aa) rotated 90;
  m1=aa+ecart*m3;
  m2=bb+ecart*m3;
  $=image(
    pickup pencircle scaled 0.2bp;
    drawdblarrow m1--m2 ;
    draw aa--m1 dashed evenly;
    draw bb--m2 dashed evenly;
    label(cote rotated angle(m2-m1),(m1+m2)/2+decalage*m3);
    );
  $
enddef;

vardef appelation(expr aa,bb,decalage,cote)=
  save $;
  pair m[],AA,BB;
  if color aa:
    AA=Projette(aa);
  else:
    AA=aa;
  fi;
  if color bb:
    BB=Projette(bb);
  else:
    BB=bb;
  fi;
  m3=unitvector(BB-AA) rotated 90;
  picture $;
  $=image(
    label(cote rotated angle(BB-AA),(BB+AA)/2+decalage*m3);
    );
  $
enddef;

vardef cotationmil(expr aa,bb,ecart,decalage,cote)= %Christophe
  pair m[],AA,BB;
  save $;
  picture cot;
   if color aa:
    AA=Projette(aa)
  else:
    AA=aa
  fi;
  if color bb:
    BB=Projette(bb)
  else:
    BB=bb
  fi;
  m3=unitvector(BB-AA) rotated 90;
  m1=AA+ecart*m3;
  m2=BB+ecart*m3;
  cot=image(
    pickup pencircle scaled 0.2bp;
    drawarrow (1/2[m1,m2]+decalage*unitvector(m1-m2))--m1;
    drawarrow (1/2[m1,m2]-decalage*unitvector(m1-m2))--m2;
    draw AA--m1 dashed evenly;
    draw BB--m2 dashed evenly;
    label(cote rotated angle(m2-m1),(m1+m2)/2);
    );
  cot
enddef;

%%%%%%%%%%
%francisation
%%%%%%%%%
def trace expr o =
    if path o: draw o else: draw o fi
enddef;
def remplis expr o =
    if path o: fill o else: fill o fi
enddef;

%3D - basé sur donymodule
color Sommet[];

color Co[];
Co0=jaune;
Co1=violet;
Co2=orange;
Co3=ciel;
Co4=vert;
Co5=bleu;
Co6=rouge;

string pointilles;

string typerepre;
typerepre:="proj";

%generalite
vardef Projette(expr X)=
  pair $;
  Xobs := -redpart(X)*Aux1 + greenpart(X)*Aux3;
  Yobs := -redpart(X)*Aux5 - greenpart(X)*Aux6 + bluepart(X)*Aux4;
  if typerepre="proj":
    Zobs := -redpart(X)*Aux7 - greenpart(X)*Aux8 - bluepart(X)*Aux2 + Rho;
    XProj := DE*Xobs/Zobs;
    YProj := DE*Yobs/Zobs;
  elseif typerepre="persp":
    XProj := DE*Xobs;
    YProj := DE*Yobs;
  fi;
  $=(XProj,YProj);
  $
enddef;

vardef Initialisation(expr r,t,p,d)=
  Rho:=r;
  Theta:=t;
  Phi:=p;
  DE:=d;
  Aux1:=sind(Theta);
  Aux2:=sind(Phi);
  Aux3:=cosd(Theta);
  Aux4:=cosd(Phi);
  Aux5:=Aux3*Aux2;
  Aux6:=Aux1*Aux2;
  Aux7:=Aux3*Aux4;
  Aux8:=Aux1*Aux4;
  pointilles:="oui";
enddef;

%vues cachees

vardef Face(text t)=
  j:=0;
  for p_=t :
    if numeric p_:
      a[j]:=p_;
      j:=j+1;
    fi;
  endfor;
  for k=1 upto (j-1):
    Fc[a0*100+(k-1)]:=a[k];
  endfor;
enddef;

vardef Oeil=(Rho*Aux7,Rho*Aux8,Rho*Aux2)
enddef;

vardef Vision(expr num)=
  save bb;
  color bb;
  bb=(redpart(Oeil-Sommet[num]),greenpart(Oeil-Sommet[num]),bluepart(Oeil-Sommet[num]));  
  bb
enddef;

vardef Normal(expr vecun,vecde,vectr)=
  save aa;
  color aa;
  P1:=redpart(vecde-vecun);
  P2:=greenpart(vecde-vecun);
  P3:=bluepart(vecde-vecun);
  Q1:=redpart(vectr-vecun);
  Q2:=greenpart(vectr-vecun);
  Q3:=bluepart(vectr-vecun);
  aa=(P2*Q3-Q2*P3,P3*Q1-Q3*P1,P1*Q2-Q1*P2);
  aa
enddef;

vardef ProduitScalaire(expr wec,mor)=
  redpart(wec)*redpart(mor)+greenpart(wec)*greenpart(mor)+bluepart(wec)*bluepart(mor)
enddef;

vardef Distance(expr aa,bb)=%Entre deux points
  sqrt((redpart(bb)-redpart(aa))*(redpart(bb)-redpart(aa))+(greenpart(bb)-greenpart(aa))*(greenpart(bb)-greenpart(aa))+(bluepart(bb)-bluepart(aa))*(bluepart(bb)-bluepart(aa)))
enddef;

vardef Module(expr aa)=%module d'un vecteur
sqrt((redpart(aa))**2+(greenpart(aa))**2+(bluepart(aa)**2))
enddef;

color CoulTrace;
CoulTrace=black;

vardef DessineObjet=
  for l=1 upto NF:
    color cc,dd;
    dd=Vision(Fc[l*100+1]);
    cc=Normal(Sommet[Fc[l*100+1]],Sommet[Fc[l*100+2]],Sommet[Fc[l*100+3]]);
    if (ProduitScalaire(dd,cc)<0):
      if pointilles="oui":
	drawoptions(dashed dashpattern(on3pt off6pt) withcolor CoulTrace);
	trace for k=1 upto Fc[100*l]:
	  Projette(Sommet[Fc[100*l+k]])--
	endfor
	cycle;
      fi;
    else:
      trace for k=1 upto Fc[100*l]:
	Projette(Sommet[Fc[100*l+k]])--
      endfor
      cycle withcolor CoulTrace;
    fi;
    drawoptions();
  endfor;
enddef;

%%Transformations

%Translations

vardef TranslateSommets(expr v)=
  for k=1 upto NbS:
    Sommet[k]:=Sommet[k]+v;
  endfor;
enddef;

vardef SymetriePlanZ(expr vv)=
  for k=1 upto NbS:
    w:=vv-bluepart(Sommet[k]);
    Sommet[k]:=(redpart(Sommet[k]),greenpart(Sommet[k]),w);
  endfor;
enddef;

vardef IntersectionDroite(expr aa,bb,cc,dd)=
  save tt;
  color tt;
  tt=whatever[aa,bb];
  tt=whatever[cc,dd];
  tt
enddef;

%%denis Roegel----------
vardef Intersectionplandroite(expr aa,bb,cc,dd,ee)=
  save int;
  boolean int;
  color gg,caaa[];
  caaa3=Normal(aa,bb,cc)/Module(Normal(aa,bb,cc));
  caaa1=aa-dd;
  caaa2=ee-dd;
  if ProduitScalaire(caaa2,caaa3)<>0:
    caaa4=caaa2*(ProduitScalaire(caaa1,caaa3)/ProduitScalaire(caaa2,caaa3));
    int:=true;
  else: % the line is parallel to the plane
    int:=false;
  fi;
  int
enddef;

vardef IntersectionPlanDroite(expr aa,bb,cc,dd,ee)=%plan (aa,bb,cc) droite(dd,ee)
  if Intersectionplandroite(aa,bb,cc,dd,ee):
    gg=dd+caaa4;
  fi;
  gg
enddef;

vardef ProjectionsurPlan(expr aa,bb,cc,dd)=%Projection du point aa sur le plan (bbccdd)
  save di,vc;
  color va,vb,vc;
  va=Normal(bb,cc,dd)/Module(Normal(bb,cc,dd));
  vb=aa-bb;
  di=-ProduitScalaire(vb,va);
  va:=di*va;
  vb:=vb+va;
  vc=bb+vb;
  vc
enddef;

vardef Intersectionplanplan(expr AA,BB,CC,DD,EE,FF)=%besoin pour la suite
  color trial[];
  path INTer;
  if Intersectionplandroite(DD,EE,FF,AA,BB):
    trial1=IntersectionPlanDroite(DD,EE,FF,AA,BB);
  else:% there is no intersection or the intersection is the line
    trial1=IntersectionPlanDroite(DD,EE,FF,AA,1/2[BB,CC]);
  fi;
  if Intersectionplandroite(DD,EE,FF,AA,CC):
    trial2=IntersectionPlanDroite(DD,EE,FF,AA,CC);
  else:% there is no intersection or the intersection is the line
    trial2=IntersectionPlanDroite(DD,EE,FF,CC,1/2[BB,AA]);%modif de cp
  fi;
  %INTer=segment(10[trial1,trial2],10[trial2,trial1]);
  INTer=droite(trial1,trial2);
  INTer
enddef;

vardef IntersectionPlanPlan(expr aa,bb,cc,dd,ee,ff)=
  %a verifier
  save da,db,dc,int,INTER;
  boolean int;
  path INTER;
  da=Module(aa-ProjectionsurPlan(aa,dd,ee,ff));
  %show da;
  db=Module(bb-ProjectionsurPlan(bb,dd,ee,ff));
  %show db;
  dc=Module(cc-ProjectionsurPlan(cc,dd,ee,ff));
  %show dc;
  if (da=db) and (db=dc): % the two planes are parallel
    int:=false;
  else:
    int:=true;
    if (da=db):
      INTER=droite(aa,bb);
    elseif (db=dc):
      INTER=droite(bb,cc);
    elseif (dc=da):
      INTER=droite(cc,aa);
    elseif (da>=db) and (da>=dc):
      INTER=Intersectionplanplan(aa,bb,cc,dd,ee,ff);
    elseif (db>=da) and (db>=dc):
      INTER=Intersectionplanplan(bb,cc,aa,dd,ee,ff);
    elseif (dc>=da) and (dc>=db):
      INTER=Intersectionplanplan(cc,aa,bb,dd,ee,ff);
    fi;
  fi;
  INTER
enddef;
%%---------------------

%Cube
numeric arete;
arete=1;

vardef Cube(text t)=
  picture cub;
  cub=image(
  NbS:=8;
  Sommet1:=(arete,0,0);
  Sommet2:=(arete,arete,0);
  Sommet3:=(0,arete,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,arete);
  Sommet6:=(arete,0,arete);
  Sommet7:=(arete,arete,arete);
  Sommet8:=(0,arete,arete);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
cub
enddef;

vardef cube=
  typetrace:="3D";
  typerepre:="persp";
  Initialisation(1500,30,20,100);
  picture cub;
  cub=image(
      NbS:=8;
    Sommet1:=(arete,0,0);
    Sommet2:=(arete,arete,0);
    Sommet3:=(0,arete,0);
    Sommet4:=(0,0,0);
    Sommet5:=(0,0,arete);
    Sommet6:=(arete,0,arete);
    Sommet7:=(arete,arete,arete);
    Sommet8:=(0,arete,arete);
%%Faces
    NF:=6;
    Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
    Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
    Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
    Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
    Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
    Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
    DessineObjet;
    );
  cub
enddef;

%Cube
vardef Paveh(text t)=
  picture paveh;
  paveh=image(
  NbS:=8;
  Sommet1:=(0.75,0,0);
  Sommet2:=(0.75,1.5,0);
  Sommet3:=(0,1.5,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,1);
  Sommet6:=(0.75,0,1);
  Sommet7:=(0.75,1.5,1);
  Sommet8:=(0,1.5,1);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
paveh
enddef;

%Cube
vardef Pavev(text t)=
  picture pavev;
  pavev=image(
  NbS:=8;
  Sommet1:=(1,0,0);
  Sommet2:=(1,0.75,0);
  Sommet3:=(0,0.75,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,1.5);
  Sommet6:=(1,0,1.5);
  Sommet7:=(1,0.75,1.5);
  Sommet8:=(0,0.75,1.5);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
pavev
enddef;

vardef Pave(text t)(expr aa,bb,cc)=
  picture pave;
  pave=image(
  NbS:=8;
  Sommet1:=(aa,0,0);
  Sommet2:=(aa,bb,0);
  Sommet3:=(0,bb,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,cc);
  Sommet6:=(aa,0,cc);
  Sommet7:=(aa,bb,cc);
  Sommet8:=(0,bb,cc);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=4;Fc[102]:=3;Fc[103]:=2;Fc[104]:=1;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=4;Fc[302]:=1;Fc[303]:=6;Fc[304]:=5;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
pave
enddef;

vardef pave(expr aa,bb,cc)=
  typetrace:="3D";
  typerepre:="persp";
  Initialisation(1500,30,20,100);
  picture PAVE;
  PAVE=image(
      NbS:=8;
    Sommet1:=(aa,0,0);
    Sommet2:=(aa,bb,0);
    Sommet3:=(0,bb,0);
    Sommet4:=(0,0,0);
    Sommet5:=(0,0,cc);
    Sommet6:=(aa,0,cc);
    Sommet7:=(aa,bb,cc);
    Sommet8:=(0,bb,cc);
%%Faces
    NF:=6;
    Fc[100]:=4;Fc[101]:=4;Fc[102]:=3;Fc[103]:=2;Fc[104]:=1;
    Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
    Fc[300]:=4;Fc[301]:=4;Fc[302]:=1;Fc[303]:=6;Fc[304]:=5;
    Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
    Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
    Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
    DessineObjet;
    );
  PAVE
enddef;

vardef Tetraedrer(text t)=
  picture tetrar;
  tetrar=image(
    %Sommets
    NbS:=4;
    Sommet1:=(0,0,1);
    Sommet2:=(-0.4714045,-0.8164965,-1/3);
    Sommet3:=(0.942809,0,-1/3);
    Sommet4:=(-0.4714045,0.8164965,-1/3);
    %Faces
    NF:=4;
    Fc[100]:=3;Fc[101]:=1;Fc[102]:=2;Fc[103]:=3;
    Fc[200]:=3;Fc[201]:=1;Fc[202]:=3;Fc[203]:=4;
    Fc[300]:=3;Fc[301]:=1;Fc[302]:=4;Fc[303]:=2;
    Fc[400]:=3;Fc[401]:=2;Fc[402]:=4;Fc[403]:=3;
    DessineObjet;
    k:=1;
    for p_=t:
      if color p_:
	p_=Sommet[k];
	k:=k+1;
      fi
    endfor;
    );
  tetrar
enddef;

endinput;
