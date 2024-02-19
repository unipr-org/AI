%
% nlp2.pl
%
% A syntactic analyzer for ridiculously simplified subset of English.
%
% Extends nlp1.pl to support:
% 1. Plular of common names
% 2. Person (first, second, third) and number (singlular, plural) of
%    noun phrases.
% 3. Subject/verb agreement.
%
% (c) 2022 Federico Bergenti
%

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
