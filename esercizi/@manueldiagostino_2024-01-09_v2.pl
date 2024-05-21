% Questa versione utilizza la grammatica G dell'esercizio, introducendo alcune
% "ottimizzazioni" ricavabili osservando G; infatti, si può osservare che
% 
% 1) per NP -> Det CN
% -	Det è a sua volta espanso in un terminale;
% -	CN espande in un terminale;
% => l'espansione di NP "consuma" esattamente 2 termini dalla lista di input.
%
% 2) per VP -> TV NP
% -	TV è espando in un terminale;
% -	NP per il punto precedente "consuma" 2 termini;
% => l'espanzione di VP "consuma" esattamente 3 termini.
%
% 3) A -> NP VP
% -	NP consuma 2 termini;
% -	VP consuma 3 termini;
% => A consuma 5 termini, in particolare passa i primi 2 elementi della lista a NP e i rimanenti a VP.

sing(X) :-
    member(X, [il,cane,topo,rincorre]).
plur(X) :-
    member(X, [i,cani,topi,rincorrono]).

tv(tv(Y), [Y | _]) :-
    member(Y, [rincorre, rincorrono]).
cn(cn(Y), [Y | _]) :-
    member(Y, [cane, cani, topo, topi]).
dt(dt(Y), [Y | _]) :-
    member(Y, [il, i]).

a(a(X,Y), L) :-
    np(X, L, R),
    vp(Y, _).

np(np(X,Y), L, R) :-
    dt(L, R),
    cn(R, Rnp).
np(np(X, Y), [W,Z | R]) :-
    sing(W),
    sing(Z),
    dt(X, [W]),
    cn(Y, [Z | R]).
np(np(X, Y), [W,Z | R]) :-
    plur(W),
    plur(Z),
    dt(X, [W]),
    cn(Y, [Z | R]).

vp(vp(X, Y), [W,Z | R]) :-
    sing(W),
    tv(X, [W]),
    np(Y, [Z | R]).
vp(vp(X, Y), [W,Z | R]) :-
    plur(W),
    tv(X, [W]),
    np(Y, [Z | R]).

a(a(X,Y), [A,B,C | R]) :-
    sing(A),
    sing(B),
    sing(C),
    np(X, [A,B]),
    vp(Y, [C | R]).
a(a(X,Y), [A,B,C | R]) :-
    plur(A),
    plur(B),
    plur(C),
    np(X, [A,B]),
    vp(Y, [C | R]).

parse(S, L) :-
    a(S, L).
