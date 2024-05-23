:- use_module(library(clpfd)).

% esmpio semplice di vincoli
example(X, Y, Z):-
    Z+Y #< 10,
    X * Y #> 0.


% goal
% ?- example(X, Y, Z), X in (-5)..5, Y = 0, label([X]).
