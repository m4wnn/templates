#let font-size = (
  tiny: 6pt,
  script: 8pt,  // scriptsize
  footnote: 9pt, // footnotesize
  small: 10pt,
  normal: 11pt, // normalsize
  large: 12pt,
  Large: 14pt,
  LARGE: 17pt,
  huge: 20pt,
  Huge: 25pt,
)

/**
 * join-authors - Join a list of authors (full names, last names, or just
 * strings) to a single string.
 */
#let join-authors(authors) = {
  return if authors.len() > 2 {
    authors.join(", ", last: ", and ")
  } else if authors.len() == 2 {
    authors.join(" and ")
  } else {
    authors.at(0)
  }
}

#let make-author(author, affls) = {
  let author-affls = if type(author.affl) == array {
    author.affl
  } else {
    (author.affl, )
  }

  let lines = author-affls.map(key => {
    let affl = affls.at(key)
    let affl-keys = ("department", "institution", "location")
    return affl-keys
      .map(key => {
        let value = affl.at(key, default: none)
        if key != "location" {
          return value
        }

        // Location and country on the same line.
        let country = affl.at("country", default: none)
        if country == none {
          return value
        } else if value == none {
          return country
        } else {
          return value + ", " + country
        }
      })
      .filter(it => it != none)
      .join("\n")
  }).map(it => emph(it))

  return block(spacing: 0em, {
    show par: set block(spacing: 5.5pt)
    text(size: font-size.normal)[*#author.name*]
    set par(justify: true, leading: 5pt, first-line-indent: 0pt)
    text(size: font-size.small)[#lines.join([\ ])]
  })
}

#let make-email(author) = {
  let label = text(size: font-size.small, smallcaps(author.email))
  return block(spacing: 0em, {
    // Compensate difference between name and email font sizes (10pt vs 9pt).
    v(1pt)
    link("mailto:" + author.email, label)
  })
}

#let make-authors(authors, affls) = {
  let cells = authors
    .map(it => (make-author(it, affls), make-email(it)))
    .join()
  return grid(
    columns: (6fr, 4fr),
    align: (left + top, right + top),
    row-gutter: 12pt,  // Visually perfect.
    ..cells)
}

#let make-title(title, authors, affls, keywords, editors) = {
  // 1. Title.
  v(31pt - (0.25in + 4.5pt))
  block(width: 100%, spacing: 0em, {
    set align(center)
    set block(spacing: 0em)
    text(size: 14pt, weight: "bold", title)
  })

  // 2. Authors.
  v(23.6pt, weak: true)
  make-authors(authors, affls)
  // 3. Editors if exist.
  if editors != none and editors.len() > 0 {
    v(28.6pt, weak: true)
    text(size: font-size.small, [*Editor:* ] + editors.join([, ]))
  }

  // Render keywords if exist.
  if keywords != none {
    keywords = keywords.join([, ])
    v(6.5pt, weak: true)  // ~1ex
    block(spacing: 0em, width: 100%, {
      set text(size: 10pt)
      set par(leading: 0.51em)  // Original 0.55em (or 0.45em?).
      pad(left: 20pt, right: 20pt)[*Keywords:* #keywords]
    })
  }

  // Space before paper content.
  v(23pt, weak: true)
}

/**
 * main - Template for Journal of Machine Learning Research (JMLR) Reduced.
 *
 * Args:
 *   title: Paper title.
 *   short-title: Paper short title (for page header).
 *   authors: Tuple of author objects and affilation dictionary.
 *   last-names: List of authors last names (for page header).
 *   date: Creation date (used in PDF metadata).
 *   keywords: Publication keywords (used in PDF metadata).
 *   not reference section.
 *   pubdata: Dictionary with auxiliary information about publication. It
 *   contains editor name(s), paper id, volume, and
 *   submission/review/publishing dates.
 */
#let main(
  title: [],
  short-title: none,
  authors: (),
  last-names: (),
  date: auto,
  keywords: (),
  pubdata: (:),
  body,
) = {
  // If there is no short title then use title as a short title.
  if short-title == none {
    short-title = title
  }

  // Authors are actually a tuple of authors and affilations.
  let affls = ()
  if authors.len() == 2 {
    (authors, affls) = authors
  }

  // If last names are not specified then try to guess last names from author
  // names.
  if last-names.len() == 0 and authors.len() > 0 {
    last-names = authors.map(it => it.name.trim("\s").split(" ").at(-1))
  }

  // If there is only one editor then create an `editors` field with a single
  // editor.
  let is_preprint = pubdata.len() == 0
  let editors = if is_preprint {
    ()
  } else if pubdata.at("editors", default: none) == none {
    (pubdata.editor, )
  } else {
    pubdata.editors
  }

  // Set document metadata.
  let meta-authors = join-authors(authors.map(it => it.name))
  set document(title: title, author: meta-authors, keywords: keywords,
               date: date)


  make-title(title, authors, affls, keywords, editors)
  parbreak()
  body
}
