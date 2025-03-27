#import "../utils/ziti.typ": zh, zihao, heiti

#let show-heading(body) = {
  let numberfunc = (..args, last) => {
    if args.pos() != () {
      numbering("1.1.1.1", ..args, last)
    } else {
      numbering("第1章", last)
    }
  }
  set heading(numbering: numberfunc)
  set heading(supplement: [节])

  // copied from https://github.com/werifu/HUST-typst-template/blob/main/utilities/set-heading.typ
  // 参考自 https://github.com/nju-lug/modern-nju-thesis/blob/main/utils/custom-heading.typ
  show heading: it => {
    set text(font: heiti)
    show: block
    // 做标题的原理，不用看
    if it != none {
      set par(first-line-indent: 0em)
      if it.has("numbering") and it.numbering != none {
        numbering(it.numbering, ..counter(heading).at(it.location()))
        // 重点是这里的空格
        // 如果直接在 numberfunc 里加空格，间距会略大（因为本身就自带间距)
        h(0.5em)
      }
      it.body
    } else {
      ""
    }
  }
  show heading.where(level: 1): it => {
    set align(center)
    show: zihao("三号")
    set block(
      below: 2.2em,
    )
    v(0.7em) //在页面开头时和页边距之间增加的距离，不能用 block 的 above
    it
  }
  show heading.where(level: 2): it => {
    show: zihao("四号")
    set block(
      above: 2em,
      below: 2em,
    )
    it
  }
  show heading.where(level: 3): it => {
    show: zihao("小四")
    set block(
      above: 1.4em,
      below: 1.4em,
    )
    it
  }
  body
}
