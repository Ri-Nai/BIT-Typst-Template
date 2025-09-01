#import "../utils/ziti.typ": zh, zihao
#import "../styles/set-paper-page.typ":show-paper-header

#let declaration_typst(twoside: false,anonymous: false,header : "北京理工大学本科生毕业设计（论文）") = [

  #if anonymous {return}
  #set par(leading: 0.96em, justify: true, first-line-indent: 2em, spacing: 1em)
  #let fakepar=context{let b=par(box());b;v(-measure(b+b).height)}
  #show heading: it=>it+fakepar // 标题后缩进
  #show: show-paper-header.with(header)
  #set text(font: "SimSun", size: zh("小三"),tracking: 0pt)

  /* #show heading.where(level: 1): it => {
    set text(font: "SimHei", size: zh("二号"), weight: "bold")
    set align(center)
    v(1em)
    it
    v(0.8em)//不使用一级标题
  } */

  
  #v(1em)
  #align(center)[
  #text(font: "SimHei",weight:"bold", size: zh("二号"))[原创性声明]]
  #v(0.8em)

  本人郑重声明：所呈交的毕业设计（论文），是本人在指导老师的指导下独立进行研究所取得的成果。除文中已经注明引用的内容外，本文不包含任何其他个人或集体已经发表或撰写过的研究成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。

  特此申明。

  #v(3em)

  #align(right)[
    本人签名：#h(7.5em)日 期：#h(2.5em)年#h(1.5em)月#h(1.5em)日
  ]

  #v(1.5em)


  #v(1em)
  #align(center)[
  #text(font: "SimHei",weight:"bold", size: zh("二号"))[关于使用授权的声明]]
  #v(0.8em)

  本人完全了解北京理工大学有关保管、#h(0.1em)使用毕业设计#h(0.1em)（论文）#h(0.1em)的规定，其中包括：①学校有权保管、并向有关部门送交本毕业设计#h(0.2em)（论文）#h(0.2em)的原件与复印件；#h(0em)②学校可以采用影印、缩印或其它复制手段复制并保存本毕业设计（论文）；③学校可允许本毕业设计（论文）被查阅或借阅；④学校可以学术交流为目的,复制赠送和交换本毕业设计（论文）；⑤学校可以公布本毕业设计（论文）的全部或部分内容。
  //以假乱真 绷
  #v(1.55em)

  #align(right)[
    本人签名：#h(7.5em)日 期：#h(2.5em)年#h(1.5em)月#h(1.5em)日

    指导教师签名：#h(7.5em)日 期：#h(2.5em)年#h(1.5em)月#h(1.5em)日
  ]

  #set page(header: none)
  #pagebreak(weak: true,to:if twoside {"odd"})
]

