color CouleurEngrenage;

vardef sin(expr t) = sind(c*t) enddef;

vardef cos(expr t) = cosd(c*t) enddef;

vardef tan(expr t) = sin(t)/cos(t) enddef;

vardef Developpante(expr dp)=
  save $;
  path $;
  $=(dp*u)*(1,0) for t=0 step 0.1 until pi:
      --((dp*u)*(cos(t)+t*sin(t),sin(t)-t*cos(t)))
  endfor;
  $
enddef;

vardef Entraxe(expr na,nb)=
  0.5*(ModuleEng/u)*(na+nb)+0.04
enddef;

vardef Engrenage(expr M,Z,Cc)=%M : Module, Z : nb dents,Cc=Centre
    % Pour des engrenages dont le profil est une développante de cercle
  save $;
  picture $;
  ModuleEng:=M*u;
  Dp:=ModuleEng*Z;%Module (mm)
  
  De:=Dp+2*ModuleEng;%Diamètre extérieur
  Dpied:=Dp-2.5*ModuleEng;%Diamètre de pied
  Alpha:=20;%Angle de pression
  Db:=Dp*cosd(Alpha);%Diamètre de base
  
  pair OPfC,APfC,BPfC,CPfC,Obase[];
  OPfC=(0,0);
  path cerclep,cerclee,cercleb,cerclepied;
  cerclep=cercles(OPfC,0.5*Dp);
  cerclee=cercles(OPfC,0.5*De);
  cercleb=cercles(OPfC,0.5*Db);
  cerclepied=cercles(OPfC,0.5*Dpied);
  path dd,daction,dsupport[],dperp[],dsymetrie,darret;
  dd=demidroite(OPfC,OPfC+(0,1));
  APfC=dd intersectionpoint cerclep;
  BPfC=dd intersectionpoint cercleb;
  path profil;
  profil=(symetrie(rotation(Developpante(0.5*Db/(u)),OPfC,90),OPfC,(0,1)) cutafter cerclee);%0.5*Dp*cosd(Alpha));
  %CPfC=dd intersectionpoint cerclepied;
  ReleveAngle:=90-angle(profil intersectionpoint cerclep);
  dsymetrie=rotation(dd,OPfC,-(360/(4*Z)+ReleveAngle));
  darret=rotation(dd,OPfC,(360/(4*Z)-ReleveAngle));
  pair D;
  D=profil intersectionpoint cerclee;
  path Profil;
  Profil=(reverse(cerclepied) cutbefore darret cutafter dd)--profil--(reverse(cerclee) cutbefore demidroite(OPfC,D) cutafter dsymetrie);
  Profil:=Profil--symetrie(reverse(Profil),OPfC,rotation((0,1),OPfC,-(360/(4*Z)+ReleveAngle)));
  path ProfilGene;
  ProfilGene=Profil
    for k=1 upto Z-1:
    --rotation(Profil,OPfC,-k*(360/Z))
  endfor
  --cycle;
  $=image(
      fill ProfilGene withcolor CouleurEngrenage;
    trace ProfilGene;
    fill cercles(OPfC,1u) withcolor blanc;
    trace cercles(OPfC,1u);
    fill cercles(OPfC,0.85u) withcolor 0.5white;
    trace cercles(OPfC,0.85u);
    fill rotation((cercles(OPfC,0.25u) shifted (dd intersectionpoint cerclepied)),OPfC,-(360/(4*Z)+ReleveAngle));
    );
  $:=rotation($,OPfC,-90+(360/(4*Z)+ReleveAngle)) shifted Cc;
  $
enddef;
