arco(a,b,9).
arco(a,c,1).  
arco(b,c,7).  
arco(b,d,8).  
arco(c,a,5).  
arco(c,d,3).

percorso(Minimo) :- percorso_minimo([], a, d, Minimo), !.

path(X,X,[X|L],[X|L],0):- not_member(L,X).
path(X,Y,[X|L],L,Peso):- arco(X,Y,Peso).
path(X,Y,L,P,Peso) :- 
	arco(Z,Y,Peso1), 
    not_member(L,Z), 
    path(X,Z,[Z|L],P,Peso2),
    Peso is Peso1+Peso2.     

not_member([],_).
not_member([H|T],X):-
    H \= X,
    not_member(T,X).


percorso_minimo(L, X, Y, Minimo) :-
    path(X, Y, [Y], Percorso,Peso),
    not_member(L,per(Percorso,Peso)) , 
    L3 = [per(Percorso,Peso)|L],
    percorso_minimo(L3,X, Y, Minimo).
percorso_minimo(L1,_X, _Y, Minimo) :-
    min(L1,Minimo).


min([],0).
min([per(_Y,X)],X).
min([per(Y,X1),per(_Y,X2)|T],Max):-
    X1=<X2, 
    min([per(Y,X1)|T],Max).
min([per(_Y,X1),per(Y,X2)|T],Max):-
    X1>X2,
    min([per(Y,X2)|T],Max).

/** <examples>
?- percorso(M)
*/
