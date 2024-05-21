% Realizzato da: Manuel Di Agostino
% 
% Creare una funzione `extract` per estrarre da
% una lista di nomi tutti quelli singolari
% o plurali.

sing(X) :-
    member(X, [il,lo,la,cane,cavallo,scimmia,serpente]).
plur(X) :-
    member(X, [i,gli,le,cani,cavalli,scimmie,serpenti]).

extract(sing, [H], [H]) :-
    sing(H).
extract(sing, [H], []) :-
    plur(H).
extract(sing, [H | R], [H | Res]) :-
    sing(H),
    extract(sing, R, Res).
extract(sing, [H | R], Res) :-
    plur(H),
    extract(sing, R, Res).

extract(plur, [H], [H]) :-
    plur(H).
extract(sing, [H], []) :-
    sing(H).
extract(plur, [H | R], [H | Res]) :-
    plur(H),
    extract(plur, R, Res).
extract(plur, [H | R], Res) :-
    sing(H),
    extract(plur, R, Res).
