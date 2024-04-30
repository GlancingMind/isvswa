/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 04.

Die Beispiele basieren auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt Structural design with Alloy
*/

/* 
Bisher
*/

abstract sig Object {}
sig File, Dir extends Object {}

/*
Wir führen nun einen weiteren Subtyp von Object ein, die
Wurzel des Dateisystems. Die Besonderheit besteht darin, dass
es genau eine Wurzel gibt. Deshalb definieren wir die Wurzel
als Singleton:
*/

one sig Root extends Dir {}

/*
Wir erweitern unsere Spezifikation des Dateisystems jetzt:

Objekte in Verzeichnissen werden einen Namen haben.
Außerdem werden wir sogenannte hard links vorsehen. 

Wikipedia zu hard link:

In modernen Dateisystemen gibt es keine feste Zuordnung 
zwischen Dateinamen und der eigentlichen Datei. Vielmehr 
wird beim Erstellen der Datei – beispielsweise auf einer 
Festplatte – zunächst bloß eine Nummer als Referenz auf die 
Datei benutzt (je nach Betriebssystem Inode- oder 
File-Record-Nummer genannt) und in einem zweiten Schritt 
ein Verzeichniseintrag mit dem Dateinamen erzeugt, der auf 
diese Nummer verweist. Im eigentlichen Sinne bezeichnet harter 
Link diese Verknüpfung von Dateiname und Datei (letztere 
repräsentiert durch Inode- oder File-Record-Nummer).

Interessant dabei ist – und das ist meistens gemeint, wenn der 
Begriff harter Link benutzt wird –, dass mehrere harte Links auf 
dieselbe Datei verweisen können, also mehrere Verzeichniseinträge 
bzw. Dateinamen für ein und dieselbe Datei existieren können.

Um diese Zuordnung verwalten zu können, werden wir die Signatur
Entry verwenden.
*/

sig Entry {}
sig Name {}

/*
Das Metamodell zeigt jetzt die bisher spezifizierte Struktur
*/

run {}

/*
run ohne weitere Angaben erzeugt Modelle mit maximal 3 Objekte
pro Supertyp, also 3 Object, 3 Entry, 3 Name

Man kann aber auch explizite Grenzen angeben:
*/

run example {} for 4 but 2 Entry, exactly 3 Name

/*
Bisher haben wir keinen Zusammenhang der Signaturen mit Ausnahme 
der Paritionierung von Object.

Im folgenden Skript strukt05 werden wir nun Relationen zwischen
den Sigs einführen.
*/

