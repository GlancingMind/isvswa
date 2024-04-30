/*
Relationale Logik in Alloy. Teil 05

Strings in Alloy
*/

sig Entry {
	key: Int,
	val: String
}

fact {
	all e: Entry | {
		e.key = 1 implies e.val = "Hello"
		e.key = 2 implies e.val = "World"
	}
}

run { Entry.key = 1 + 2 }

/*
Man sollte Strings möglichst vermeiden.
Normalerweise benötigt man Namen oder Bezeichnungen
in unseren Spezifikationen nur zur Unterscheidung von
Objekten, also als Id. Was der Name tatsächlich ist, spielt 
keine Rolle, er muss nur die Objekte unterscheiden.
Für diesen Zweck reichen die symbolischen Namen, die der
Analyzer erzeugt, man braucht dazu keine expliziten Strings.

Bemerkung:
Ich weiß nicht, weshalb es in Alloy den vordefinierten Typ
gibt. Ich kenne keine Spezifikation, bei der er tatsächlich
verwendet wird.
*/
