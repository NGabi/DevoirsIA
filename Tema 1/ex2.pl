langage(X):-member(X,[html,c,java,prolog]).
domaine(X):-member(X,[math,physique,chimie,bio]).

specialist(X,Y):-langage(X),domaine(Y),Y\=chimie,Y\=bio.
specialist(X,chimie):-langage(X),X\=html.
specialist(X,bio):-X=java.

james(X,Y):-specialist(X,Y).
tom(X,Y):-specialist(X,Y),X\=prolog,X\=html,Y\=math.
bob(X,Y):-specialist(X,Y),Y=physique,X\=prolog.
jim(X,Y):-specialist(X,Y).

amis(L):-james(X1,Y1),tom(X2,Y2),bob(X3,Y3),jim(X4,Y4),X1\=X2,X1\=X3,X1\=X4,X2\=X3,X2\=X4,X3\=X4,Y1\=Y2,Y1\=Y3,Y1\=Y4,Y2\=Y3,Y2\=Y4,Y3\=Y4,L=[[X1,Y1],[X2,Y2],[X3,Y3],[X4,Y4]].

