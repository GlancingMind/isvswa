sig Node {
  edges: set Node
}

// starke zusammengehörigkeit
all disj n1, n2 : Node | n1 in n2.^edges

// Schwache zusammengehörigkeit
all disj n1, n2 : Node | n1 n2.^(edges + ~edges) // mit ~edges machen wir aus dem Graphen ein ungerichteten Graphen.

// vollständiger Graph
all disj n1, n2 : Node | n1 -> n2 in edges
Node -> Node - iden
