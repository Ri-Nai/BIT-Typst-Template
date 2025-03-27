#import "../utils/ziti.typ": zh, zihao
#import "../styles/set-paper-page.typ": top-diff
// inspired from 璜珀's blog https://blog.hpcesia.com/posts/5252cfe9/
#let contents() = {
  align(center)[
    #v(-top-diff)
    #v(0.6em)
    #text(
      size: zh("三号"),
      font: "SimHei",
      "目　录",
    )
  ]


  context {
    let contents-location = here()
    show outline.entry: it => {
      let loc = it.element.location()
      link(
        loc,
        it.indented(
          it.prefix(),
          {
            it.body()
            h(0.5em)
            box(width: 1fr, it.fill)
            let before = loc.position().page < contents-location.position().page
            numbering(
              if before { "I" } else { "1" },
              ..counter(page).at(loc),
            )
          },
        ),
      )
    }
    outline(title: [], indent: 2em)
  }
  pagebreak()
}


