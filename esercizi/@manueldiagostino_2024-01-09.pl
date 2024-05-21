% Questa versione utilizza la grammatica acontestuale riportata nel testo dell'esame.
% In particolare, il primo argomento è l'albero sintattico prodotto espandendo la produzione e 
% ogni predicato prende una lista ground L di terminali del linguaggio generato L(G);
% Le variabili della parte destra della rispettiva produzione vengono parsate e la parte non 
% analizzata di lista viene inserita come terzo argomento. Se presente, il quarto argomento [sing|plur]
% indica se è necessario effettuare il parsing di elementi singolari o, rispettivamente, plurali.

% Esempio:
% Il goal := dt(S, [il,cane], R, sing). è soddisfatto da 
%	-	S=dt(il)
%	-	R=[cane]

tv(tv(A), [A | R], R, sing) :-
    member(A, [rincorre]).
tv(tv(A), [A | R], R, plur) :-
    member(A, [rincorrono]).
cn(cn(A), [A | R], R, sing) :-
    member(A, [cane, topo]).
cn(cn(A), [A | R], R, plur) :-
    member(A, [cani, topi]).
dt(dt(A), [A | R], R, sing) :-
    member(A, [il]).
dt(dt(A), [A | R], R, plur) :-
    member(A, [i]).

a(a(X,Y), L) :-
    np(X, L, R, sing),
    vp(Y, R, _, sing).
a(a(X,Y), L) :-
    np(X, L, R, plur),
    vp(Y, R, _, plur).

np(np(X,Y), L, Rnp, sing) :-
    dt(X, L, R, sing),
    cn(Y, R, Rnp, sing).
np(np(X,Y), L, Rnp, plur) :-
    dt(X, L, R, plur),
    cn(Y, R, Rnp, plur).

vp(vp(X,Y), L, R, sing) :-
   	tv(X, L, R, sing),
    np(Y, R, _, _).
vp(vp(X,Y), L, R, plur) :-
   	tv(X, L, R, plur),
    np(Y, R, _, _).

parse(S, L) :-
    a(S,L).
