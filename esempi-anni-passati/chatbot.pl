%
% chatbot.pl
%
% A ridiculously simplified chatbot.
%
% Uses nlp4.pl to acquire knowledge and answer questions.
%
% (c) 2022 Federico Bergenti
%

:- [nlp4].

bot :-
    writeln("A very simple chatbot"), nl,
    bot([]).

bot(KB) :-
    write("> "),
    readln(Line),
    input(KB1, KB, Line),
    !,
    bot(KB1).
bot(KB) :-
    writeln("I do not know what to say"),
    bot(KB).

input(_, _, [halt, '.']) :-
    writeln("Bye"),
    halt.
input(KB1, KB, Line) :-
    tell(KB1, KB, Line),
    writeln("OK").
input(KB, KB, Line) :-
    ask(Answer, KB, Line),
    answer(Answer).
input(KB, KB, Line) :-
    ask(_, KB, Line).

answer(Answer) :-
    output(Answer),
    !,
    fail.

output([]) :-
    nl.
output([H | R]) :-
    write(H), 
    write(" "),
    output(R).

tell([SA | KB], KB, Line) :-
    a(SA, Line, ['.']),
    !.

ask(Answer, KB, Line) :-
    q(SQ, Line, ['?']),
    SQ = action(Action, Modifiers1),
    member(action(Action, Modifiers2), KB),
    subset(Modifiers1, Modifiers2),
    a(SQ, Answer, []).

:- bot.
