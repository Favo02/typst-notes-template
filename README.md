# Typst Notes Template

Simple [Typst](https://typst.app/home) (better than LaTeX) template for university notes, with full **English and Italian** language support.

Includes:

- multi-language support (`en` / `it`) with per-field override capability
- colored boxes (gentle-clues)
- improved equations (equate, colored macros)
- drawings and diagrams (cetz, fletcher)
- code and pseudocode (codly, lovelace)
- custom front matter, header and footer
- macros to reference theorems, sections and equations

and

- custom Copilot instructions for automatic PR review (no more typos)
- GitHub actions to automatically compile PDF (both artifact for PRs and release for main branch)
- branch rules to protect commits without review

See the [simple PDF](https://github.com/Favo02/typst-notes-template/releases/) or a [real usage PDF](https://github.com/Favo02/algoritmi-e-complessita/releases/) for an example!

## Quick Start

### 1. Minimal Usage

```typst
#import "template.typ": *

#show: academic-notes.with(
  title: "Course Name",
  subtitle: "University Name - Degree Program",
  authors: (
    ("Your Name", "github-username"),
  ),
  lang: "en", // or "it"
)

#part("First Part")

= Chapter 1
Content here...
```

### 2. With All Options

```typst
#import "template.typ": *

#show: academic-notes.with(
  // --- Required
  title: "Algorithms and Complexity",
  subtitle: "University of Example - Master's in Computer Science",
  authors: (
    ("Your Name", "your-github"),
    ("Collaborator", "their-github"),
  ),
  lang: "en", // or "it"

  // --- Optional, uncomment to change
  repo-url: "https://github.com/username/repo",
  course-url: "https://university.edu/courses/algorithms",
  year: "2024-25",
  lecturer: "Prof. Surname",
  // date: datetime.today(),
  // license: "CC-BY-4.0",
  // license-url: "https://creativecommons.org/licenses/by/4.0/",
  // heading-numbering: "1.1.",
  // equation-numbering: none,
  // page-numbering: "1",

  // --- Optional with language-based defaults, uncomment to override
  // introduction: auto,       // set to content to replace the auto-generated intro
  // last-modified-label: auto,
  // outline-title: auto,
  // part-label: auto,
  // note-title: auto,
  // warning-title: auto,
  // informally-title: auto,
  // example-title: auto,
  // proof-title: auto,
  // theorem-title: auto,
  // theorem-label: auto,
  // equation-supplement: auto,
  // figure-supplement: auto,
)

// Your content here
```

## Template Functions

### Colored Math Helpers

Highlight parts of mathematical expressions:

```typst
$ mg(x^2) + mo(y^2) = mb(z^2) $
```

- `mg(body)`: Green
- `mm(body)`: Maroon
- `mo(body)`: Orange
- `mr(body)`: Red
- `mp(body)`: Purple
- `mb(body)`: Blue
- `comment(body)`: Small inline comment (8 pt, plain text)

### Info Boxes

All boxes use the language-appropriate title by default and accept an optional `title:` override:

```typst
#note[
  Informational note. Useful for supplementary observations.
]

#warning(title: "STOP")[
  Warning or critical information.
]

#informally[
  Informal or intuitive explanation before the formal definition.
]

#example[
  A practical example or concrete case.
]

#theorem[
  Unnamed theorem — numbered automatically.
  $ sum_(i=1)^n i = (n(n+1))/2 $ <eq-sum>
]

#theorem(title: "My Theorem")[
  Named theorem — still numbered automatically.
] <my-theorem>

#proof[
  Proof of the theorem above.
  Equations are automatically numbered inside proof and theorem boxes.
]
```

> Equations are numbered automatically **only** inside `#theorem` and `#proof` boxes.

### Cross-referencing

```typst
// Link to a theorem (shows "THM N" with the correct number)
See #link-theorem(<my-theorem>)

// Link to a section (shows its number and title)
See #link-section(<section-label>)

// Link to a numbered equation
See #link-equation(<eq-sum>)
```

### Document Organization

```typst
// Major part divisions (Roman numerals, full page)
#part("Part Title")

// Chapter — triggers an automatic page break
= Chapter Title

// Section
== Section Title

// Subsection
=== Subsection Title

// Mark incomplete sections with a visible warning
#todo
```

## File Structure

For a new course, organize your files like this:

```
my-course/
├── template.typ               # The template file
├── main.typ                   # Your main document
└── chapters/                  # Individual chapter files
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
  lang: "en",
)

#include "chapters/1-chapter-one.typ"
#include "chapters/2-chapter-two.typ"
#include "chapters/3-chapter-three.typ"
```

## Parameters Reference

### Required Parameters

| Parameter  | Type                             | Description                                    |
| ---------- | -------------------------------- | ---------------------------------------------- |
| `title`    | string                           | Document title                                 |
| `subtitle` | string                           | Document subtitle (e.g. university and degree) |
| `authors`  | array of `(name, github)` tuples | At least one author required                   |
| `lang`     | `"en"` or `"it"`                 | Document language — drives all default labels  |

### Optional Parameters

| Parameter            | Type            | Default            | Description                                                               |
| -------------------- | --------------- | ------------------ | ------------------------------------------------------------------------- |
| `repo-url`           | string / `none` | `none`             | GitHub repository URL; used in the auto-generated introduction and footer |
| `course-url`         | string / `none` | `none`             | URL of the course page; used in the auto-generated introduction           |
| `year`               | string / `none` | `none`             | Academic year (e.g. `"2024-25"`); used in the auto-generated introduction |
| `lecturer`           | string / `none` | `none`             | Lecturer name; used in the auto-generated introduction                    |
| `date`               | datetime        | `datetime.today()` | Date shown in the cover and footer                                        |
| `license`            | string          | `"CC-BY-4.0"`      | License name shown in the introduction                                    |
| `license-url`        | string          | CC-BY-4.0 URL      | URL of the license                                                        |
| `heading-numbering`  | string          | `"1.1."`           | Heading numbering format                                                  |
| `equation-numbering` | string / `none` | `none`             | Global equation numbering (always enabled inside theorems/proofs)         |
| `page-numbering`     | string          | `"1"`              | Page numbering format                                                     |

### Language-Defaulted Parameters

These all default to `auto`, which resolves to the appropriate value for `lang`. Pass an explicit value to override for the whole document.

| Parameter             | `"en"` default              | `"it"` default              | Description                                                                 |
| --------------------- | --------------------------- | --------------------------- | --------------------------------------------------------------------------- |
| `introduction`        | auto-generated English text | auto-generated Italian text | Content of the introduction page; set to any content to replace it entirely |
| `last-modified-label` | `"Last modified"`           | `"Ultima modifica"`         | Label before the date on the cover                                          |
| `outline-title`       | `"Table of Contents"`       | `"Indice"`                  | Title of the table of contents                                              |
| `part-label`          | `"Part"`                    | `"Parte"`                   | Word printed before the Roman numeral in `#part()`                          |
| `note-title`          | `"Note"`                    | `"Nota"`                    | Default title for `#note[]` boxes                                           |
| `warning-title`       | `"Warning"`                 | `"Attenzione"`              | Default title for `#warning[]` boxes                                        |
| `informally-title`    | `"Informally"`              | `"Informalmente"`           | Default title for `#informally[]` boxes                                     |
| `example-title`       | `"Example"`                 | `"Esempio"`                 | Default title for `#example[]` boxes                                        |
| `proof-title`         | `"Proof"`                   | `"Dimostrazione"`           | Default title for `#proof[]` boxes                                          |
| `theorem-title`       | `"Theorem"`                 | `"Teorema"`                 | Default title for untitled `#theorem[]` boxes                               |
| `theorem-label`       | `"THM"`                     | `"THM"`                     | Short label used in theorem badges and `#link-theorem()`                    |
| `equation-supplement` | `"EQ"`                      | `"EQ"`                      | Supplement word for equation cross-references                               |
| `figure-supplement`   | `"Figure"`                  | `"Figura"`                  | Supplement word for figure cross-references                                 |

> Individual box calls also accept a `title:` named parameter to override the title for that single occurrence, e.g. `#warning(title: "Critical")[...]`.

## Examples

See `main.typ` for a complete example with all features demonstrated, and `chapters/example.typ` for an in-depth showcase of every box type, diagram tool, and cross-reference helper.

## Customization

The template is designed to be customizable. You can:

1. **Switch language**: Set `lang: "it"` or `lang: "en"` — all labels update automatically
2. **Override individual labels**: Pass any language-defaulted parameter explicitly (e.g. `theorem-label: "Teo"`)
3. **Modify colors**: Edit the color definitions in `template.typ`
4. **Add new box types**: Create new functions following the pattern of `note`, `warning`, etc.
5. **Change styling**: Adjust the `set` and `show` rules in the template function
6. **Add new helpers**: Create additional utility functions as needed
