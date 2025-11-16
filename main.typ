// Example usage of the academic-notes template
// This demonstrates how to use the template for academic notes

#import "template.typ": *

#show: academic-notes.with(
  // Required parameters
  title: "Course Name",
  subtitle: "University Name - Master's Degree in Computer Science",
  authors: (
    ("Your Name", "your-github-username"),
    ("Another Author", "their-github-username"),
  ),

  // Optional parameters (these have defaults if not specified)
  repo-url: "https://github.com/your-username/repo-name",
  license: "CC-BY-4.0",
  license-url: "https://creativecommons.org/licenses/by/4.0/",
  last-modified-label: "Last modified", // Customize this (e.g., "Ultima modifica" for Italian)

  // Custom introduction (optional - if omitted, a default one is generated)
  introduction: [
    #show link: underline
    = Course Name Notes

    Notes from the #link("https://example.com")[_Course Name_] course (a.y. 2024/25),
    taught by Prof. _Professor Name_, Master's Degree in Computer Science,
    University Name.

    Created by #(("Your Name", "your-github-username"), ("Another Author", "their-github-username")).map(author => [#link("https://github.com/" + author.at(1))[#text(author.at(0))]]).join([, ]),
    with contributions from #link("https://github.com/your-username/repo-name/graphs/contributors")[other contributors].

    These notes are open source: #link("https://github.com/your-username/repo-name")[github.com/your-username/repo-name]
    licensed under #link("https://creativecommons.org/licenses/by/4.0/")[CC-BY-4.0].
    Contributions and corrections are welcome via Issues or Pull Requests.

    Last modified: #datetime.today().display("[day]/[month]/[year]").
  ],

  // Styling options (optional - these have sensible defaults)
  heading-numbering: "1.1.",
  figure-supplement: "Figure",
)

// ============================================================================
// YOUR CONTENT STARTS HERE
// ============================================================================

// You can organize your content with parts
#part("First Part")

= First Chapter

== Section 1.1

This is example content. You can use all template helpers:

#nota[
  This is an informative note.
]

#attenzione[
  This is an important warning.
]

#esempio[
  This is a practical example.
]

#informalmente[
  Informal explanation of the concept.
]

=== Theorems and Proofs

#teorema("Example Theorem")[
  This is the theorem content. Equations are numbered automatically:
  $ sum_(i=1)^n i = (n(n+1))/2 $ <eq-sum>
]

#dimostrazione[
  This is the proof. Equations are also numbered here:
  $ 2 dot sum_(i=1)^n i = sum_(i=1)^n i + sum_(i=1)^n i $

  We can reference @eq-sum using links.
]

=== Colored Math

You can use colors to highlight parts of mathematical formulas:
$ mg(x^2) + mo(y^2) = mb(z^2) $

== Section 1.2

More content...

#part("Second Part")

= Second Chapter

Content of the second chapter...

#todo // Use this to mark incomplete sections

#include "chapters/example.typ" // You can include external files for better organization
