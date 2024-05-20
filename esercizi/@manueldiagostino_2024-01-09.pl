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
