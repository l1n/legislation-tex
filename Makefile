LATEX = `which latex`
PDFLATEX = `which pdflatex`

PDFFILES = legislation.pdf
DVIFILES = legislation.dvi
ALLFILES = $(PDFFILES) $(DVIFILES)

main:	$(PDFFILES)

pdf:	main

all:	$(ALLFILES)

%.pdf:	%.tex
	$(PDFLATEX) $<
	$(PDFLATEX) $< # Run twice for pagewise lineno

clean:
	git clean -f
