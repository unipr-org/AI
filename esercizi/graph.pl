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

% ?- path(a, f, P).
% Il percorso che parte da X e arriva ad X è una lista formata solo da X se è un nodo
path(X, X, [X]) :- 
    node(X).

path(X, Y, [X | R]) :- 
    arc(X, Z), 
    path(Z, Y, R).

% ?- path(X, f, P), member(c, P).
% Se la lista intera inizia con X ci fermiamo
member(X, [X | _]). % Possiamo introdurre le variabili dummy per le variabili singleton

% Altrimenti andiamo a scorrere la lista controllando gli elementi successivi
member(X, [_ | R]) :-
    member(X, R).

% ?- path(X, f, P), member(c, P), len(P, 3).
% ?- path(X, f, P), member(c, P), len(P, N), N > 3
len([], 0).
len([_ | R], L) :-
    len(R, LR),
    L is 1 + LR.
    

