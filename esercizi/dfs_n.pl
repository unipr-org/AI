% Realizzato da @manueldiagostino
% dfs_N() elenca i percorsi a profondità massima N.

:- use_module(library(clpfd)).

non_member(_, []) :-
    !.
non_member(X, [X | _]) :-
    !,
    fail.
non_member(X, [_ | T]) :-
    non_member(X, T).

children(G, Node, Children, CurrentChildren) :-
    member([Node, Y], G),
    non_member(Y, CurrentChildren),
    children(G, Node, Children, [Y | CurrentChildren]),
    !.
children(G, Node, CurrentChildren, CurrentChildren) :-
    member([Node, Y], G),
    member(Y, CurrentChildren),
    !.
children(_G, _Node, [], _).

dfs_N_rec(_G, N, [NextNode | Visited], [NextNode | _Nodes], Visited) :-
    non_member(NextNode, Visited),
    length(Visited,N).
dfs_N_rec(G, N, Path, [CurrNode | Nodes], Visited) :-
	member([CurrNode, Y], G),
    non_member(Y, Visited),
    children(G, CurrNode, Children, []),
    append(Children, Nodes, NewVisitQueue),
    dfs_N_rec(G, N, Path, NewVisitQueue, [CurrNode | Visited]).
dfs_N_rec(G, N, Path, [CurrNode, NextNode | Nodes], [LastVisited | Visited]) :-
    member([LastVisited, NextNode], G),
    member([LastVisited, CurrNode], G),
    dfs_N_rec(G, N, Path, [NextNode | Nodes], [LastVisited | Visited]).
    
dfs_N(G, Source, N, Path) :-
    dfs_N_rec(G, N, RPath, [Source], []),
    reverse(RPath, Path).
