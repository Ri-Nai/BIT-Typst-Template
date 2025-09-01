#let declaration(
  twoside: false,
  anonymous: false,
) = {
  if anonymous { return }
  set page(
    paper: "a4",
    margin: 0em,
  )
  image("../assets/declaration.svg", width: 100%)

  pagebreak(weak: true, to: if twoside { "odd" })
}
