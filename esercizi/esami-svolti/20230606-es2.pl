% 2023-06-06 esercizio 2

:- use_module(library(clpfd)).

filter([], []).

filter([H | R], L2) :-
    H in 1..10, 
    filter(R, L2).

filter([H | R], [H, H | L2]) :-
    H in 11..20,
	filter(R, L2).

filter([H | R], [L | L2]) :-
    H in 21..30,
    L #= H + 1,
	filter(R, L2).

filter([H | R], [H | L2]) :-
    H in 31..50, 
    filter(R, L2).
