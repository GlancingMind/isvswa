sig Node {
  edges: set Node
}

// starke zusammengehörigkeit
pred strongly_connected {
  all disj n1, n2 : Node | n1 in n2.^edges
}

// Schwache zusammengehörigkeit
pred weekly_connected {
  all disj n1, n2 : Node | n1 in n2.^(edges + ~edges) // mit ~edges machen wir aus dem Graphen ein ungerichteten Graphen.
}

// vollständiger Graph
pred complete {
  all disj n1, n2 : Node | n1 -> n2 in edges
  // kann auch so ausgedrückt werden
  // Node -> Node - iden
}
