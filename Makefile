SRC := floorplan.tex
PDF := floorplan.pdf

.PHONY: all clean

all: $(PDF)

$(PDF): $(SRC)
	latexmk -pdf -interaction=nonstopmode $(SRC)

clean:
	latexmk -C $(SRC)
