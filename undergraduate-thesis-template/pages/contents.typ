#import "../utils/ziti.typ": cn-zihao, cn-zh

// inspired from 璜珀's blog https://blog.hpcesia.com/posts/5252cfe9/ 
#let contents() = {
  align(center)[
    #v(0.6em)
    #text(
      size: cn-zh("三号"),
      font: "SimHei",
      "目　录",
    )<contents>
    #v(1.8em)
  ]


  context {
    let contents-location = locate(<contents>)
    show outline.entry: it => {
      let loc = it.element.location()
      link(
        loc,
        it.body,
      )
      h(0.5em)
      box(width: 1fr, it.fill)
      let before = loc.position().page < contents-location.position().page
      link(
        loc,
        numbering(
          if before { "I" } else { "1" },
          ..counter(page).at(loc),
        ),
      )
    }

    outline(title: [], indent: 2em)
  }
  pagebreak()
}


