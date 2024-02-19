%
% lists.pl
%
% Some predicates for lists that reimplement those of many libraries.
% 
% Notes:
% 1. The implementation is based on the ECLiPSe implementation.
% 2. Predicate length/2 was renamed to size/2 because SWI-Prolog does 
%    not allow length/2 to be redefined.
% 3. Predicate subset/2 uses an implementation from SWI-Prolog.    
%
% (c) 2022 Federico Bergenti
%

:- use_module(library(clpfd)).

% member(?Term, ?List)
% Succeeds if Term unifies with a member of the list List.
member(X, [X | _]).
member(X, [_ | T]) :- 
    member(X, T).

% memberchk(+Term, ?List)
% Succeeds if Term is a member of the list List.
memberchk(X, [X | _]) :-
    !.
memberchk(X, [_ | T]) :- 
    memberchk(X, T).

% nonmember(+Element, +List)
% Succeeds if Element is not an element of the list List.
nonmember(H, [H | _]) :-
    !,
    fail.
nonmember(H, [_ | T]) :-
    !,
    nonmember(H, T).
nonmember(_, []).

% size(?List, ?N)
% Succeeds if the length of list List is N.
size([], 0).
size([_ | L], Length) :-
    Length #>= 1,
    N1 #= Length - 1,
    size(L, N1).

% append(?List1, ?List2, ?List3)
% Succeeds if List3 is the result of appending List2 to List1.
append([], X, X).
append([X | L1], L2, [X | L3]):-
    append(L1, L2, L3).

% prefix(?List1, ?List2)
% Succeeds if List1 is a prefix of List2.
prefix(X, Y) :-
    append(X, _, Y).

% reverse(+List, ?Reversed)
% Succeeds if Reversed is the reversed list List.
reverse(List, Rev) :-
    reverse(List, Rev, []).

reverse([], L, L).
reverse([H | T], L, SoFar) :-
    reverse(T, L, [H | SoFar]).

% select(?Element, ?List1, ?List2)
% Succeeds if List2 is List1 less an occurence of Element in List1.
select(A, [A | B], B).
select(A, [B, C | D], [B | E]) :-
    select(A, [C | D], E).

% intersection(+List1, +List2, ?Common)
% Succeeds if Common unifies with the list which contains the common 
% elements of List1 and List2.
intersection([], _, []).
intersection([Head | L1tail], L2, L3) :-
    memberchk(Head, L2),
    !,
    L3 = [Head | L3tail],
    intersection(L1tail, L2, L3tail).
intersection([_ | L1tail], L2, L3) :-
    intersection(L1tail, L2, L3).

% subset(+SubList, +List)
% Succeeds if all elements of SubList are also elements of List.
subset([], _).
subset([E | R], Set) :-
    memberchk(E, Set),
    subset(R, Set).

% subtract(+List1, +List2, ?Remainder)
% Succeeds if Remainder is the list which contains those elements of 
% List1 which are not in List2.
subtract([], _, []).
subtract([H | T], L2, L3) :-
    memberchk(H, L2),
    !,
    subtract(T, L2, L3).
subtract([H | T1], L2, [H | T3]) :-
    subtract(T1, L2, T3).

% union(+List1, +List2, ?Union)
% Succeeds if Union is the list which contains the union of elements in 
% List1 and those in List2.
union([], L, L).
union([H |L1T], L2, L3) :-
    memberchk(H, L2),
    !,
    union(L1T, L2, L3).
union([H | L1T], L2, [H | L3T]) :-
    union(L1T, L2, L3T).
