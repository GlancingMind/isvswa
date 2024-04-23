sig Class {
  super : lone Class,
  mvars : set Var
}
one sig Object extends Class {}
sig Name {}
sig Var {
  name : one Name
}


pred OneBaseClass {
  no Object.super
  all c: Class - Object | one c.super
}

pred NoSelfInheritance {
  all c: Class | c not in c.^super
}

pred DisjMemberNames {
  mvars.name in Class -> lone Name
}

run {
  OneBaseClass
  NoSelfInheritance
  DisjMemberNames
} for 3 but exactly 4 Class

check {
  DisjMemberNames
}
