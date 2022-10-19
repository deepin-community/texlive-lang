vardef LATEX primary s =
  write "verbatimtex" to "mptextmp.mp";
  write "%&latex" to "mptextmp.mp";
  write "\documentclass[]{article}" to "mptextmp.mp";
  write "\usepackage{ProfCollege}" to "mptextmp.mp";
  write "\usepackage[utf8]{inputenc}" to "mptextmp.mp";
  write "\usepackage[T1]{fontenc}" to "mptextmp.mp";
  write "\usepackage{fourier}" to "mptextmp.mp";
  write "\usepackage[french]{babel}" to "mptextmp.mp";
  write "\begin{document}" to "mptextmp.mp";
  write "etex" to "mptextmp.mp";
  write "btex "&s&" etex" to "mptextmp.mp";
  write EOF to "mptextmp.mp";
  scantokens "input mptextmp"
enddef;
