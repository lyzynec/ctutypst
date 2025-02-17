#import "@preview/muchpdf:0.1.0": muchpdf

//#let ctu-color = cmyk(100%, 43%, 0%, 0%) // this is the correct color, but all logos are wrong -_-
#let ctu-color = rgb(0, 101, 189)
#let ctu-font = ("Technika")

#let ctu-bachelor-thesis = "bachelor-thesis"
#let ctu-diploma-thesis = "diploma-thesis"

#let appendix(body) = {
    set heading(numbering: "A.1")
    show heading.where(level: 1): set heading(supplement: [Appendix])
    counter(heading).update(0)
    body
}

#let ctutypst(
    title: none,
    subtitle: none,
    author: (),
    lang: "cs",
    date: datetime.today(),
    thesis-type: ctu-bachelor-thesis,
    institution: "fel",
    department: none,

    supervisor: none,
    study-program: none,

    assignment: none,

    acknowledgements: none,
    declaration: none,

    abstract-en: none,
    abstract-cs: none,

    keywords-en: (),
    keywords-cs: (),

    body
) = {

    let ctu-logo-map = (
        symbol:     "resources/symbols/symbol.svg",
        symbol-inv: "resources/symbols/symbol-inv.svg",

        logo: (
            cs:     "resources/symbols/logo-cs.svg",
            en:     "resources/symbols/logo-en.svg",
        ),

        faculty: (
            fa: (
                cs: "resources/symbols/faculty/fa-cs.svg",
                en: "resources/symbols/faculty/fa-en.svg",
            ),
            fbmi: (
                cs: "resources/symbols/faculty/fbmi-cs.svg",
                en: "resources/symbols/faculty/fbmi-en.svg",
            ),
            fd: (
                cs: "resources/symbols/faculty/fd-cs.svg",
                en: "resources/symbols/faculty/fd-en.svg",
            ),
            fel: (
                cs: "resources/symbols/faculty/fel-cs.svg",
                en: "resources/symbols/faculty/fel-en.svg",
            ),
            fit: (
                cs: "resources/symbols/faculty/fit-cs.svg",
                en: "resources/symbols/faculty/fit-en.svg",
            ),
            fjfi: (
                cs: "resources/symbols/faculty/fjfi-cs.svg",
                en: "resources/symbols/faculty/fjfi-en.svg",
            ),
            fs: (
                cs: "resources/symbols/faculty/fs-cs.svg",
                en: "resources/symbols/faculty/fs-en.svg",
            ),
            fsv: (
                cs: "resources/symbols/faculty/fsv-cs.svg",
                en: "resources/symbols/faculty/fsv-en.svg",
            ),
        ),
    )
    let ctu-loc = (
        czech-technical-university: (
            cs: "České vysoké učení technické v Praze",
            en: "Czech Technical University in Prague",
        ),
        bachelor-thesis: (
            cs: "Bakalářská práce",
            en: "Bachelor Thesis",
        ),
        diploma-thesis: (
            cs: "Diplomová práce",
            en: "Diploma Thesis",
        ),

        department:     (cs: "Katedra",             en: "Department"),
        supervisor:     (cs: "Vedoucí práce",       en: "Supervisor"),
        study-program:  (cs: "Studijní program",    en: "Study program"),
        months: (
            (cs: "leden",       en: "January"),
            (cs: "únor",        en: "February"),
            (cs: "březen",      en: "March"),
            (cs: "duben",       en: "April"),
            (cs: "květen",      en: "May"),
            (cs: "červen",      en: "June"),
            (cs: "červenec",    en: "July"),
            (cs: "srpen",       en: "August"),
            (cs: "září",        en: "September"),
            (cs: "říjen",       en: "October"),
            (cs: "listopad",    en: "November"),
            (cs: "prosinec",    en: "December"),
        ),
        acknowledgement:    (cs: "Poděkování",      en: "Acknowledgement"),
        declaration:        (cs: "Prohlášení",      en: "Declaration"),
        abstract:           (cs: "Abstrakt",        en: "Abstract"),
        keywords:           (cs: "Klíčová slova",   en: "Keywords"),

        contents:           (cs: "Obsah",           en: "Contents"),
        figures:            (cs: "Obrázky",         en: "Figures"),
        chapter:            (cs: "Kapitola",        en: "Chapter"),
        bibliography:       (cs: "Literatura",      en: "Bibliography"),
    )

    let keywords = if lang == "cs" {
        keywords-cs
    } else if lang == "en" {
        keywords-en
    }

    set document(author: author, date: date, keywords: keywords, title: title)
    set page(margin: 25mm, number-align: center, numbering: "i", paper: "a4")

    set par(first-line-indent: 2em, justify: true)
    set block(spacing: 0.8em)

    set text(lang: lang, font: ctu-font)

    set list(marker:
        text(fill: ctu-color, font: ctu-font, weight: "bold", math.square.filled)
    )

    set heading(numbering: "1.1")
    show heading: set text(fill: ctu-color, font: ctu-font, weight: "bold")
    show heading: set par(justify: false, first-line-indent: 0em)

    show heading.where(level: 1): set text(size: 2em)
    show heading.where(level: 1): set heading(supplement: ctu-loc.at("chapter").at(lang))
    show heading.where(level: 2): set text(size: 1.5em)
    show heading.where(level: 3): set text(size: 1.25em)

    show heading.where(level: 1): it => {
        pagebreak()
        context if calc.even(here().page()) {
            page[]
        }
        box(stroke: (left: 0.5em + ctu-color), inset: (left: 0.5em, bottom: 1em))[
            #text(fill: black, weight: "regular")[
                #it.supplement #context counter(heading).display()
            ]\
            #it.body
        ]
        linebreak()
    }

    set math.equation(numbering: "(1)")

    set bibliography(title: none)

    show link: set text(fill: ctu-color, weight: "bold")
    show ref: set text(fill: ctu-color, weight: "bold")

    let sub-heading(body) = {
        box(
            stroke: (left: 0.5em + ctu-color),
            inset: (left: 0.5em, bottom: 1em))
        [
            #par(justify: false, first-line-indent: 0em)[
                #text(fill: ctu-color, font: ctu-font, weight: "bold", size: 2em)[
                    #body
                ]
            ]
        ]
    }

    let semi-heading(body) = {
        box(width: 100%, inset: (bottom: 1em),
        par(justify: false, first-line-indent: 0em)[
            #text(fill: ctu-color, font: ctu-font, weight: "bold", size: 1.8em)[
                #body
            ]
        ])
    }

    page(numbering: none)[ #box[
        #align(left)[#text(fill: ctu-color, font: ctu-font, weight: "bold", size: 2em, hyphenate: false)[
            #ctu-loc.at("czech-technical-university").at(lang)
        ]]
        
        #box(
            stroke: (left: 1.5em + ctu-color),
            inset: (left: 1.5em, top: 0.5em, bottom: 0.5em),
            height: 100%,
        )[
            #text(ctu-loc.at(thesis-type).at(lang), font: ctu-font, size: 2em)

            #image(ctu-logo-map.faculty.at(institution).at(lang), height: 10em)

            #v(1em)

            #text(fill: ctu-color, font: ctu-font, size: 2.5em, weight: "bold", title)
            #text(fill: black, font: ctu-font, size: 2em, subtitle)

            #align(horizon, text(fill: black, font: ctu-font, size: 2em, author))

            #v(2em)

            #align(horizon,
                if department != none {
                    text(fill: black, font: ctu-font, size: 1.6em, department)
                    
                }
            )

            #align(bottom)[
                #if supervisor != none [
                    #text(fill: black, font: ctu-font, size: 1.25em)[
                        #ctu-loc.at("supervisor").at(lang): #supervisor
                    ]
                ]

                #if study-program != none [
                    #text(fill: black, font: ctu-font, size: 1.25em)[
                        #ctu-loc.at("study-program").at(lang): #study-program
                    ]
                ]

                #text(fill: black, font: ctu-font, size: 1.25em)[
                    #ctu-loc.at("months").at(date.month() - 1).at(lang)
                    #date.year() 
                ]
            ]
        ]
    ]]

    page[]

    if assignment != none {
        set page(numbering: none)
        muchpdf(read(assignment, encoding: none), height: 100%)
        set page(numbering: "i")
    }

    context if calc.even(here().page()) { page[] }
    

    // acknowledgements and declaration
    page(
        grid(
            columns: (50%, 50%),
            align: (center, center),

            box(height: 100%)[
                #if acknowledgements != none [
                    #semi-heading(ctu-loc.at("acknowledgement").at(lang))
                    #acknowledgements
                ]
            ],
            grid.vline(stroke: 1.5em + ctu-color),
            box(height: 100%)[
                #if declaration != none [
                    #semi-heading(ctu-loc.at("declaration").at(lang))
                    #declaration
                ]
            ]
        )
    )

    // abstract and keywords
    page(
        box(grid(
            columns: (50%, 50%),
            align: (center, center),

            box(inset: (bottom: 5em))[
                #if abstract-cs != none [
                    #semi-heading(ctu-loc.at("abstract").at("cs"))
                    #abstract-cs
                ]
            ],
            grid.vline(stroke: 1.5em + ctu-color),
            box(inset: (bottom: 5em))[
                #if abstract-en != none [
                    #semi-heading(ctu-loc.at("abstract").at("en"))

                    #abstract-en
                ]
            ],
            box(height: 100%)[
                #if keywords-cs != () [
                    #semi-heading(ctu-loc.at("keywords").at("cs"))

                    #for keyword in keywords-cs [
                        #if keyword != keywords-cs.at(0) {","}
                        #keyword
                    ]
                ]
            ],
            grid.vline(stroke: 1.5em + ctu-color),
            box(height: 100%)[
                #if keywords-en != () [
                    #semi-heading(ctu-loc.at("keywords").at("en"))

                    #for keyword in keywords-en [
                        #if keyword != keywords-en.at(0) {","}
                        #keyword
                    ]
                ]
            ]       
        ))
    )

    // contents
    page(
        columns(2)[
            #semi-heading(ctu-loc.at("contents").at(lang))
            #outline(
                title: none,
                depth: 3,
                target: heading,
                fill: repeat(text(fill: ctu-color)[#math.dot]),
                indent: true
            )
        ]
    )
    page(
        context {
            if counter(figure).final().at(0) > 0 {
                columns[
                    #semi-heading(ctu-loc.at("figures").at(lang))
                    #outline(
                        title: none,
                        depth: 1,
                        target: figure.where(kind: image),
                        fill: repeat(text(fill: ctu-color)[#math.dot]),
                    )
                ]
            }
        }
    )

    context if calc.even(here().page()) { page[] }

    counter(page).update(1)


    let numberingH(c)={
        return numbering(c.numbering,..counter(heading).at(c.location()))
    }

    let currentH(level: 1)={
        let elems = query(selector(heading.where(level: level)).after(here()))

        if elems.len() != 0 and elems.first().location().page() == here().page() {
            return [#numberingH(elems.first()) #elems.first().body] 
        } else {
            elems = query(selector(heading.where(level: level)).before(here()))
            if elems.len() != 0 {
            return [#numberingH(elems.last()) #elems.last().body] 
            }
        }
        return ""
    }

    set page(numbering: "1", header: context{
        if calc.even(here().page()) [
            #align(left, text(currentH(), size: 1.5em, fill: ctu-color, font: ctu-font))
        ] else [
            #align(right, text(currentH(level: 2), size: 1em, font: ctu-font))
        ]
    })

    body
}
