# massage_html.awk
# Part of latex-doc-ptr
#   make4ht loses the subsection run-in headers.  It puts the resulting material
# on two lines.  So this small state machine passes through the .html file
# and creates subsection classes from paragraphs.
#
# 2020-Dec-31 Jim Hefferon

BEGIN { lastLine = ""}

# Look for second line of two-line patterns for subsections
/^class="Spectral-Bold-lf-t-1x-x-109">/ {
  if(lastLine == "<span ") {
      printf("<p class=\"subsection\">%s\n", lastLine)
  } else {
      print lastLine
  }
}

!/^class="Spectral-Bold-lf-t-1x-x-109">/ {
    print lastLine
}

{ lastLine = $0 }

END {print lastLine}

