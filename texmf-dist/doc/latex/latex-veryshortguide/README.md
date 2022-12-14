
[//]: # (veryshortguide LaTeX class)

# veryshortguide

This is the README.md file for the veryshortguide LaTeX class v0.7 (2020-04-16)
generated by ClassPack v.1.19 (2020-05-19) on 21 May 2020 at 11:55:35 

## Summary

This is the document class originally designed for the _Very Short Guide
to LaTeX_, a 4pp folder designed as an aide-mémoire for people who have
just done a course in LaTeX and need something by them on their desk the
next day to refresh their memories. It is _not_ intended as a substitute
for full documentation.

Please do not complain that there is no math here. It won't fit. Someone
else can do a math leaflet. IANAM.


## Automated installation

If this class is distributed from CTAN, it should be in a zip file which
allows it to be installed automatically by the TeX Live Manager (tlmgr)
and similar automated installers.

If you are using automated LaTeX package installation, no further action
is required: the package will be installed the first time you use it in
a LaTeX document.

If you are using the TeX Live Manager (_tlmgr_) program manually, you
can install this package with the command:


## TDS installation

This class is also available as a TeX Directory System (TDS) zip file
(`.tds.zip`). This is the standard directory layout for a modern TeX
installation which enables the class to be unzipped directly into your
Personal TeX Directory without the need to use _tlmgr_. If you haven’t
yet created a Personal TeX Directory, see below for details of what one
is, and how to create it.
  *  You can install this class on any TDS-compliant personal system (laptop,
desktop, workstation, table, smartphone, PDA, etc) by unzipping it
straight into your Personal TeX Directory. This will put all the files
into the right places, so you can start using them immediately.
  *  On a shared (multiuser) system like a server, the administrator can
unzip it into the `$TEXMFLOCAL` directory instead (see below), and run
your TeX directory-indexing program (eg _texhash_, _mktexlsr_, etc) so
that everyone can use it.
  *  If you are using an old non-TDS-compliant system, see below under Manual
Installation.

### Your Personal TeX Directory

This is a directory (folder) where you should put all local manual
modifications (updates, additions such as new or updated classes,
packages, and fonts) that are _not_ handled automatically by _tlmgr_.
The name and location are fixed (for all practical purposes):
  *  Apple Mac OS X

    ~/Library/texmf
  *  Unix and GNU/Linux

    ~/texmf
  *  MS-Windows 95/XP/NT

    C:\texmf
  *  MS-Windows 2007 and above

    Computer\System\YOURNAME\texmf

Create that folder now if it does not already exist. Put (or unzip) all
additions to your system that are _not_ handled by _tlmgr_ into this
directory, following _exactly_ the subdirectory structure that is used
in your main TeX distribution (unzipping a TDS file does this for you).
This is what enables LaTeX to find stuff automatically.


> ####  If you are a Windows user running _MiKTeX_
> When you create the folder for your Personal TeX Directory, you MUST add it to _MiKTeX_ ’s list of supported folders. Run the _MiKTeX Maintenance/Settings_ program, select the `Roots` tab, and add the folder. You only have to do this once.
> > Each time you add or remove software in your Personal TeX Directory, you MUST then click on the `Update FNDB` button in the `General` tab of the _MiKTeX Maintenance/Settings_ program, otherwise _MiKTeX_ will not find them and nothing will work!
> 

Unix (Mac and GNU/Linux) users do not need to (indeed, should not) run
their filename database indexer program (_mktexlsr_ or _texhash_) for
files put into a personal TeX directory.


## Installation on shared systems

On multi-user systems (Unix-based), identify the shared local directory
tree with the command

    kpsewhich -expand-var '$TEXMFLOCAL'

This will give you the location of the shared `texmf` directory into
which you must unzip these files.

Do not forget to run your local TeX filename database indexer program
(_texhash_ or _mktexlsr_) after installation, otherwise the files will
not be found by LaTeX and nothing will work!


## Manual installation (non-TDS systems)

To install this software manually, download and unzip the _non-_TDS zip
file into a temporary directory and move the class and/or package
file[s] and other files to the proper locations where LaTeX will find
them on your system. This is referred to in some documentation as “the
`TEXINPUTS` directory”, although it may be called something else on your
system.

_It is your responsibility to know where this location is._ See the
question in the TeX FAQ at https://texfaq.org/FAQ-inst-wlcf.html for
more information. If you do not know, or cannot find it, or do not have
access to it, your TeX system may be out of date and may need replacing.



## Online systems and “last resort” systems

Some online LaTeX systems use CTAN, so a package from there should be
available on demand. For other online LaTeX systems where you do not
have access to the file system, unzip the _non-_TDS zip file into a
temporary directory and upload the files to the online system. Follow
their instructions for where to put them.

In an emergency, or as a last resort on unmanageable systems, it is
possible simply to put the class and/or package file[s] into your
current working directory (the same folder as your `.tex` file[s]).

While this may work, it is not supported, and may lead to other
resources (packages, fonts, images etc) not being found.


## Usage

Include the line shown below in the Preamble of your LaTeX document; a
`\documentclass` line should be at the top; a `\usepackage` command
normally goes anywhere in the Preamble:

    \documentclass[options]{veryshortguide}

(similarly for other classes or packages if more than one is supplied
with this package). Read the documentation for the options available, if
any. The documentation is distributed as a PDF document in the zip file.
You can also regenerate it by typesetting the `veryshortguide.dtx` file
with `xelatex` (and `` and _makeindex_) in the normal way.


## Bugs and TODO

No outstanding reported bugs at the time of this version.

For TODO items, see the PDF documentation.


## Copyright

The following statement is included in the source code:

     Transformed from veryshortguide.xml by ClassPack db2dtx.xsl
     version 1.19 (2020-05-19) on Thursday 21 May 2020 at 11:55:35
    
     veryshortguide.cls is copyright © 2009-2020 by Peter Flynn <peter@silmaril.ie>
    
     This work may be distributed and/or modified under the
     conditions of the LaTeX Project Public License, either
     version 1.3 of this license or (at your option) any later
     version. The latest version of this license is in:
    
         http://www.latex-project.org/lppl.txt
    
     and version 1.3 or later is part of all distributions of
     LaTeX version 2005/12/01 or later.
    
     This work has the LPPL maintenance status ‘maintained’.
     
     The current maintainer of this work is Peter Flynn <peter@silmaril.ie>
    
     This work consists of the files veryshortguide.dtx and veryshortguide.ins,
     the derived file , 
     and any other ancillary files listed in the MANIFEST.
    

