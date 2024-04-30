/*
Relationale Logik in Alloy. Teil 02

Die Darstellung basiert auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt A relational logic primer
*/

/* 
Die Variante der Spezifikation des Dateisystems

In dieser Datei geht es um n-äre Relationen.
*/

abstract sig Object {}

sig File extends Object {}

sig Dir extends Object {
	entries: Name -> Object
}

one sig Root extends Dir {}

sig Name {}

/* 
Wir definieren jetzt ein konkretes Modell, das wir dann für
die Beispiele für die Operatoren verwenden:
*/

one sig Name0, Name1, Name2 extends Name {}
one sig Dir0, Dir1 extends Dir {}
one sig File0 extends File {}

fact {
	#Name = 3
	#Object = 4
	entries = Root -> Name1 -> Dir0 
          + Root -> Name0 -> File0
          + Root -> Name2 -> File0
          + Dir0 -> Name1 -> Dir1
}

run {}	
	
/*
Wir brauchen jetzt keine facts, weil wir ja das Modell explizit
definiert haben. Normalerweise macht man das natürlich nicht,
hier dient es nur dazu, damit wir dann im Evaluator beispielhaft 
die Konstrukte der relationalen Logik ausprobieren können.

Für die Visualierung verwenden wir rellog.thm.
*/

/*
Wir sehen uns Beispiele im Evaluator an:

Object
Name
entries

Wir bemerken dabei, dass jedes Singleton, das wir definiert
haben eine hochgestellte Nummer 0 hat, d.h. intern ist 
zum Beispiel Dir0 tatsächlich Dir0$0.
*/

/*
Beispiele für den Join

Root.entries

ergibt die Einträge in Root, nämlich Namen die Objekte
referenzieren
┌──────┬──────┐
│Name0⁰│File0⁰│
├──────┼──────┤
│Name1⁰│Dir0⁰ │
├──────┼──────┤
│Name2⁰│File0⁰│
└──────┴──────┘

(entries.Object).Name

ergibt Verzeichnisse, die nicht leer sind
┌─────┐
│Dir0⁰│
├─────┤
│Root⁰│
└─────┘

Warum?

entries.Object
ist die Projektion auf die beiden ersten Komponenten der Relation
entries, also alle Verzeichnisse mit Namen der Einträgen:

┌─────┬──────┐
│Dir0⁰│Name1⁰│
├─────┼──────┤
│Root⁰│Name0⁰│
│     ├──────┤
│     │Name1⁰│
│     ├──────┤
│     │Name2⁰│
└─────┴──────┘

(entries.Object).Name
ist die Projektion dieser Relation auf die erste Komponente,
also alle Verzeichnisse, die Namen enthalten.

Nebenbei: . ist linksassoziativ, d.h.
(entries.Object).Name = entries.Object.Name
*/

/*
Beispiel für die Konstruktion von Relationen.

Unsere ternäre Relation entries ist eine Teilmenge von
Dir -> Name -> Object. 


┌─────┬──────┬──────┐
│Dir0⁰│Name1⁰│Dir1⁰ │
├─────┼──────┼──────┤
│Root⁰│Name0⁰│File0⁰│
│     ├──────┼──────┤
│     │Name1⁰│Dir0⁰ │
│     ├──────┼──────┤
│     │Name2⁰│File0⁰│
└─────┴──────┴──────┘

Wenn wir nun daraus die binäre Relation der Verzeichnisse und der
zugeordneten Objekte machen wollen, dann können wir das so tun:

{d: Dir, o: Object | some d.entries.o}

ergibt
┌─────┬──────┐
│Dir0⁰│Dir1⁰ │
├─────┼──────┤
│Root⁰│Dir0⁰ │
│     ├──────┤
│     │File0⁰│
└─────┴──────┘
Wir haben so die Projektion auf Komponente1 und Komponente 3 gebildet.

*/

/* 
Wir haben gesehen, dass in unseren Modellen immer auch
automatisch Integers als Objekte vorgekommen sind.

Im nächsten Skript rellog03.als wollen wir uns damit 
etwas genauer befassen.
*/






