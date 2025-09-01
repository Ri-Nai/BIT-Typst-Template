#import "styles/set-paper-page.typ": show-paper-page-size, show-paper-header, show-paper-footer, show-mainbody
#import "styles/set-heading.typ": show-heading
#import "styles/set-figure.typ": show-figure
#import "styles/set-code.typ": show-code

#import "utils/ziti.typ": zh, zihao, songti, heiti
#import "utils/indent-funs.typ": indent
#import "utils/three-line-table.typ": three-line-table
#import "utils/bib-citation.typ": bib-cite

#import "pages/cover.typ": cover
#import "pages/declaration.typ": declaration
#import "pages/declaration-typst.typ": declaration_typst
#import "pages/abstract.typ": abstract
#import "pages/abstract-en.typ": abstract-en
#import "pages/contents.typ": contents
#import "pages/supplementary.typ": supplematry-page, references, conclusion, acknowledgements, appendices

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
  declare: true,
  abstract-content: [],
  abstract-en-content: [],
  keywords: (),
  keywords-en: (),
  header: "北京理工大学本科生毕业设计（论文）",
  body,
  twoside: false,
  anonymous: false,
) = {
  // 应用模板样式和格式设置：
  // - show-cn-fakebold: 为中文字符应用伪粗体效果
  // - show-fix-indent: 修正段落缩进
  // - show-figure: 配置图表、公式样式
  // - show-paper-page-size: 设置页面大小和边距
  // - show-code: 配置代码行样式
  // - show-mainbody: 设置论文正文格式
  show: show-cn-fakebold
  show: show-paper-page-size
  show: show-code
  show: show-mainbody


  // 设置参考文献风格：
  // - 使用 GB/T 7714-2005 数字格式引用样式
  // - 可选择使用北京理工大学自定义引用样式（需取消注释第二行）
  // 注：只能选择使用其中一种样式，请根据需要选择合适的引用格式

  set bibliography(style: "gb-7714-2005-numeric")
  // set bibliography(style: "assets/beijing-institute-of-technology.csl")

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
    date: date,
    twoside: twoside, 
    anonymous: anonymous,
  )

  // 生成原创性声明
  if declare != none {
  if declare { declaration(twoside: twoside, anonymous: anonymous) } 
  else {declaration_typst(twoside: twoside, anonymous: anonymous)}
  }
  // 设置文档显示样式：
  // - show-paper-header: 显示论文页眉
  // - show-paper-footer: 显示论文页脚，使用"I"样式
  show: show-paper-header.with(header)
  show: show-paper-footer.with(style: "I")

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
  pagebreak(weak: true)

  // 生成目录
  contents()

  // 应用自定义标题样式和页脚（使用"1"样式）
  show: show-paper-footer.with(style: "1")
  show: show-heading
  show: show-figure

  body
}
