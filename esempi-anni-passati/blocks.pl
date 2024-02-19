%
% blocks.pl
%
% Planning in the blocks world using breadth-first search.
% 
% Uncomment the following predicate for tests: 
% test(Plan) :-
%     plan(Plan,
%          [hand_empty, on_table(a), on(b, a), on(c, b), on(d, c), clear(d)],
%          [hand_empty, on_table(c), on(b, c), on(a, b), on(d, a), clear(d)],
%          []).
%
% (c) 2022 Federico Bergenti
%

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
       [hand_empty, on_table(X), clear(X)],
       [holding(X)]) :-
    block(X).
action(take(X),
       [hand_empty, clear(X), on(X, Y)],
       [],
       [holding(X), clear(Y)],
       [hand_empty, clear(X), on(X, Y)]) :-
    block(X),
    block(Y),
    X \= Y.
action(put_on(X, Y),
       [holding(X), clear(Y)],
       [],
       [hand_empty, clear(X), on(X, Y)],
       [holding(X), clear(Y)]) :-
    block(X),
    block(Y),
    X \= Y.

plan(Plan, State, GoalPositive, GoalNegative) :-
    plan_bfs(Reversed, [node(State, [State], [])], GoalPositive, GoalNegative),
    reverse(Plan, Reversed),
    !.

plan_bfs(Plan, [node(State, _, Plan) | _], GoalPositive, GoalNegative) :-
    subset(GoalPositive, State),
    intersection(GoalNegative, State, []),
    !.
plan_bfs(Plan, Fringe, GoalPositive, GoalNegative) :-
    Fringe = [FringeHead | FringeRest],
    actions([], Actions),
    expand(Expanded, FringeHead, Actions),
    append(FringeRest, Expanded, NewFringe),
    plan_bfs(Plan, NewFringe, GoalPositive, GoalNegative),
    !.
plan_bfs(Plan, [_ | FringeRest], GoalPositive, GoalNegative) :-
    plan_bfs(Plan, FringeRest, GoalPositive, GoalNegative).

expand([node(Post, [State | States], [Action | Actions]) | ExpandedRest], Node, [Action | ActionRest]) :-
    Node = node(State, States, Actions),
    action(Action, PrePositive, PreNegative, PostPositive, PostNegative),
    subset(PrePositive, State),
    intersection(PreNegative, State, []),
    subtract(State, PostNegative, Post1),
    union(Post1, PostPositive, Post),
    nonin(Post, States),
    expand(ExpandedRest, Node, ActionRest),
    !.
expand(Expanded, Node, [_ | ActionRest]) :-
    expand(Expanded, Node, ActionRest),
    !.
expand([], _, []).

actions(Current, Actions) :-
    action(Action, _, _, _, _),
    nonmember(Action, Current),
    !,
    actions([Action | Current], Actions).
actions(Current, Current).

nonin(E, [H | _]) :-
    subset(E, H),
    subset(H, E),
    !,
    fail.
nonin(E, [_ | R]) :-
    !,
    nonin(E, R).
nonin(_, []).

nonmember(H, [H | _]) :-
    !,
    fail.
nonmember(H, [_ | T]) :-
    !,
    nonmember(H, T).
nonmember(_, []).
