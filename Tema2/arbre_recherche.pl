


est_arbre_recherche(void).
est_arbre_recherche(T):-est_arbre_recherche(T,_,_).
est_arbre_recherche(arbre(X,void,void), X, X).
est_arbre_recherche(arbre(X,arbre(G,GG,DG),void), Min, X):-
		    G<X,
		    est_arbre_recherche(arbre(G,GG,DG),Min,_).
est_arbre_recherche(arbre(X,void,arbre(D,GD,DD)), X, Max):-
		    D>X,
		    est_arbre_recherche(arbre(D,GD,DD),_,Max).
est_arbre_recherche(arbre(X,arbre(G,GG,DG),arbre(D,GD,DD)),Min,Max):-
		    G<X,D>X,
		    est_arbre_recherche(arbre(G,GG,DG),Min,_),
		    est_arbre_recherche(arbre(D,GD,DD),_,Max).
