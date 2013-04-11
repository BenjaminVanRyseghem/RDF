atom_reverse(X,X) :- atom_length(X,0).
atom_reverse(X,X) :- atom_length(X,1).
atom_reverse(X,Y) :- atom_concat(A,B,X), atom_length(A,1), atom_reverse(B,B2), atom_concat(B2, A,Y).

palindrome(X) :- atom_reverse(X, X).

palindrome2(X) :- atom_length(X,0).
palindrome2(X) :- atom_length(X,1).
palindrome2(X) :- atom_length(X,S), P is S-1, L is P-1, sub_atom(X,0,1,_,A), sub_atom(X,P,1,_,A), sub_atom(X,1,L,_,W), palindrome2(W).