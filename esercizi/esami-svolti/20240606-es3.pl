% Scritto da @manueldiagostino
% La risoluzione si basa sulla seguente grammatica acontestuale:
%
%	 Expr -> AddExpr
%	 AddExpr -> MulExpr 'sum' AddExpr | MulExpr
%	 MulExpr -> Factor 'prod' MulExpr | Factor
%	 Factor -> '(' Expr ')' | Integer
%
% dove i terminali sono racchiusi tra apici singoli e Integer identifica un qualsiasi numero intero.

:- use_module(library(clpfd)).
%:- debug.

begin(H, [H | R], R).

fact(_, [], _) :- fail.
fact(Res, L, R3) :-
    begin(open, L, R1),
    expr(Res, R1, R2),
    begin(close, R2, R3),
	!.
fact(H, [H | R], R) :-
    integer(H).

mul(Res, L, R3) :-
    fact(LeftRes, L, R1),
    begin(prod, R1, R2),
    mul(RightRes, R2, R3),
    Res is LeftRes * RightRes,
    !.
mul(Res, L, R) :-
    fact(Res, L, R).

add(Res, L, R3) :-
    mul(LeftRes, L, R1),
    begin(sum, R1, R2),
    add(RightRes, R2, R3),
    Res is LeftRes + RightRes,
    !.
add(Res, L, R) :-
    mul(Res, L, R).

expr(Res, L, R) :-
    add(Res, L, R).


comp(E, L) :-
    expr(E, L, _).
