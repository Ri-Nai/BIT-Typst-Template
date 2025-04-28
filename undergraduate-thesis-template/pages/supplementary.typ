#import "../utils/ziti.typ": zh, zihao


#let supplematry-page(title: "", body) = {
  let numberfunc = (..args, last) => {
    if args.pos() != () {
      numbering("1.1.1.", ..(args.pos().slice(1)), last)
    }
  }
  set heading(numbering: numberfunc)
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "regular")
    show: zihao("三号")
    v(-1em)
    it
    v(-0.4em)
  }
  [
    = #{
      let title-length = title.clusters().len()
      if title-length >= 4 {
        title
      } else {
        title.clusters().join(h(0.5em) * (4 - title-length))
      }
    }
  ]
  body
}

#let references(
  ..path,
) = supplematry-page(
  title: "参考文献",
  bibliography(
    title: none,
    ..path,
  ),
)

#let conclusion(body) = supplematry-page(title: "结论", body)

#let acknowledgements(body) = supplematry-page(title: "致谢", body)


#let appendices(body) = supplematry-page(title: "附录", body)

