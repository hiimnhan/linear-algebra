#import "@preview/clean-math-paper:0.2.3": *

#let date = datetime.today().display("[month repr:long]
[day], [year]")
#set math.mat(delim: "[", column-gap: 1em, row-gap: 0.2em)
#set math.cases(gap: 1em)
#let nosp = h(0pt)
#let sp_2 = h(2pt)
#let veclen(v) = {
  $bar.v.double nosp #v nosp bar.v.double$
}



#show: template.with(
  title: "Linear Algebra",
  authors: (
    (name: "Nhan Nguyen"),
  ),
  date: date,
  heading-color: rgb("#0000ff"),
  link-color: rgb("#008002"),
  // Insert your abstract after the colon, wrapped in brackets.
  abstract: [
    This note is what I have learnt and think important in linear algebra. The structure basically follows @immersiveMath.
  ],
)

= Basic notation
I use the following notation:
- $bold(A) in RR^(m times n)$ denotes a matrix with $m$ rows and $n$ columns.
- $bold(x) in RR^n$ denotes a _vector_ with $n$ entries. By default, it is a *column vector*. If I want to explicitly represent a *row vector*, I use $bold(x)^T$ (transpose of $bold(x)$).
- The $i$th element of $bold(x)$ is denoted by $x_i$
$
  bold(x) = vec(x_1, x_2, dots.v, x_n, delim: "[").
$

- I use the notation $attach(a, br: "ij")$ (or $attach(bold(A), br: "ij")$, $attach(bold(A), br: "i,j")$) for the element at coordination ($i$, $j$) of the matrix.
$
  bold(A) = mat(a_11, a_12, dots.h, a_(1n); a_21, a_22, dots.h, a_(2n); dots.v, dots.v, dots.down, dots.v; a_(m 1), a_(m 2), dots.h, a_(m n)).
$

- $j$th column of $bold(A)$ is denoted by $a_j$ or $attach(bold(A), br: : comma j)$
$
  bold(A) = mat(bar.v, bar.v, space.quad, bar.v; a_1, a_2, dots.h, a_3; bar.v, bar.v, space.quad, bar.v;)
$

- $i$th row of $bold(A)$ is denoted by $a_i$ or $attach(bold(A), br: i comma :)$
$
  A = mat(bar.h, a_1^T, bar.h; bar.h, a_2^T, bar.h; space.quad, dots.h, space.quad; bar.h, a_3^T, bar.h;).
$

= Dot Product
We need the dot product to determine how much two vectors align.
#definition(title: "Dot Product")[
  The dot product between to vector $bold(u)$ and $bold(v)$, denoted by $bold(u) dot bold(v)$ and is defined as a scalar value

  $
    bold(u) dot bold(v) = cases(
      bar.v.double nosp bold(u) nosp bar.v.double bar.v.double nosp bold(v) nosp bar.v.double cos[bold(u), bold(v)] "if" bold(u) eq.not 0 "and" bold(v) eq.not 0,
      0 "if" bold(u) eq 0 "or" bold(v) eq 0
    )
  $<dot-product>
]<dot-product-def>

== Unit vectors and Normalization
A unit vector is a vector whose length is 1, i.e., $bold(v)$ is a unit vector if $veclen(bold(v)) = 1$. A *normalized vector* $bold(n)$ is created from $v$ by dividing $bold(v)$ by its length, $veclen(bold(v))$, i.e.,
$
  bold(n) = 1 / veclen(bold(v)) bold(v)
$<vec-normalization>

== Projection
#image("projection.png")

#definition(title: "Orthgonal projection")[
  If $bold(v)$ is a non-zero vector, then the orthogonal projection of $bold(u)$ onto $v$ is denoted $P_v bold(u)$, and is defined by
  $
    P_v bold(u) = frac(bold(u) dot bold(v), veclen(bold(v))^2) bold(v)
  $
]<orth-projection>

#proof[
  Assume one vector $bold(u)$, shall be projected orthogonally onto another vector, let's say $bold(v)$, creating a new vector, $bold(w)$. Since $bold(u)$ and $bold(v)$ makes up a triangle, the following must hold:
  $
    cos[bold(u), bold(v)] = veclen(bold(w)) / veclen(bold(u))
  $
  This means that $veclen(bold(w)) = veclen(bold(u)) cos[bold(u), bold(v)]$. If v has length 1, i.e., $veclen(bold(v)) = 1$, then the projected vector can be computed as
  $
    bold(w) = veclen(bold(w)) bold(v) = veclen(bold(u)) cos[bold(u), bold(v)] bold(v)
  $

  In case of $bold(v)$ does not have length 1, we can normalize it using @eq:vec-normalization. If $bold(v)$ is replaced by $1 / veclen(bold(v)) bold(v)$ in equation above, the following is obtained
  $
    bold(w) = frac(veclen(bold(u)) cos[bold(u), bold(v)], veclen(bold(v))) bold(v)
  $
  Next, multiply both the numerator and denominator by $veclen(bold(v))$
  $
    bold(w) = frac(veclen(bold(u)) veclen(bold(v)) cos[bold(u), bold(v)], veclen(bold(v))^2) bold(v)
  $
  The numerator is @dot-product-def, now we can write shorter
  $
    bold(w) = frac(bold(u) dot bold(v), veclen(bold(v))^2) bold(v)
  $
]

== Rules and Properties
#theorem(title: "Dot product rules")[
  1. $bold(u) dot bold(v) = bold(v) dot bold(u)$
  2. $k(bold(u) dot bold(v)) = (k bold(u)) dot bold(v)$
  3. $bold(v) dot (bold(u) + bold(w)) = bold(v) dot bold(u) + bold(v) dot bold(w)$
  4. $bold(v) dot bold(v) = veclen(bold(v))^2 gt.eq 0$, with equality only when $bold(v) = 0$
]

== Orthonomal Basis
#definition(title: "Orthonormal basis")[
  For an $n$-dimensional orthonormal basis, consisting of the set of basis vectors, $brace.l bold(e)_1, dots.h, bold(e)_n brace.r$, the following must hold
  $
    bold(e)_i dot bold(e)_j = cases(
      1 "if" i = j,
      0 "if" i eq.not j.
    )
  $
  This means that basis vectors are of unit length, and pairwise orthogonal.
]<orthogonal-basis>

#definition(title: "Dot Product calculation in Orthonormal basis")[
  In any orthonormal basis, the dot product between two $n$-dimensional vectors, $bold(u)$ and $bold(v)$, can be calculated as
  $
    bold(u) dot bold(v) = sum_(i = 1)^n u_i v_i
  $
]

=== Vector length in orthonormal basis
Assume a $n$-dimensional vector $bold(v)$, its length in an orthonormal basis can be calculated as
$
  veclen(bold(v)) = sqrt(sum_(i=1)^n v_i^2)
$

= Linear Dependence and Independence
#definition(title: "Linear combination")[
  The vector, $bold(u)$, is a linear combination of the vectors, $bold(v)_1, dots.h, bold(v)_n$ when $bold(u)$ is expressed as
  $
    bold(u) = k_1 bold(v)_1 + k_2 bold(v)_2 + dots.h + k_n bold(v)_n = sum_(i = 1)^n k_i v_i
  $
  where $k_1, k_2, dots.h, k_n$ are scalar values.
]<linear-combination>

For example, $bold(w) = w_x bold(e)_1 + w_y bold(e)_2 + w_z bold(e)_3$, that is, 3-dimensional vector $bold(w)$ is a _linear combination_ of the basis vectors, $bold(e)_1$, $bold(e)_2$ and $bold(e)_3$, and $w_x$, $w_y$, $w_z$ are the scalar values.

#definition(title: "Linear independence and dependence")[
  The set of vectors, $bold(v)_1, dots.h, bold(v)_n$, is said to be linearly independent, if the equation
  $
    k_1 bold(v)_1 + k_2 bold(v)_2 + dots.h + k_n bold(v)_n = 0
  $
  *only* has a single solution which is
  $
    k_1 = k_2 = dots.h = k_n = 0
  $
  If there is at least one other solution, then the set of vectors is linearly dependent
]<linear-independence-dependence>

= Spanning
#definition(title: "Span")[
  The set of vectors $brace.l bold(v)_1, dots.h, bold(v)_q brace.r$ in $RR^n$ is said to span $RR^n$, if the equation
  $
    k_1 bold(v)_1 + k_2 bold(v)_2 + dots.h + k_n bold(v)_n = bold(u)
  $
  has at least one solution, for every vector $bold(u)$.
]<def-span>

= The Matrix
#definition(title: "Matrix transpose")[
  The transpose of an $r times c$ matrix, $bold(A)$, is denoted by $bold(A)^T$ of size $c times r$ and is formed by making the columns of $bold(A)$ into rows in $bold(A)^T$.
]

#example[
  Assume we have the following matrices,

  $
    bold(A) = mat(1, 6, 5; 6, 2, 4; 5, 4, 3), bold(B) = mat(1, 4; 2, 5; 3, 6),
    bold(C) = mat(1, 2, 3)
  $

  Their corresponding transposes are
  $
    bold(A)^T = mat(1, 6, 5; 6, 2, 4; 5, 4, 3),
    bold(B)^T = mat(1, 2, 3; 4, 5, 6),
    bold(C)^T = mat(1; 2; 3)
  $
]

#definition(title: "Symmetric matrix")[
  A square matrix is called symmetric if $bold(A) = bold(A)^T$
]

== Matrix Operations
=== Matrix Multiplication by a Scalar
#definition(title: "Matrix Multiplication by a Scalar")[
  A matrix $bold(A)$ can be multiplied by a scalar $k$ to form a new matrix $bold(S) = k bold(A)$, which is of the same size as A
  $
    bold(S) = mat(s_11, s_12, dots.h, s_(1n); s_21, s_22, dots.h, s_(2n); dots.v, dots.v, dots.down, dots.v; s_(m 1), s_(m 2), dots.h, s_(m n)) = mat(k a_11, k a_12, dots.h, k a_(1n); k a_21, k a_22, dots.h, k a_(2n); dots.v, dots.v, dots.down, dots.v; k a_(m 1), k a_(m 2), dots.h, k a_(m n))
  $
]

#example[
  A $2 times 2$ matrix $bold(A)$ is
  $
    bold(A) = mat(5, -2; 3, 8)
  $
  multiply it by $k = 4$, we get
  $
    k bold(A) = 4 #sp_2 mat(5, -2; 3, 8) = mat(4 dot 5, 4 dot (-2); 4 dot 3, 4 dot 8) = mat(20, -8; 12, 32)
  $
]

=== Matrix addition
#definition(title: "Matrix Addition")[
  If 2 matrices $bold(A)$ and $bold(B)$ have the same size, then the 2 matrices can be added to create a new matrix, $bold(S) = bold(A) + bold(B)$ of the same size, where each element $s_(i j)$ is the sum of the elements in the same position in matrix $bold(A)$ and $bold(B)$

  $
    bold(S) = mat(s_11, s_12, dots.h, s_(1n); s_21, s_22, dots.h, s_(2n); dots.v, dots.v, dots.down, dots.v; s_(m 1), s_(m 2), dots.h, s_(m n)) = mat(a_11 + b_11, a_12 + b_12, dots.h, a_(1n) + b_(1n); a_21 + b_21, a_22 + b_22, dots.h, a_(2n) + b_(2n); dots.v, dots.v, dots.down, dots.v; a_(m 1) + b_(m 1), a_(m 2) + b_(m 2), dots.h, a_(m n) + b_(m n))
  $
]

#example[
  Assume we have two $2 times 2$ matrices $bold(A)$ and $bold(B)$
  $
    bold(A) = mat(5, -2; 3, 8) "and" bold(B) = mat(-1, 2; 4, -6)
  $
  The matrix addition, $bold(S) = bold(A) + bold(B)$, is
  $
    bold(S) = bold(A) + bold(B) = mat(5, -2; 3, 8) + mat(-1, 2; 4, -6) = mat(5 - 1, -2 + 2; 3 + 4, 8 - 6) = mat(4, 0; 7, 2)
  $
]

=== Matrix-Matrix Multiplication
#definition(title: "Matrix-Matrix Multiplication")[
  Let $bold(A)$ is a $r times s$ matrix, $bold(B)$ is a $s times t$ matrix, then the product matrix $bold(P) = bold(A) bold(B)$, is defined as
  $
    bold(P) = bold(A) bold(B) &= mat(a_11, a_12, dots.h, a_(1s); a_21, a_22, dots.h, a_(2s); dots.v, dots.v, dots.down, dots.v; a_(r 1), a_(r 2), dots.h, a_(r s)) mat(b_11, b_12, dots.h, b_(1t); b_21, b_22, dots.h, b_(2t); dots.v, dots.v, dots.down, dots.v; b_(s 1), b_(s 2), dots.h, b_(s t)) \
    &= mat(attach(sum, br: k = 1, tr: s)a_(1 k) b_(k 1), dots.h, attach(sum, br: k = 1, tr: s)a_(1 k) b_(k t); dots.v, dots.down, dots.v; attach(sum, br: k = 1, tr: s)a_(r k) b_(k 1), dots.h, attach(sum, br: k = 1, tr: s)a_(s k) b_(k t))
  $
]

The sum in the product, $attach(sum, br: k = 1, tr: s)a_(i k) b_(k j)$, is the same as the dot product in an orthonormal basis (@dot-product-def). We can simplify the notion
$
  [p_(i j)] = [attach(sum, b: k = 1, t: s) a_(i k) b_(k j)] = [bold(a)_(i ,) dot bold(b)_(, j)]
$

*The column picture of matrix multiplication*

Every column of $bold(P)$ is a _linear combination_ of the columns of $bold(A)$.

#figure(
  image("col-pic.png"),
  caption: [Column picture of matrix multiplication. Image taken from @strangArtLinearAlgebra2024 ],
)<fig-col-picture>

*The row picture of matrix multiplication*

Every row of $bold(P)$ is a _linear combination_ of the rows of $bold(B)$.

#figure(
  image("row-pic.png"),
  caption: [Row picture of matrix multiplication. Image taken from @strangArtLinearAlgebra2024 ],
)<fig-row-picture>


== Matrix Arithmetric Properties
Basically matrix operations include associativity, distributivity, commutativity. Here I list some more important operations
1. $(bold(A) + bold(B))^T = bold(A)^T + bold(B)^T$
2. $(bold(A)^T)^T = bold(A)$
3. $(bold(A) bold(B))^T = bold(B)^T bold(A)^T$

== Matrix inverse
#definition(title: "Matrix Inverse")[
  The square matrix $bold(A)$ is said to be invertible if there exists a matrix $bold(A)^(-1)$, which is called the inverse of $bold(A)$, such that
  $
    bold(A) bold(A)^(-1) = bold(A)^(-1) bold(A) = bold(I)
  $
]

== Matrices, Span, Linear Independence relationship
#theorem(title: "Matrices and Span")[
  The following two statements are equivalent:
  1. The *column vectors* of the matrix $bold(A)$ span $RR^p$.
  2. The equation $bold(A) bold(x) = bold(y)$ has a solution for every $bold(y)$.
]

#proof()[
  According to @def-span, the column vectors $bold(a)_1, bold(a)_2, dots.h, bold(a)_q$ span $RR^p$ $i.i.f$ $sum_(i = 1)^q x_i bold(a)_i = bold(y)$ has a solution for every $bold(y)$. If $bold(A)$ is a $p times q$ matrix with $bold(a)_1, bold(a)_2, dots.h, bold(a)_q$ as columns, then $bold(A) bold(x) = bold(y) arrow.l.r.double.long sum_(i = 1)^q x_i bold(a)_i = bold(y)$.
]

== Change of Base
Normally, we use vector $bold(e)_1 = vec(1, 0)$ and $bold(e)_2 = vec(0, 1)$ as our basis. What if we use different set of vectors, let's say, $bold(b)_1 = vec(2, 1)$ and $bold(b)_2 = (-1, 1)$ as our new basis?

#figure(
  image("old-basis.png"),
  caption: [
    vector $vec(3, 2)$ is represented by scaling basis vector $hat(bold(i))$ 3 times and vector $hat(bold(j))$ 2 times. Image is taken from @3b1bChangeBasis
  ],
)

#figure(
  image("new-basis.png"),
  caption: [
    vector $vec(-1, 2)$ is represented by scaling basis vector $bold(b_1)$ -1 times and vector $bold(b_2)$ 2 times. Image is taken from @3b1bChangeBasis
  ],
)

#example()[
  Assume we have two bases, $bold(e) = brace.l bold(e)_1, bold(e)_2 brace.r$ and $bold(B) = brace.l bold(b)_1, bold(b)_2 brace.r$, defined as
  $
    bold(e)_1 = vec(1, 0), bold(e)_2 = vec(0, 1) "and" bold(b)_1 = vec(2, 1), bold(b)_2 = vec(-1, 1)
  $

  We want to transform vector $bold(v) = vec(-1, 2)$ in $bold(B)$ coordinate system into $bold(E)$ coordinate system.

  The transformation matrix from $bold(B)$ to $bold(E)$ is

  $
    bold(P) = mat(2, -1; 1, 1)
  $
  Then vector $v$ in $bold(B)$ coordinate system can be represented in $bold(E)$ coordiate system as

  $
    bold(v)^' = bold(P) bold(v) = mat(2, -1; 1, 1) vec(-1, 2) = vec(-4, 1)
  $

  Vice versa, if we want to represent a vector in $bold(E)$ to $bold(B)$ we can use the inverse matrix of $P$.

  $
    bold(v) = bold(P)^(-1) bold(v)^'
  $
]

= Determinants
#definition("Determinant")[
  The determinant _det_ is a scalar function of a square matrix $A$ fulfilling the following three properties:
  1. $det(I) = 1$
  2. $bar dots.h lambda_1 bold(a)_1 + lambda_2 bold(a)_2 + dots.h bar = lambda_1 bar dots.h #h(4pt) bold(a)_1 #h(4pt) dots.h bar + lambda_2 bar dots.h #h(4pt) bold(a)_2 #h(4pt) dots.h bar$
  3. $bar dots.h #h(4pt) bold(a)_i #h(4pt) dots.h #h(4pt) bold(a)_i #h(4pt) dots.h bar = 0$
]<def-determinant>

#theorem(title: "Properties of the determinant")[
  4. $bar dots.h #h(4pt) bold(0) #h(4pt) dots.h bar = 0$
  5. $bar dots.h #h(4pt) bold(a)_i #h(4pt) dots.h #h(4pt) bold(a)_j #h(4pt) dots.h bar = - bar dots.h #h(4pt) bold(a)_j #h(4pt) dots.h #h(4pt) bold(a)_i #h(4pt) dots.h bar$
  6. $bar dots.h #h(4pt) bold(a)_i #h(4pt) dots.h #h(4pt) bold(a)_j #h(4pt) dots.h bar = bar dots.h #h(4pt) bold(a)_i + lambda bold(a)_j #h(4pt) dots.h #h(4pt) bold(a)_j #h(4pt) dots.h bar$
  7. $det(bold(A)) = det(bold(A)^T)$
  8. $det(bold(A) bold(B)) = det(bold(A)) det(bold(B))$
  9. $det(bold(A)^(-1)) = 1 / det(bold(A))$
]

#figure(
  image("determinant.png"),
  caption: [
    Determinant illutration. Image taken from @immersiveMath
  ],
)


Determinant is somehow like a measurement of how much a linear transformation stretches or squishes things, i.e., _area_ of vectors. However, the determinant can be a negative number. In that case, it is about the orientation of linear transformation, just like flipping things around.

#figure(
  image("negative-det.png"),
  caption: [
    Negative determinant illutration. Image taken from @3b1bDeterminant
  ],
)

I put aside how to calculate the determinant because it's boring and not that necessary as long as I have my computer.

#definition(title: "Adjoint matrix")[
  The adjoint matrix $"adj"(bold(A))$ is a matrix whose element at position $(i, j)$ is $(-1)^(i + j) D_(i j)$, where $D_(i j)$ is the determinant of the matrix $bold(A)$ after removing row $i$ and column $j$
]

*Cramer's Rule*
Cramer's Rule is useful when you want solve $bold(A) bold(x) = bold(y)$ without needing to know the inverse matrix of $bold(A)$

#theorem(title: "Cramer's Rule")[
  If $bold(A)$ is a square matrix and $det(A) eq.not 0$ then the solition $bold(x)$ to the matrix equation $bold(A) bold(x) = bold(y)$ has
  $
    x_i = frac(det(bold(a)_1 #sp_2 dots.h #sp_2 bold(a)_(i - 1) #sp_2 dots.h #sp_2 bold(y) #sp_2 bold(a)_(i + 1) #sp_2 dots.h #sp_2 bold(a)_n), det(bold(A)))
  $
]


#theorem(title: "Determinants, Independence, and Invertibility")[
  The following equivalence holds for all square matrices $bold(A)$,
  1. The column vectors of $bold(A)$ is a basis
  2. The row vectors of $bold(A)$ is a basis
  3. The matrix equation $bold(A) bold(x) = 0$ has only one solution $bold(x) = 0$
  4. The matrix equation $bold(A) bold(x) = bold(y)$ has a solution for every $bold(y)$
  5. The matrix $bold(A)$ is invertible
  6. $det(bold(A)) eq.not 0$
]<theorem-det-indep-invert>

= Rank
== Linear Subspaces
#definition()[
  Let $V$ be a linear vector space over $RR$. A subset $W subset V$ is a subspace of $V$ is it satisfies the following properties:
  1. $W$ is non-empty, i.e., $bold(0) in W$.
  2. $W$ is closed under addition, i.e. for any $bold(a), bold(b) in W$, we have $bold(a) + bold(b) in W$
  3. $W$ is closed under scalar multiplication, i.e. for any $c in RR$, and $bold(a) in W$, we have $c bold(a) in W$
]<def-subspace>

#theorem()[
  Let $bold(v_1), bold(v_2), dots.h, bold(v_n)$ be vectors in $RR^n$. Then $"span"(bold(v_1), bold(v_2), dots.h, bold(v_n))$ is a subspace of $RR^n$
]<span-subspace>

#proof()[
  To prove: for $bold(v_1), dots.h, bold(v_n) in RR^n$, the set
  $
    S = "span"(bold(v_1), dots.h, bold(v_n)) = brace.l sum_(i = 1)^k a_i bold(v_i) : a_i in RR brace.r
  $
  is a subspace of $RR^n$.
  We must show $S$ satisfy @def-subspace.
  1. Non-empty/zero vector in $S$
  Take all coefficients $a_i = 0$. Then $sum_(i = 1)^k 0 bold(v_i) = bold(0) in S$
  2. Closed under addition
  Let $bold(x) = sum_(i = 1)^k a_i v_i in S$ and $bold(y) = sum_(i = 1)^k b_i v_i in S$.

  Then
  $
    bold(x) + bold(y) = sum_(i = 1)^k (a_i + b_i) bold(v_i),
  $
  which is a linear combination of $bold(v_1), dots.h, bold(v_n)$, so $bold(x) + bold(y) in S$.
  3. Closed under scalar multiplication
  Let $bold(x) = sum_(i = 1)^k a_i bold(v_i) in S$ and $c in RR$.
  Then
  $
    c bold(x) = sum_(i = 1)^k (c a_i) bold(v_i),
  $
  is a linear combination of the same vectors, hence $c bold(x) in S$.
]

#lemma()[
  Let $S in RR^n$ be a subspace. If
  $
    S subset.eq "span"(brace.l bold(v_1), dots.h, bold(v_k) brace.r)
  $
  then the dimension of $S$ is at most $k$.
]<lemma-subspace-dim-span>

#proof()[

  Let $U = "span"(brace.l bold(v_1), dots.h, bold(v_k) brace.r)$ and $S subset.eq U$ is a subspace in $RR^n$. We try to prove $dim(S) lt.eq k$.

  A basis for $U$ can be chosen from the set $brace.l bold(v_1), dots.h, bold(v_k) brace.r$. The number of vectors in this basis is equal to $dim(U)$. So
  $
    dim(U) lt.eq k
  $
  Since $S$ is a subspace of $U$, it is known that
  $
    dim(S) lt.eq dim(U)
  $

  Combining two inequalities, it is concluded that $dim(S) lt.eq dim(U) lt.eq k$
]


== Null Space and Nullity
#definition(title: "Null Space")[
  If $A$ is an $m times n$ matrix, then the entire set of solutions to $bold(A) bold(x) = bold(0)$ is called the null space of $A$.
]<def-null-space>

#definition(title: "Nullity")[
  The dimension of the null space is denoted $"nullity"(bold(A))$.
]<def-nullity>

== Column Space, Row Space, and Rank

#definition(title: "Column Space")[
  Let $bold(A) = (bold(a)_(, 1) dots.h bold(a)_(, n))$ is an $m times n$ matrix. The column space of $bold(A)$ is then the set of all linear combinations of the column vectors $bold(a)_(, i)$.
]<def-col-space>
Note that the column space is a subspace of $RR^m$ by definition, since the number of elements in all column vectors of $bold(A)$ is $m$.

#definition(title: "Row Space")[
  Let $bold(A) = (bold(a)_(, 1) dots.h bold(a)_(, n))^T$ be an $m times n$ matrix. The row space of $bold(A)$ is then the set of all linear combinations of the row vectors, $bold(a)_(, i)^T$
]<def-row-space>

Note that the row space is a subspace of $RR^n$ by definition, since the number of elements in all row vectors is $n$.

#definition(title: "Row Echelon Form (REF) of a Matrix")[
  A matrix $bold(A)$ is said to be on REF if its rows with only zeroes (if any) are placed at bottom, and the first non-zero cofficient, $a_(i j)$, on each row with number $i$ is placed such that all other rows with a first non-zero coefficient, $a_(i^' j^')$, fulfills $i^' lt i$ (the row $i^'$ is above row $i$) and $j^' lt j$
]<def-ref>

#example()[
  A matrix on REF can be obtained by applying _Gaussian elimination_ until no more reductions can be made. E.g.,
  $
    mat(
      underline(2), 0, 1, -2, 1;
      0, underline(1), 4, 2, 1;
      0, 0, 0, underline(1), 2; 0, 0, 0, 0, 0
    )
  $
]

#theorem()[
  Given a system $bold(A) bold(x) = bold(0)$, which after Gaussian elimination is on REF $bold(R) bold(x) = bold(0)$, then
  1. The non-zero rows of $R$ form a basis for the row space of $bold(R)$ and also for $bold(A)$.
  2. The column vectors with the first non-zero element of the row vectors form the column space basis of $bold(R)$, while the column space for $bold(A)$ is the column vectors from $bold(A)$ with the column numbers as the columns for the column space for $bold(R)$.
]

#theorem(title: "Column and Row Rank Size")[
  The row rank is equal to the column rank of a matrix $bold(A)$.
]<theorem-col-row-rank-size>

#proof()[
  This proof is taken from @mh1200ColRowRankProof.

  We will use @lemma-subspace-dim-span to prove @theorem-col-row-rank-size.

  Let $bold(A)$ be a $m times n$ matrix and say that $bold(A) = bold(X) bold(Y)$ where $bold(X)$ is a $m times d$ matrix and $Y$ is a $d times n$ matrix.

  We know that every row of $bold(A)$ is a linear combination of the rows of $bold(Y)$ (see @fig-row-picture). Hence $"rowspace"(bold(A)) subset.eq "span"(brace.l bold(Y)_1, dots.h, bold(Y)_d brace.r)$ and follow @lemma-subspace-dim-span the dimension of the row space is at most $d$.

  Likewise, every column of $bold(A)$ is a linear combination of the cols of $bold(X)$ (see @fig-col-picture). Hence $"columnspace"(bold(A)) subset.eq "span"(brace.l bold(X)_1, dots.h, bold(X)_d brace.r)$ and follow @lemma-subspace-dim-span the dimension of the column space is at most $d$.

  We need to prove the column rank is less than or equal the row rank.

  Let $bold(A)$ be a $m times n$ matrix. If the dimension of the row space of $bold(A)$ is $r$, then $bold(A) = bold(X) bold(Y)$ for some $m times r$ matrix $bold(X)$ and $r times n$ matrix $bold(Y)$.

  Reason: Let $bold(Y)_1, dots.h, bold(Y)_r$ be a basis for the row space of $A$ and let $bold(A)_1, dots.h, bold(A)_m$ be the rows of $bold(A)$. Then
  $
    bold(A)_1 = bold(x)_(1 1) bold(Y)_1 + bold(x)_(1 2) bold(Y)_2 + dots.h + bold(x)_(1 r) bold(Y)_r \
    bold(A)_2 = bold(x)_(2 1) bold(Y)_1 + bold(x)_(2 2) bold(Y)_2 + dots.h + bold(x)_(2 r) bold(Y)_r \
    dots.v \
    bold(A)_m = bold(x)_(m 1) bold(Y)_1 + bold(x)_(m 2) bold(Y)_2 + dots.h + bold(x)_(m r) bold(Y)_r
  $
  Thus, $bold(A) = bold(X) bold(Y)$ where $bold(Y)$ is the matrix with rows $bold(Y)_1, dots.h, bold(Y)_r$ and $bold(X)$ is the matrix of coefficients $bold(X)(i, j) = bold(x)_(i j)$. And as we show above, the column rank is at most $r$ which is the row rank of $bold(A)$.

  Now, we prove the row rank is less than or equal the column rank. The proof is the same as above.

  From two claims above, we can see that column rank must be equal to row rank.
]

A consequence of this proof is the following:

The rank of a $m times n$ matrix $bold(A)$ is equal to the minimum $d$ such that there is a $m times d$ matrix $bold(X)$ and a $d times n$ matrix $bold(Y)$ satisfying $bold(A) = bold(X) bold(Y)$.

Also
#theorem()[
  The rank of a matrix is the number of pivot elements after Gaussian elimination.
]<theorem-rank-matrix>

#proof()[
  The row rank of matrix $bold(A)$ is equal to the dimension of the row space of the reduced matrix $bold(R)$ after Gaussian elimination. Since a basis of the row space of $bold(R)$ consists of those rows that have a pivot element, the dimension and thereby the rank is the number of pivot elements.
]

#theorem(title: "Dimension Theorem")[
  For an $m times n$ matrix $bold(A)$, it holds that
  $
    "rank"(bold(A)) + "nullity"(bold(A)) = n
  $<eq-dimension>
]<theorem-dimension>

= Eigenvalues and Eigenvectors
#definition(title: "Eigenvalues and Eigenvectors")[
  Let $bold(A)$ is a square $n times n$ matrix.

  An eigenvector of $bold(A)$ is a non-zero vector $bold(v)$ in $RR^n$ such that $bold(A) bold(v) = lambda bold(v)$, for some scalar $lambda$.

  An eigenvalue of $bold(A)$ is a scalar $lambda$ such that the equation $bold(A) bold(v) = lambda bold(v)$ has a nontrivial solution.
]<def-eigen>

Basically, when in a linear transformation, most of vectors will be off their span. However, there are some vectors stretch out on their span instead. These vectors are called _eigenvectors_ and the number representing how much they stretch is called _eigenvalues_.

#theorem()[
  If $bold(v)$ is an eigenvector with eigenvalue $lambda$, then $mu bold(v)$ is also an eigenvector with the same eigenvalue for each $mu eq.not 0$.
]

#proof()[
  if $bold(v)$ is an eigenvector with eigenvalue $lambda$, then $bold(v) eq.not 0$ and $F(bold(v)) = lambda bold(v)$. For each non-zero multiple $bold(u) = mu bold(v)$, we have that $bold(u) eq.not 0$ and that $F(bold(u)) = F(mu bold(v)) = mu F(bold(v)) = mu lambda bold(v) = lambda bold(u)$.
]
So the eigenvectors can be *rescaled* and have to be *non-zero*.

== Calculate Eigenvectors and Eigenvalues

#definition()[
  Let $bold(A)$ is a square matrix of size $n times n$. The polynomial
  $
    p_(bold(A))(lambda) = det(lambda bold(I) - bold(A))
  $<eq-char-poly>
  is then called the characteristic polynomial.
]<def-char-poly>

Given a matrix $bold(A)$, how we can calculate the eigenvectors $bold(v)$ and the corresponding eigenvalues $lambda$? The equation @eq:eq-char-poly can be rewritten as
$
  lambda bold(v) - bold(A) bold(v) = (lambda bold(I) - bold(A)) bold(v) = 0
$
If $bold(v)$ is an eigenvector, then the matrix $(lambda bold(I) - bold(A))$ has a non-zero null vector. According to @theorem-det-indep-invert, this means that $p_(bold(A))(lambda) = det(lambda bold(I) - bold(A)) = 0$.

== Diagonalization
#bibliography("ref.bib")
