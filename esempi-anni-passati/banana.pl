%
% banana.pl
%
% The monkey and banana problem solved using depth-first search.
% 
% Uncomment the following predicate for tests: 
% test(Plan) :- 
%    plan(Plan,
%         [floor, at(south), box_at(east), banana_at(center)],
%         [have_banana, floor],
%         []).
%
% (c) 2022 Federico Bergenti
%

position(north).
position(south).
position(west).
position(east).
position(center).

action(take_banana,
       [at(X), banana_at(X)],
       [floor],
       [have_banana],
       [banana_at(X)]) :-
        position(X).
action(climb_up,
       [at(X), box_at(X), floor],
       [],
       [],
       [floor]) :-
    position(X).
action(climb_down,
       [at(X), box_at(X)],
       [floor],
       [floor],
       []) :-
    position(X).
action(move_box_to(Y),
       [at(X), box_at(X), floor],
       [],
       [box_at(Y), at(Y)],
       [box_at(X), at(X)]) :-
    position(X),
    position(Y),
    X \= Y.
action(move_to(Y),
       [at(X), floor],
       [],
       [at(Y)],
       [at(X)]) :-
    position(X),
    position(Y),
    X \= Y.

plan(Plan, State, GoalPositive, GoalNegative) :-
    plan_dfs(Reversed, [node(State, [State], [])], GoalPositive, GoalNegative),
    reverse(Plan, Reversed),
    !.

plan_dfs(Plan, [node(State, _, Plan) | _], GoalPositive, GoalNegative) :-
    subset(GoalPositive, State),
    intersection(GoalNegative, State, []),
    !.
plan_dfs(Plan, Fringe, GoalPositive, GoalNegative) :-
    Fringe = [FringeHead | FringeRest],
    actions([], Actions),
    expand(Expanded, FringeHead, Actions),
    append(Expanded, FringeRest, NewFringe),
    plan_dfs(Plan, NewFringe, GoalPositive, GoalNegative),
    !.
plan_dfs(Plan, [_ | FringeRest], GoalPositive, GoalNegative) :-
    plan_dfs(Plan, FringeRest, GoalPositive, GoalNegative).

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
