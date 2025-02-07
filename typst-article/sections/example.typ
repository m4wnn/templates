#import "../configs/great-theorems.typ" as gt

= Example

#lorem(50) @testament2018holy

$
  Y = a + b X + e
$

#gt.theorem[
  Pythagoras' Theorem
  $
  a^2 + b^2 = c^2
  $
  where:
  - $a$ and $b$ are the legs (perpendicular sides) of the right-angled triangle.
  - $c$ is the hypotenuse (the longest side opposite the right angle).

  #gt.proof[
    + Consider a right-angled triangle with sides $a$, $b$, and $c$.
    + Drop a perpendicular from the right angle to the hypotenuse, dividing the triangle into two smaller similar triangles.
    + Using properties of similar triangles and the proportionality of sides, we derive:
      #set math.equation(numbering: none)
      $
      c^2 = a^2 + b^2
      $
  ]
]
