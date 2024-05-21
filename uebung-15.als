open util/graph[Node]

abstract sig Color {}
one sig Red, Green, Blue extends Color {}

sig Node {
    neighbor: set Node,
    color : one Color
} {
    this not in neighbor
}

fact neighbors_are_eachothers_neighbors {
    undirected[neighbor]
}

fact neighbor_have_different_colors {
    all n: Node | n.color not in n.neighbor.color
}

// run {} for exactly 3 Node


// b)

// one sig WA, SA, NT, Q, NSW, V, T extends Node {}

// fact Australia {
//     WA.neighbor = NT + SA
//     NT.neighbor = WA + SA + Q
//     SA.neighbor = WA + NT + Q + NSW + V
//     Q.neighbor = NT + SA + NSW
//     V.neighbor = SA + NSW
//     T.neighbor = none // Tasmania doesn't have any neighbors
// }

// run {}

// c

// one sig Yellow extends Color {} // comment this out to show, that the graph cannot be colored with three colors
// one sig N1, N2, N3, N4 extends Node {}
// fact Four_Colord_Graph {
//     N1.neighbor = N2 + N3 + N4
//     N2.neighbor = N1 + N3 + N4
//     N3.neighbor = N1 + N2 + N4
//     N4.neighbor = N1 + N2 + N3
// }

// run {}

// d

// Ja, wenn ein es drei Länder gibt, die miteinander benachbart sind und ein
// weiteres, welches diese drei Länder umschließt. Also auch mit allen drei
// benachbart ist. Siehe Bild.