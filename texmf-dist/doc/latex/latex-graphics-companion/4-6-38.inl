\usepackage {pstricks,pst-node,pst-tree}
\psset{labelsep=2pt,tnpos=a,radius=2pt}
\pstree[treemode=R]{\TC*~{25}}
{
\TC*~{5}~[tnpos=r]{$L_a$}
\taput{$a$}
\pstree{\TC*~{20}\tbput{$b$}}
 {
 \pstree{\TC*~{15}\taput{$a$}}
  {
   \TC*~{7}~[tnpos=r]{$L_{baa}$}\taput{$a$}
   \TC*~{5}~[tnpos=r]{$L_{bab}$}\taput{$b$}
   \TC*~{3}~[tnpos=r]{$L_{bac}$}\tbput{$c$}
  }
  \TC*~{5}~[tnpos=r]{$L_{bb}$}
  \tbput{$b$}
 }
}
