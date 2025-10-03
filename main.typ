#import "imports.typ": *

// metadata
#let title = "Corso di Template"
#let subtitle = "Università degli Studi di Milano - Informatica"
#let authors = (("Luca Favini", "Favo02"), ("Andrea Sacchi", "alsacchi"))

#set document(
  title: title,
  author: authors.map(author => author.at(0)),
)

// first page and outline
#frontmatter(title, subtitle, authors)

// various settings
#set terms(separator: [: ]) // terms list
#set heading(numbering: "1.1.") // heading numbering
#set math.equation(numbering: "(1.1)", supplement: "EQ") // equations numbering
#show: equate.equate.with(breakable: true, sub-numbering: true) // equations settings
#show: gentle-clues.gentle-clues.with(breakable: true) // colored boxes
#show: codly.codly-init.with() // code setup

// page break every chapter
#show heading.where(level: 1): it => {
  pagebreak()
  it
}

// header and footer
#set page(
  numbering: "1",
  number-align: bottom + right,
  header: [
    #set text(8pt, style: "italic")
    #title
    #h(1fr)
    #context [
      #let headings = query(heading)
      #let current-page = here().page()
      #let filtered-headings = headings.filter(h => h.location().page() <= current-page)
      #if filtered-headings.len() > 0 [
        #let current-heading = filtered-headings.last()
        #if current-heading.numbering != none [
          #numbering(current-heading.numbering, ..counter(heading).at(current-heading.location())) #current-heading.body
        ] else [
          #current-heading.body
        ]
      ]
    ]
  ],
  footer: [
    #set text(8pt)
    _#authors.map(author => author.at(0)).join(", ") - #datetime.today().display("[day]/[month]/[year]")_
    #h(1fr)
    #context [#text(12pt)[#counter(page).display("1")]]
  ],
)

// content
#include "chapters/1-example.typ"
