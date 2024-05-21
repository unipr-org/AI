% Realizzato da: Simone Colli
%
% Creare una funzione `separate` per separare
% gli articoli determinativi, forniti in una lista,
% in 2 liste contenenti rispettivamente articoli singolari
% e articoli plurali.

sing(X) :-
    member(X, [il, lo, la]).

plur(X) :-
    member(X, [i, gli, le]).

separate([H | []], [H | []], []) :-
    sing(H).


separate([H | []], [], [H | []]) :-
    plur(H).


separate([H | R], [H | S], P) :-
   sing(H), separate(R, S, P).


separate([H | R], S, [H | P]) :-
   plur(H), separate(R, S, P).


% Esempio di goal:
% ?- separate([il, i, lo, le, la, gli], Sing, Plur)
