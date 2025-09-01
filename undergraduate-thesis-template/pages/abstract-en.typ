#import "../utils/ziti.typ": zh, zihao, heiti

#let abstract-en(
  title: "",
  content: [],
  keywords: (),
) = [

  #set par(leading: 1.25em)
  #v(-0.5em)
  #if content == [] {
    return
  }

  #let en-title(it) = {
    set text(weight: "bold", size: zh("三号"))
    set par(justify: false)
    set align(center)
    v(1.5em)
    it
  }

  #show heading.where(level: 1): it => {
    set text(size: zh("三号"), weight: "regular")

    set align(center)
    v(3em)
    it
    v(1em)
  }

  #en-title(title)

  = Abstract

  #content

  #linebreak()
  #text(weight: "bold")[
    Key Words: #keywords.join("; ")
  ]

  #pagebreak()
]
