all: presentation.pdf


.PHONY: clean

%.pdf: %.tex 	
	pdflatex $< 2> /dev/null # Surpress warnings


SVG_FILES = $(wildcard ./slides/*.svg)
PDF_FILES = $(subst ./slides/,pdfs/,$(SVG_FILES:.svg=.pdf))
$(info    SVG_FILES: $(SVG_FILES))
$(info    PDF_FILES: $(PDF_FILES))
images: $(PDF_FILES)

presentation.pdf: images 

pdfs/%.pdf: ./slides/%.svg
	inkscape $< -T --export-dpi=600 --export-area-page --export-filename=./$@ # Option -T turns text into paths 

clean:
	rm -f *.aux *.bbl *.log *.dvi *.nav *.out *.snm *~ *.toc *.pdf pdfs/*.pdf

print-%:
	@echo '$*=$($*)'

