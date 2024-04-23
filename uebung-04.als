abstract sig Person {
    children: set Person,
    siblings: set Person
}

sig Man, Woman extends Person {}

sig Married in Person {
    spouse: one Married
}

/*
a
- [x] Person kann sich selbst als Kind haben
- [x] Person kann sich selbst als Geschwisterteil haben
- [x] Person ist verheiratet mit sich selbst
- [ ] Person ist verheiratet mit seinem Kind
- [ ] Person kann Geschwisterteil und Kind einer Person gleichzeitig sein
- [ ] Person kann Kind seines Geschwisterteils sein
- [ ] Person können ihre gegenseitigen Kinder sein P1 <- kind von -> P2
*/


// b

pred PersonsCanNeverBeTheirOwnChildren {
    all p: Person | p not in p.children
}

pred PersonsCanNeverBeTheirOwnSpouses {
    all p: Person | p not in p.spouse
}

pred PersonsCanNeverBeTheirOwnSiblings {
    all p: Person | p not in p.siblings
}

pred PersonsCanNeverBeMarriedToTheirDescendants {
    all p: Person | no p.spouse & p.^children
}

pred PersonsCanNeverBeMarriedToTheirSiblings {
    all p: Person | no p.spouse & p.siblings
}

pred SiblingsRelationIsAlwaysBidirectional {
    all p: Person | all s : p.siblings | p in s.siblings
}

pred SpousesRelationIsAlwaysBidirectional {
    all p: Person | all s : p.spouse | p in s.spouse
}

pred PersonsCannotBeEachOthersChildren {
    all p: Person | all c : p.children | p not in c.children
}

pred APersonsChildCanNeverBeThePersonsSibling {
    all p: Person | no p.^siblings & p.^children
}

pred SiblingsHaveSameParents {
    all p: Person | all c: p.children | all s: c.siblings | s in p.children
}

pred SiblingsCannotHaveImmediateCommonDescendants {
    // This rules out incest
    all p: Person | all c : p.children | c not in p.siblings.children
}

pred PersonsCanNeverBeDescendentsOfThemself {
    all p: Person | p not in p.^children
}

pred DontMarryDescendantsOfmySiblings {
    all p: Person | all s: p.siblings | all c : s.^children | c.spouse != p
}

pred ChildrenOfAPersonMustBeSiblings {
    all p: Person | all c: p.children | all ps: p.children - c | c in ps.siblings
}

pred DescendentsOfMyChildrenCannotBeMyImmediateChildren {
    all p: Person | all c: p.children | all cc: c.^children | cc not in p.children
}

pred SiblingsOfMySiblingsAreMySiblings {
    all p: Person | all s: p.siblings | all ss : s.siblings | p in ss.siblings
}

run example {
    PersonsCanNeverBeDescendentsOfThemself
    PersonsCanNeverBeTheirOwnSpouses
    PersonsCanNeverBeTheirOwnSiblings
    PersonsCanNeverBeMarriedToTheirDescendants
    PersonsCanNeverBeMarriedToTheirSiblings
    APersonsChildCanNeverBeThePersonsSibling
    SiblingsRelationIsAlwaysBidirectional // C
    SpousesRelationIsAlwaysBidirectional
    PersonsCannotBeEachOthersChildren
    SiblingsHaveSameParents
    SiblingsCannotHaveImmediateCommonDescendants
    DontMarryDescendantsOfmySiblings
    ChildrenOfAPersonMustBeSiblings
    SiblingsOfMySiblingsAreMySiblings
    DescendentsOfMyChildrenCannotBeMyImmediateChildren
} for exactly 3 Person

// c
// Wenn eine andere PErson ein Geschwisterteil ist, dann ist dies auch umgekehrt der Fall.
// SiblingsRelationIsAlwaysBidirectional

// Verheiratete Personen haben keinen gemeinsamen Vorfahren
pred MarriedPersonsDontHaveCommonAncestor {
    all p: Person | all c: p.children | c.spouse not in p.children
}