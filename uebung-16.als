enum Bool { Verum, Falsum }

fun Bool.Not: Bool {
    this in Verum => Falsum else Verum
    // Bool - this
}

fun Bool.And[b: Bool]: Bool {
    ((this + b) in Verum) => Verum else Falsum
}

fun Bool.Or[b: Bool]: Bool {
    (this in Verum) => Verum else (b in Verum) => Verum else Falsum
    // (Verum in (this + b)) => Verum else Falsum
}

fun Bool.Implies[b: Bool]: Bool {
    // Implication "A implies B" can be written as: not A or B
    (Not[this].Or[b] in Verum) => Verum else Falsum
}
