%
%	Realizzato da @manueldiagostino
%	
% 	minpath(Source, Dest, Path).
%

:- debug.

arc(a,b).
arc(a,c).
arc(b,d).
arc(b,e).
arc(d,f).
arc(c,f).
arc(h,f).
arc(f,i).
arc(f,g).

minpath(Source, Dest, Path) :-
    minpath_bfs([state(Source, [])], Dest, [], RPath),
    reverse(RPath, Path).

minpath_bfs([state(DestParent, Path) | _], Dest, _VisitedStates, [Dest, DestParent | Path]) :-
    arc(DestParent, Dest),
    !.
minpath_bfs([state(Node, CurrPath) | R], Dest, VisitedStates, Path) :-
    children(state(Node, CurrPath), [], Children),
    append(R, Children, TempQueue),
    subtract(TempQueue, VisitedStates, NewVisitQueue),
    union([state(Node, CurrPath)], VisitedStates, NewVisitedStates),
    minpath_bfs(NewVisitQueue, Dest, NewVisitedStates, Path).

children(state(CurrNode, CurrPath), VisitedChildren, Children) :-
    arc(CurrNode, NextNode),
    NextState = state(NextNode, [CurrNode | CurrPath]),
    non_member(NextState, VisitedChildren),
    children(state(CurrNode, CurrPath), [NextState | VisitedChildren], Children),
    !.
children(state(CurrNode, CurrPath), Children, Children) :-
    arc(CurrNode, NextNode),
    NextState = state(NextNode, [CurrNode | CurrPath]),
    member(NextState, Children),
    !.
children(state(_CurrNode, _CurrPath), _, []).

non_member(_X, []) :- !.
non_member(X, [X | _]) :-
    !,
    fail.
non_member(X, [_ | R]) :-
    non_member(X, R).