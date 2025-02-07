#import "configs/style.typ" as doc_style
#show: doc_style.main

#import "configs/great-theorems.typ" as gt
#show: gt.main

#import "configs/misc.typ" as misc


#let affls = (
  one: (
    department: "Department of Economic Research",
    institution: "Central Bank of Gondwana",
    location: "New Londo, DS 420-666",
    country: "Gondwana"),
)

#let authors = (
  (name: "Author One",
   affl: "one",
   email: "one@der.cbg.gob"),
)

#show: misc.main.with(
  title: [Article Example],
  authors: (authors, affls),
  keywords: ("keyword one", "keyword two", "keyword three"),
  pubdata: (
    id: "21-0000",
    editor: "My editor",
    volume: 23,
    submitted-at: datetime(year: 2021, month: 1, day: 1),
    revised-at: datetime(year: 2022, month: 5, day: 1),
    published-at: datetime(year: 2022, month: 9, day: 1),
  ),
)

#include "sections/example.typ"

#bibliography(
  "references.bib",
  style: "chicago-author-date"
)
