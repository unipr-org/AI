%
% nlp3.pl
%
% A syntactic analyzer for ridiculously simplified subset of English.
%
% Extends nlp2.pl to support:
% 1. Yes/no questions.
% 2. Who questions.
% 3. Where questions.
%
% (c) 2022 Federico Bergenti
%

s(I, R) :-
    a(I, R).
s(I, R) :-
    q(I, R).

q(I, R) :-
    qyn(I, R).
q(I, R) :-
    qwho(I, R).
q(I, R) :-
    qwhere(I, R).

qwho([who | R1], R) :-
    vp(_, R1, R).

qyn(I, R) :-
    aux(I, R).

qwhere([where | R1], R) :-
    aux(R1, R).

aux([does | R1], R) :-
    np(tps, R1, R2),
    vp(ntps, R2, R).
aux([do | R1], R) :-
    np(ntps, R1, R2),
    vp(ntps, R2, R).

a(I, R) :-
    np(PN, I, R1),
    vp(PN, R1, R).

np(tps, [PN | R], R) :-
    pn(PN).
np(tps, [Det, CN | R1], R) :-
    det(Det),
    cn(CN, _),
    optpps(R1, R).
np(ntps, [Det, CN | R1], R) :-
    det(Det),
    cn(_, CN),
    optpps(R1, R).

vp(tps, [IV | R1], R) :-
    iv(_, IV),
    optpps(R1, R).
vp(ntps, [IV | R1], R) :-
    iv(IV, _),
    optpps(R1, R).
vp(tps, [TV | R1], R) :-
    tv(_, TV),
    np(_, R1, R2),
    optpps(R2, R).
vp(ntps, [TV | R1], R) :-
    tv(TV, _),
    np(_, R1, R2),
    optpps(R2, R).

optpps(R, R).
optpps(I, R) :-
    pp(I, R1),
    optpps(R1, R).

pp([Prep | R1], R) :-
    prep(Prep),
    np(_, R1, R).

det(the).

prep(in).
prep(near).

pn(alice).
pn(bob).
pn(london).

cn(book, books).
cn(cake, cakes).
cn(garden, gardens).
cn(house, houses).
cn(kid, kids).
cn(lake, lakes).

tv(eat, eats).
tv(read, reads).

iv(live, lives).
iv(run, runs).
