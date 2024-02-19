%
% nlp4.pl
%
% A syntactic analyzer for ridiculously simplified subset of English.
%
% Extends nlp3.pl to associate meanings with sentences.
%
% (c) 2022 Federico Bergenti
%

s(SS, I, R) :-
    a(SS, I, R).
s(SS, I, R) :-
    q(SS, I, R).

q(SQ, I, R) :-
    qyn(SQ, I, R).
q(SQ, I, R) :-
    qwho(SQ, I, R).
q(SQ, I, R) :-
    qwhere(SQ, I, R).

qwho(action(VPN, [subject(_) | SPPs]), [who | R1], R) :-
    SVP = action(VPN, SPPs),
    vp(SVP, _, R1, R).

qyn(SQ, I, R) :-
    aux(SQ, I, R).

qwhere(action(VPN, SPPs), [where | R1], R) :-
    SAUX = action(VPN, SPP1s),
    aux(SAUX, R1, R),
    append(SPP1s, [where(_, _)], SPPs).

aux(action(VPN, [subject(SNP) | SPPs]), [does | R1], R) :-
    SVP = action(VPN, SPPs),
    np(SNP, tps, R1, R2),
    vp(SVP, ntps, R2, R).
aux(action(VPN, [subject(SNP) | SPPs]), [do | R1], R) :-
    SVP = action(VPN, SPPs),
    np(SNP, ntps, R1, R2),
    vp(SVP, ntps, R2, R).

a(action(VPN, [subject(SNP) | SPPs]), I, R) :-
    SVP = action(VPN, SPPs),
    np(SNP, PN, I, R1),
    vp(SVP, PN, R1, R).

np(id(PN), tps, [PN | R], R) :-
    pn(PN).
np(the(CN), tps, [Det, CN | R], R) :-
    det(Det),
    cn(CN, _).
np(the(CN, SPPs), tps, [Det, CN | R1], R) :-
    det(Det),
    cn(CN, _),
    SPPs = [_ | _],
    optpps(SPPs, R1, R).
np(all(N), ntps, [Det, CN | R], R) :-
    det(Det),
    cn(N, CN).
np(some(N, SPPs), ntps, [Det, CN | R1], R) :-
    det(Det),
    cn(N, CN),
    optpps(SPPs, R1, R).

vp(action(N, SPPs), tps, [IV | R1], R) :-
    iv(N, IV),
    optpps(SPPs, R1, R).
vp(action(IV, SPPs), ntps, [IV | R1], R) :-
    iv(IV, _),
    optpps(SPPs, R1, R).
vp(action(N, [object(SNP) | SPPs]), tps, [TV | R1], R) :-
    tv(N, TV),
    np(SNP, _, R1, R2),
    optpps(SPPs, R2, R).
vp(action(TV, [object(SNP) | SPPs]), ntps, [TV | R1], R) :-
    tv(TV, _),
    np(SNP, _, R1, R2),
    optpps(SPPs, R2, R).

optpps([], R, R).
optpps([SPP | SPPs], I, R) :-
    pp(SPP, I, R1),
    optpps(SPPs, R1, R).

pp(where(Prep, SNP), [Prep | R1], R) :-
    prep(where, Prep),
    np(SNP, _, R1, R).

det(the).

prep(where, in).
prep(where, near).

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
