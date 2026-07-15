SRC := floorplan.tex
PDF := floorplan.pdf

.PHONY: all clean open

all: $(PDF)

$(PDF): $(SRC)
	latexmk -pdf -interaction=nonstopmode $(SRC)

clean:
	latexmk -C $(SRC)

open: $(PDF)
	open $(PDF)