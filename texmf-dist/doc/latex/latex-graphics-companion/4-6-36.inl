\usepackage {pstricks,pst-node,pst-tree}
\pstree[nodesep=2pt,
  levelsep=20pt]{\TR{grandfather}}
{\pstree{\TR{uncle}}{\TR{cousin}}
 \pstree{\TR{father}}
   {\pstree{\TR{brother}}{\TR{nephew}}
   \pstree{\TR{Me}}
     {\pstree{\TR{son}}{\TR{grandson}}
     }
   }
}
