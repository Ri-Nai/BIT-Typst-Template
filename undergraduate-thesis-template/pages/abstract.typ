#import "../utils/ziti.typ": zh, zihao

#let abstract(
  title: "",
  content: [],
  keywords: (),
) = [

  #if content == [] {
    return
  } 
  #let zh-title(it) = {
    set text(font: "SimHei", weight: "bold", size: zh("小二"))

    set align(center)
    v(1em)
    it
  }

  #show heading.where(level: 1): it => {
    set text(font: "SimHei", size: zh("三号"))

    set align(center)
    v(0.6em)
    it
    v(1.4em)
  }

  #zh-title(title)

  = 摘#h(1em)要

  #content

  #linebreak()
  #text(
    font: "SimHei",
    weight: "bold",
  )[
    关键词：#keywords.join("；")
  ]

  #pagebreak()

]
