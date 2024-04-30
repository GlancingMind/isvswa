/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 01.

Die Beispiele basieren auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt Structural design with Alloy
*/


/*
Wir definieren zunächst Dateien und Ordner, beides Sorten von
Objects. Dazu verwendet man Signaturen (sig).

Eine Signatur kann man sich zunächst vorstellen als die
Definition eines Typs von Objekten oder einer Menge gleichartiger
Objekte. (Später kommt mehr dazu
und wir werden sehen, dass wir eigentlich eine unäre Relation
definieren.)
*/

sig Object {}

sig File in Object {}
sig Dir in Object {}

/* 
Damit haben wir Objects definiert und Files und Dirs als
Teilmengen von Objects.

Mit dem Kommando run können wir "Welten" erzeugen, die dieser
Spezifikation entsprechen:
*/

run {}

/* 
Wir bekommen Beispiele, an denen wir sehen, dass es auch
"Welten" gibt, in denen wir Objekte sehen, die sowohl Files
als auch Dirs sind.

Das liegt daran, dass wir Teilmengen definiert haben und diese
können sich natürlich auch überlappen.

Wie können wir dies verhindern? Wir müssen es festlegen:
*/

pred Disj {
	no File & Dir
}

/*
Ein Prädikat (pred) ist eine Aussage, die wahr oder falsch sein
kann. In unserem Beispiel verwenden wir den Operator &, der
den Durchschnitt von Mengen (bzw. Relationen) bezeichnet. Außerdem
kommt no zum Einsatz, eine Bedingung, die aussagt, wieviele Elemente
eine Menge (oder wieviele Tupel eine Relation) haben darf:

no A   = A ist leer
some A = A hat mindestens ein Element
one A  = A hat genau ein Element
lone A = A hat höchstens ein Element

In unserem Fall ist die Aussage also dass der Durchschnitt von
File und Dir leer sein muss.

Wenn  wir jetzt die Beispiele ansehen:
*/

run {
	Disj
}

/*
dann sehen wir, dass nun die beiden Teilmengen disjunkt sind. Aber
es kann noch Objekte geben, die weder Files noch Dirs sind. Auch das
können wir durch ein Prädikat ausschließen:
*/

pred Partition {
	Disj
	Object = File + Dir
}

/* 
Der Operator + ist die Vereinigung von Mengen. Die beiden Bedingungen,
dass zwei Teilmengen eine Partition einer Menge bilden sind: 
(1) sie sind disjunkt und
(2) ihre Vereinigung ergibt die gesamte Menge.

Wir lassen den Alloy Analyzer wieder Beispiele produzieren:
*/

run {
	Partition
}

/*
Man kann übrigens Prädikate auch als fact spezifizieren. Dadurch
legt man fest, dass die Integritätsbedingung immer gelten muss,
bei jedem run. Man muss sie also beim run nicht explizit angeben.
*/

/* 
Das Beispiel einer Partition einer Signatur durch ihre Teilmengen
kommt oft vor, deshalb gibt es dafür ein spezielles Konzept in
Alloy: extends statt in.

Das wollen wir uns in der nächsten Spezifikation strukt02.als
ansehen.
*/

