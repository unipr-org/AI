:- use_module(library(clpfd)).
example(X, Y, Z):-
    Z+Y #< 10,
    X * Y #> 0.

% ?- example(X, Y, Z), X in (-5)..5, Y = 0, label([X]).
