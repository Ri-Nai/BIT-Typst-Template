#import "styles/set-paper-page.typ": *
#import "styles/set-heading.typ": *
#import "styles/set-figure.typ": show-figure
#import "styles/set-code.typ": *

#import "utils/ziti.typ": *
#import "utils/indent-funs.typ": *
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
  // 应用模板样式和格式设置：
  // - show-cn-fakebold: 为中文字符应用伪粗体效果
  // - show-fix-indent: 修正段落缩进
  // - show-figure: 配置图表、公式样式
  // - show-paper-page-size: 设置页面大小和边距
  // - show-code: 配置代码行样式
  show: show-cn-fakebold
  show: show-fix-indent
  show: show-paper-page-size
  show: show-code

  // 生成论文封面
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

  // 生成原创性声明
  declaration()

  // 设置文档显示样式：
  // - show-paper-header: 显示论文页眉
  // - show-paper-footer: 显示论文页脚，使用"I"样式
  // - show-mainbody: 设置论文正文格式
  show: show-paper-header
  show: show-paper-footer.with(style: "I")
  show: show-mainbody

  // 生成中文摘要
  abstract(
    title: title,
    content: abstract-content,
    keywords: keywords,
  )

  // 生成英文摘要
  abstract-en(
    title: title-en,
    content: abstract-en-content,
    keywords: keywords-en,
  )

  // 生成目录
  contents()

  // 应用自定义标题样式和页脚（使用"1"样式）
  show: show-paper-footer.with(style: "1")
  show: show-heading
  show: show-figure

  body
}
