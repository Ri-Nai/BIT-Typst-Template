#import "../utils/ziti.typ": zh, zihao


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
  override-info: (:),
  cover-logo-path: "../assets/header.png",
) = {
  set align(center)
  show: zihao("五号")
  v(5.5em)

  image(cover-logo-path, width: 9.87cm)

  show: zihao("小初")
  v(-0.8em)

  block(
    below: 0.3em,
    text(
      // 由于使用了 fakebold，所以这里用不了 tracking 这个属性
      //在 word 里显示的是设置 3 磅的字间距，感觉是左右各包了 3 磅
      // tracking: 6pt,
      font: "SimSun",
      weight: "bold",
    )[
      #let tracking = 6pt
      #subject.clusters().join(h(tracking))
    ],
  )


  block(
    below: 0.6em,
    height: 6.6cm,
    align(horizon)[
      #text(
        size: zh("二号"),
        font: "STxihei",
        weight: "bold",
        title,
      )

      #set par(leading: 1.25em)

      #text(
        size: zh("三号"),
        font: "Times New Roman",
        weight: "bold",
        title-en,
      )
    ],
  )

  set par(leading: 1em)

  show: zihao("三号")

  let infos = (
    "学院": college,
    "专业": major,
    "班级": class,
    "学生姓名": author,
    "学号": student-id,
    "指导教师": guide-teacher,
  )

  if override-info.len() > 0 {
    infos = override-info
  }

  let info_key(key) = (
    align(
      right,
      key.clusters().join((4 - key.clusters().len()) * h(1em)) + "：",
    )
  )

  let info_value(body) = {
    body
    v(-0.6em)
    line(length: 100%)
  }
  grid(
    columns: (6em, 14em),
    column-gutter: 1em,
    row-gutter: 0.9em,
    ..infos
      .pairs()
      .map(info => (
        info_key(info.at(0)),
        info_value(info.at(1)),
      ))
      .flatten(),
  )
  v(1fr)
  (
    [#date.year()],
    [年],
    [#date.month()],
    [月],
    [#date.day()],
    [日],
  ).join(h(0.5em))
  v(0.5em)

  pagebreak(weak: true)
}
