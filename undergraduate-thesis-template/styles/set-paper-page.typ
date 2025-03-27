#import "../utils/ziti.typ": zh, zihao, songti

#let paper-page-size = (
  top: 3.85cm,
  bottom: 2.6cm,
  left: 3cm,
  right: 2.6cm,
  header-distance: 2.4cm,
  footer-distance: 2cm,
)
#let top-diff = paper-page-size.top - 3.6cm // 3.6cm 是历史版本的默认值，防止页面发生偏移

#let show-paper-page-size(body) = {
  let top = paper-page-size.top
  let bottom = paper-page-size.bottom
  let left = paper-page-size.left
  let right = paper-page-size.right
  let header-distance = paper-page-size.header-distance
  let footer-distance = paper-page-size.footer-distance
  set page(
    paper: "a4",
    margin: (
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    ),
    header-ascent: (top - zh("四号") * 1.4 - header-distance),
    footer-descent: (bottom - zh("五号") - footer-distance),
  )

  body
}

#let show-paper-header(header, body) = {
  set page(
    header: {
      set text(
        font: songti,
        zh("四号"),
        tracking: 1pt,
        top-edge: "ascender",
        bottom-edge: "descender",
      )
      align(center, header)
      v(-1.05em)
      line(length: 100%, stroke: 0.75pt)
    },
  )

  body
}

#let show-paper-footer(body, style: "1") = {
  context counter(page).update(1)
  set page(
    footer: {
      set align(center)
      text(font: songti, zh("五号"), context counter(page).display(style))
    },
  )

  body
}

#let show-mainbody(body) = {
  set text(font: songti, zh("小四"), hyphenate: false)

  set par(
    leading: 1.15em,
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    justify: true,
  )

  body
}
