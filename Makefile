SRC := floor_plan.tex
PDF := floor_plan.pdf

.PHONY: all clean open

all: $(PDF)

$(PDF): $(SRC)
	latexmk -pdf -interaction=nonstopmode $(SRC)

clean:
	latexmk -C $(SRC)

open: $(PDF)
	open $(PDF)