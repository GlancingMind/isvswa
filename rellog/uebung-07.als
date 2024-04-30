sig A, B {}

one sig Relation {
    r: A -> B
}

// die Relation ist injektiv, wenn zwei Elemente von A niemals dasselbe Element von B zugeordnet haben.
// D.h. auf ein Element von B zeigt maximal ein Element von A
pred injektiv [r: A->B] {
    all b: B | lone r.b
}

// die Relation ist surjektiv, wenn jedes Element von B mindestens einem Element von A zugeordnet ist.
pred surjektiv [r: A->B] {
    all b: B | some r.b
}

// die Relation ist eine partielle Funktion, wenn jedes Element von A höchstens einem Element von B zugeordnet ist.
pred partiell [r: A->B] {
    all a: A | lone a.r
}

// die Relation ist total, wenn jedes Element von A mindestens einem Element von B zugeordnet ist
pred total [r: A->B] {
    all a: A | some a.r
}

// die Relation ist eine (totale) Funktion, wenn jedes Element von A genau einem Element von B zugeordnet ist.
pred funktion [r: A->B] {
    all a: A | one a.r
}

// die Relation ist eine Darstellung, wenn sie partiell und injektiv ist.
pred projektion [r: A->B] {
    partiell[r] and injektiv[r]
}

// die Relation ist eine Abstraktion, wenn sie partiell und surjektiv ist.
pred abstraktion [r: A->B] {
    partiell[r] and surjektiv[r]
}

// die Relation ist eine Injektion, wenn sie eine Funktion und injektiv ist.
pred injektion [r: A->B] {
    funktion[r] and injektiv[r]
}

// die Relation ist eine Surjektion, wenn sie eine Funktion und surjektiv ist.
pred surjektion [r: A->B] {
    funktion[r] and surjektiv[r]
}

// die Relation ist eine Bijektion, wenn sie eine Injektion und eine Surjektion ist.
pred bijektion [r: A->B] {
    injektion[r] and surjektion[r]
}

run {
    // injektiv[Relation.r]
    // surjektiv[Relation.r]
    // partiell[Relation.r]
    // total[Relation.r]
    // funktion[Relation.r]
    // projektion[Relation.r]
    // abstraktion[Relation.r]
    // injektion[Relation.r]
    // surjektion[Relation.r]
    bijektion[Relation.r]
}
