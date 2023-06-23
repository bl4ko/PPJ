fib([]).

fib([0]).

fib([1,0]).

fib([X,Y,Z|T]) :-
    X is Y + Z,
    fib([Y, Z | T]).