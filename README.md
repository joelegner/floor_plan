# floor_plan

> The purpose of this repository is to generate `floorplan.pdf` which is a plan view of my driveway before a garage sale.

Welcome to `floor_plan`! I am Joe Legner. The point of this repository is to explore what happens when we follow this dictum to the greatest extent:

> GALL'S LAW: Every complex system that works evolved from a simpler system that worked.

Using this as our premise, we have done only the following so far:

1. Written `floorplan.tex` file with Tikz drawing code.
2. Written a `Makefile`.

This gives us the following functionality:

```bash
% make
# Lots of messages
% open floorplan.pdf
# The floorplan.pdf file opens
```

This is a simple system, because it has only two parts: `floorplan.tex` and `Makefile`. It works, because it makes the `floorplan.pdf` file. 