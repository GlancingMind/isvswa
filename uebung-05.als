//sig Person {
//    mother: Person,
//    father: Person,
//    sister: Person
//}

sig s {
    p: set s,
    q: set s
}

assert a {
    s.(p + q) = s.p + s.q
}

assert b {
    s.(p - q) = s.p - s.q
}

assert c {
    s.(p & q) = s.p & s.q
}

assert d {
    ~(p & q) = ~p + ~q
}

assert e {
    p.~q = q.p
}

assert f {
    s.~p = p.s
}

check a
check b
check c
check d
check e
check f
