(TeX-add-style-hook
 "matapli-doc"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("crop" "cam" "a4" "center")))
   (TeX-run-style-hooks
    "latex2e"
    "mataplidoc"
    "mataplidoc10"
    "multicol"
    "pdfpages"
    "matapli"
    "matapli10"
    "crop"
    "LobsterTwo")
   (TeX-add-symbols
    "MatapliChapterFont")
   (LaTeX-add-labels
    "sec:exemples"
    "sec:titre"
    "sec:printauthors"
    "sec:encart"
    "sec:section")
   (LaTeX-add-bibliographies
    "bibliomatapli"
    "Monfichier"))
 :latex)

