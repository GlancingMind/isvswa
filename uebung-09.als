sig Professor {
    betreut: set Student
}

sig Dozent in Professor + Masterstudent {}

abstract sig Student {
    matrikelnummer: one Matrikelnummer,
    fachbereich: one Fachbereich,
    absolviert: set Kurs
}
sig Bachelorstudent extends Student {}
sig Masterstudent extends Student {
    mentor: one Professor
}

sig Matrikelnummer {}
sig Fachbereich {
    bietetAn: some Kurs,
    dozenten: some Dozent
}

sig Kurs {
    dozent: one Dozent,
    voraussetzung: set Kurs,
    eingeschrieben: set Student,
    warteliste: set Student,
}
sig Pflichtkurs in Kurs {}

fact PflichkursWirdNurVonProfessorAngeboten {
    all pk: Pflichtkurs | pk.dozent in Professor
}

fact WennKeinStudentEingeschriebenIstWartelisteEinesKursesLeer {
    all k: Kurs | no k.eingeschrieben implies no k.warteliste
}

fact StudentKannNichtZugleichEingeschriebenUndAufWartelisteSein {
    all k: Kurs | no (k.eingeschrieben & k.warteliste)
}

fact MasterantKannKeineKurseLehrenInWelchenErEingeschriebenIst {
    all k: Kurs | k.dozent not in (k.eingeschrieben + k.warteliste)
}

fact KursVoraussetzungIstAzyklich {
    all k: Kurs | k not in k.^voraussetzung
}

fact StudentKannSichNurZuEinemKursAnmeldenDessenVoraussetzungenErErfuellt {
    all k: Kurs, s: k.(eingeschrieben + warteliste) | k.voraussetzung in s.absolviert
}

fact MentorEinesMasterstudentenBetreutDiesenAuch {
    ~mentor = betreut
}

assert StudentMussInMindestensEinemPflichtkursEingeschriebenSein {
    all s: Student | some pk: Pflichtkurs | s in pk.eingeschrieben
}
check StudentMussInMindestensEinemPflichtkursEingeschriebenSein

assert StudentHatAlleVorausgesetztenKurseSeinerAbsolviertenKurseAbsolviert {
    all s: Student | s.absolviert.^voraussetzung in s.absolviert
}
check StudentHatAlleVorausgesetztenKurseSeinerAbsolviertenKurseAbsolviert

run {}

// Weitere Integritätsprüfungen:
// - Eine Matrikelnummer kann nur einen Studenten zugeordnet werden.
//    all disj s1, s2: Student | s1.matrikelnummer != s2.matrikelnummer
// - Ein Kurs kann nur von einem Fachbereich angeboten werden.
// - Kurse sollten keine Gegenseitige Voraussetzungsabhängigkeit haben.
