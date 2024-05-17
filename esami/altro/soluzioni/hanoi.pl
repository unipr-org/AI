muovi(1, X, Y, _) :- 
  write('Muovi il disco sopra a '),
  write(X),
  write(' su '),
  write(Y),
  nl.

muovi(N, X, Y, Z) :- 
  N > 1,
  M is N-1,
  muovi(M, X, Z, Y), 
  muovi(1, X, Y, _), 
  muovi(M, Z, Y, X).

hanoi(N) :-
  muovi(N, palo1, palo3, palo2).
