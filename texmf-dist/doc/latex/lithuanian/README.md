# Lithuanian language support package for TeX

Provides single-byte extra encodings for output and input:

  * Extended `latin7` encoding used by `fontenc` package - `L7x`: `l7xenc.def`, `l7xenc.dfu`, `l7xenc.sty`  
    (extended `ISO/IEC 8859-13:1998`, see `latin7x.pdf` in package documentation)
 
  * Code page definitions used by `inputenc` package:
    - `cp775.def` for `DOS`
    - `latin7.def` for `Linux`
    - `cp1257.def` for `Windows` (exists in a standard `TL` distribution)

## Lithuanian TeX support for URW family Type1 fonts

  * `map`, `fd`, `tfm` files with `L7x` encoding

## Instalation

  To manually (re)install a package, run `tlmgr install lithuanian`.  
  (`tlmgr` is the command name of the `TeX Live` package manager)

## manual map files management 

   * `updmap --enable Map $TEXMFLOCAL/fonts/map/dvips/lt/l7x-urwvn.map`  
     (for current user)  

   * `updmap-sys --enable Map $TEXMFLOCAL/fonts/map/dvips/lt/l7x-urwvn.map`  
     (for all users)

Enjoy Lithuanian TeXing!

2023-03-07
Sigitas Tolušis
