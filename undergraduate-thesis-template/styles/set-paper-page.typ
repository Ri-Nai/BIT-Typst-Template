#import "../utils/ziti.typ": *

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

#let show-paper-header(header, body) = {
  set page(
    header: {
      set text(font: songti, zh("四号"), tracking: 1pt)
      align(center, header)
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

#let show-mainbody(body) = {
  set text(font: songti, zh("小四"), hyphenate: false)

  set par(leading: 1.15em, first-line-indent: 2em, justify: true)

  body
}
