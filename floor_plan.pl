% floor_plan.pl
% Generates floor_plan.tex (a TikZ site/floor plan, 1/4" = 1'-0",
% on an 8.5in x 11in sheet) from a set of geometry facts.
%
% Run with:  swipl -g generate -t halt floor_plan.pl
% or from the toplevel:  ?- consult('floor_plan.pl'), generate.

:- module(floor_plan, [generate/0, generate/1]).

% ============================================================
% 1. GEOMETRY DATA  (page inches — these replace the \def's)
% ============================================================

% -- horizontal reference values --
drive_lx(2.0).          % left edge of driveway
drive_rx(6.5).           % right edge of driveway
drive_cx(4.25).          % driveway centerline
side_main_w(1.0).        % width of the two sidewalks by the street
side_low_w(0.75).        % width of the lower-left sidewalk
flare_out(0.5).          % each flare kicks out this much beyond the driveway edge

% -- vertical reference values (measured up from the garage line) --
garage_y(0.4).
street_y(10.4).          % garage + 10in driveway length
side_main_y(7.4).        % 7in from garage
side_low_y(1.4).         % 1in from garage
table_n_cy(6.4).         % north table centerline, 6in from garage
plywood_cy(4.4).         % plywood centerline, 4in from garage
table_s_cy(2.4).         % south table centerline, 2in from garage

% -- item sizes --
table_w(0.625).          % 5/8in
table_h(1.5).
ply_w(2.0).
ply_h(1.0).

% -- labels / metadata --
street_name('WALSINGHAM WAY').
scale_label('1/4" = 1\'-0"').
plan_date('7/15/2026').
note_teal_rgb(173, 216, 213).

% ============================================================
% 2. DERIVED GEOMETRY
%    (arithmetic that the .tex did inline via \def expressions
%    like \sideMainY+\sideMainW is made explicit here instead)
% ============================================================

side_main_top(Y) :- side_main_y(Y0), side_main_w(W), Y is Y0 + W.
side_low_top(Y)  :- side_low_y(Y0),  side_low_w(W),  Y is Y0 + W.

flare_left_x(X)  :- drive_lx(L), flare_out(F), X is L - F.
flare_right_x(X) :- drive_rx(R), flare_out(F), X is R + F.

% bounding box (min/max corner) for a table/plywood item centered at (Cx,Cy)
item_box(Cx, Cy, W, H, x0(X0), y0(Y0), x1(X1), y1(Y1)) :-
    X0 is Cx - W/2, X1 is Cx + W/2,
    Y0 is Cy - H/2, Y1 is Cy + H/2.

% ============================================================
% 3. EMITTERS  (one predicate per drawing section)
%    Each takes the output Stream and writes its TikZ chunk.
% ============================================================

write_preamble(S) :-
    format(S, "\\documentclass[letterpaper]{article}~n", []),
    format(S, "\\usepackage[paperwidth=8.5in,paperheight=11in,margin=0in]{geometry}~n", []),
    format(S, "\\usepackage{tikz}~n", []),
    format(S, "\\usetikzlibrary{arrows.meta}~n", []),
    format(S, "\\pagestyle{empty}~n~n", []),
    format(S, "\\begin{document}~n", []),
    format(S, "\\begin{tikzpicture}[x=1in,y=1in,line join=round,line cap=round]~n~n", []).

write_street(S) :-
    street_y(Sy),
    street_name(Name),
    format(S, "  % ---- street ----~n", []),
    format(S, "  \\draw[thick] (0.2,~w) -- (8.3,~w);~n", [Sy, Sy]),
    Label is Sy + 0.22,
    format(S, "  \\node[font=\\bfseries] at (4.25,~w) {~w};~n~n", [Label, Name]).

write_driveway(S) :-
    drive_lx(Lx), drive_rx(Rx), garage_y(Gy),
    side_main_top(Top), street_y(Sy),
    flare_left_x(FLx), flare_right_x(FRx),
    format(S, "  % ---- driveway verticals + flares ----~n", []),
    format(S, "  \\draw[thick] (~w,~w) -- (~w,~w);~n", [Lx, Gy, Lx, Top]),
    format(S, "  \\draw[thick] (~w,~w) -- (~w,~w);~n", [Rx, Gy, Rx, Top]),
    format(S, "  \\draw[thick] (~w,~w) -- (~w,~w);~n", [Lx, Top, FLx, Sy]),
    format(S, "  \\draw[thick] (~w,~w) -- (~w,~w);~n~n", [Rx, Top, FRx, Sy]).

write_garage(S) :-
    drive_lx(Lx), drive_rx(Rx), drive_cx(Cx), garage_y(Gy),
    LabelY is Gy - 0.07,
    format(S, "  % ---- garage line ----~n", []),
    format(S, "  \\draw[thick] (~w,~w) -- (~w,~w);~n", [Lx, Gy, Rx, Gy]),
    format(S, "  \\node[font=\\bfseries] at (~w,~w) {GARAGE};~n~n", [Cx, LabelY]).

% One sidewalk "bracket": two parallel ticks + a cross-bar, with a
% rotated label offset to one side. Side = left/right selects which
% way the label offsets, since left sidewalks label to the left and
% right sidewalks label to the right.
write_sidewalk_bracket(S, InnerX, Y0, W, Side) :-
    (   Side == left
    ->  OuterX is InnerX - W,
        LabelX is OuterX - 0.25
    ;   OuterX is InnerX + W,
        LabelX is OuterX + 0.25
    ),
    Y1 is Y0 + W,
    TickY0 is Y0 - 0.1,
    TickY1 is Y1 + 0.1,
    LabelY is Y0 + W/2,
    format(S, "  \\draw (~w,~w) -- (~w,~w);~n", [OuterX, Y0, InnerX, Y0]),
    format(S, "  \\draw (~w,~w) -- (~w,~w);~n", [OuterX, Y1, InnerX, Y1]),
    format(S, "  \\draw (~w,~w) -- (~w,~w);~n", [OuterX, TickY0, OuterX, TickY1]),
    format(S, "  \\node[rotate=90,font=\\small] at (~w,~w) {SIDEWALK};~n", [LabelX, LabelY]).

write_sidewalks(S) :-
    drive_lx(Lx), drive_rx(Rx),
    side_main_y(MainY), side_main_w(MainW),
    side_low_y(LowY),  side_low_w(LowW),
    format(S, "  % ---- sidewalks ----~n", []),
    write_sidewalk_bracket(S, Lx, MainY, MainW, left),
    nl(S),
    write_sidewalk_bracket(S, Rx, MainY, MainW, right),
    nl(S),
    write_sidewalk_bracket(S, Lx, LowY, LowW, left),
    nl(S).

write_item_box(S, Cx, Cy, W, H, Label) :-
    item_box(Cx, Cy, W, H, x0(X0), y0(Y0), x1(X1), y1(Y1)),
    format(S, "  \\draw[fill=noteteal] (~w,~w) rectangle (~w,~w);~n", [X0, Y0, X1, Y1]),
    format(S, "  \\node[rotate=90,font=\\small] at (~w,~w) {~w};~n", [Cx, Cy, Label]).

write_items(S) :-
    note_teal_rgb(R, G, B),
    format(S, "  % ---- items on the driveway ----~n", []),
    format(S, "  \\definecolor{noteteal}{RGB}{~w,~w,~w}~n~n", [R, G, B]),
    drive_cx(Cx),
    table_w(TW), table_h(TH), ply_w(PW), ply_h(PH),
    table_n_cy(NCy), plywood_cy(PCy), table_s_cy(SCy),
    write_item_box(S, Cx, NCy, TW, TH, 'WHITE TABLE'),
    nl(S),
    % plywood uses a two-line centered label, so it's written directly
    item_box(Cx, PCy, PW, PH, x0(X0), y0(Y0), x1(X1), y1(Y1)),
    format(S, "  \\draw[fill=noteteal] (~w,~w) rectangle (~w,~w);~n", [X0, Y0, X1, Y1]),
    format(S, "  \\node[font=\\small,align=center] at (~w,~w) {PLYWOOD ON\\\\SAWHORSES};~n~n", [Cx, PCy]),
    write_item_box(S, Cx, SCy, TW, TH, 'WHITE TABLE'),
    nl(S).

write_title_block(S) :-
    scale_label(Scale), plan_date(Date),
    format(S, "  % ---- title block: scale + date ----~n", []),
    format(S, "  \\node[anchor=west] at (0.3,10.75) {~w};~n", [Scale]),
    format(S, "  \\node[anchor=east] at (8.2,10.75) {~w};~n~n", [Date]).

write_north_arrow(S) :-
    format(S, "  % ---- north arrow ----~n", []),
    format(S, "  \\draw[thick,-{Latex[length=3mm]}] (7.9,10.45) -- (7.9,10.75);~n", []),
    format(S, "  \\node[font=\\bfseries] at (7.9,10.9) {N};~n~n", []).

write_postamble(S) :-
    format(S, "\\end{tikzpicture}~n", []),
    format(S, "\\end{document}~n", []).

% ============================================================
% 4. TOP-LEVEL DRIVER
% ============================================================

%! generate is det.
%  Writes floor_plan.tex in the current directory.
generate :-
    generate('floor_plan.tex').

%! generate(+Path) is det.
%  Writes the generated TikZ document to Path.
generate(Path) :-
    setup_call_cleanup(
        open(Path, write, S),
        emit_document(S),
        close(S)
    ),
    format("Wrote ~w~n", [Path]).

emit_document(S) :-
    write_preamble(S),
    write_street(S),
    write_driveway(S),
    write_garage(S),
    write_sidewalks(S),
    write_items(S),
    write_title_block(S),
    write_north_arrow(S),
    write_postamble(S).