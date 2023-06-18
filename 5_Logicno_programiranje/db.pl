loves(romeo, juliet). % romeo loves juliet (fact)

loves(juliet, romeo) :- loves(romeo, juliet). % juliet loves romeo if romeo loves juliet

male(albert).
male(bob).
male(bill).
male(carl).
male(charlie).
male(dan).
male(edward).

female(alice).
female(betsy).
female(diana).
% listing(male)

parent(bob, carl).
parent(bob, charlie).

happy(albert).
happy(alice).
happy(bob).
happy(bill).
with_albert(alice).

near_water(albert).

runs(albert) :-
    happy(albert).

% if X is happy, then X dances
dances(alice) :-
    happy(alice),
    with_albert(alice).

does_alice_dance :- dances(alice),
    write('When Alice is happy and with Albert she dances').

swims(bob) :-
    happy(bob).

swims(bill) :-
    near_water(bill).


get_grandchild :-
    parent(albert, X),
    parent(X, Y),
    format('~w ~s grandparent ~n', [X, "is the"])


brother(bob, bill).

parent(X, carl), brother(X, Y).

grand_parent(X, Y) :-
    parent(Z, X),
    parent(Y, Z).