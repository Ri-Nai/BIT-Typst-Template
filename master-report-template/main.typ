#import "template.typ": paper
#import "utils/three-line-table.typ": three-line-table
#import "pages/supplementary.typ": *

#show: paper.with(
  title: "北京理工大学本科生毕业设计（论文）题目",
  title-en: "The Subject of Undergraduate Graduation Project (Thesis) of Beijing Institute of Technology",
  college: "计算机学院",
  major: "计算机科学与技术",
  class: "计科2301班",
  author: "杨紫诺",
  student-id: "1120234514",
  guide-teacher: "暂无，求包养",
  date: datetime.today(),
  abstract-content: [
    本文……。

    摘要正文选用模板中的样式所定义的“正文”，每段落首行缩进2个字符；或者手动设置成每段落首行缩进2个汉字，字体：宋体，字号：小四，行距：固定值22磅，间距：段前、段后均为0行。【阅后删除此段】

    摘要是一篇具有独立性和完整性的短文，应概括而扼要地反映出本论文的主要内容。包括研究目的、研究方法、研究结果和结论等，特别要突出研究结果和结论。中文摘要力求语言精炼准确，本科生毕业设计（论文）摘要建议300-500字。摘要中不可出现参考文献、图、表、化学结构式、非公知公用的符号和术语。英文摘要与中文摘要的内容应一致。【阅后删除此段】
  ],
  abstract-en-content: [
    #lorem(40)
  ],
  keywords: ("北京理工大学", "本科生", "毕业设计（论文）"),
  keywords-en: ("BIT", "Undergraduate", "Graduation Project(Thesis)"),
)

= 一级题目
== 二级题目
=== 三级题目

正文……

正文部分：宋体、小四；正文行距：22磅；间距段前段后均为0行。【阅后删除此段】
图、表居中，图注标在图下方，表头标在表上方，宋体、五号、居中，1.25倍行距，间距段前段后均为0行，图表与上下文之间各空一行。【阅后删除此段】
图-示例：【阅后删除此段】

#figure(
  image("assets/bit-logo.png"),
  caption: "标题序号",
)

\

表-示例：【阅后删除此段】

#linebreak()
#figure(
  three-line-table(
    header: ("项目", "产量", "销量", "产值", "比重"),
    ("手机", 1000, 10000, 500, "50%"),
    ("计算机", 5500, 5000, 220, "22%"),
    ("笔记本电脑", 1100, 1000, 280, "28%"),
    footer: ("合计", 7600, 15000, 1000, "100%"),
  ),
  kind: table,
  caption: "统计表",
)

\

公式标注应于该公式所在行的最右侧。对于较长的公式只可在符号处（$+$、$-$、$*$、$\/$、$<=$ $>=$等）转行。在文中引用公式时，在标号前加“式”，如式（1-2）。【阅后删除此段】
公式-示例：【阅后删除此段】

$ #[LRI] = 1 \/ sqrt(1 + (frac(mu_R, mu_s))^2 (sigma_R / sigma_S)^2) $



#pagebreak()

= typst 用法部分示例

== 如同 `markdown` 一样好用的标题
如题所示
=== 我是三级标题

==== 四级标题我没特意设置了
===== 五级标题我也不知道到底长啥样了

== 如同 `markdown` 一样好用的代码块


#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)
Oh my god, it's `python`.

Oh my god, it's ```cpp int main()```

Oh my god, it's code-lines

```cpp
#include <iostream>
using namespace std;
int main() {
  cout << "Hello, World!" << endl;
  return 0;
}
```

== 数学模式

#references("./ref.bib")

#appendices()[]

#acknowledgements()[]
