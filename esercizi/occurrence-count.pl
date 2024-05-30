:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%% Conteggio delle occorrenze passato un termine 
% ?- count([a, b, c, a], a, R).

count([], _, 0) :- % caso base
    !.

count([X | T], X, R) :- % caso positivo
    count(T, X, R1),
    R #= R1 + 1,
    !.
    
count([_ | T], X, R) :- % caso negativo
    count(T, X, R).

%%%%%%%%%%%%%%%%%% Conteggio delle occorrenze passata una lista
% ?- count_all([a, b, c, a], [a, b, c], [2, 1, 1]).
% ?- count_all([a, b, c, a], [a, b, c], R).

count_all(Set, [X], [Result]) :- % caso base
    count(Set, X, Result),
    !.

count_all(Set, [H | Rest], [SingleResult | Result]) :-
    count(Set, H, SingleResult),
    count_all(Set, Rest, Result).
