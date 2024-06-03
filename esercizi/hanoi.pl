%
%	Realizzato da @manueldiagostino
% Obiettivo: creare un agente in grado di risolvere il gioco della torre di Hanoi.
%


:- debug.
:- use_module(library(clpfd)).

non_member(H, [H | _]) :-
    !,
    fail.
non_member(H, [_ | T]) :-
    !,
    non_member(H, T).
non_member(_, []).

satisfy_order([]) :- !.
satisfy_order([disk(_)]) :- !.
satisfy_order([DiskL, DiskR | Disks]) :-
              DiskL = disk(L),
              DiskR = disk(R),
              L #< R,
              satisfy_order([DiskR | Disks]).
    
stake(1, Disks) :- satisfy_order(Disks), !.
stake(2, Disks) :- satisfy_order(Disks), !.
stake(3, Disks) :- satisfy_order(Disks), !.

disk(X) :- 
    integer(X),
    X #> 0.


get_disks(N, CurrDisks, CurrDisks) :-
    length(CurrDisks, CurrDisksLen),
    N #= CurrDisksLen,
    !.
get_disks(N, [], Disks) :-
    NewDisk = disk(1),
    get_disks(N, [NewDisk], Disks),
    !.
get_disks(N, [disk(LastIndex) | R], Disks) :-
    NewIndex is LastIndex + 1,
    NewDisk = disk(NewIndex),
    get_disks(N, [NewDisk, disk(LastIndex) | R ], Disks).

on_stake(D, Stake) :-
    D = disk(_X),
    Stake = stake(_K, Disks),
    member(D, Disks),
    !.

action(take(disk(X), stake(K, [disk(X) | R])),
       [hand_free, stake(K, [disk(X) | R])],
       [holding(disk(X))],
       [holding(disk(X)), NewStake],
       [hand_free, stake(K, [disk(X) | R])]) :-
    NewStake = stake(K, R).
action(put(disk(X), stake(K, [])),
       [holding(disk(X)), stake(K, [])],
       [hand_free],
       [hand_free, NewStake],
       [holding(disk(X)), stake(K, [])]) :-
    NewStake = stake(K, [disk(X)]).
action(put(disk(X), stake(K, [disk(Y) | R])),
       [holding(disk(X)), stake(K, [disk(Y) | R])],
       [hand_free],
       [hand_free, NewStake],
       [holding(disk(X)), stake(K, [disk(Y) | R])]) :-
    NewStake = stake(K, [disk(X), disk(Y) | R]),
    X #< Y.

children(X, Children, Visited) :-
    X = node(State, PrevStates, Actions),
    action(Act, PrePos, PreNeg, PostPos, PostNeg),
    subset(PrePos, State),
    intersection(PreNeg, State, []),
    subtract(State, PostNeg, TempState),
    union(TempState, PostPos, NewState),
    Y = node(NewState, [State | PrevStates], [Act | Actions]),
    non_member(NewState, PrevStates),
    non_member(Y, Visited),
    children(X, Children, [Y | Visited]),
    !.
children(X, Children, Children) :-
    X = node(State, PrevStates, Actions),
    action(Act, PrePos, PreNeg, PostPos, PostNeg),
    subset(PrePos, State),
    intersection(PreNeg, State, []),
    subtract(State, PostNeg, TempState),
    union(TempState, PostPos, NewState),
    Y = node(NewState, [State | PrevStates], [Act | Actions]),
    non_member(NewState, PrevStates),
    member(Y, Children),
    !.
children(X, [], _) :-
    X = node(_, _, _).

plan(Plan, InitialState, GoalPositive, GoalNegative) :-
    plan_bfs(PlanR, [node(InitialState, [], [])], GoalPositive, GoalNegative),
    reverse(Plan, PlanR).

plan_bfs(Plan, [node(State, _PrevStates, Plan) | _], GoalPositive, GoalNegative) :-
    subset(GoalPositive, State),
    intersection(State, GoalNegative, []),
    !.
plan_bfs(Plan, [CurrNode | Nodes], GoalPositive, GoalNegative) :-
    children(CurrNode, Children, []),
    append(Nodes, Children, NewVisitQueue),
    plan_bfs(Plan, NewVisitQueue, GoalPositive, GoalNegative),
    !.


