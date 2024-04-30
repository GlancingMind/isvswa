/*
Spezifikation von Strukturen (statisch) in Alloy am Beispiel 
der Spezifikation eines Dateisystems. Teil 06.

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

/*
Nun wollen wir das Konzept der Hardlinks vervollständigen:
Ein Entry hat einen Namen und verweist auf ein Object, die
eigentliche Datei oder das Verzeichnis:
*/

sig Entry {
	name: one Name,
	object: one Object
}

/*
Nun wollen wir dafür sorgen, dass wir interessante Modelle
mit run bekommen. Dazu geben wir für den Lauf einige 
Integritätsbedingungen an:
*/

run {
	some File
	some Dir - Root
} for 4

/* 
Damit wir die Diagramme besser lesen können, passen wir das
Theme an:
- wir lassen uns ein Layout per Magie erzeugen
- wir zeigen den Name eines Entry als Attribut
- wir zeigen nicht verwendete Namen nicht an
- wir speichern das Theme als strukt.thm
*/

/* 
Doch nun wollen wir mal die erzeugten Modelle genauer
ansehen. Wir entdecken Probleme:
- ein Entry kann zu mehreren Dirs gehören
- verschiedene Entries können im gleichen Dir denselben Namen haben
- Es kann ein Dir != Root ohne Eltern geben
- Es kann ein File geben, das in keinem Entry vorkommt
- ...

Unser Modelle sind unterspezifiziert. Es sind Konfigurationen
möglich, die unserer Intention nicht entsprechen, die wir aber
explizit ausschließen müssen. Dazu kann man in Alloy 
Integritätsbedingungen als fact definieren. Ein fact muss in jedem
erzeugten Modell erfüllt sein.

Solche facts definieren wir in strukt07.als
*/

