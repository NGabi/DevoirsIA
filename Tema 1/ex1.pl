div(L, X, Y):-split(L,L,X,Y).

split(Y,[],[],Y).
split([H|T],[_,_|T1],[H|T2],Y):-split(T,T1,T2,Y).
split([H|T],[X|T1],[H|T2],Y):-split(T,T1,T2,Y).