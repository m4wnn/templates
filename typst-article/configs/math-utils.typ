
// Font variant for math equations.
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

// Equations with no numbering.
#let nonum(eq) = math.equation(block: true, numbering: none, eq)
