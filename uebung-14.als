enum Name {A,B,C,D,E,F,G,H}

sig Queen {
    row: one Name,
    col: one Name
}

fact QueensCannotAttackEachOther {
    all disj q1, q2: Queen | not q1.canAttack[q2]
}

pred Queen.canAttack[q: Queen] {
        this.row = q.row
    or  this.col = q.col
    or  #elementsBetween[this.col, q.col] = #elementsBetween[this.row, q.row]
    // They are on a diagonaly to each other, if their columns are the same width
    // apart as their rows.  |col_i-col_j| == |row_i-row_j|
}

fun elementsBetween(x, y: Name): set Name {
    let s = smaller[x, y],
        e = larger[x, y] |
    e.prevs - s.prevs - s
}

run {} for exactly 8 Queen

// So könnte man direkt berechnungen durchführen.
// one sig Name {
//     A: 1,
//     B: 2,
//     C: 3,
//     D: 4,
//     E: 5,
//     F: 6,
//     G: 7,
//     H: 8
// }