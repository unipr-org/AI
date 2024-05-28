% Realizzato da @manueldiagostino
% Implementare la visita in profondità (DFS)

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

arc(a, b).
arc(a, c).
arc(b, e).
arc(b, f).
arc(b, g).
arc(c, h).
arc(c, i).
arc(i, j).
arc(i, k).

concat([], L, L).
concat([H | R], L, [H | NewResult]) :-
    concat(R, L, NewResult).

reverse_([], []).
reverse_([H | R], Result) :-
    reverse_(R, RReverse),
    concat(RReverse, [H], Result).

non_member(_, []) :- !.
non_member(X, [X | _]) :-
    !,
    fail.
non_member(X, [_ | R]) :-
    non_member(X, R).

get_children_rec(X, Children, Result) :-
    arc(X,Y),
    non_member(Y, Children),
    get_children_rec(X, [Y | Children], Result),
    !.
get_children_rec(X, Children, Children) :-
    arc(X,Y),
    member(Y, Children).
get_children_rec(_, Children, Children).

get_children(X, Result) :-
    get_children_rec(X, [], Result).

dfs_rec([], VisitedNodes, VisitedNodes).
dfs_rec([CurrNode | Nodes], VisitedNodes, Result) :-
    get_children(CurrNode, Children),
    concat(Children, Nodes, VisitQueue),
    dfs_rec(VisitQueue, [CurrNode | VisitedNodes], Result).

dfs(Source, NodeList) :-
		node(Source),
    dfs_rec([Source], [], NodeList).
