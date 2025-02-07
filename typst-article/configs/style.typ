// General styling of the document.
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
 * h, h1, h2, h3 - Style rules for headings.
 */

#let h(body) = {
  set text(size: font-size.normal, weight: "regular")
  set block(above: 11.9pt, below: 11.7pt)
  body
}

#let h1(body) = {
  set text(size: font-size.large, weight: "bold")
  set block(above: 13pt, below: 13pt)
  body
}

#let h2(body) = {
  set text(size: font-size.normal, weight: "bold")
  set block(above: 11.9pt, below: 11.8pt)
  body
}

#let h3(body) = {
  set text(size: font-size.normal, weight: "regular")
  set block(above: 11.9pt, below: 11.7pt)
  body
}

#let main(doc) = [
  #set math.equation(numbering: "(1)")
  
  #set page(
    paper: "us-letter",
    margin: (
      top: 1in,
      bottom: 1in,
      left: 1in,
      right: 1in,
    ),
    number-align: center,
  )
  
  #set par(justify: true)
  
  #set text(
    size: 12pt,
    lang: "en",
  )

  // Basic paragraph and text settings.
  #set text(size: font-size.normal)
  #set par(leading: 0.55em, first-line-indent: 17pt, justify: true)

  // Configure heading appearence and numbering.
  #set heading(numbering: "1.1")
  #show heading.where(level: 1): it => {
    show: h1
    // Render section with such names without numbering as level 3 heading.
    let unnumbered = (
      [Acknowledgments],
      [Acknowledgments and Disclosure of Funding],
    )
    if unnumbered.any(name => name == it.body) {
      set align(left)
      set text(size: font-size.large, weight: "bold")
      set par(first-line-indent: 0pt)
      v(0.3in, weak: true)
      block(spacing: 0pt, it.body)
      v(0.2in, weak: true)
    } else {
      it
    }
  }
  
  #show heading.where(level: 2): h2
  #show heading.where(level: 3): h3

  #set enum(indent: 14pt, spacing: 15pt)
  #show enum: set block(spacing: 18pt)

  #set list(indent: 14pt, spacing: 15pt)
  #show list: set block(spacing: 18pt)
  
  #doc
]

