#import "./lib.typ": *

// NOTE: All arguments areentirely optional.
#show: ctutypst.with(
    title: [Thesis Example],
    title-translated: [Příklad práce],
    subtitle: [This is a subtitle.],
    author: "lyzynec",
    lang: "en",
    institution: "fel",

    thesis-type: ctu-masters-thesis,

    department: "Department of Control Engineering",

    supervisor: "Some Guy",
    supervisor-address: "Somewhere",
    study-program: "bruh",

    //assignment: "assignment.pdf",

    acknowledgements: "I want to thank god (Jiří Velebil).",
    declaration: "I hereby declare myself sleepy.",

    abstract-en: [English abstract here.],
    abstract-cs: [Český abstrakt zde.],

    keywords-en: ("key", "word"),
    keywords-cs: ("klíčo", "slovo"),
)

= Introduction
#lorem(50)

#lorem(50)

= Figures & Tables
== Figures
Reference to figure @fig.
#figure(caption: [This is a figure.],
    image("./resources/symbols/symbol-inv.svg")
) <fig>

== Tables
Reference to table @tab.
#figure(caption: [This is a table.], table(
    columns: 2,
    [a], [b],
    [c], [d],
))<tab>

= Math
Here goes an equation @eq.
$
A bold(x) = bold(b)
$ <eq>

// From now on, headings are appendices
#show: appendix

= Additional Stuff
#lorem(50)

== Subappendix
#lorem(20)

= Bibliography
// NOTE: You can also use .bib files, full: true means it shows even unmentioned
// books.
#bibliography("bib.yml", full: true)
