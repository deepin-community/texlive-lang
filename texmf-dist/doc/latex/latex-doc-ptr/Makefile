# Makefile
#  For latex-doc-ptr.
# 2020-Dec-31 Jim Hefferon

latex-doc-ptr.pdf: latex-doc-ptr.tex latex-doc-ptr.sty dash.sty
	pdflatex --file-line-error --interaction=nonstopmode $<

latex-doc-ptr.html: latex-doc-ptr.tex latex-doc-ptr.sty dash.sty
	make4ht latex-doc-ptr.tex 
	cp latex-doc-ptr.css.replacement latex-doc-ptr.css
        # Get subsections headers
	awk -f massage_html.awk <latex-doc-ptr.html > latex-doc-ptr-massaged.html 
	# Correct lost ligatures (all very fragile, but I can't grok tex4ht)
	sed -e 's/>\Wname\W</>name</' \
            -e 's/also available o\W*ine/also available offline/' \
	    -e 's/\W*nd them by/find them by/' \
	    -e 's/uno\W*cial reference/unofficial reference/' \
	    -e 's/Many web pages o\W*er quick help with/Many web pages offer quick help with/' \
	    -e 's/You are likely to \W*nd an answer/You are likely to find an answer/' \
	    -e 's/has the latest o\W*cial versions/has the latest official versions/' \
	    -e 's/If you have trouble \W*nding something/\n<p>If you have trouble finding something/' \
	    -e 's/any document containing signi\W*cant amounts of mathematics/any document containing significant amounts of mathematics/' \
	    -e 's/control \W*oating environments/control floating environments/' \
	    -e 's/override automatic \W*oat placement/override automatic float placement/' \
	    -e 's/cause issues \W what if/cause issues\&nbsp;\&mdash; what if/' \
	    -e 's/left? \W but it/left?\&nbsp;\&mdash; but it/' \
	    -e 's/and \W*le paths that can break/and file paths that can break/' \
	    -e 's/The \W*rst/The first/' \
	    -e 's/which lets you de\W*ne your own/which lets you define your own/' \
	    -e 's/scienti\W*c units,/scientific units,/' \
	    -e 's/often want to generate \W*ller text./often want to generate filler text./' \
	    -e 's/give the \W*le name without/give the file name without/' \
	    -e 's/lists of \W*gures/lists of figures/' \
	    -e 's/to an external \W*le/to an external file/' \
	    -e 's/via a completely di\W*erent/via a completely different/' \
	    -e 's/as \W*la-tech\W* or \W*lay-tech,\W*/as \&apos;la-tech\&apos; or \&apos;lay-tech\&apos;, /' \
	    -e 's/as as \Wla-tech\W or \Wlay-tech,\W apos;la-techas \Wla-tech\W or \Wlay-tech,\W apos; or as \Wla-tech\W or \Wlay-tech,\W apos;lay-techas \Wla-tech\W or \Wlay-tech,\W apos;,/as \&apos;la-tech&apos; or \&apos;lay-tech\&apos;, /' \
	    -e 's/We prefer the \Wrst,/We prefer the first,/' \
	    -e 's/the \Wrst syllable./the first syllable./'  \
            < latex-doc-ptr-massaged.html > latex-doc-ptr-massaged-ligs.html
	# Correct lost paragraphs inside subsections
	sed -e 's/Many people use/<p>&/' \
	    -e 's/If you have trouble/<p>&/' \
	    -e 's/As referred to above,/<p>&/' \
	    -e 's/Also, include/<p>&/' \
	    -e 's/Enhance captions/<p>&/' \
	    -e 's/Get hyperlinks/<p>&/' \
	    -e 's/Inside verbatim/<p>&/' \
	    -e 's/If you use Python,/<p>&/' \
	    -e 's/Make boxes that/<p>&/' \
	    -e 's/Use <a/<p>&/' \
	    -e 's/Finally, when/<p>&/' \
	    -e 's/To include/<p>&/' \
	    -e 's/In your plots/<p>&/' \
	    -e 's/For footnotes,/<p>&/' \
	    -e 's/Bibliographies are/<p>&/' \
	    -e 's/There are many/<p>&/' \
	    -e 's/To make presentations,/<p>&/' < latex-doc-ptr-massaged-ligs.html > latex-doc-ptr-massaged-pars.html
	# Correct misc
	sed -e 's/X  E </Xe</' \
	    -e 's/Books  <\/span><p>/Books  <\/span>/' \
	    -e 's/filler text. <p>/filler text. /' \
        < latex-doc-ptr-massaged-pars.html > latex-doc-ptr-massaged-misc.html
	# Bring it back to latex-doc-ptr.html
	cp latex-doc-ptr-massaged-misc.html latex-doc-ptr.html 
	rm latex-doc-ptr-massaged-ligs.html \
           latex-doc-ptr-massaged-pars.html \
           latex-doc-ptr-massaged-misc.html

all: latex-doc-ptr.pdf latex-doc-ptr.html
