# 1. ????????

????? disser ???????????? ??? ??????? ????????, ??????????? ? ?????????????
? ???????????? ? ???????????? ??????????????? ??????? ? ??? ??.

# 2. ????????????? ?????? ? ?????????

??? ?????????? ?????? ?????????? ? ????? ???????????? LaTeX ?????? ????
??????????? ????????? ??????:
amsfonts, amsmath, amssymb, caption, cmap, gost, graphicx, ifpdf, kvoptions,
natbib, hyperref, subcaption, wrapfig, ? ????? ?????? ??? ?????????
???????? ????? ? ???????.

??? ????????????? ?????? Times ? ????????? ?????? ??????? ??????????
????? tempora ??? cyrtimes, ? ?????????????? ?????? --- newtxmath ??? mtpro.

??? ?????????????????? ????????? ???????? ? ??????? ???????? Makefile ?
nomake.cmd ??????? ?????????? ????????? Ghostscript, epstool ? sam2p.

# 3. ????????? ????????? ??????

- ????? disser ???????? ?? CTAN: http://www.ctan.org/tex-archive/macros/latex/contrib/disser/
- ???????? ??????? ?? Sourceforge: http://sourceforge.net/projects/disser/
- ????????? ??????????? ???????? ??????? ???????:
  - https://github.org/polariton/disser/
  - https://bitbucket.org/sky/disser/
  - https://sourceforge.net/p/disser/disser.git

ZIP-????? ? ????????? ????????: http://www.ctan.org/get/macros/latex/contrib/disser.zip
ZIP-????? ? ???????? ??????? ? ?????????????, ??????? ????????? ? ???????????? ?? ??????????? ?????????? ????????? TeX (??. disser-<version>.tds.zip ? ??????? Download).

# 4. ?????????
## 4.1. ?? ZIP-?????? ?? ????????????????? ???????

???? ?????? ????????? ???????? ????? ? ???????? ?????????????.
???? disser-<version>.tds.zip ???????? ????????? ????? ??????? ?
????????????, ??????? ??? ????? ?????? ??????????? ? ??????? TeX.

?????? ??? Unix-???????? ?????????:
```sh
$ cd /????/?/texmf
$ unzip /????/?/?????/disser-<version>.tds.zip
$ mktexlsr
```

?????? ??? Windows:
```sh
$ cd ????:\????\?\texmf
$ unzip ????:\????\?\?????\disser-<version>.tds.zip
$ mktexlsr
```

## 4.2. ?? ???????? ???????

??? ????????? ?????????? ??????? ? ??????? ? ?????????????? ?????????
???????? ? ????????? ????????? ???????

- ? Unix-???????? ??????????:
```sh
$ env DESTDIR=/????/?/texmf make install
```

- ? Windows:
```sh
$ set DESTDIR=????:\????\?\texmf
$ nomake install
```

????? /????/?/texmf ? ????:\????\?\texmf -- ???? ? ?????? ????????? TeX.
????? ????????? ??????? ???????? ???? ???? ?????? ? ??????? ???????
```sh
$ mktexlsr
```

??????? ?????? ??? ???????????? MiKTeX ?????? 2.9 ? Windows 7.

- ????????? ??? ???? ?????????????:
```sh
$ set DESTDIR=%ALLUSERSPROFILE%\MiKTeX\2.9
$ nomake install
$ mktexlsr --admin
```

- ????????? ?????? ??? ???????? ????????????:
```sh
$ set DESTDIR=%APPDATA%\MiKTeX\2.9
$ nomake install
$ mktexlsr
```

# 5. ????????

????????? (?) ????????? ????????

?? ??? ?? ??????????? ???/?? ???????? ????? ??? ?????????? ?? ??? ????? ??????? ?????? ???????, ?????? ??????? 1.3 ?? ???? ??????? ?? (?? ??? ??????) ??? ????? ???????. ??? ?????? ??????? ?? ???? ??????? ?? ?? ????://???.?????-???????.???/????.??? ??? ??????? 1.3 ?? ????? ?? ???? ?? ??? ????????????? ?? ????? ??????? 2003/12/01 ?? ?????.

???? ??????? ?? ??????????? ?? ??? ???? ???? ?? ???? ?? ??????, ??? ??????? ??? ????????; ??????? ???? ??? ??????? ???????? ?? ?????????????? ?? ??????? ??? ? ?????????? ???????.
