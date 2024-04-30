/*
Relationale Logik in Alloy. Teil 03

Integers in Alloy
*/

run {}

/* 
Wenn wir im Fenster mit dem Modell die Darstellung als
Txt wählen sehen wir:

---INSTANCE---
loop=0
end=0
integers={-8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7}
univ={-1, -2, -3, -4, -5, -6, -7, -8, 0, 1, 2, 3, 4, 5, 6, 7}
Int={-1, -2, -3, -4, -5, -6, -7, -8, 0, 1, 2, 3, 4, 5, 6, 7}
seq/Int={0, 1, 2, 3}
String={}
none={}
this/Univ={}

wir haben also die Integers im Bereich -8 .. 7 automatisch
als Elemente des Universums.

Wir können dieses Bereich auch erhöhen:
*/

run {} for 6 int

/*
Wir haben nun den Bereich -16 .. 15 im Universum,
d.h. die Angabe for 5 int gibt die Zahl der Bits an,
die für die Integers verwendet werden.
*/

/*
Nun wollen wir die Integers mal verwenden. Dazu öffnen wir den
Evaluator und geben ein z.B. 3 + 4.

Wir erhalten folgendes Ergebnis:


┌─┐
│3│
├─┤
│4│
└─┘

Uups!

+ ist in Alloy die Mengenvereinigung, und die Integers sind
unäre Relationen wie alles in Alloy.

Achtung: Man kann sich also bei Integern leicht vertun.

Um die üblichen Operatoren für Integers muss man Funktionen
verwenden:

add[3, 4]
sub[4, 3]
mul[2, 2]
div[3, 2]
rem[3, 2]

Wir können diese Beispiele im Evaluator ausprobieren
*/

/*
Vergleichsoperatoren können infix geschrieben werden:

1 <= 2
1 < 2
1 > 2
1 >= 2
1 != 2
1 = 2
*/

/*
Aufpassen muss man mit Overflows:

add[7, 1] ergibt -8 im Evaluator
*/

/* 
In den Options kann man für den Analyzer einstellen, ob
overflows verhindert werden sollen.

Wenn diese Option auf "Prevent overflows" eingestellt ist,
dann werden nur Modelle erzeugt, bei denen kein overflow
vorkommt.
*/

/*
Es gibt auch ein Modul integer, mit dem ein Typ Int definiert
wird, der Integers emuliert.

Diese Möglichkeit werden wir in nächsten Skript rellog04.als
untersuchen.
*/







