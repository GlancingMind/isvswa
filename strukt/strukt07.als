/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 07.

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

/*
Nun formulieren wir die Integritätsbedingungen, die in allen
Modellen gelten sollen:
*/

fact {
	// Ein Entry kann nicht in mehreren Dirs vorkommen
	entries in Dir lone -> Entry
}

/*
Erläuterung:

Dies bedeutet, dass die Relation entries Teilmenge des
injektiven Produkts von Dir mit Entry ist, d.h. 
einem Dir können mehrere Entries zugeordnet sein, aber
einem Entry höchstens ein Dir.

Man kann diese Integritätsbedingung in Alloy auch anders
ausdrücken:

fact {
  all x, y: Dir | x != y implies no (x.entries & y.entries)
}

Für zwei verschiedene Dirs ist die Schnittmenge ihrer entries leer.

Da man oft Aussagen wie alle x != y hat, gibt es dafür ein
Schlüsselwort, d.h. man kann kürzer schreiben:

fact {
  all disj x, y: Dir | no (x.entries & y.entries)
}

Man kann aber die Relation entries auch in der umgekehrten
Richtung ansehen und dann schreiben:

fact {
  all e: Entry | lone entries.e
}

entries.e ist die Menge der Dirs, in denen e vorkommt. Wenn sie
höchstens ein Element haben darf, bedeutet das gerade, dass ein
Entry in höchstens einem Dir vorkommen darf.

Noch kompakter kann man ausdrücken als

fact {
  entries in Dir lone -> Entry
}

Noch kompakter könnte man gleich definieren

sig Dir extends Object {
	entries: disj set Entry
}

*/

/*
Weitere Integritätsbedingungen
*/
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
  // Ein Entry gehört zu genau einem Dir
  entries in Dir one -> Entry
}
	
fact {
   // Dirs können sich nicht selbst enthalten
	 // d.entries = Einträge in Dir d
	 // d.entries.object = Objects in diesen Einträgen
   all d : Dir | d not in d.entries.object
}

run {}

run {
	some File
	some Dir - Root
} for 4

/*
Wir können nun mit run die erzeugten Modelle überprüfen
und uns überzeugen, dass keine merkwürdigen Konfigurationen
mehr auftreten.

Aber es kann sehr viele Modelle geben und es ist schwierig,
alle zu überprüfen. Deshalb wollen wir sehen, wie man in Alloy
Eigenschaften "maschinell" überprüfen kann. (Wir behalten dabei
im Auge, dass jeweils nur Modelle mit endlich vielen Objekten zu
einem gegebenen Scope überprüft werden.)

Als Beispiel wollen wir überprüfen, ob alle Objekte von der Wurzel
aus erreichbar sind. Dazu formulieren wir eine Annahme:
*/

assert ObjectsAreReachable {
	Object - Root in Root.^(entries.object)
}

/*
Dabei ist der Operator ^ der transitive Abschluss. Das bedeutet, dass
Root.^(entries.object) alle Objekte enthält, die in Einträgen 
vorkommen, die über einen Pfad von Root aus erreichbar sind.
*/

/*
Eine Annahme kann man mit dem  Kommando check überprüfen.
Der Alloy Analyzer versucht dann ein Gegenbeispiel zu finden.
*/

check ObjectsAreReachable 

/*
Uups. Wir bekommen ein Gegenbeispiel. 

Warum: wir haben ein fact, dass ein Dir sich nicht selbst 
enthalten kann. Aber dies erlaubt trotzdem einen (indirekten)
Zyklus.

Wir müssen also die Bedingung verschärfen.
Dies tun wir in strukt08.als
*/ 



