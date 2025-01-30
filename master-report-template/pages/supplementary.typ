#import "../utils/ziti.typ": *


#let supplematry-page(title: "", body) = {
  set heading(level: 1, numbering: none)
  show heading.where(level: 1): it => {
    set align(center)
    show: cn-zihao("三号")
    v(0.6em)
    it
  }
  pagebreak(weak: true)
  [
    = #{
      let title-length = title.clusters().len()
      if title-length >= 4 {
        title
      } else {
        title.clusters().join(" " * (4 - title-length))
      }
    }
  ]
  body
  pagebreak(weak: true)
}

#let references(
  style: "gb-7714-2015-numeric",
  ..path,
) = supplematry-page(
  title: "参考文献",
  bibliography(
    title: none,
    style: style,
    ..path,
  ),
)


#let acknowledgements(body) = supplematry-page(title: "致谢", body)


#let appendices(body) = supplematry-page(title: "附录", body)

