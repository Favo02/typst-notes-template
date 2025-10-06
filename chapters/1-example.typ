#import "../imports.typ": *

= Template ed Esempi

Questo capitolo dimostra l'uso di tutti gli elementi personalizzati disponibili nel template.

== Testo colorato in matematica <testo-colorato>

Il template offre diverse funzioni per colorare il testo matematico:

- `mg()`: $mg(1+2 -> "verde oliva")$
- `mm()`: $mm(1+2 -> "marrone")$
- `mo()`: $mo(1+2 -> "arancione")$
- `mr()`: $mr(1+2 -> "rosso")$
- `mp()`: $mp(1+2 -> "viola")$
- `mb()`: $mb(1+2 -> "blu")$

#esempio[
  Utilizzando i colori nelle equazioni:

  $ f(n) = mg(O(n^2)) + mm(Omega(n log n)) + mo(Theta(n)) $

  $ mr(x^2) + mp(y^2) = mb(r^2) $
]

== Riquadri colorati

Il template fornisce diversi tipi di riquadri per evidenziare contenuti specifici.

=== Nota

#nota[
  Questo è un riquadro di tipo "nota", utile per aggiungere informazioni supplementari o osservazioni importanti.
]

=== Attenzione

#attenzione[
  Questo è un riquadro di tipo "attenzione", utilizzato per avvertimenti o informazioni critiche da non dimenticare.
]

=== Informalmente

#informalmente[
  Questo riquadro viene utilizzato per spiegazioni informali o intuitive di concetti complessi, prima di presentare le definizioni formali.
]

=== Esempio

#esempio[
  I riquadri "esempio" contengono applicazioni pratiche o casi concreti per illustrare i concetti teorici.

  Ad esempio, dato l'insieme $A = {1, 2, 3}$, la sua cardinalità è $|A| = 3$.
]

=== Dimostrazione

#dimostrazione[
  I riquadri "dimostrazione" contengono le dimostrazioni formali dei teoremi.

  Dimostriamo che $1 + 1 = 2$:
  - Partiamo da $1$
  - Aggiungiamo $1$
  - Otteniamo $2$

  Quindi $1 + 1 = 2$, $qed$.
]

=== Teorema

#teorema("Esempio di Teorema")[
  Questo è un esempio di teorema. Ogni teorema viene numerato automaticamente.

  $ forall n in bb(N), quad n^2 >= 0 $
] <esempio-teorema>

#teorema("Altro Teorema")[
  Un secondo teorema per mostrare la numerazione progressiva.

  $ sum_(i=1)^n i = (n(n+1))/2 $
] <somma-gauss>

== Equazioni numerate <equazioni-numerate>

Le equazioni sono numerate automaticamente solo all'interno dei box `teorema` e `dimostrazione`:

#teorema("Relatività di Einstein")[
  La relazione massa-energia è espressa da:
  $ E = m c^2 $ <einstein>

  #dimostrazione[
    $ E/m = c^2 $ <einstein2>
  ]
] <teorema-einstein>

Le equazioni fuori dai box non sono numerate:

$ x + y = z $

$ integral_0^infinity e^(-x) dif x = 1 $

== Collegamenti e riferimenti

=== Collegamenti a sezioni

Possiamo creare collegamenti a sezioni utilizzando `link-section()`. Ad esempio, torniamo alla #link-section(<testo-colorato>) o alle #link-section(<equazioni-numerate>).

=== Collegamenti a teoremi

Possiamo riferirci ai teoremi usando `link-teorema()`. Vedi #link-teorema(<teorema-einstein>).

=== Collegamenti a equazioni

Le equazioni numerate nei teoremi possono essere referenziate con `link-equation()`: #link-equation(<einstein>) e #link-equation(<einstein2>).

== Liste di definizioni

Il template supporta liste di definizioni con il separatore `:`:

/ Termine 1: Definizione del primo termine, che può essere anche molto lunga e occupare più righe senza problemi.

/ Termine 2: Definizione del secondo termine.

/ $f: A -> B$: Una funzione che mappa elementi dall'insieme $A$ all'insieme $B$.

/ Complessità: Misura delle risorse (tempo, spazio) necessarie per risolvere un problema.

== Pseudocodice <pseudocodice>

Il template supporta la scrittura di pseudocodice usando il pacchetto `lovelace`:

#pseudocode(
  [*Input*: array $A[1...n]$],
  [*Output*: somma degli elementi],
  [$"somma" <- 0$],
  [*For* $i <- 1$ *to* $n$ *do*],
  indent(
    [$"somma" <- "somma" + A[i]$],
  ),
  [*End For*],
  [*Return* $"somma"$],
)

#esempio[
  Un esempio più complesso con condizioni:

  #pseudocode(
    [*Input*: numero $n$],
    [*Output*: $"true"$ se $n$ è primo, $"false"$ altrimenti],
    [*If* $n <= 1$ *then*],
    indent(
      [*Return* $"false"$],
    ),
    [*End If*],
    [*For* $i <- 2$ *to* $sqrt(n)$ *do*],
    indent(
      [*If* $n mod i = 0$ *then*],
      indent(
        [*Return* $"false"$],
      ),
      [*End If*],
    ),
    [*End For*],
    [*Return* $"true"$],
  )
]

== Diagrammi con Fletcher

Il pacchetto `fletcher` permette di creare diagrammi a grafo:

#align(center)[
  #import fletcher: *
  #diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), $A$, name: <a>),
    node((1, 0), $B$, name: <b>),
    node((0, 1), $C$, name: <c>),
    node((1, 1), $D$, name: <d>),
    edge(<a>, <b>, "->", label: $f$),
    edge(<a>, <c>, "->", label: $g$),
    edge(<b>, <d>, "->", label: $h$),
    edge(<c>, <d>, "->", label: $k$),
  )
]

#esempio[
  Un grafo più complesso con cicli:

  #align(center)[
    #import fletcher: *
    #diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      node((0, 0), [Start], shape: fletcher.shapes.pill, name: <start>),
      node((1, 0), $v_1$, name: <v1>),
      node((2, 0), $v_2$, name: <v2>),
      node((1, 1), $v_3$, name: <v3>),
      edge(<start>, <v1>, "->"),
      edge(<v1>, <v2>, "->", bend: 20deg),
      edge(<v2>, <v1>, "->", bend: 20deg),
      edge(<v1>, <v3>, "->"),
      edge(<v3>, <v2>, "->"),
    )
  ]
]

== Disegni con CeTZ

Il pacchetto `cetz` permette di creare disegni personalizzati:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Triangolo
    line((0, 0), (2, 0), stroke: 2pt + blue)
    line((2, 0), (1, 1.7), stroke: 2pt + blue)
    line((1, 1.7), (0, 0), stroke: 2pt + blue)

    // Vertici
    circle((0, 0), radius: 0.08, fill: red)
    circle((2, 0), radius: 0.08, fill: red)
    circle((1, 1.7), radius: 0.08, fill: red)

    // Etichette
    content((0, -0.3), [$A$])
    content((2, -0.3), [$B$])
    content((1, 2), [$C$])
  })
]

#esempio[
  Un grafico con forme diverse:

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      // Rettangolo
      rect((0, 0), (1, 0.6), fill: blue.transparentize(70%), stroke: 2pt + blue)
      content((0.5, 0.3), [Box 1])

      // Cerchio
      circle((2.5, 0.3), radius: 0.4, fill: red.transparentize(70%), stroke: 2pt + red)
      content((2.5, 0.3), [Box 2])

      // Freccia
      line((1.1, 0.3), (2.0, 0.3), mark: (end: ">"), stroke: 2pt)
    })
  ]
]

== Diagrammi di Venn

Il pacchetto `cetz-venn` permette di creare diagrammi di Venn:

#align(center)[
  #cetz.canvas({
    import cetz-venn: *
    import cetz.draw: *

    venn2(
      name: "venn",
      a-fill: blue.transparentize(50%),
      b-fill: red.transparentize(50%),
    )
    content("venn.a", [$A$])
    content("venn.b", [$B$])
    content("venn.ab", [$A inter B$])
  })
]

== Marcatore TODO

Quando una sezione è incompleta o necessita di revisione, utilizzare il marcatore `todo`:

#todo
