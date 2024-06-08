% min_path(Graph, Source, Destination, MinPath).
% dove Graph è una lista di archi [[a,b],[b,c], ...].
% Possono essere presenti i cicli.
%
% Goal:
% G=[[a,b], [a,c], [b,d], [d,e], [c,e], [a,e], [b,h], [e,h]],
% min_path(G, a, h, Path).

:- use_module(library(clpfd)).

non_member(_,[]) :-
    !.
non_member(X, [X | _]) :-
    !,
    fail.
non_member(X, [Y | R]) :-
    X \= Y,
    non_member(X, R).

shorter_rec([], CurrMin, CurrMin).
shorter_rec([H | T], CurrMin, Res) :-
    length(H, HLen),
    length(CurrMin, CurrMinLen),
    HLen #< CurrMinLen,
    shorter_rec(T, H, Res),
    !.
shorter_rec([H | T], CurrMin, Res) :-
    length(H, HLen),
    length(CurrMin, CurrMinLen),
    HLen #>= CurrMinLen,
    shorter_rec(T, CurrMin, Res).

shorter([H | T], Res) :-
    shorter_rec(T, H, Res).
    

children(G, Node, []) :-
    non_member([Node, _], G),
    !.
children(G, Node, [Next | Children]) :-
    member([Node, Next], G),
    subtract(G, [[Node,Next]], GRest),
    children(GRest, Node, Children).

expand_dfs(G, Node, VisitQueue, NewVisitQueue) :-
    children(G, Node, Children),
    append(Children, VisitQueue, NewVisitQueue).

path_rec(G, Destination, Path, [CurrNode | Nodes], Visited) :-
    expand_dfs(G, CurrNode, Nodes, NewVisitQueue),
    non_member(Destination, NewVisitQueue), % se non raggiungo destinazione con una espansione
    path_rec(G, Destination, Path, NewVisitQueue, [CurrNode | Visited]).
path_rec(G, Destination, Path, [CurrNode | Nodes], Visited) :-
    expand_dfs(G, CurrNode, Nodes, NewVisitQueue),
		member(Destination, NewVisitQueue),
    ReversePath = [Destination, CurrNode | Visited],
    reverse(ReversePath, Path).

min_path_rec(G, Source, Destination, Paths, MinPath) :-
    path_rec(G, Destination, Path, [Source], []),
    non_member(Path, Paths),
    min_path_rec(G, Source, Destination, [Path | Paths], MinPath),
		!.
min_path_rec(_G, _Source, _Destination, Paths, MinPath) :-
    shorter(Paths, MinPath).

min_path(G, Source, Destination, MinPath) :-
    min_path_rec(G, Source, Destination, [], MinPath).
