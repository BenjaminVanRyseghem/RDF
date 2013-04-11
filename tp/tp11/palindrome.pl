atom_reverse(X,X) :- atom_length(X,0).
atom_reverse(X,X) :- atom_length(X,1).
atom_reverse(X,Y) :- atom_concat(A,B,X), atom_length(A,1), atom_reverse(B,B2), atom_concat(B2, A,Y).

palindrome(X) :- atom_reverse(X, X).