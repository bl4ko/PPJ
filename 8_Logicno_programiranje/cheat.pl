% ----------------------- Recursion --------------------------------------
% base case, have to be before recursive case so it is matched before recursive, 
% if recurisve case would be first it would be always matched and hence endless loop
sum_range(A,B,Result) :-
    A == B,
    Result=A.
% same as sum_range(A, A, A).

% recursive case
sum_range(A,B, Result) :-
    A1 is A + 1,
    sum_range(A1, B, Result1),
    Result is A + Result1.

% sum_range(1, 10, 55). true
% sum_range(1, 10, R). R = 55.


% Fibonacci example, fib(0) = 0, fib(1), fib(n) = fib(n-1) + fib(n-2)
% base cases
fib(0,0). % fib(0, X) -> X = 0
fib(1,1). % fib(1, X) -> X = 1
% recursive case
fib(N, R) :-
    N1 is N - 1, N2 is N - 2,
    fib(N1, R1), fib(N2, R2),
    R is R1 + R2.


% Factorial: 0! = 1, n! = n x (n-1)
factorial(0, 1).
factorial(N, R) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    R is N * R1.


% ------------------ Iterative ------------------------------------------------

% iterative factorial
% public predicate
factorial_it(N, R) :-
    factorial_it(0, N, 1, R). % helper call, branching recurision

% base case
factorial_it(N, N, R, R).

% recursive case
factorial_it(I, N, T, R) :-
    I < N,
    I1 is I + 1,
    T1 is T * I1,
    factorial_it(I1, N, T1, R).

%? factorial_it(3, X).
%? factorial_it(0,3,1,R). % with X=R
%? factorial_it(1,3,1, R'). % with R=R'
%? factorial_it(2,3,2, R''). % with R'=R'' (if one gets a value they both do, linked variables)
%? factorial_it(3,3,6, R'''). % with R'' = R'''
%? factorial_it(3,3,6,6). % with R'''= 6

% Factorial iterative from up to bottom
factorial_itb(N,F) :-
    factorial_itb(N, 1, F).

factorial_itb(0, F, F).

factorial_itb(N,T,F) :-
    N>0,
    T1 is T*N,
    N1 is N-1,
    factorial_itb(N1, T1, F).


% ----------------- LISTS ------------------------------------------------
% X = [], empty list X 

% ?- X = [1,2,3,4]
% X = [1,2,3,4]

% ?- [1,2,3] = [1,2,3] 
%  true

% ?- [X, Y, Z] = [1,2,3]
% X=1, Y=2, Z=3.

% ?- [X, b(Y), c(3)] = [a(1), b(2), c(3)]
% X=a(1), Y=2.

% Pipe operator
% ?- [a] = [a|[]]
% true

% ?- X = [a|[]]
% X = [a]

% ?- L=[1|[2,3]].
% L = [1,2,3]

% ?- X = [1|[2|[3|[]]]].
% X=[1,2,3]

% ?- [a|b] = [a,b] % Not proper list
% false

% X = [[a | [b | []]] | [[c | [d | []]]]
% X = [[a,b] | [c,d]]


% ?- [1,2,3,4,5] = [H|T]
% H=1, T=[2,3,4,5].

% ?- [H|T] = [a].
% H=a, T=[].

% ?- [H|T] = [].
% false

% ?- [1,2,3,4] = [_, _ | X]. % We don't care _ what elements are
% X = [3,4]

% ?- [1,2,3,4] = [_, _, _, X].
% X = 4

% ?- [1,2,3,4] = [_,_,_|[X]].
% X = 4.

% student(Id, name([Last, First], grades([a1,a2,a3,test])))
student(1001, name([ellenovitch, alice]), grades([92, 75, 100, 85])).
student(1002, name([boberson, bob]), grades([50, 64, 73, 66])).
student(1003, name([charleston, charlie]), grades([65, 75, 85, 100])).
student(1004, name([davidson, dave]), grades([10, 92, 34, 87])).
student(1005, name([ellenovitch, ellen]), grades([72, 87, 82, 70])).

% Who is student with id 1001
% student(1001, name([_, X]), _)

% How did alice do on assignment 1
% student(_, name([_, alice]), grades([A1, _, _, _])).

% How did alice do on assignment2
% ?- student(_, name([_, alice]), grades([_,A2|_])).

% How did student 1002 do on the test?
% ?- student(1002, _, grades([_, _, _, Test])).

% Who got 100 on the test
% ?- student(_, name([_,X]), grades([_, _, _ ,100])).
% ?- student(_, _, grades(L)), last(L, Test).

% Did anyone get 100 on anything?
% student(_, name(Name), grades(Grades)), member(100, Grades).

% What is each student's average greade?
% ?- student(_,name(Name), grades([A1, A2, A3, Test])), Average is (A1+A2+A3+Test)/4.

% --- Prolog list predicates -------
% contains(X, L) is true if item X is in list L
contains(X, [X|_]).

contains(X, [_ | T]) :-
    contains(X, T).

% len(List,Length). is true if length is the number of elementsi n the list
len([], 0).

len([_|T], R) :-
    len(T, R1),
    R is 1 + R1.

len_it(L, R) :-
    len_it(L, 0, R).
len_it([], C, C).
len_it([_|T], C, R) :-
    C1 is C + 1,
    len_it(T, C1, R).

% join(L1, L2, L3) is true if the first arg joined to the second arg makes the 3rd
join([], L2, L2).

join([H|T], L2, [H|L3]) :-
    join(T, L2, L3).

% del_first(X, L, R). where R is the result of removing the first instance X from L
del_first(X, [X|T], T).

del_first(X, [H|T], [H|R]) :-
    X\=H,
    del_first(X,T,R).

% del(X,L,R) where R is the result of removing *any* instance of X from L
del(X,[X|T], T).
del(X, [H|T], [H|R]) :-
    del(X,T,R).

% selects(L, R). true if L is a subset of R
selects([],_). % empty subset is subset of all sets
selects([H|T],R) :-
    del(H, R, R1),
    selects(T, R1).

% mySort(L, R) is true if R is the sorted version of list L (Insertion sort)
mySort([], []).
mySort([H|T], Result) :-
    mySort(T, SortedTail),
    insert(H, SortedTail, Result).

% insert element in sorted array
insert(Element, [], [Element]).

insert(X, [H|T], [X,H|T]) :-
    X =< H.

insert(X, [H|T], [H|R]) :-
    X > H,
    insert(X,T,R).

% max of the list maximum(L,R) is true if the number R is the largest value from the list L
maximum([H|T], M) :-
    maximum(T, H, M).

maximum([], M, M).

maximum([H|T], M1, M) :-
    (H > M1 -> M2 = H ; M2 = M1),
    maximum(T, M2, M).

% even_list/1 is true if its argument is a list with an even number of elements
even_list([]).

even_list([_,_]).

even_list([_,_|T]) :-
    even_list(T).

% all_even/1 is true if its argument is a list with all even numbers
all_even([]).

all_even([H|T]) :-
    Rem is H mod 2,
    Rem == 0,
    all_even(T).

% sum(L, R) is true if R is the sum of all elements in the list L
sum([], 0).

sum([H|T], R) :-
    number(H),
    sum(T, R1),
    R is H + R1.

% mapping, scale(X, L, R) is true if R is the list of asll elements in L scaled by the constant X
scale(_, [], []).

scale(X, [H|T], [H1|R2]) :-
    number(X),
    H1 is X * H,
    scale(X, T, R2).
    % R is [H1|R2], we do this in argument, is is only for single character

% general purpose mapping: square(X, X2) - X2 is X,X bultin
% map(F,L,R) is true if R is the list of all elements in L mapped by F.
square(X, X2) :-
    X2 is X * X.

map(_, [], []).

map(F, [H|T], [H1 | R2]) :-
    call(F, H, H1),
    map(F, T, R2).


% Example tehtnica
sum([], 0).
sum([H|T], Sum) :-
    sum_list(T, SumTail),
    Sum is H + SumTail.

balance(L, R, B) :-
    sum(L, SumL),
    sum(R, SumR),
    B is SumR - SumL.


% all three clauses can be used during the execution of the split/3 predicate because Prolog uses backtracking to explore all possible solutions.
% In Prolog, when you write several clauses for the same predicate (like split/3 in this case), Prolog treats them as being joined by a logical "OR". That means Prolog will try each clause in order from top to bottom, and stop as soon as it finds one that succeeds.

% If there are no weights available than L and R must be also empty
split([], [], []).

split([H|T], [H|L], R) :-
    split(T, L, R).

split([H|T], L, [H|R]) :-
    split(T, L, R).

% Don't add weight to any side
split([_|T], L, R) :-
    split(T, L, R).

% ?- split([1,2,3], L, R)

% Mesaure the weights


% ----------------------------- PROLOG CUTS --------------------------------------------------------
% Make function stop once it knows it is true, with cuts ! symbol
contains_fast(X, [X|_]) :- !. % once we come here stop backtrack

contains_fast(X,[_|T]) :-
    contains_fast(X,T).

fact(a).
fact(b).

% ------------------------------- PROLOG CONSTRAINTS ------------------------------------------------

% To use constraints, we have to use the clpfd library
:- use_module(library(clpfd)).
% To work with end domains (whole numbers eg. 1..10) we have to use clpr library
:- use_module(library(clpr)).

% CLP(FD) library supports the following arithmetic operations
% +, -, *, ^, min, max, mod, rem, asb, //, div
% #= (equality), #\= (inequality), #< (less than), #=< (less than or equal to), #> (greater than), #>= (greater than or equal to)

% Domain for variable can be defined as
A in 0..42
B in inf..sup
[A, B, C] ins 1..10

% all_distinct([A,B,C]) % all variables must have different values
% label([A,B,C]) % assign values to variables, before we use label all domains must be limited

% Napisali bomo program, ki na sahovsko plosco velikost nxn rapozred n dam tako ,da se med sabo ne napadajo (torej noben par dam ni na isti hyorizontali, vertikali ali diagonali). Koordinate posamezne figure bomo zapisali v obiliki X/Y
% predikat safe_pair(X1/Y1, X2/Y2), zagotovi da se dami med sabo ne napdata
safe_pair(X1/Y1, X2/Y2) :-
    X1 #\= X2, % X1 is not equal to X2
    Y1 #\= Y2, % Y1 is not equal to Y2
    abs(X1 - X2) #\= abs(Y1 - Y2). % abs(X1 - X2) is not equal to abs(Y1 - Y2)

% predikat safe_list/2 ki sprejme koordinate ene dame in seznam koordinat preostalih dam ter preveri da dama na koordinatah X/Y ne napada nobene v seznamu
safe_list(_, []).

safe_list(Q, [H|T]) :-
    safe_pair(Q, H),
    safe_list(Q, T).

% predikat safe_list(L), ki sprejme seznam koordinat in preveri, da se med sabo ne napada noben par v seznamu
safe_list([]).

% safe_list([_/_]).
safe_list([H|T]) :-
    safe_list(H, T),
    safe_list(T)