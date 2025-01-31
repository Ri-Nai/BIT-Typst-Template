#import "@preview/i-figured:0.2.4"
#import "../utils/ziti.typ": *

// copied from https://github.com/werifu/HUST-typst-template/blob/main/utilities/set-numbering.typ and set-figure.typ

// 设置编号 (引用时, 需要使用标签), 注意, 必须在 heading 设置完成后再调用
#let show-numbering(body) = {
  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure.with(numbering: "1-1")
  show math.equation: i-figured.show-equation.with(numbering: "(1-1)")

  body
}

#let show-caption(body) = {
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(font: songti, size: cn-zh("五号"))
  set figure.caption(separator: [])
  body
}

#let show-citation(body) = {
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  set math.equation(supplement: [式])

  body
}

#let show-figure(body) = {
  show: show-numbering
  show: show-caption
  show: show-citation
  body
}
