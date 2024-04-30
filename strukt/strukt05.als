/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 05.

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
one sig Root extends Dir {}

sig Entry {}
sig Name {}

/* 
Wir spezifizieren, dass ein Verzeichnis vom Typ Dir
mehrere Einträge vom Typ Entry enthalten kann.

Dazu verwenden wir ein Feld entries in der Signatur Dir:
*/

sig Dir extends Object {
	entries: set Entry
}

run {}


/*
Tatsächlich haben wir durch das Feld entries eine binäre
Relation definiert, d.h. entries ist eine Teilmenge des
kartesischen Produkts Dir -> Entry (-> bezeichnet in Alloy
das kartesische Produkt).
*/

/*
Alloy Themes:
In der Visualisierung der Modelle werden die Tupel dieser
Relation durch einen Pfeil mit dem Label entries dargestellt.

Man kann aber auch die Visualisierung ändern und die Relation
entries als Attribut der Signatur Dir anzeigen.

Wir werden später noch mit den Einstellungen experimentieren.
*/

/* 
Alloy Evaluator:
Wir können zu einem erzeugten Modell auch den Alloy Evaluator
aufrufen und dort Ausdrücke oder Formeln für dieses konkrete
Modell auswerten.

Zum Beispiel

- Dir
- entries
- Dir$0.entries
- Dir$0->Entry$0
- Dir$0->Entry

Im Evaluator sieht man am besten, dass in Alloy alles eine Relation
ist.
*/

/*
Weiter geht es mit strukt06.als
*/

