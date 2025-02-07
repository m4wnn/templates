#import "@preview/great-theorems:0.1.1": *
#import "@preview/rich-counters:0.2.1": *

#let main(doc) = [
  #set heading(numbering: "1.1")
  #show: great-theorems-init
  #show link: text.with(fill: blue)
  #doc
]

#let mathcounter = rich-counter(
  identifier: "mathblocks",
  inherited_levels: 1,
)

#let theorem = mathblock(
  blocktitle: "Theorem",
  counter: mathcounter,
)

#let lemma = mathblock(
  blocktitle: "Lemma",
  counter: mathcounter,
)

#let remark = mathblock(
  blocktitle: "Remark",
  prefix: [_Remark._],
  inset: 5pt,
  fill: lime,
  radius: 5pt,
)

#let definition = mathblock(
  blocktitle: "Definition",
  counter: mathcounter,
)

#let claim = mathblock(
  blocktitle: "Claim",
  counter: mathcounter,
)

#let proof = proofblock()
