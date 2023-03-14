all: presentation.pdf

#Use full directory names for inkscape compatibility on Mac
current_dir = $(shell pwd)

#temporarily deal with alias issue for inkscape on mac (due to zsh shell being new default but not used by make recipes)
INKSCAPE = /Applications/Inkscape.app/Contents/MacOS/inkscape

.PHONY: clean

%.pdf: %.tex 	
	pdflatex $< 2> /dev/null # Surpress warnings


SVG_FILES = $(wildcard $(current_dir)/slides/*.svg)
PDF_FILES = $(subst $(current_dir)/slides/,pdfs/,$(SVG_FILES:.svg=.pdf))
images: $(PDF_FILES)

presentation.pdf: images 

pdfs/%.pdf: $(current_dir)/slides/%.svg
	$(INKSCAPE) $< -T --export-dpi=600 --export-area-page --export-filename=$(current_dir)/$@ # Option -T turns text into paths 

clean:
	rm -f *.aux *.bbl *.log *.dvi *.nav *.out *.snm *~ *.toc *.pdf pdfs/*.pdf

print-%:
	@echo '$*=$($*)'

