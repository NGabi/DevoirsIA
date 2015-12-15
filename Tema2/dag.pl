% Given a Graph G and a source node N, verify that G is a direct acyclic graph
% Assume that:
% 1. G is already available in the knowledge base;
% 2. All nodes are reachable from N;
% 3. Every node has exactly two outgoing edges or has none;
% 4. Each edge has a label denoting if it is the first or second outgoing edge of a node.
% The program must:
% 1. use the fail-cut combination to fail when encountering a loop; 2. use a red cut;
% 3. not be longer than 4 rules.


edge(a, b, 1).
edge(a, c, 2).
edge(b, c, 1).
edge(b, e, 2).
edge(c, d, 1).
edge(c, e, 2).


dag(Node) :- dag(Node, [Node]).

dag(Node, Visited) :- edge(Node, Dest, _),\+member(Dest, Visited).
dag(Node, Visited) :- 
	edge(Node, D1, 1),
	edge(Node, D2, 2),
	!,
	dag(D1, [D1|Visited]), 
	dag(D2, [D2|Visited]).
dag(_, _) :- !.