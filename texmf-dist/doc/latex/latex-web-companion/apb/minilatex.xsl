<?xml version='1.0'?>
<!-- minilatex.xsl --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns="http://www.tug.org/latex"
                default-space="strip"
                result-ns="">

<xsl:template name="label">
  <xsl:apply-templates/>
  <xsl:if test="../@id"><xsl:text>\label{</xsl:text>
  <xsl:value-of select="../@id"/><xsl:text>}</xsl:text></xsl:if>
<xsl:text>}
</xsl:text>
</xsl:template>

<xsl:template match="document">
<xsl:text>\documentclass[]{</xsl:text>
<xsl:value-of select="@class"/>
<xsl:text>}
\usepackage[dvips]{graphicx}
\usepackage[T1]{fontenc}
\begin{document}
</xsl:text>
<xsl:apply-templates/>
<xsl:text>\end{document}
</xsl:text>
</xsl:template>

<!--   ================ Frontmatter element ======================= -->
<xsl:template match="frontmatter">
  <xsl:apply-templates/>
<xsl:text>
\maketitle
</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/title">
<xsl:text>
\title{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/author">
<xsl:text>
\author{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}
</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/author/name">
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="frontmatter/author/thanks">
<xsl:text>
\thanks{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/author/inst">
<xsl:text>
\thanks{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/date">
<xsl:text>
\date{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}
</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/abstract">
<xsl:text>
\begin{abstract}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{abstract}
</xsl:text>
</xsl:template>
<xsl:template match="frontmatter/keywords">
<xsl:text>\keywords{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<!--   ===================== Bodymatter element =================== -->
<xsl:template match="bodymatter|part|chapter|section|subsection|
                     subsubsection|paragraph|subparagraph">
  <xsl:apply-templates/>
</xsl:template>
<!--   =================== Section headings ======================= -->
<xsl:template match="part/stitle">
  <xsl:text>\part{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="chapter/stitle">
  <xsl:text>\chapter{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="section/stitle">
  <xsl:text>\section{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="subsection/stitle">
  <xsl:text>\subsection{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="subsubsection/stitle">
  <xsl:text>\subsubsection{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="paragraph/stitle">
  <xsl:text>\paragraph{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="subparagraph/stitle">
  <xsl:text>\subparagraph{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<!--   ===================== Font changes ========================= -->
<xsl:template match="emph">
<xsl:text>\emph{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="textbf">
<xsl:text>\textbf{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="textsc">
<xsl:text>\textsc{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="textsf">
<xsl:text>\textsf{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="textsl">
<xsl:text>\textsl{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="texttt">
<xsl:text>\texttt{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<!--   =================== Cross-references ======================= -->
<xsl:template match="cite">
  <xsl:text>\cite{</xsl:text>
  <xsl:value-of select="@refid"/>
  <xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="pageref">
  <xsl:text>\pageref{</xsl:text>
  <xsl:value-of select="@refid"/>
  <xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="ref">
  <xsl:text>\ref{</xsl:text>
  <xsl:value-of select="@refid"/>
  <xsl:text>}</xsl:text>
</xsl:template>
<!--   =============== quotes, footnotes, verbatim ================ -->
<xsl:template match="footnote">
<xsl:text>\footnote{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="quote">
<xsl:text>
\begin{quote}</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{quote}</xsl:text>
</xsl:template>
<xsl:template match="quotation">
<xsl:text>
\begin{quotation}</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{quotation}</xsl:text>
</xsl:template>
<xsl:template match="verbatim">
<xsl:text>
\begin{verbatim}</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{verbatim}</xsl:text>
</xsl:template>
<!--   ========================= Lists ============================ -->
<xsl:template match="description">
<xsl:text>
\begin{description}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{description}
</xsl:text>
</xsl:template>
<xsl:template match="description/term">
<xsl:text>
\item[</xsl:text>
  <xsl:apply-templates/>
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="description/item">
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="enumerate">
<xsl:text>
\begin{enumerate}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{enumerate}
</xsl:text>
</xsl:template>
<xsl:template match="itemize">
<xsl:text>
\begin{itemize}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{itemize}
</xsl:text>
</xsl:template>
<xsl:template match="enumerate|itemize/item">
<xsl:text>
\item </xsl:text>
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="bibliography">
<xsl:text>
\begin{thebibliography}{99}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{thebibliography}
</xsl:text>
</xsl:template>
<xsl:template match="bibliography/bibitem">
<xsl:text>\bibitem{</xsl:text>
<xsl:value-of select="@id"/>
<xsl:text>}</xsl:text>
<xsl:apply-templates/>
</xsl:template>
<!--   ====================== Mathematics ========================= -->
<xsl:template match="inlinemath">
<xsl:text>$</xsl:text>
  <xsl:apply-templates/>
<xsl:text>$</xsl:text>
</xsl:template>
<xsl:template match="displaymath">
<xsl:text>
\begin{displaymath}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{displaymath}
</xsl:text>
</xsl:template>
<xsl:template match="equation">
<xsl:text>
\begin{equation}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{equation}
</xsl:text>
</xsl:template>
<xsl:template match="eqnarray">
<xsl:text>
\begin{eqnarray}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{eqnarray}
</xsl:text>
</xsl:template>
<!--   ====================== A paragraph ========================= -->
<xsl:template match="par">
<xsl:text>
\par
</xsl:text>
  <xsl:apply-templates/>
</xsl:template>
<!--   ======================== Tabular =========================== -->
<xsl:template match="tabular">
<xsl:text>
\begin{tabular}{</xsl:text>
  <xsl:value-of select="@preamble"/><xsl:text>}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{tabular}
</xsl:text>
</xsl:template>
<xsl:template match="tabular/row">  
<xsl:apply-templates/>
<xsl:text>\\
</xsl:text>
</xsl:template>
<xsl:template match="tabular/row/cell">  
<xsl:apply-templates/><xsl:text>&amp;</xsl:text>
</xsl:template>
<xsl:template match="tabular/row/cell[position()=last()]" priority="2">  
<xsl:apply-templates/>
</xsl:template>
<!--   ================== "floats" and their contents ============= -->
<xsl:template match="figure">
<xsl:text>
\begin{figure}\centering
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{figure}
</xsl:text>
</xsl:template>
<xsl:template match="table">
<xsl:text>
\begin{table}\centering
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{table}
</xsl:text>
</xsl:template>
<xsl:template match="figure/caption | table/caption">
  <xsl:text>\caption{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<!--   ==================== Includegraphics ======================= -->
<xsl:template match="includegraphics">
<xsl:text>
\includegraphics[</xsl:text>
<xsl:if test="@width"><xsl:text>width=</xsl:text>
    <xsl:value-of select="@width"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@height"><xsl:text>height=</xsl:text>
    <xsl:value-of select="@height"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@bb"><xsl:text>bb="</xsl:text>
    <xsl:value-of select="@bb"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@angle"><xsl:text>angle=</xsl:text>
    <xsl:value-of select="@angle"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@scale"><xsl:text>scale=</xsl:text>
    <xsl:value-of select="@scale"/><xsl:text></xsl:text></xsl:if>
<xsl:text>]{</xsl:text><xsl:value-of select="@file"/><xsl:text>}
</xsl:text>
</xsl:template>

</xsl:stylesheet>
