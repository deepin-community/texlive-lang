prologues:=3;

path carre[];

u:=0.5mm;

vardef BlocAffichage=
  for k=0 upto 34:
    carre[k]:=(unitsquare scaled u) shifted(u*(k mod 5,5-(k div 5)));
  endfor;
enddef;

vardef Affichage(expr decomp)=
  save $;
  picture $;
  drawoptions(withpen pensquare scaled0.1);
  $=image(%
      for k=0 upto 34:
      if (substring(k,k+1) of decomp)="1":
	fill carre[k];
      fi;
    endfor;
    );
  drawoptions();
  $
enddef;

nblignes:=0;

boolean print;
print:=false;

color CouleurEcran;
CouleurEcran=(107/255,148/255,107/255);

boolean Math;
Math=true;

decahoriz:=0;

vardef Test(expr cptk,cptnt)=
  pair decalage;
  if nblignes mod 2=0:
    decalage:=u*((20-length(cptnt)+cptk)*6,-8*(nblignes-1));
  else:
    decalage:=u*(decahoriz,-8*(nblignes-1));
    decahoriz:=decahoriz+6;
  fi;
  if substring(cptk,cptk+1) of cptnt="A":draw Affichage("01110100011000110001111111000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="B":draw Affichage("11110100011000111110100011000111110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="C":draw Affichage("01110100011000010000100001000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="D":draw Affichage("11100100101000110001100011001011100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="E":draw Affichage("11111100001000011111100001000011111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="F":draw Affichage("11111100001000011111100001000010000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="G":draw Affichage("01110100011000010111100011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="H":draw Affichage("10001100011000111111100011000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="I":draw Affichage("01110001000010000100001000010001110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="J":draw Affichage("00111000100001000010000101001001100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="K":draw Affichage("10001100101010011000101001001010001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="L":draw Affichage("10000100001000010000100001000011111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="M":draw Affichage("10001110111010110101100011000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="N":draw Affichage("10001100011100110101100111000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="O":draw Affichage("01110100011000110001100011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="P":draw Affichage("11110100011000111110100001000010000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="Q":draw Affichage("01110100011000110001101011001001101") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="R":draw Affichage("11110100011000111110101001001010001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="S":draw Affichage("01111100001000001110000010000111110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="T":draw Affichage("11111001000010000100001000010000100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="U":draw Affichage("10001100011000110001100011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="V":draw Affichage("10001100011000110001100010101000100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="W":draw Affichage("10101101011010110101101011010101010") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="X":draw Affichage("10001100010101000100010101000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="Y":draw Affichage("10001100011000101010001000010000100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="Z":draw Affichage("11111000010001000100010001000011111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="a":draw Affichage("00000000000111100001011111000101111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="b":draw Affichage("10000100001011011001100011000111110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="c":draw Affichage("00000000000111010000100001000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="d":draw Affichage("00001000010110110011100011000101111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="e":if Math:
	draw Affichage("00000000000000000001101000100010100") shifted(decalage);
	decalage:=u*(decahoriz-1,-8*(nblignes-1));
	draw Affichage("00000000001001010101101011010110010")  shifted(decalage);
	decahoriz:=decahoriz+6;
      else:
	draw Affichage("00000000000111010001111111000001110") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="@":draw Affichage("00010001000111010001111111000001110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="f":draw Affichage("00110010010100011100010000100001000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="g":draw Affichage("00000011111000110001011110000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="h":draw Affichage("10000100001011011001100011000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="i":draw Affichage("00100000000110000100001000010001110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="j":if Math=true:
	draw Affichage("00011000011110100001000000000000000") shifted(decalage);
      else:
	draw Affichage("00010000000011000010000101001001100") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="k":if Math=true:
	draw Affichage("11100001000100011100000000000000000") shifted(decalage);
      else:
	draw Affichage("10000100001001010100110001010010010") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="l":if Math=true:
	draw Affichage("11100010000010011100000000000000000") shifted(decalage);
      else:
	draw Affichage("01100001000010000100001000010001110") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="m":draw Affichage("00000000001101010101101011000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="n":draw Affichage("00000000001011011001100011000110001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="o":draw Affichage("00000000000111010001100011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="p":draw Affichage("00000000001111010001111101000010000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="q":if Math=true:
	draw Affichage("00000000001111101010010100101010001") shifted(decalage);
      else:
	draw Affichage("00000000000110110011011110000100001") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="r":draw Affichage("00000000001011011001100001000010000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="s":draw Affichage("00000000000111010000011100000111110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="t":draw Affichage("01000010001110001000010000100100110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="u":draw Affichage("00000000001000110001100011001101101") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="v":if Math=true:
	draw Affichage("00111001000010000100101000110000100") shifted(decalage);	
      else:
	draw Affichage("00000000001000110001100010111000100") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="w":draw Affichage("00000000001010110101101011010101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="x":draw Affichage("00000000001000101010001000101010001") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="y":draw Affichage("00000000001000110001011110000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="z":draw Affichage("00000000001111100010001000100011111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="0":draw Affichage("01110100011001110101110011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="1":draw Affichage("00100011000010000100001000010001110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="2":draw Affichage("01110100010000100010001000100011111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="3":draw Affichage("11111000100010000010000011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="4":draw Affichage("00010001100101010010111110001000010") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="5":draw Affichage("11111100001111000001000011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="6":draw Affichage("00110010001000011110100011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="7":draw Affichage("11111000010001000100010000100001000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="8":draw Affichage("01110100011000101110100011000101110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="9":draw Affichage("01110100011000101111000010001001100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="!":draw Affichage("00100001000010000100000000000000100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="'":draw Affichage("01100001000100000000000000000000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="(":draw Affichage("00010001000100001000010000010000010") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt=")":draw Affichage("01000001000001000010000100010001000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="*":draw Affichage("00000001001010101110101010010000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="+":draw Affichage("00000001000010011111001000010000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt=",":draw Affichage("00000000000000000000011000010001000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="-":draw Affichage("00000000000000011111000000000000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt=".":draw Affichage("00000000000000000000000000110001100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="/":draw Affichage("00000000010001000100010001000000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt=":":if Math=true:
	draw Affichage("00000000000000000000000000000000000") shifted(decalage);
      else:
	draw Affichage("00000011000110000000011000110000000") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt=";":if Math=true:
	  draw Affichage("00000001000000011111000000010000000") shifted(decalage);
      else:
	draw Affichage("00000011000110000000011000010001000") shifted(decalage);
      fi;
    elseif substring(cptk,cptk+1) of cptnt="<":draw Affichage("00010001000100010000010000010000010") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="=":draw Affichage("00000000001111100000111110000000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt=">":draw Affichage("10000010000010000010001000100010000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="?":draw Affichage("01110100010000100010001000000000100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="[":draw Affichage("01110010000100001000010000100001110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="]":draw Affichage("01110000100001000010000100001001110") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="`":draw Affichage("01000001000001000000000000000000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="|":draw Affichage("00100001000010000100001000010000100") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt=" ":draw Affichage("00000100010101000100010101000100000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="&":draw Affichage("00000100001100011100110001000000000") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="$":draw Affichage("00000000000000100001000010000111111") shifted(decalage);
    elseif substring(cptk,cptk+1) of cptnt="^":draw Affichage("00100010101000100000000000000000000") shifted(decalage);
    fi;
enddef;

vardef LCD(text nt)(text rep)(expr NB)=
  decahoriz:=0;
  nblignes:=nblignes+1;
  path Ecran;
  Ecran:=(u*(0,-1)--u*(120,-1)--u*(120,7)--u*(0,7)--cycle) shifted(u*(0,-8*(nblignes-1)));
  fill Ecran withcolor if print=true:0.8white else:CouleurEcran fi;
  draw Ecran withcolor if print=true:0.8white else:CouleurEcran fi;
  for k=0 upto length(nt)-1:
    BlocAffichage;
    Test(k,nt);
  endfor;
  for k=1 upto NB:
    nblignes:=nblignes+1;
    Ecran:=(u*(0,-1)--u*(120,-1)--u*(120,7)--u*(0,7)--cycle) shifted(u*(0,-8*(nblignes-1)));
    fill Ecran withcolor if print=true:0.8white else:CouleurEcran fi;
    draw Ecran withcolor if print=true:0.8white else:CouleurEcran fi;
  endfor;
  nblignes:=nblignes+1;
  Ecran:=(u*(0,-1)--u*(120,-1)--u*(120,7)--u*(0,7)--cycle) shifted(u*(0,-8*(nblignes-1)));
  fill Ecran withcolor if print=true:0.8white else:CouleurEcran fi;
  draw Ecran withcolor if print=true:0.8white else:CouleurEcran fi;
  for k=0 upto length(rep)-1:
    BlocAffichage;
    Test(k,rep);
  endfor;
enddef;

endinput;
