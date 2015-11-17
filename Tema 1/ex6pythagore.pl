pythagore(0,0,0).
pythagore(X,0,X).
pythagore(0,X,X).
pythagore(X,Y,Z):-T1 is X*X,T2 is Y*Y,P is Z*Z,check(T1,T2,P).
check(T1,T2,P):-P is T1+T2.
