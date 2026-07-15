PRO := floor_plan.pl
SRC := floor_plan.tex
PDF := floor_plan.pdf

.PHONY: all clean open

all: $(PDF)

$(SRC): $(PRO)
	swipl -g generate -t halt $(PRO)

$(PDF): $(SRC)
	latexmk -pdf -interaction=nonstopmode $(SRC)

clean:
	@rm -f $(SRC)
	@rm -f *.aux
	@rm -f *.fdb_latexmk
	@rm -f *.fls
	@rm -f *.log
	@rm -f *.swp

open: $(PDF)
	open $(PDF)
