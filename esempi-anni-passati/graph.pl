%
% graph.pl
%
% Traversal of a directed graph (not necessarily acyclic).
% 
% (c) 2022 Federico Bergenti
%

node(a).
node(b).
node(c).

arc(a, a).
arc(a, b).
arc(b, c).
arc(c, a).

path(X, Y, P) :-
    path1(X, Y, [], P).

path1(_, X, V, _) :- 
    member(X, V), 
    !, 
    fail.
path1(X, X, V, [X | V]) :-
    node(X).
path1(Y, X, V, R) :-
    arc(Z, X),
    path1(Y, Z, [X | V], R).
