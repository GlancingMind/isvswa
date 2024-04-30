/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 08.

Die Beispiele basieren auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt Structural design with Alloy
*/

/* 
Bisher
*/

abstract sig Object {}
sig File extends Object {}
sig Dir extends Object {
	entries: set Entry
}
one sig Root extends Dir {}

sig Name {}

sig Entry {
	name: one Name,
	object: one Object
}


fact {
	// Ein Entry kann nicht in mehreren Dirs vorkommen
	entries in Dir lone -> Entry
}
fact {
  // Namen von Einträgen in Dirs müssen eindeutig sein
	// d.entries = Einträge in d und name.n = Einträge mit Name n
  all d : Dir, n : Name | lone (d.entries & name.n)
}

fact {
  // Ein Dir kann in höchstens einem Eintrag vorkommen
	// object.d = Einträge, in denen d vorkommt
  all d : Dir | lone object.d
}

fact {
  // Jedes Object außer Root kommt in einem Eintrag vor
  Entry.object = Object - Root
}

fact {
  // Ein Entry gehören zu genau einem Dir
  entries in Dir one -> Entry
}

/* 
Hier war das Problem:	
fact {
   // Dirs können sich nicht selbst enthalten
	 // d.entries = Einträge in Dir d
	 // d.entried.object = Objects in diesen Einträgen
   all d : Dir | d not in d.entries.object
}
besser mit transitivem Abschluss:
*/

fact {
   // Dirs können sich nicht selbst enthalten
   all d : Dir | d not in d.^(entries.object)
}

run {}

run {
	some File
	some Dir - Root
} for 4


assert ObjectsAreReachable {
	Object - Root in Root.^(entries.object)
}


check ObjectsAreReachable 

/*
Jetzt bekommen wir kein Gegenbeispiel mehr. Allerdings wird nur im
Scope 3 gesucht. Wir können ihn erhöhen: 
*/ 

check ObjectsAreReachable for 8

/* 
Mit Scope 8 dauert die Überprüfung etwa 16 Sekunden auf meinem
Rechner.

Die small scope hypothesis sagt uns, dass für solche Art von 
Fragestellungen Fehler in kleinen Modellen gefunden werden können.

Wir sind also überzeugt, dass unsere Spezifikation die überprüfte
Eigenschaft hat.
*/

/* 
Es gibt noch eine andere Möglichkeit, das Dateisystem zu 
spezifizieren. Siehe strukt09.als
*/




