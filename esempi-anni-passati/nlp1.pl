%
% nlp1.pl
%
% A syntactic analyzer for ridiculously simplified subset of English.
%
% (c) 2022 Federico Bergenti
%

a(I, R) :-
    np(I, R1),
    vp(R1, R).

np([PN | R], R) :-
    pn(PN).
np([Det, CN | R1], R) :-
    det(Det),
    cn(CN),
    optpps(R1, R).

vp([IV | R1], R) :-
    iv(IV),
    optpps(R1, R).
vp([TV | R1], R) :-
    tv(TV),
    np(R1, R2),
    optpps(R2, R).

optpps(R, R).
optpps(I, R) :-
    pp(I, R1),
    optpps(R1, R).

pp([Prep | R1], R) :-
    prep(Prep),
    np(R1, R).

det(the).

prep(in).
prep(near).

pn(alice).
pn(bob).
pn(london).

cn(book).
cn(cake).
cn(garden).
cn(house).
cn(kid).
cn(lake).

tv(eats).
tv(reads).

iv(lives).
iv(runs).
