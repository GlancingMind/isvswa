/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 09.

Die Beispiele basieren auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt Structural design with Alloy
*/

/* 
Bisher haben wir immer binäre Relationen verwendet. Man kann
in Alloy aber auch n-äre Relationen einsetzen.

Als Beispiel machen wir eine Variante der Spezifikation unseres
Dateisystems mit Hardlinks, bei der eine ternäre Relation
vorkommt. 
*/

abstract sig Object {}

sig File extends Object {}

sig Dir extends Object {
	entries: Name -> Object
}

/*
Dir enthält im Feld entries nun eine Menge von Paaren von
Name und Object. Das bedeutet, dass entries selbst jetzt
eine Teilmenge von Dir -> Name -> Object ist.
*/

one sig Root extends Dir {}

sig Name {}

fact {
  // Namen von Einträgen in Dirs müssen eindeutig sein
	// d.entries = Paare (Name, Object) in d und 
  // n.(d.entries) = die Menge der Namen n in diesen Paaren
  all d : Dir, n : Name | lone n.(d.entries)
}

fact {
  // Ein Dir kann in höchstens einem anderen Dir enthalten sein
	// entries.d = Einträge, in denen d vorkommt
  all d : Dir | lone entries.d
}

fact {
  // Jedes Object außer Root kommt in einem Eintrag vor
	// Object.entries = alle möglichen Paare (Name, Object)
	// Name.(Object.entries) = Menge der Objekte in diesen Paaren,
	//  also alle in ihnen vorkommenden Objekte 
  Name.(Object.entries) = Object - Root
}

fact {
   // Dirs können sich nicht selbst enthalten, auch kein Zyklus
   all d : Dir | d not in d.^{d: Dir, o: Object | some d.entries.o }
}

run {}

run {
	some File
	some Dir - Root
} for 4

/*
Die Visualisierung kann nun etwas unübersichtlich werden,
deshalb kann man besser die Darstellung der Modelle als Tabellen,
d.h. tabellarische Darstellung der Relationen verwenden.
*/

assert ObjectsAreReachable {
	Object - Root in Root.^{d: Dir, o: Object | some d.entries.o }
}


check ObjectsAreReachable 


check ObjectsAreReachable for 8

/* 
Damit ist unsere Einführung in das Design von Strukturen in
Alloy = relationale Logik abgeschlossen.

Im nächsten Abschnitt, werden wir systematisch alle Konstrukte
der relationalen Logik in Alloy kennenlernen. 
*/




