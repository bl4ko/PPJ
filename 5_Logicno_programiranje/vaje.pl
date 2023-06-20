parent(tina, william).
parent(thomas, william).
parent(thomas, sally).
parent(thomas, jeffrey).
parent(sally, andrew).
parent(sally, melanie).
parent(andrew, joanne).
parent(jill, joanne).
parent(joanne, steve).
parent(william, vanessa).
parent(william, patricia).
parent(vanessa, susan).
parent(patrick, susan).
parent(patricia, john).
parent(john, michael).
parent(john, michelle).

parent(frank, george).
parent(estelle, george).
parent(morty, jerry).
parent(helen, jerry).
parent(jerry, anna).
parent(elaine, anna).
parent(elaine, kramer).
parent(george, kramer).

parent(margaret, nevia).
parent(margaret, alessandro).
parent(ana, aleksander).
parent(aleksandr, aleksander).
parent(nevia, luana).
parent(aleksander, luana).
parent(nevia, daniela).
parent(aleksander, daniela).

male(william).
male(thomas).
male(jeffrey).
male(andrew).
male(steve).
male(patrick).
male(john).
male(michael).
male(frank).
male(george).
male(morty).
male(jerry).
male(kramer).
male(aleksandr).
male(alessandro).
male(aleksander).

female(tina).
female(sally).
female(melanie).
female(joanne).
female(jill).
female(vanessa).
female(patricia).
female(susan).
female(michelle).
female(estelle).
female(helen).
female(elaine).
female(anna).
female(margaret).
female(ana).
female(nevia).
female(luana).
female(daniela).

% Navadni predikati
mother(X, Y) :-
    female(X),
    parent(X, Y).

grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

sister(X, Y) :-
    parent(Z,X),
    parent(Z,Y),
    female(X),    
    X \== Y.

% Definicija predikata sister/2 poskrbi za pravi spol in da ne gre za isto osebo
aunt(X, Y) :-
    sister(X, Z),
    parent(Z, Y).

% Robni pogoj, Rekurzija
ancestor(X, Y) :-
    parent(X, Y).

ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

descdendant(X, Y) :-
    ancestor(Y, X).


% Seznami

% Sezname v prologu pišemo z oglatimi oklepaji:
% L = [1, 2, 3, 4]

% in lahko vsebujejo karkoli:
% ?- L = [1, a, foo(4,5), [a,b,c], 3.14].

% Z združevanjem lahko v seznamu dostopamo do glave (prvega elementa) in repa (preostanka seznama):
% ?- [H|T] = [1,2,3,4].
% H = 1,
% T = [2,3,4].

% Seveda deluje tudi obratno:
% ?- H = 1, T = [2,3,4], L = [H|T].
% L = [1,2,3,4].

% Dva poljubna seznama lahko staknemo s predikatom append/3:
% ?- append([1,2], [3,4], L).
% L = [1,2,3,4].

% Seveda deluje tudi obratno ~ poiščemo lahko A in B, ki se stakneta v dani seznam:
% ?- append(A, B, [1,2,3]).
% A = [],
% B = [1, 2, 3] ;
% A = [1],
% B = [2, 3] ;
% A = [1, 2],
% B = [3] ;
% A = [1, 2, 3],
% B = [].

% Definirajte predikat ancestor(X, Y, L), ki deluje enako kot ancestor/2, le da vrne še seznam oseb na poti od X do Y.
ancestor(X, Y, [X, Y]) :- 
    parent(X, Y).

ancestor(X, Y, [X|Path]) :-
    parent(X, Z),
    ancestor(Z, Y, Path).

% Definirajte predikat member(X, L), ki velja, ko je X element seznama L.
member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).

% Definirajte predikat insert(X, L1, L2), ki velja, ko seznam L2 dobimo tako, da v L1 vstavimo X na poljubno mesto
% element lahko vstavimo na prvo mesto
insert(X, L, [X|L]).
% rekurzija poskrbi za vse ostale možnosti
insert(X, [H|T], [H|T2]) :-
    insert(X, T, T2).
% insert(1, [2,3], L).
% L = [1,2,3] ;
% L = [2,1,3] ;
% L = [2,3,1].


% Definirajte predikat reverse(A, B), ki velja, ko vsebuje seznam B elemente seznama A v obratnem vrstnem redu.
reverse([], []).
reverse([H|T], L) :-
    reverse(T, R),
    append(R, [H], L). % za dodajanje na konec seznama si pomagamo z append/3



% -------------------- Turingov stroj ------------------------------------------------

% Check if a list is sorted
is_sorted(L) :-
    % Split the list L into some prefix list _, and a suffix list starting with [A, B|_]
    % [A, B|_] is a list of at least two elements where 'A' and 'B' are the first two elements
    % In Prolog, when a predicate has multiple clauses or theere are multiple solutions to a
    % goal like in our case append/3, prolog will try each one in turn until it finds a solutioni
    % that makes the entire predicate true. If no solution is found, it will backtrack and try
    % the next one. So it wil generate all possible splits
    \+ (append(_, [A, B|_], L), A > B).

is_sorted([X,Y|T]) :-
    X =< Y,
    is_sorted([Y|T]).

% permute/2: definirajete predikat permute(A, B), ki velja ce je seznam B, permutacija elementov iz seznama A
% Base case: empty list is a permutation of itself
permute([], []).
% Recursive case: applies to lists with at least one argument
permute([H|T], L) :-
    % L1 is a permutation of T
    permute(T, L1),
    % L is a permutation of H and L1
    insert(H, L1, L).


% ----------------------- Random izpiti ------------------------------------
sum([], 0).
sum([H|T], Sum) :-
    sum_list(T, SumTail),
    Sum is H + SumTail.

% Izpiti
balance(L, R, B) :-
    sum(L, SumL),
    sum(R, SumR),
    B is SumR - SumL.


% If there are no weights available than L and R must be also empty
split([], [], []).

% all three clauses can be used during the execution of the split/3 predicate because Prolog uses backtracking to explore all possible solutions.
% In Prolog, when you write several clauses for the same predicate (like split/3 in this case), Prolog treats them as being joined by a logical "OR". That means Prolog will try each clause in order from top to bottom, and stop as soon as it finds one that succeeds.

split([H|T], [H|L], R) :-
    split(T, L, R).

split([H|T], L, [H|R]) :-
    split(T, L, R).

% Don't add weight to any side
split([_|T], L, R) :-
    split(T, L, R).

% ?- split([1,2,3], L, R)


% measure(Ws, W), all possible W that we can weight, using weights from Ws
measure(Ws, W) :-
    split(Ws, L, R),
    balance(L, R, W).

% measure_interval(Ws, A, B), when we can with weights in Ws measure objects from weight of A to including B.
measure_interval(_,A, B) :-
    A > B.

measure_interval(Ws, A, B) :-
    once(measure(Ws, A)),
    A1 is A + 1,
    measure_interval(Ws, A1, B).

% length(Ws, 4), Ws in 1..40, label(Ws), measure_interval(Ws,0,40).

zacetne_zaloge([a/10, b/3, c/0, d/5, e/1, m/3, g/2]).

cesta(a, b, 8).
cesta(b, c, 3).
cesta(c, d, 4).
cesta(a, e, 6).
cesta(e, m, 9).
cesta(m, g, 3).
cesta(g, d, 5).
cesta(g, b, 4).


% Sestavite predikat sprazni(V, Z1, Z2), ki sprazni zaloge goriva v vozlišču V, pri
% čemer so Z1 trenutne zaloge in Z2 zaloge, ko spraznimo V. Primer:
% ?- sprazni (c, [a/5, b/3, c/4, d/8], Z2).
% Z2 = [a/5, b/3, c/0, d/8].
sprazni(_, [], []).

sprazni(H, [H/_|T], [H/0|R]) :-
    sprazni(H, T, R).

sprazni(H, [N/M|T], [N/M|R]) :-
    H \= N,
    sprazni(H, T, R).


% natoci(V, G1, Z1, G2, Z2), ki sprejme vozlisce V, trenutno gorivo v avtu G1 in zaloge Z1.
% Gorivo iz vozlisca V pretoci v avto, da dobi novo stanje goriva G2 in zaloge Z2
natoci(_, G1, [], G1, []).

natoci(V, G1, [V/N|T], G2, [V/0|Z2]) :-
    G2 is G1 + N,
    natoci(V, G2, T, G2, Z2).

natoci(V, G1, [H/N|T], G2, [H/N|Z2]) :-
    V \= H,
    natoci(V, G1, T, G2, Z2).


:-use_module(library(clpfd)).

eval([ N ] , N ).

eval([+| E ] , A ) :-
    append(E1, E2 ,E ),
    eval( E1, A1 ),
    eval( E2, A2 ),
    A #= A1 + A2.

eval([ -| E ] , A ) :-
    append( E1 , E2 , E ) ,
    eval( E1 , A1 ),
    eval( E2 , A2 ),
    A #= A1 - A2 .

eval([*| E ] , A ) :-
    append( E1 , E2 , E ),
    eval( E1 , A1 ),
    eval( E2 , A2 ),
    A #= A1 * A2.