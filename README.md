# floor_plan

Welcome to `floor_plan`! I am Joe Legner. This project is an experiment to see what happens when we start with a project that "works" and evolve it by following Gall's Law. The software is sort of incidental to this experiment. But it still needs a purpose to exist. The purpose of the software is to generate a file called `floor_plan.pdf`. The PDF is a plan view of my driveway with three tables set up for a garage sale we are planning. 

> [!IMPORTANT]
> This project shall follow **Gall's Law**, which states, "Every complex system that works evolved from a simpler system that worked."

## Version 0 (Superseded)

_When was Version 0 released?_

Wednesday, July 15, 2026.

_When was Version 0 superseded?_

Wednesday, July 15, 2026.

_What was Version 0?_

Version 0 of the `floor_plan` project was a paper floor plan drawn by Joe Legner on 1/8-inch grid graph paper at a scale of 1/4"=1'-0". This has been superseded by Version 1. 

_What good was Version 0?_

Version 0 worked. That means it was able to be extended, so it became the working system to start the wheel of Gall's Law rolling. The next thing to be done was to write Version 1 on the computer. That's where we turn our attention next in this exciting `README.md` file.

## Current Version 1 (Released)

_When was Version 1 released?_

Wednesday, July 15, 2026.

_How is Version 1 documented?_

There is a tag called "Version 1".

_How did Version 1 get tagged like this?_

```bash
% git tag -a v1.0 -m "Version 1"
% git push origin --tags
```

_What is the function of Version 1?_

The function of Version 1 is to generate a file called `floor_plan.pdf` at the command line.

> [!NOTE]
> This is all Version 1 does: It makes a file called `floor_plan.pdf`. When we say things like "Version 1 works", that means "Version 1 makes a file called `floor_plan.pdf`."

_What does this look like in practice?_

```bash
% git clone https://github.com/joelegner/floor_plan/
% cd floor_plan
% make open
# Lots of messages
# The floor_plan.pdf file opens
```

We will call the present system Version 1. Version 1 has just four (4) parts. 

1. This `README.md` file.
2. A `LICENSE` file containing GNU Affero General Public License v3.0.
3. The `floor_plan.tex` file with Tikz drawing code.
4. A `Makefile`.
5. A `.gitignore` file to avoid tracking LaTeX cruft.

> [!TIP]
> It is possible to give people nicely formatted tips. 

_Where can I learn more about the license?_

https://choosealicense.com/licenses/agpl-3.0/

Version 1 works. 

_How do I install Version 1?_

At a command terminal:

```bash
% git clone https://github.com/joelegner/floor_plan/
% cd floor_plan
```
_How do I run Version 1?_

At a command terminal:

```bash
% make open
```

## Future Version 2 (Planned)

> [!CAUTION]
> Version 2 is not yet implemented.

Version 2 is the next iteration. It may have five (5) or more parts. It must work.

_What counts as Version 2 "working"?_

Generate the `floor_plan.tex` file from a new `floor_plan.pl` Prolog source file.

_What are the goals for Version 2?_

1. Update the `Makefile` to work with `floor_plan.pl`.
2. Fix the word "GARAGE" printing off the page.
3. Move the North Arrow to some greener pasture.
