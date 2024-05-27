%% Realizzato da @manueldiagostino
% 
% Il predicato bfs(Source, Result) visita l'albero con sorgente Source tramite
% una visita in ampiezza (BFS); Result contiene l'elenco dei nodi attraversati.
% Il predicato bfs_level(Source, Result) visita l'albero suddividendolo per
% livelli; Result contiene la lista di tutti i livelli trovati.

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

non_member(_, []) :- 
    !.
non_member(X, [X | _]) :-
    !,
    fail.
non_member(X, [_ | R]) :-
    non_member(X, R).

append_([], L, L).
append_([H | R], Elem, [H | NewR]) :-
    append_(R, Elem, NewR).

reverse([],[]).
reverse([H | R], Reversed) :-
    reverse(R, ReversedTail),
    append_(ReversedTail, [H], Reversed).


% accodo solo quando Next non è ancora presente nella coda
enqueue_rec(Source, Queue, Result) :-
    arc(Source, Next),
    non_member(Next, Queue),
    enqueue_rec(Source, [Next | Queue], Result).
% se Next è presente, vuole dire che ho già accodato tutti
enqueue_rec(Source, Queue, Result) :-
    arc(Source, Next),
    member(Next, Queue),
    reverse(Queue, Result).

enqueue(Source, Result) :-
    enqueue_rec(Source,[],Result),
    !.
enqueue(S, []) :-
    node(S).


bfs_rec([], NodeList, NodeList).
bfs_rec([CurrNode | VisitQueue], NodeList, Result) :-
    enqueue(CurrNode, Children),
    append_(VisitQueue, Children, NewVisitQueue),
    append_(NodeList, Children, NewNodeList),
    bfs_rec(NewVisitQueue, NewNodeList, Result),
    !.

bfs(Source, Result) :-
    bfs_rec([Source], [Source], Result).
