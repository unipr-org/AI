%
% dag.pl
%
% Traversal of a directed acyclic graph.
% 
% (c) 2022 Federico Bergenti
%

node(a).
node(b).
node(c).
node(d).
node(e).
node(f).
node(g).
node(h).
node(i).
node(j).
node(k).
node(l).
node(m).

arc(a, b).
arc(a, c).
arc(b, c).
arc(c, e).
arc(c, f).
arc(c, i).
arc(d, e).
arc(d, f).
arc(d, g).
arc(e, j).
arc(f, l).
arc(f, m).
arc(g, l).
arc(g, m).
arc(h, i).
arc(h, k).
arc(i, e).
arc(i, j).
arc(i, k).

path(X, X, [X]) :-
    node(X).
path(X, Y, [X | R]) :-
    arc(X, Z),
    path(Z, Y, R).
