#import "../utils/ziti.typ": cn-zihao, cn-zh



#let cover(
  subject: "本科生毕业设计(论文)",
  title: "北京理工大学本科生毕业设计（论文）题目",
  title-en: "The Subject of Undergraduate Graduation Project (Thesis) of Beijing Institute of Technology",
  college: "",
  major: "",
  class: "",
  author: "",
  student-id: "",
  guide-teacher: "",
  date: datetime.today(),
  cover-logo-path: "../assets/header.png",
) = {
  align(center)[
    #show: cn-zihao("五号")
    
    #v(6em)

    #image(cover-logo-path, width: 9.87cm)

    #v(-0.8 * cn-zh("小初"))

    #text(
      size: cn-zh("小初"),
      // 由于使用了 fakebold，所以这里用不了 tracking 这个属性
      //在 word 里显示的是设置 3 磅的字间距，感觉是左右各包了 3 磅
      // tracking: 6pt,
      font: "SimSun",
      weight: "bold",
    )[
      #let tracking = 6pt
      #subject.clusters().join(h(tracking))
    ]


    #v(-0.8 * cn-zh("小初"))

    #box(
      height: 6.6cm,
      align(horizon)[
        #text(
          size: cn-zh("二号"),
          font: "STxihei",
          weight: "bold",
          title,
        )

        #set par(leading: 1.25em)

        #text(
          size: cn-zh("三号"),
          font: "Times New Roman",
          weight: "bold",
          title-en,
        )
      ],
    )

    #set par(leading: 1em)
    #set text(font: "SimSun")

    #show: cn-zihao("三号")



    #let info_key(key) = (
      align(
        right,
        key.clusters().join((4 - key.clusters().len()) * " " * 2) + "：",
      )
    )

    #let info_value(body) = {
      body
      v(-0.6em)
      line(length: 100%)
    }
    #grid(
      columns: (6em, 14em),
      column-gutter: 1em,
      row-gutter: 0.9em,
      info_key("学院"), info_value(college),
      info_key("专业"), info_value(major),
      info_key("班级"), info_value(class),
      info_key("学生姓名"), info_value(author),
      info_key("学号"), info_value(student-id),
      info_key("指导教师"), info_value(guide-teacher),
    )
    #show: cn-zihao("五号")

    #v(-1.2 * cn-zh("三号"))
    #(v(5.84em + 1.2em))
    // #rect([a])
    #show: cn-zihao("五号")

    #text(
      font: "SimSun",
      size: 16pt,
    )[
      #date.year() 年 #date.month() 月 #date.day() 日
    ]
  ]

  pagebreak()
}
