% Conway Game of Life (Stack Overflow, 'magus' implementation)

% The life grid, 15x15
grid([
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,1,0,1,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,1,0,1,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
     ]
   ).

% Infinite generates sep with keystroke
% -------------------------------------
life(Grid) :-
    dumpgen(Grid),
    onegen(Grid, 0, NewGrid),
    get_single_char(_),
    life(NewGrid).


% Dumps a generation out
% ----------------------
dumpgen([]) :- nl.
dumpgen([H|T]) :-
    write(H), nl,
    dumpgen(T).

% Does one generation
% --------------------------------
onegen(_, 15, []).

onegen(Grid, Row, [NewRow|NewGrid]) :-
    xformrow(Grid, Row, 0, NewRow),
    NRow is Row + 1,
    onegen(Grid, NRow, NewGrid).

% Transforms one row
% --------------------------------
xformrow(_, _, 15, []).
xformrow(Grid, Row, Col, [NewState|NewList]) :-
    xformstate(Grid, Row, Col, NewState),
    NewCol is Col + 1,
    xformrow(Grid, Row, NewCol, NewList).


% Request new state of any cell
% --------------------------------
xformstate(Grid, Row, Col, NS) :-
    cellstate(Grid, Row, Col, CS),
    nextstate(Grid, Row, Col, CS, NS).

% Calculate next state of any cell
% --------------------------------

% Cell is currently dead
nextstate(Grid, Row, Col, 0, NS) :-
    neightotal(Grid, Row, Col, Total),
    (Total =:= 3 -> NS = 1 ; NS = 0).

% Cell is currently alive
nextstate(Grid, Row, Col, 1, NS) :-
    neightotal(Grid, Row, Col, Total),
    ((Total =:= 2; Total =:=3)
    -> NS = 1; NS = 0).

% State of all surrounding neighbours
%-------------------------------------
neightotal(Grid, Row, Col, TotalSum) :-

    % Immediately neighbours X, Y
    XM1 is Col - 1,
    XP1 is Col + 1,
    YM1 is Row - 1,
    YP1 is Row + 1,

    % State at all those compass points
    cellstate(Grid, YM1, Col, N),
    cellstate(Grid, YM1, XP1, NE),
    cellstate(Grid, Row, XP1, E),
    cellstate(Grid, YP1, XP1, SE),
    cellstate(Grid, YP1, Col, S),
    cellstate(Grid, YP1, XM1, SW),
    cellstate(Grid, Row, XM1, W),
    cellstate(Grid, YM1, XM1, NW),

    % Add up the liveness
    TotalSum is N + NE + E + SE + S + SW + W + NW.


% State at any given row/col - 0 or 1
% -----------------------------------
% Valid range, return it's state
cellstate(Grid, Row, Col, State) :-
    between(0, 14, Row),
    between(0, 14, Col),
    nth0(Row, Grid, RL),
    nth0(Col, RL, State).

% Outside range is dead
cellstate(_, _, _, 0).
