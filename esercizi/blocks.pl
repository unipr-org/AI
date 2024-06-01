% 
% Realizzato da @manueldiagostino
%
% Obiettivo: definire un agente in grado
% di manipolare blocchi su di un tavolo.
% 
% Si ricordi che l'albero di ricerca è composto
% da nodi i quali contengono:
% - stato corrente del mondo
% - lista degli stati attraversati fino a quel punto
% - sequenza di azioni necessarie (il piano)
% 
% Le azioni possibili:
% - take_from_table(X)
% - put_on_table(X)
% - take(X)
% - put_on(X, Y)
% 
% Stati possibili:
% - hand_empty
% - clear(X)
% - on_table(X)
% - holding(X)
% - on(X,Y)
%

non_member(H, [H | _]) :-
    !,
    fail.
non_member(H, [_ | T]) :-
    !,
    non_member(H, T).
non_member(_, []).

block(a).
block(b).
block(c).
block(d).

action(take_from_table(X),
       [hand_empty, clear(X), on_table(X)],
       [],
       [holding(X)],
       [hand_empty, clear(X), on_table(X)]) :-
    block(X).
action(put_on_table(X),
       [holding(X)],
       [],
       [hand_empty, clear(X), on_table(X)],
       [holding(X)]) :-
    block(X).
action(take(X),
       [hand_empty, clear(X), on(X,Y)],
       [],
       [holding(X), clear(Y)],
       [hand_empty, clear(X), on(X,Y)]) :-
    block(X),
    block(Y),
    X \= Y.
action(put_on(X,Y),
       [holding(X), clear(Y)],
       [],
       [hand_empty, clear(X), on(X,Y)],
       [holding(X), clear(Y)]) :-
    block(X),
    block(Y),
    X \= Y.

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
    member(Y, Children).
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
