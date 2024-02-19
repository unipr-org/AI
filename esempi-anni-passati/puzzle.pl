%
% puzzle.pl
%
% Solver of 8-puzzles that uses the A* algorithm.
% 
% Uncomment the following predicate for tests: 
% test(Plan) :-
%     plan(Plan,
%          [
%          at(0, 0, 6), at(0, 1, 5), at(0, 2, 2), 
%          at(1, 0, 4), at(1, 1, 8), at(1, 2, 3),   
%          at(2, 0, 1), at(2, 1, 7), at(2, 2, 0)
%          ],
%          [
%          at(0, 0, 1), at(0, 1, 2), at(0, 2, 3), 
%          at(1, 0, 4), at(1, 1, 5), at(1, 2, 6),   
%          at(2, 0, 7), at(2, 1, 8), at(2, 2, 0)
%          ],
%         []).
%
% (c) 2022 Federico Bergenti
%

row(R) :- 
    member(R, [0, 1, 2]).

column(C) :- 
    member(C, [0, 1, 2]).

label(N) :- 
    member(N, [1, 2, 3, 4, 5, 6, 7, 8]).

action(move_left(N),
       [at(R, C, N), at(R, CM1, 0)],
       [],
       [at(R, CM1, N), at(R, C, 0)],
       [at(R, C, N), at(R, CM1, 0)]) :-
    label(N),
    row(R),
    column(C),
    C > 0,
    CM1 is C - 1.
action(move_right(N),
       [at(R, C, N), at(R, CP1, 0)],
       [],
       [at(R, CP1, N), at(R, C, 0)],
       [at(R, C, N), at(R, CP1, 0)]) :-
    label(N),
    row(R),
    column(C),
    C < 2,
    CP1 is C + 1.
action(move_up(N),
       [at(R, C, N), at(RM1, C, 0)],
       [],
       [at(RM1, C, N), at(R, C, 0)],
       [at(R, C, N), at(RM1, C, 0)]) :-
    label(N),
    row(R),
    column(C),
    R > 0,
    RM1 is R - 1.
action(move_down(N),
       [at(R, C, N), at(RP1, C, 0)],
       [],
       [at(RP1, C, N), at(R, C, 0)],
       [at(R, C, N), at(RP1, C, 0)]) :-
    label(N),
    row(R),
    column(C),
    R < 2,
    RP1 is R + 1.

h_star(HS, node(State, _, _)) :-
    h_star(HS, State, 0, 8).

h_star(Sum, _, Sum, 0) :-
    !.
h_star(HS, State, Sum, N) :-
    member(at(R, C, N), State),
    N1 is N - 1,
    RN is N1 div 3,
    CN is N1 mod 3,
    Sum1 is Sum + abs(R - RN) + abs(C - CN),
    h_star(HS, State, Sum1, N1).

plan(Plan, State, GoalPositive, GoalNegative) :-
    plan_a_star(Reversed, [node(State, [State], [])], GoalPositive, GoalNegative),
    reverse(Plan, Reversed),
    !.

plan_a_star(Plan, [node(State, _, Plan) | _], GoalPositive, GoalNegative) :-
    subset(GoalPositive, State),
    intersection(GoalNegative, State, []),
    !.
plan_a_star(Plan, Fringe, GoalPositive, GoalNegative) :-
    Fringe = [FringeHead | FringeRest],
    actions([], Actions),
    expand(Expanded, FringeHead, Actions),
    insert(Expanded, FringeRest, NewFringe),
    plan_a_star(Plan, NewFringe, GoalPositive, GoalNegative),
    !.
plan_a_star(Plan, [_ | FringeRest], GoalPositive, GoalNegative) :-
    plan_a_star(Plan, FringeRest, GoalPositive, GoalNegative).

insert([], Fringe, Fringe) :-
    !.
insert([Head | Rest], [], NewFringe) :-
    !,
    insert(Rest, [Head], NewFringe).
insert([Head | Rest], [FringeHead | FringeRest], NewFringe) :-
    h_star(HS, Head),
    h_star(FS, FringeHead),
    HS =< FS,
    insert(Rest, [Head, FringeHead | FringeRest], NewFringe),
    !.
insert([Head | Rest], [FringeHead | FringeRest], NewFringe) :-
    insert(Rest, [FringeHead, Head | FringeRest], NewFringe).

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
