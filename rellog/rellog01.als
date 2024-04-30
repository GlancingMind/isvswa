/*
Relationale Logik in Alloy. Teil 01

Die Darstellung basiert auf

Julien Brunel, David Chemouil, Alcino Cunha, Nuno Macedo:
Formal Software Desing with Alloy 6
Abschnitt A relational logic primer
*/

/* 
Unsere Spezifikation des Dateisystems
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
Wir definieren jetzt ein konkretes Modell, das wir dann für
die Beispiele für die Operatoren verwenden:
*/



one sig Entry0, Entry1, Entry2, Entry3, Entry4 extends Entry {}
one sig Name0, Name1, Name2, Name3 extends Name {}
one sig Dir0, Dir1 extends Dir {}
one sig File0, File1 extends File {}

fact {
	#Entry = 5
	#Name = 4
	#Object = 5
	name = Entry1 -> Name2 + Entry0 -> Name0 +
         Entry2 -> Name1 + Entry3 -> Name1 +
				 Entry4 -> Name3
	entries = Root -> Entry1 + Root -> Entry0 + Root -> Entry2 +
            Dir0 -> Entry3 + Dir1 -> Entry4
	object = Entry1 -> File0 + Entry0 -> File0 +
           Entry2 -> Dir0 + Entry3 -> Dir1 + Entry4 -> File1
}

run {}	
	
/*
Wir brauchen jetzt keine specs, weil wir ja das Modell explizit
definiert haben. Normalerweise macht man das natürlich nicht,
hier dient es nur dazu, damit wir dann im Evaluator beispielhaft 
die Konstrukte der relationalen Logik ausprobieren können.

Für die Visualierung verwenden wir rellog.thm.
*/

/*
Grundsätzlich: Alles ist in Alloy eine Relation:
- ein einzelnes Element ist also eine unäre Relation 
  mit genau einem Tupel
- eine Menge ist eine unäre Relation

Wir sehen uns Beispiele im Evaluator an:

Dir
name
Root

Wir bemerken dabei, dass jedes Singleton, das wir definiert
haben eine hochgestellte Nummer 0 hat, d.h. intern ist 
zum Beispiel Dir0 tatsächlich Dir0$0.

Es gibt vordefinierte Relationen:

univ = das Universum. 

Wir beobachten, dass Integers auch automatisch vordefiniert
sind, dazu später mehr:
Int

iden = die identitätsrelation mit Tupeln (x,x) für alle x in univ

none = die leere Menge
*/

/*
Operatoren der Aussagenlogik in Alloy

Negation:    !, not
Konjunktion: &&, and
Disjunktion: ||, or
Implikation: =>, implies
Äquivalenz:  <=>, iff

Beispiele:

!Root in none ist true 
Root in none  ist false

!Root in none && Root in none  ist false

Root in none implies Dir0$0 in none ist true
!Root in none implies Dir0$0 in none ist false

implies kann optional ein else haben:
P implies Q else T entspricht (not P or Q) and (P or T) bzw. (P and Q) or (not P and T)
*/


/*
Quantoren in Alloy

Sei A eine unäre Relation (eine Menge) und P eine Formel. Dann kann man verwenden:

all x: A | P         P ist für alle x in A wahr = Allquantor
some x: A | P        Es gibt ein x in A für das P wahr ist = Existenzquantor
no x: A | P          Es gibt kein x in A für das P wahr ist = all x: A | not P
lone x: A | P        P ist für höchstens ein x in A wahr
one x: A | P         P ist für genau ein x in A wahr

Man kann auch mehrere Variablen quantifizieren:

all x, y: A | P     P ist für alle x und y in A wahr. Dabei kann x = y sein

Wenn man ausdrücken will, dass x und y verschieden sein müssen, kann man schreiben:
all x, y: A | x != y implies P oder kürzer all disj x, y: A | P

Man kann mehrere Variabeln aus unterschiedlichen Mengen gleichzeitig quantifizieren:
all x: A, y : B | P P ist wahr für alle x in A und alle y in B
*/

/*
Vordefinierte Formeln in Alloy

R in S       R ist eine Teilmenge von S. Man beachte, wenn R ein Singleton ist, dann
             kann man das auch als R ist in S enthalten auffassen.
R = S        Die beiden Relationen sind identisch
some R       R hat mindestens ein Tupel
lone R       R hat höchstens ein Tupel
one R        R hat genau ein Tupel
no R         R ist leer

Beispiele für unser Modell im Evaluator:

Root in Dir ist true
A -> B ist das kartesische Produkt
Entry -> Name
Wenn A und B Elemente sind, dann ist es das Tupel bestehend aus A und B
Entry0$0 -> Name0$0

Entry0$0 -> Name0$0 in name ist true
Entry0$0 -> Name1$0 in name ist false

Root = Dir ist false
Root != Dir ist true

some name ist true
lone name ist false
lone Root ist true
one Root ist true
one Dir ist false
no Root ist false
no Dir & File ist true, der Durchschnitt von Dir und File ist leer
*/

/*
Relationale Operatoren 1

+      Vereinigung
&      Durchschnitt
-      Differenz

Beispiele im Evaluator:

File + Dir
File & Dir
Root & Dir
Object - Dir
Dir - Object
*/

/*
Relationale Operatoren 2

.     Komposition, Relationaler Join, Dot Join
      R.S besteht aus den Tupeln (r_1, ..., r_(k-1), s_2, ..., s_l) mit
							(r_1, ..., r_k) in R und (s_1, ..., s_l) in S und r_k = s_1
      Man nennt das auch Komposition, weil es bei Funktionen gerade die Komposition der
		  Funktionen wäre: f: x -> y und g: y -> z ergibt f.g: x -> z
[]    Box Join
      Ist einfach eine andere Notation für den relationalen Join:
			R[S] = S.R
			Syntaktischer Zucker, besonders geeignet für binäre Relationen, die Hashmaps sind.
			Ist die Relation R eine Hashmap { (key1, val1), (key2, val2), ... , (keyn = valn)}
			dann ist key1.R gerade val1. Dafür kann man den Box Join schreiben: R{key1]
->    Kartesisches Produkt, Cross Join

Beispiele im Evaluator:

Root.entries        sind alle Entries der Root
entries[Root]
Root.entries.name   sind alle Namen der Entries der Root
entries.object      die binäre Relation der Verzeichnis und der Objekte, die sie enthalten
                    Beachte: entries in Dir -> Entry und object in Entry -> Object, also
                       entries.object in Dir -> Object
object[Entry0$0]		Das Objekt, das in Entry0 ist
Entry0$0.object     ebenfalls
entries.Entry       Verzeichnisse, die einen Entry enthalten
                    Kann man auch sehen als Projektion von entries auf die erste Komponente
Dir.entries         Entries, die in einem Verzeichnis vorkommen
                    Projektion von entries auf die letzte, die zweite Komponente 
File->Name          Alle möglichen Kombinationen von Files mit Namen
Dir ->Name          Alle möglichen Kombinationen von Dirs mit Namen
*/

/* Relationale Operatoren 3
<:    Einschränkung auf den Definitionsbereich, den Bereich der ersten Komponente
:>    Einschränkung auf den Wertebereich, den Bereich der letzten Komponente
++    Überschreiben von Tupeln in einer Relation
~     Transposition einer binären Relation
^     Transitiver Abschluss einer binären Relation
*     Reflexiver transitiver Abschluss einer binären Relation

Beispiele im Evaluator:

Object <: iden      Die Identitätsrelation auf Objects
Name <: iden        Die Identitätsrelation auf Namen
Root <: entries     entries nur für Root
entries :> Entry0$0 Tupel in entries, deren zweite Komponente Entry0 ist

entries ++ (Root -> (Root.entries & object.Dir))
                    Root.entries & object.Dir = Entries von Root, die Dirs sind, keine Files
                    die Tupel in entries mit erster Komponente Root werden ersetzt durch
                    den Ausdruck (Root -> (Roo─────┬───────┐
│Dir0⁰│Entry3⁰│
├─────┼───────┤
│Dir1⁰│Entry4⁰│
├─────┼───────┤
│Root⁰│Entry4⁰│
└─────┴───────┘
t.entries & object.Dir))
                    d.h. das Ergebnis hat alle entries aber keine Files in Root
entries ++ Root->Entry4$0

~entries            Die transponierte Relation entries
~entries.entries    Die binäre Relation aller Entrys im selben Dir
name.~name          Die Relation der Entry, die in denselben Namen haben
name.~name - iden   - ohne die trivialen Paare

^(entries.object)   Objekte in einem Verzeichnis oder Unterverzeichnis
Root.*(entries.object)
                    Alle Objekte im Dateisystem,  d.h. 
                    alles was man von Root aus erreichen kann und Root selbst
*/


/*
Unterschiedliche Ausdrucksweisen:

In Alloy kann man ein und denselben Sachverhalt auf drei
verschiedene Arten ausdrücken.

Als Beispiel wollen wir das Prädikat ausdrücken, das aussagt,
dass die Relation object injektiv ist, d.h. dass ein Object
in höchstens einem Entry enthalten ist.

Dies ist übrigens in unserem Beispiel nicht der Fall, d.h.
wenn wir die Aussage prüfen, müssen wir ein Gegenbeispiel
bekommen.
*/

/* 
Stil 1: im Stil der Prädikatenlogik
*/

assert object_inj1 {
	all x, y: Entry, o: Object | 
				x->o in object and y->o in object implies x=y
}

check object_inj1

/*
Stil 2: Navigierender Stil von Alloy
*/

assert object_inj2 {
	all o: Object | lone object.o
}

check object_inj2

/*
Stil 3: Relationaler Stil
*/

assert object_inj3 {
	object.~object in iden
}

check object_inj3

/*
Im nächsten Skript rellog02.als wollen wir noch
einige Beispiele mit einer ternären Relation machen.
*/
 
