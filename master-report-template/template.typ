#import "utils/ziti.typ": *
#import "utils/indent-funs.typ": *
#import "utils/set-paper-page.typ": *
#import "utils/set-heading.typ": *
#import "utils/set-figure.typ": show-figure
#import "utils/three-line-table.typ": three-line-table


#import "pages/cover.typ": *
#import "pages/declaration.typ": *
#import "pages/abstract.typ": *
#import "pages/abstract-en.typ": *
#import "pages/contents.typ": *

#import "@preview/cuti:0.3.0": show-cn-fakebold


#let paper(
  subject: "",
  title: "",
  title-en: "",
  college: "",
  major: "",
  class: "",
  author: "",
  student-id: "",
  guide-teacher: "",
  date: datetime.today(),
  abstract-content: [],
  abstract-en-content: [],
  keywords: (),
  keywords-en: (),
  body,
) = {

  show: show-cn-fakebold
  show: show-fix-indent

  show: show-figure

  show: show-paper-page-size


  cover(
    subject: subject,
    title: title,
    title-en: title-en,
    college: college,
    major: major,
    class: class,
    author: author,
    student-id: student-id,
    guide-teacher: guide-teacher,
  )


  declaration()

  show: show-paper-header
  show: show-paper-footer.with(style: "I")

  set text(font: songti, cn-zh("小四"), hyphenate: false)

  set par(leading: 1.15em, first-line-indent: 2em, justify: true)


  abstract(
    title: title,
    content: abstract-content,
    keywords: keywords,
  )

  abstract-en(
    title: title-en,
    content: abstract-en-content,
    keywords: keywords-en,
  )

  contents()


  show: show-paper-footer.with(style: "1")
  show: show-heading

  body
}

