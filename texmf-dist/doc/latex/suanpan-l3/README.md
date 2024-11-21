The traditional Chinese 7-bids suanpan(abacus) package based on l3draw
=======

The `suanpan-l3` package is a traditional Chinese 7-bids abacus drawing package that utilizes l3draw and TikZ and is developed with Expl3. It can effectively manage both upper and lower bids, while also considering bottom bid, top bid, and hanging bid.

The `suanpan-l3` package offers a unique environment for drawing abacuses, denoted as `suanpan`. Within this environment, 8 specialized macros are available for the creation of abacuses. The `\rod` macro is used to lay out a single rod, while the `\rod*` macro draws a counting point on this rod's beam. The `\rods` macro is capable of laying out a set of rods. The `\bid` macro colors the specified bid. The `\bids` macro colors all inner bids that are near the beam, while the `\bids*` macro colors all outer bids that are far from the beam. The `\rodmark` mark the rod on beam. Lastly, the `\mkfame` macro is used to lay out the frame of an abacus.

At the same time, the `suanpan-l3` package offers customization options for abacus, including line width, draw color, fill color, bid space, rod space, etc. These can be configured through package options, `suanpan` environment options, or `\suanpanset` macro.

For further details and examples, please refer to the manual(in Chinese/English).

Contributing
------------

1. gitee repository:
   (1). repository: [suanpan](https://gitee.com/nwafu_nan/suan-pan)
   (2). Issues and PR: [issue](https://gitee.com/nwafu_nan/suan-pan/issues) or [pull request](https://gitee.com/nwafu_nan/suan-pan/pulls).

基于l3draw的中国传统7珠算盘LaTeX排版宏包
=======

`suanpan-l3`是一个基于l3draw和TikZ绘图宏包，用Expl3开发的中国传统7珠圆珠算盘排版宏包，它能够实现普通上珠、下珠和使用底珠、顶珠和悬珠的算盘排版。

`suanpan-l3`宏包提供了唯一的一个`suanpan`排版环境用于绘制需要排版的算盘，在该环境中使用专用命令`\rod`排版一个档位，`\rod*`命令排版带计位点的档位，`\rods`命令排版一组档位，`\bid`命令为指定的算珠进行着色，`\bids`命令为指定档位的内珠进行着色，`\bids*`命令为指定的档位的外珠进行着色，`\rodmark`命令用于为档位横梁添加标记，`\mkframe`命令排版算盘边框。

同时，`suanpan-l3`宏包还为算盘排版提供线宽、颜色、间距等**外观**设置选项，可以通过宏包选项、环境选项对其进行设置，也可以通过`\suanpanset`命令实现外观属性设置。

可以通过阅读宏包手册以了解该宏包更多的使用细节和使用样例。

##  参与贡献
---------------------

1. gitee仓库:
    (1). 仓库地址: [suanpan](https://gitee.com/nwafu_nan/suan-pan)
    (2). Issues and PR: [issue](https://gitee.com/nwafu_nan/suan-pan/issues) or [pull request](https://gitee.com/nwafu_nan/suan-pan/pulls).

Copyright and Licence
---------------------

    Copyright (C) 2020-2024 by Nan Geng <nangeng@nwafu.edu.cn>
    ----------------------------------------------------------------------

    This work may be distributed and/or modified under the
    conditions of the LaTeX Project Public License, either
    version 1.3c of this license or (at your option) any later
    version. This version of this license is in
       http://www.latex-project.org/lppl/lppl-1-3c.txt
    and the latest version of this license is in
       http://www.latex-project.org/lppl.txt
    and version 1.3 or later is part of all distributions of
    LaTeX version 2005/12/01 or later.

    This work has the LPPL maintenance status "maintained".

    The Current Maintainer of this work is Nan Geng.

    This package consists of suanpan-l3.sty, suanpan-l3.tex and README.md(this file),
                 and the derived files suanpan-l3.pdf with build.sh.
