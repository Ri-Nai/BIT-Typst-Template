#import "../utils/ziti.typ": zh, zihao
#import "../styles/set-paper-page.typ": top-diff

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
  outline(title: [], indent: 2em)
  pagebreak()
}


