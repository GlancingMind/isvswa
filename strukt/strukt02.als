/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 02.

Die Beispiele basieren auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt Structural design with Alloy
*/

/* 
Die Basis der Spezifikation eines Dateisystems wird die
Partition der Objects in Dirs und Files sein:
*/

sig Object {}

sig File, Dir extends Object {}

run {}

/* 
Wir sehen, dass wir nun Modelle ("Welten") bekommen, in denen
es Files, Dirs und Objects gibt. Es ist kein Beispiel dabei, bei
dem ein Objekt sowolh ein File als auch ein Dir ist. Dass die
beiden Teilmengen disjunkt sind, ist durch extends spezifiziert.

Dies können wir den Alloy Analyzer auch überprüfen lassen. Um
Aussagen zu überprüfen gibt es das Kommando check. Also:
*/

check Disj {
	//no File & Dir
}

/*
Ergebnis:

Warning #1
& is irrelevant because the two subexpressions are always
disjoint.
Left type = {this/File}
Right type = {this/Dir}

Das bedeutet, dass der Analyzer den Check gar nicht ausgeführt
hat, weil er schon erkannt hat, dass die beiden Teilmengen
wegen extends disjunkt sein müssen.

Wir sehen daran: Alloy enthält ein Typsystem. Dieses Typsystem
wird verwendet, um irrelevante Ausdrücke zu erkennen.
*/ 

/* 
Die erzeugten Modelle enthalten aber Beispiele, in denen es
sich nicht um eine wirkliche Partitionierung handelt:
*/

check Partition {
	Object = File + Dir
}

/*
Um den Check ausführen zu können müssen wir oben
no File & Dir
auskommentieren
*/

/* 
Jetzt liefert der check Gegenbeispiele, eben solche bei denen
Objects vorkommen, die weder Fils noch Dirs sind.

D.h. extends garantiert nur die Disjunktheit, spezifiziert aber
nicht wirklich eine Partitionierung. Aber auch dafür gibt es ein
spezielles Konzept in Alloy (das man erraten kann!), das wir in
strukt03.als ansehen werden.
*/


   
