#import "ziti.typ": *

#let show-paper-page-size(body) = {
  set page(
    paper: "a4",
    margin: (
      top: 3.6cm,
      bottom: 2.6cm,
      left: 3cm,
      right: 2.6cm,
    ),
    header-ascent: 0.5cm,
    footer-descent: 0.4cm,
  )

  body
}

#let show-paper-header(body) = {
  set page(
    header: {
      set text(font: songti, cn-zh("四号"), tracking: 1pt)
      align(center)[北京理工大学本科生毕业设计（论文）]
      v(-0.8em)
      line(length: 100%, stroke: 0.7pt)
    },
  )

  body
}

#let show-paper-footer(body, style: "1") = {
  context counter(page).update(1)
  set page(
    footer: {
      set align(center)
      text(font: songti, 10pt, baseline: -3pt, context counter(page).display(style))
    },
  )

  body
}
