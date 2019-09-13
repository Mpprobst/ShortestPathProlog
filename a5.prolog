/* Shortest Path */
/* By: Michael Probst */
/* These instructions give the shortest path in a directed graph */
/* Sample data
edge(a, x1, x2, 1) .
edge(b, x2, x3, 2) .
edge(c, x3, x1, -1) .
edge(d, x2, x5, 2) .
edge(e, x3, x4, 3) .
edge(f, x4, x2, -5) .
edge(g, x5, x4, -1) .
edge(h, x4, x5, 1) . 
*/

path(FromVertex, ToVertex, _, Weight):-
        edge(_, FromVertex, ToVertex, Weight), 
        Weight > 0.

path(FromVertex, ToVertex, Path, Weight) :-
        edge(Edge, FromVertex, NextVertex, W1),
        W1 > 0,
        path(NextVertex, ToVertex, [Edge|Path], W2),
        Weight is W1 + W2.

shortest(FromVertex, ToVertex, Path, Weight) :-
   setof([Path, Weight], path(FromVertex, ToVertex, Path, Weight), Set),
   Set = [_|_], /* fail if empty */
   minimal(Set,[Path, Weight]).

minimal([Head|Tail], Min) :- min(Tail, Head, Min).

min([], M, M).

min([[Path, Weight]|Rest], [_, M], Min):-
        Weight < M,
        !, /* prevents backtracking because we only want the shortest path */
        min(Rest, [Path, Weight],Min).

min([_|Rest], M, Min):-
        min(Rest, M, Min).
