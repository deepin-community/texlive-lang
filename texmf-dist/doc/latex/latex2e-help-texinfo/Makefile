# $Id: Makefile 1142 2023-01-11 16:09:29Z karl $
# Public domain.  Originally written 2006, Karl Berry.
# Makefile for latexrefman.

en_tex_output = latex2e.dvi latex2e.pdf
es_tex_output = latex2e-es.dvi latex2e-es.pdf
fr_tex_output = latex2e-fr.dvi latex2e-fr.pdf
#
xref_suffixes := ky cp vr fn cp pg tp
xref_suffixes := $(xref_suffixes) $(addsuffix s,$(xref_suffixes))
xref_suffixes := aux log toc $(xref_suffixes)
mi_suffixes = dbk html info txt xml
en_mi_output = $(addprefix latex2e., $(mi_suffixes))
es_mi_output = $(addprefix latex2e-es., $(mi_suffixes))
fr_mi_output = $(addprefix latex2e-fr., $(mi_suffixes))
#
all_suffixes = dvi pdf $(mi_suffixes)


#  how to build.
# 
texi2dvi = texfot texi2dvi --batch --tidy --build-dir=$*.t2dvi
texi2pdf = texfot texi2pdf --batch --tidy --build-dir=$*.t2pdf
#
makeinfo = makeinfo
texi2docbook = $(makeinfo) --docbook
texi2html = $(makeinfo) --no-split $(htmlopts)
texi2info = $(makeinfo) --no-split
texi2txt = $(makeinfo) --plaintext --no-split
texi2xml = $(makeinfo) --xml
#
htmlopts = --html $(html_css) $(t2html_top) $(t2html_home) $(html_pagewords)
#
html_css = --css-include=latex2e.css
#
# Nodes must be larger than this to get navigation panel at bottom of
# page; default is 300.
html_pagewords = -c WORDS_IN_PAGE=10000
#
# Go somewhere useful from Top:
t2html_top = -c TOP_NODE_UP_URL=https://tug.org/texinfohtml/
#
# Put a link in the footer:
t2html_home = -c PRE_BODY_CLOSE="<hr/><div class='referenceinfo'>\
<a href='https://latexref.xyz/'>\
<i>Unofficial LaTeX2e reference manual</i></a></div>"

%.pdf: %.texi
	$(texi2pdf) $<
%.dvi: %.texi
	$(texi2dvi) $<
#
%.dbk: %.texi
	$(texi2docbook) -o $@ $<
%.html: %.texi latex2e.css
	$(texi2html) $<
%.info: %.texi
	$(texi2info) $<
%.txt: %.texi
	$(texi2txt) -o $@ $<
%.xml: %.texi
	$(texi2xml) $<


#  targets follow.
#
default: check-en

# to test changes, build a subset: html and info (since these formats
# exercise significantly different code paths), and pdf for tex.
check_suffixes = html info pdf
#
check-en: spell-en $(addprefix latex2e., $(check_suffixes))
check-es: $(addprefix latex2e-es., $(check_suffixes))
check-fr: $(addprefix latex2e-fr., $(check_suffixes))
check: check-en check-es check-fr

# Build per language.
en: $(en_mi_output) $(en_tex_output)
es: $(es_mi_output) $(es_tex_output)
fr: $(fr_mi_output) $(fr_tex_output)

# To build everything in all languages.
all: en es fr

# Sort of following the GNU sequence of clean targets.
distclean clean mostlyclean:
	rm -rf latex2e*.t2* latex2e-help-texinfo-tree*

realclean maintainer-clean: distclean
	rm -f $(addprefix latex2e*., pdf dvi $(mi_suffixes) $(xref_suffixes))


#  Basic dist target for CTAN, but please see ./README
# for all the necessary steps.
# 
txt_files = ChangeLog Makefile NEWS README \
            aspell.en.pws latex2e.css ltx-help.el
# html_files = index.html mirroring.html writing.html 
figure_files = list.eps list.pdf list.png list.txt
figure_source_files = asy/list.asy
distname = latex2e-help-texinfo
distzip = $(distname).zip
#
htmlsplit = $(distname)-tree
htmlsplitzip = $(htmlsplit).zip
#
dist: en es
	rm -rf $(distname)
	mkdir $(distname) && cd $(distname) && ln -s ../* .
	mkdir $(distname)/spanish && cd $(distname)/spanish && ln -s ../../* .
	rm -f $(distzip)
	zip -q $(distzip) \
$(addprefix $(distname)/, $(txt_files) \
latex2e.texi common.texi $(en_mi_output) latex2e.pdf) \
$(addprefix $(distname)/spanish/,  $(es_mi_output) latex2e-es.pdf) \
$(addprefix $(distname)/latex2e-figures/,  $(figure_files)) \
$(addprefix $(distname)/graphics/,  README $(figure_source_files))
	rm -f $(htmlsplitzip)
	cd $(htmlsplit) && zip -qr ../$(htmlsplitzip) latex2e 
	zip -q $(distzip) $(distname)
	@ls -l $(distzip); unzip -l $(distzip)

easyurls: htmlsplit dist
	cd src \
        && rm -rf testdist && mkdir -p testdist \
        && cp ../latex2e-help-texinfo-tree.zip testdist \
        && rm -rf latex2e && unzip -q testdist/latex2e-help-texinfo-tree \
        && $(easyurls_python) ./easyurls.py $(easyurls_opt) \
        && zip -rq ../latex2e-help-texinfo-tree-easyurls.zip latex2e

easyurls_python = python3.6 # depends on bs4 (beautifulsoup4)
easyurls_opt = --directory latex2e --action softlink --lower_case --rewrite_index --debug

# To update web site, after basic build is ok (check-dw, spelling, etc.),
# first undo temporary build results:
#   make svr       # revert generated single files
#   make svrsplit  # revert generated split html
# then update ChangeLog, etc.,
# then svn commit the modified source files,
# then:
#   make
#   make htmlsplit
#   make dist
#   make easyurls     # depends htmlsplit and dist
#   make commitready  # many files will have status ! 
#   svn commit        # to commit regenerated files   
# then:
#   svn update     # restore easy url stubs
#   make svrsplit  # restore generated split html
#
# If uploading to CTAN:
#   (update NEWS, write announcement)
#   upload latex2e-help-texinfo.zip
#
# Clean up:
#   rm -rf src/testdist src/latex2e
#   rm -rf latex2e-help-texinfo   
#   rm latex2e-help-texinfo-tree{,-easyurls}.zip   
#   rm latex2e-help-texinfo.zip   

# In Texinfo 7.0, the default output directory changed to foo_html.
# Change it back.
html_split_opts = $(htmlopts) -o latex2e

# Get many small .html files.
htmlsplit: en
	rm -rf $(htmlsplit)
	mkdir $(htmlsplit) && cd $(htmlsplit) && ln -s ../* .	
	cd $(htmlsplit) && $(makeinfo) $(html_split_opts) latex2e.texi
	cd $(htmlsplit)/latex2e && ln -s ../../latex2e-figures .

# Right before a commit, delete html files that are gone and add new ones.
htmlsplitstatus = cd $(htmlsplit)/latex2e && svn status *.html
commitready: htmlsplit
	$(htmlsplitstatus) | sed -n 's/^\!//p' | xargs -r svn rm
	$(htmlsplitstatus) | sed -n 's/^\?//p' | xargs -r svn add
# we linked everything above, remove the unused upper-level links.
	cd $(htmlsplit) && svn status | sed -n 's/^\?//p' | xargs rm -f
	rm -rf latex2e.t2dvi # fix requires rebuilding svn repo, it seems
	svn status

# A hacky spell check target.
# Remove \commandnames to reduce exception list, but not {args} or
# [args], since they are often words.
spell spell-en:
	sed -e 's/\\[a-zA-Z]*//g' latex2e.texi \
	| aspell list --mode=texinfo --add-extra-dicts=`pwd`/aspell.en.pws \
        | sort -f -u

# Check for doubled words.
# http://www.math.utah.edu/~beebe/software/file-tools.html#dw
# The first sed expression elides a few @-command lines which cause
# duplicates; the second expr some text in the middle of lines.
check-dw:
	sed -e 's/^@\(node\|item\|anchor\|.index\|.*section\) .*//' \
	    -e 's/ da da\|xxx\|overwrite\|{test test}\|[iI][jJ]//g' \
	  latex2e.texi | dw

# Convenience targets to svn revert the generated files,
# and svn diff the source files.
svr:
	svn revert $(addprefix latex2e*., $(all_suffixes))
	svn status
svrsplit:
	svn revert --depth infinity $(htmlsplit)
svd:
	svn diff $(txt_files) *.texi
