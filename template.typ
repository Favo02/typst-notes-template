// Academic Notes Template
// A template for university course notes with rich formatting features
// Author: Luca Favini (Favo02)

#import "@preview/gentle-clues:1.2.0"
#import "@preview/equate:0.3.2"
#import "@preview/cetz:0.4.0"
#import "@preview/fletcher:0.5.8"
#import "@preview/cetz-venn:0.1.4"
#import "@preview/lovelace:0.3.0": indent, pseudocode
#import "@preview/codly:1.3.0"
#import "@preview/pinit:0.2.2"

// ============================================================================
// COLORED MATH TEXT HELPERS
// ============================================================================
// Helper functions to color mathematical text for emphasis
// Usage: $mg(x^2) + mo(y^2) = mb(z^2)$

#let mg(body) = text(fill: green, $#body$)     // green
#let mm(body) = text(fill: maroon, $#body$)    // maroon
#let mo(body) = text(fill: orange, $#body$)    // orange
#let mr(body) = text(fill: red, $#body$)       // red
#let mp(body) = text(fill: purple, $#body$)    // purple
#let mb(body) = text(fill: blue, $#body$)      // blue

// ============================================================================
// COLORED INFO BOXES
// ============================================================================
// Helper functions for different types of information boxes
// Note: default titles are in Italian, but can be customized

#let nota(body) = { gentle-clues.info(title: "Nota")[#body] }
#let attenzione(body) = { gentle-clues.warning(title: "Attenzione")[#body] }
#let informalmente(body) = { gentle-clues.idea(title: "Informalmente", accent-color: green)[#body] }
#let esempio(body) = { gentle-clues.experiment(title: "Esempio", accent-color: purple)[#body] }

// Proof box with auto-numbered equations
#let dimostrazione(body) = {
  set math.equation(numbering: "(1.1)", supplement: "EQ")
  gentle-clues.memo(title: "Dimostrazione")[#body]
}

// Theorem box with auto-numbering and auto-numbered equations
#let teoremi-counter = counter("teorema")
#let teorema(title, body) = {
  set math.equation(numbering: "(1.1)", supplement: "EQ")
  teoremi-counter.step()
  gentle-clues.task(
    title: title + "  " + emph("(THM " + context (teoremi-counter.display()) + ")"),
    accent-color: eastern,
  )[#body]
}

// ============================================================================
// LINKING HELPERS
// ============================================================================
// Helper functions for creating cross-references

// Link to a theorem by label
#let link-teorema(label) = {
  underline(link(label, "THM " + context (1 + teoremi-counter.at(locate(label)).first())))
}

// Link to a section by label
#let link-section(label) = {
  underline(link(label, context {
    let target = query(label).first()
    let heading-number = counter(heading).at(target.location())
    if target.numbering != none {
      numbering(target.numbering, ..heading-number) + " " + target.body
    } else {
      target.body
    }
  }))
}

// Link to a numbered equation by label
#let link-equation(label) = underline(ref(label))

// ============================================================================
// FRONTMATTER (COVER PAGE AND OUTLINE)
// ============================================================================

#let frontmatter(title, subtitle, authors, introduction, date, last-modified-label) = {
  align(center + horizon, block(width: 90%)[
    #text(3em)[*#title*]
    #block(above: 1.5em)[#text(1.3em)[#subtitle]]
    #block(below: 0.8em)[#(
      authors.map(author => [#link("https://github.com/" + author.at(1))[#author.at(0)]]).join([, ])
    )]
    #text(0.8em)[#last-modified-label: #date.display("[day]/[month]/[year]")]
  ])

  pagebreak()

  // Introduction section
  set heading(numbering: none, bookmarked: false, outlined: false)
  [#introduction]

  // Outline styling
  show outline.entry.where(level: 1): it => {
    if it.element.numbering == none and it.element.outlined {
      v(0.5em)
      text(1.1em)[*#it*]
    } else {
      it
    }
  }

  outline(
    title: "Table of Contents",
    indent: auto,
  )
}

// ============================================================================
// PART COUNTER AND FUNCTION
// ============================================================================
// Create major divisions in the document (displayed as full pages)
// Parts are numbered with Roman numerals (I, II, III, ...)

#let part-counter = counter("part")
#let part(title) = {
  part-counter.step()
  align(center + horizon)[
    #context {
      let part-num = numbering("I", part-counter.get().first())
      heading(level: 1, numbering: none, outlined: true, bookmarked: true)[
        Part #part-num: #title
      ]
    }
  ]
}

// ============================================================================
// WORK IN PROGRESS WARNING
// ============================================================================

#let todo = {
  emoji.warning
  [*TODO: this section is pending confirmation, it may be incorrect or incomplete*]
  emoji.warning
}

// ============================================================================
// MAIN TEMPLATE FUNCTION
// ============================================================================

#let academic-notes(
  // Required parameters
  title: none,
  subtitle: none,
  authors: (),
  // Optional parameters
  introduction: none,
  date: datetime.today(),
  repo-url: none,
  license: "CC-BY-4.0",
  license-url: "https://creativecommons.org/licenses/by/4.0/",
  last-modified-label: "Last modified",
  // Styling options
  heading-numbering: "1.1.",
  equation-numbering: none,
  figure-supplement: "Figure",
  page-numbering: "1",
  // Content
  body,
) = {
  // ============================================================================
  // VALIDATION
  // ============================================================================

  assert(title != none, message: "title is required")
  assert(subtitle != none, message: "subtitle is required")
  assert(authors.len() > 0, message: "at least one author is required")

  // ============================================================================
  // DOCUMENT METADATA
  // ============================================================================

  set document(
    title: title,
    author: authors.map(author => author.at(0)),
  )

  // ============================================================================
  // DEFAULT INTRODUCTION IF NOT PROVIDED
  // ============================================================================

  let default-introduction = [
    #show link: underline
    = #title

    #if subtitle != none [
      #subtitle
    ]

    Created by #(authors.map(author => [#link("https://github.com/" + author.at(1))[#text(author.at(0))]]).join([, ]))#if repo-url != none [, with contributions from #link(repo-url + "/graphs/contributors")[other contributors]].

    #if repo-url != none [
      These notes are open source: #link(repo-url)[#repo-url.split("://").at(1)] licensed under #link(license-url)[#license].
      Contributions and corrections are welcome via Issues or Pull Requests.
    ]

    #last-modified-label: #date.display("[day]/[month]/[year]").
  ]

  let final-introduction = if introduction != none { introduction } else { default-introduction }

  // ============================================================================
  // FRONTMATTER
  // ============================================================================

  frontmatter(title, subtitle, authors, final-introduction, date, last-modified-label)

  // ============================================================================
  // GENERAL SETTINGS
  // ============================================================================

  set terms(separator: [: ])
  set heading(numbering: heading-numbering)
  set math.equation(numbering: equation-numbering, supplement: "EQ")
  show: equate.equate.with(breakable: true, sub-numbering: true)
  show: gentle-clues.gentle-clues.with(breakable: true)
  show: codly.codly-init.with()
  show link: underline
  set figure(supplement: figure-supplement)

  // ============================================================================
  // PAGE BREAK EVERY CHAPTER
  // ============================================================================

  show heading.where(level: 1): it => {
    pagebreak()
    it
  }

  // ============================================================================
  // HEADER AND FOOTER
  // ============================================================================

  set page(
    numbering: page-numbering,
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
            #numbering(
              current-heading.numbering,
              ..counter(heading).at(current-heading.location()),
            ) #current-heading.body
          ] else [
            #current-heading.body
          ]
        ]
      ]
    ],
    footer: [
      #set text(8pt)
      _#authors.map(author => author.at(0)).join(", ") - #date.display("[day]/[month]/[year]")_
      #h(1fr)
      #context [#text(12pt)[#counter(page).display(page-numbering)]]
    ],
  )

  // ============================================================================
  // BODY CONTENT
  // ============================================================================

  body
}
