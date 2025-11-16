# Typst Notes Template

Simple [Typst](https://typst.app/home) (better than LaTeX) template for university notes.

Includes:

- colored boxes (gentle clues)
- improved equations (equate, colored macros)
- drawings and diagrams (cetz, fletcher)
- code and pseudocode (codly, lovelace)
- custom front matter, header and footer
- macros to reference theorems, sections and equations

and

- custom Copilot instructions for automatic PR review (no more typos)
- GitHub actions to automatically compile PDF (both artifact for PRs and release for main branch)

See the [simple PDF](https://github.com/Favo02/typst-notes-template/releases/) or a [real usage PDF](https://github.com/Favo02/algoritmi-e-complessita/releases/) for an example!

## Quick Start

### 1. Basic Usage

```typst
#import "template.typ": *

#show: academic-notes.with(
  title: "Course Name",
  subtitle: "University Name - Degree Program",
  authors: (
    ("Your Name", "github-username"),
    ("Collaborator", "their-github"),
  ),
)

#part("First Part")

= Chapter 1
Content here...
```

### 2. With All Options

```typst
#import "template.typ": *

#show: academic-notes.with(
  // Required
  title: "Algorithms and Complexity",
  subtitle: "University of Example - Master's in Computer Science",
  authors: (
    ("Your Name", "your-github"),
    ("Collaborator", "their-github"),
  ),

  // Optional
  repo-url: "https://github.com/username/repo",
  license: "CC-BY-4.0",
  license-url: "https://creativecommons.org/licenses/by/4.0/",
  date: datetime.today(),

  // Styling (all optional with sensible defaults)
  heading-numbering: "1.1.",
  equation-numbering: none,
  figure-supplement: "Figure",
  page-numbering: "1",

  // Custom introduction (optional)
  introduction: [
    = My Course Notes
    Custom introduction text...
  ],
)

// Your content here
```

## Template Functions

### Colored Math Helpers

Highlight parts of mathematical expressions:

```typst
$ #mg(x^2) + #mo(y^2) = #mb(z^2) $
```

- `mg(body)`: Green
- `mm(body)`: Maroon
- `mo(body)`: Orange
- `mr(body)`: Red
- `mp(body)`: Purple
- `mb(body)`: Blue

### Info Boxes

```typst
#nota[
  This is an informational note.
]

#attenzione[
  This is a warning or important attention.
]

#informalmente[
  Informal explanation of a concept.
]

#esempio[
  A practical example.
]

#teorema("Theorem Name")[
  Statement of the theorem.
  Equations are automatically numbered:
  $ sum_(i=1)^n i = (n(n+1))/2 $ <eq-label>
]

#dimostrazione[
  Proof of the theorem.
  Equations are also numbered here.
]
```

### Cross-referencing

```typst
// Link to a theorem
See #link-teorema(<theorem-label>)

// Link to a section
See #link-section(<section-label>)

// Link to an equation
See #link-equation(<eq-label>)
```

### Document Organization

```typst
// Major part divisions (Roman numerals)
#part("Part Title")

// Chapters (automatic page break)
= Chapter Title

// Sections
== Section Title

// Subsections
=== Subsection Title

// Mark incomplete sections
#todo
```

## File Structure

For a new course, organize your files like this:

```
my-course/
├── template.typ         # The template file
├── main.typ            # Your main document
└── chapters/           # Individual chapter files
    ├── 1-chapter-one.typ
    ├── 2-chapter-two.typ
    └── 3-chapter-three.typ
```

In `main.typ`:

```typst
#import "template.typ": *

#show: academic-notes.with(
  title: "Course Name",
  subtitle: "University - Degree",
  authors: (("Name", "github-user"),),
)

#include "chapters/1-chapter-one.typ"
#include "chapters/2-chapter-two.typ"
#include "chapters/3-chapter-three.typ"
```

## Parameters Reference

### Required Parameters

- `title` (string): Document title
- `subtitle` (string): Document subtitle (e.g., university and degree)
- `authors` (array of tuples): Each tuple is `("Full Name", "github-username")`

### Optional Parameters

- `introduction` (content): Custom introduction page content
- `date` (datetime): Document date (default: `datetime.today()`)
- `repo-url` (string): GitHub repository URL
- `license` (string): License name (default: "CC-BY-4.0")
- `license-url` (string): License URL (default: CC-BY-4.0 URL)
- `last-modified-label` (string): Label for the last modified date (default: "Last modified")
- `heading-numbering` (string): Heading numbering format (default: "1.1.")
- `equation-numbering` (string/none): Equation numbering format (default: none, enabled in theorems/proofs)
- `figure-supplement` (string): Figure label (default: "Figure")
- `page-numbering` (string): Page numbering format (default: "1")

## Examples

See `main.typ` for a complete example with all features demonstrated.

## Customization

The template is designed to be customizable. You can:

1. **Modify colors**: Edit the color definitions in `template.typ`
2. **Add new box types**: Create new functions following the pattern of `nota`, `attenzione`, etc.
3. **Change styling**: Adjust the `set` and `show` rules in the template function
4. **Add new helpers**: Create additional utility functions as needed
