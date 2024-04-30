/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 03.

Die Beispiele basieren auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt Structural design with Alloy
*/

/* 
Bisher:  (aber ohne abstract)
*/

abstract sig Object {}
sig File, Dir extends Object {}

run {}

/* 
Unsere Modelle enthalten jetzt Dirs und Files, andere Objects kommen
nicht vor.

Der Alloy Analyzer erzeugt Modelle mit bis zu 3 Objekten für eine
Signatur, also in unserem Beispiel bis zu 3 Objekte vom Typ Object.

Man kann beim run die Anzahl auch erhöhen oder auch exakt angeben:
*/

run {} for 4 Object

run {} for exactly 5 Object

/*
Fazit soweit:

Das Typsystem von Alloy erlaubt es mit den Schlüsselwortern
extends und abstract eine Typhierarchie zu spezifizieren, 
die einen Basistyp partitioniert.
*/

/* 
Im folgenden Skript werden wir weitere Signaturen einführen -
siehe strukt04.als
*/
 



