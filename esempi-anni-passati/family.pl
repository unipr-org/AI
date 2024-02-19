%
% family.pl
%
% The standard example of a family tree.
% 
% (c) 2022 Federico Bergenti
%

mother_of(alice, carol).
mother_of(carol, eve).
mother_of(carol, frank).
mother_of(helen, kate).
mother_of(eve, john).
mother_of(grace, lucy).
mother_of(grace, mike).

father_of(bob, carol).
father_of(dave, eve).
father_of(dave, frank).
father_of(ivan, kate).
father_of(ivan, john).
father_of(frank, lucy).
father_of(frank, mike).

grandmother_of(X, Y) :-
    mother_of(X, Z),
    parent_of(Z, Y).

grandfather_of(X, Y) :-
    father_of(X, Z),
    parent_of(Z, Y).

parent_of(X, Y) :-
    mother_of(X, Y).
parent_of(X, Y) :-
    father_of(X, Y).

grandparent_of(X, Y) :-
    grandmother_of(X, Y).
grandparent_of(X, Y) :-
    grandfather_of(X, Y).

progenitor_of(X, Y) :-
    parent_of(X, Y).
progenitor_of(X, Y) :-
    parent_of(X, Z),
    progenitor_of(Z, Y).

descendent_of(X, Y) :-
    parent_of(Y, X).
descendent_of(X, Y) :-
    parent_of(Z, X), 
    descendent_of(Z, Y).
