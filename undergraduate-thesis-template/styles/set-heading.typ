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
    v(0.6em)
    it
    v(0.4em)
  }
  show heading.where(level: 2): it => {
    show: zihao("四号")
    v(0.6em)
    it
    v(0.3em)
  }
  show heading.where(level: 3): it => {
    show: zihao("小四")
    v(0.6em)
    it
    v(0.1em)
  }
  body
}
