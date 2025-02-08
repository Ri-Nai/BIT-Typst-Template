#import "template.typ": *

#show: paper.with(
  subject: "本科生毕业设计(论文)",
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

\ // 加一个空段（ \ 表示换行）

表-示例：【阅后删除此段】

#linebreak()
#figure(
  three-line-table(
    header: ("项目", "产量", "销量", "产值", "比重"),
    ("手机", 1000, 10000, 500, "50%"),
    ("计算机", 5500, 5000, 220, "22%"),
    ("笔记本电脑", 1100, 1000, 280, "28%"),
    footer: ("合计", 7600, 16000, 1000, "100%"),
  ),
  caption: "统计表",
)

#linebreak() // linebreak 也是换行的意思

公式标注应于该公式所在行的最右侧。对于较长的公式只可在符号处（$+$、$-$、$*$、$\/$、$<=$ $>=$等）转行。在文中引用公式时，在标号前加“式”，如@eqt:LRI。【阅后删除此段】
公式-示例：【阅后删除此段】

$ #[LRI] = 1 \/ sqrt(1 + (frac(mu_R, mu_s))^2 (sigma_R / sigma_S)^2) $<LRI>


#pagebreak() // pagebreak 分页
// #pagebreak(weak: true) // weak 分页，表示若下面是空白页则不分页


= typst 用法部分示例

== 如同 `markdown` 一样好用的标题
如题所示
=== 我是三级标题

==== 四级标题我没特意设置了
===== 五级标题我也不知道到底长啥样了

=== 标题引用 <title-citation>

在 标题后面加上标签 `<label-name>` ，然后在文中引用时，使用 `@label-name` 即可。

例如：在 @title-citation 中，展示了标题引用的例子。

== 如同 `markdown` 一样好用的代码块


Oh my god, it's `python`.

Oh my god, it's ```cpp int main()```

Oh my god, it's Hello, World!

```cpp
#include <iostream>
using namespace std;
int main() {
  cout << "Hello, World!" << endl;
  return 0;
}
```

== 数学模式

与`LaTeX` 基本一致。$a^2 + b^2 = c^2$ 表示行内公式。
$ a^2 + b^2 = c^2 $ 表示行间公式。

符号可能有点不大相同，做了很多智能化的操作，以及再也不用加 `\{}` 了。

=== 公式引用 <formula-citation>

与 @title-citation 类似，公式引用也是一样的。

在公式后面加上标签 `<label-name>` ，然后在文中引用时，使用 `@eqt:label-name` 即可。

例如

$ a^2 + b^2 = c^2 $ <gougu>

@eqt:gougu 是勾股定理。

=== 数学模式示例

@tbl:math-mode-example 展示了一些数学模式的例子。


#[
  #let code-display(code) = (
    raw(code, lang: "typst", block: true),
    eval(code),
  )
  #show <math-mode-example>: it => {
    show figure: set block(breakable: true)
    set table.cell(breakable: true)
    it
  }
  #figure(
    table(
      align: horizon,
      columns: (auto,),
      fill: (x, y) => if calc.even(y) { luma(240) } else { none },
      ..code-display("$ 1 / 2 $
$ frac(1, 2) $
$ sqrt(2) $"),

      ..code-display("$
  pi(i) = cases(
    #[$0, quad i = 0$],
    #[$max{k | k < i, s[0...k-1] = s[i-(k-1)...i]}, quad 0 < i < n$]
  )
$"),
      // 二维正态分布密度函数
      ..code-display("$
  f(x, y) = frac(1, 2  pi  sigma_x  sigma_y)
  dot e^(-frac(1, 2)(
    frac((x - mu_x)^2, sigma_x^2) +
    frac((y - mu_y)^2, sigma_y^2) +
    2 rho frac((x - mu_x)(y - mu_y), sigma_x sigma_y)
  ))
$
$
  f(x, y) = & frac(1, 2  pi  sigma_x  sigma_y) \ // 使用 \ 来换行
  dot & exp(-frac(1, 2)(  // 使用 & 来对齐，类似于 LaTeX
    frac((x - mu_x)^2, sigma_x^2) +
    frac((y - mu_y)^2, sigma_y^2) +
    2 rho frac((x - mu_x)(y - mu_y), sigma_x sigma_y)
  ))
$
"),
    ),
    caption: "数学模式示例",
  ) <math-mode-example>
]

== 图表

=== 图片
#figure(
  image(
    width: 30%,
    "assets/bit-logo.png",
  ),
  caption: "BIT Logo",
) <bit-logo>

=== 表格简单示例

#figure(
  table(
    columns: 3,
    [姓名], [年龄], [性别],
    [张三], [18], [男],
    [李四], [19], [女],
    [王五], [20], [男],
  ),
  caption: "学生信息表",
) <student-info>

#figure(
  three-line-table(
    header: ("项目", "产量", "销量", "产值", "比重"),
    ("手机", 1000, 10000, 500, "50%"),
    ("计算机", 5500, 5000, 220, "22%"),
    ("笔记本电脑", 1100, 1000, 280, "28%"),
    footer: ("合计", 7600, 16000, 1000, "100%"),
  ),
  caption: "统计表",
) <stat-table>

=== breakable 参数

`figure` 函数有 `block` 参数，可以设置为 `breakable: true` 来实现跨页显示。

即 `set figure.block(breakable: true)`。

如 @tbl:math-mode-example 和 @tbl:99-table 就是跨页显示的表格。


=== 图表引用

与 @title-citation 和 @formula-citation 类似，图表引用也是一样的。

我们需要在图表后面加上标签 `<label-name>` ，然后在文中引用时，使用 `@tbl:label-name / @fig:label-name` （取决于是表还是图）即可。

@fig:bit-logo 是北京理工大学的 Logo。

@tbl:stat-table 是统计表。

=== 编程写法

`Typst` 里表格 `table` 函数的写法自由度很高，可以翻阅文档查看更多用法。

这里展示了几个比较经典的类函数式编程写法。

// 防止作用域滥用
#[
  #let cell(i, j) = if i * j != 0 {
    table.cell(
      fill: rgb(
        ((10 - calc.abs(i - j)) / 20 * 100%),
        ((10 - calc.abs(i - j)) / 20 * 100%),
        90%,
      ),
      text(fill: rgb(255, 255, 255))[$#(i * j)$],
    )
  } else if i + j != 0 {
    table.cell(
      fill: rgb(90%, 90%, ((10 - calc.abs(i - j)) / 20 * 100%)),
      text(fill: rgb(0, 0, 0))[$#(i + j)$],
    )
  } else {
    table.cell(
      fill: rgb("#7eff4f"),
      text(fill: rgb(0, 0, 0))[$times$],
    )
  }
  #show figure: set block(breakable: true)
  #figure(
    caption: "九九乘法表",
    table(
      columns: 10,
      ..range(10).map(i => range(10).map(j => cell(i, j))).flatten(),
    ),
  ) <99-table>
]
#[
  #let n = 100
  #figure(
    caption: "1 - " + str(n) + " 质数表",
    table(
      columns: 10,
      [1],
      ..range(2, n + 1).map(x => table.cell(
          fill: if range(2, calc.floor(calc.sqrt(x)) + 1).all(y => calc.rem-euclid(x, y) != 0) {
            luma(200)
          },
          str(x),
        ),
      )),
    ),
  )
]

#[
  #let header = ("项目", "产量", "销量", "产值", "比重")
  #let projects = (
    ("手机", 1000, 10000, 500),
    ("计算机", 5500, 5000, 220),
    ("笔记本电脑", 1100, 1000, 280),
  )
  #let footer = ("合计",) + projects.reduce((a, b) => a.zip(b).map(x => x.at(0) + x.at(1))).slice(1) + ("100%",)
  #(projects = projects.map(x => x + (repr(x.at(3) / footer.at(3) * 100%),)))
  #figure(
    three-line-table(
      header: header,
      ..projects,
      footer: footer,
    ),
    caption: "统计表",
  )
]

== 列表

列表我没有专门做，样式还是原本的。

Typst 支持嵌套列表体系，可通过缩进实现层级结构：

+ 有序列表
+ #lorem(40)
+ 混合列表类型
  - 无序子项
  - 支持多种标记符号
    1. 二级嵌套项
    2. 自定义符号支持
- 无序列表
- #lorem(40)
  - 常规短横线
  1. 嵌套有序项
  2. 自动缩进对齐

== 参考文献引用

引用时直接根据 `bib` 文件中的 `key` 作为参数引用即可。

目前本模板采用的是 `Typst` 内置的 `gb-7714-2015-numeric` 格式。与学校的要求有一定出入。

// 内置引用函数
#cite(<yuFeiJiZongTiDuoXueKeSheJiYouHuaDeXianZhuangYuFaZhanFangXiang2008>)

#cite(<OBRIEN1994Aircraft>)aaa#cite(<张伯伟2002全唐五代诗格会考>)

#cite(<OBRIEN1994Aircraft>)#cite(<张伯伟2002全唐五代诗格会考>)

#cite(<OBRIEN1994Aircraft>)
#cite(<张伯伟2002全唐五代诗格会考>)

#cite(<Hajela2012Application>)
#cite(<Sobieski>)

// 模板自定义引用函数，可以引用多个文献
#bib-cite(<fengxiqiao>, <Sobieszczanski>, <jiangxizhou>, <xiexide>, <yaoboyuan>)

#bib-cite(<yuFeiJiZongTiDuoXueKeSheJiYouHuaDeXianZhuangYuFaZhanFangXiang2008>, <Hajela2012Application>)

#bib-cite(
  <yuFeiJiZongTiDuoXueKeSheJiYouHuaDeXianZhuangYuFaZhanFangXiang2008>,
  <Hajela2012Application>,
  <张伯伟2002全唐五代诗格会考>,
  <OBRIEN1994Aircraft>,
  <雷光春2012>,
  <白书农>,
  <zhanghesheng>,
  <Sobieski>,
  <fengxiqiao>,
  <Sobieszczanski>,
  <jiangxizhou>,
  <xiexide>,
  <yaoboyuan>,
)


#conclusion()[
  本文结论……。

  结论作为毕业设计（论文）正文的最后部分单独排写，但不加章号。结论是对整个论文主要结果的总结。在结论中应明确指出本研究的创新点，对其应用前景和社会、经济价值等加以预测和评价，并指出今后进一步在本研究方向进行研究工作的展望与设想。结论部分的撰写应简明扼要，突出创新性。【阅后删除此段】

  结论正文样式与文章正文相同：宋体、小四；行距：22磅；间距段前段后均为0行。【阅后删除此段】

]

#references("./ref.bib")

#appendices()[

  附录相关内容…

  附录是毕业设计（论文）主体的补充项目，为了体现整篇文章的完整性，写入正文又可能有损于论文的条理性、逻辑性和精炼性，这些材料可以写入附录段，但对于每一篇文章并不是必须的。附录依次用大写正体英文字母A、B、C……编序号，如附录A、附录B。【阅后删除此段】

  附录正文样式与文章正文相同：宋体、小四；行距：22磅；间距段前段后均为0行。【阅后删除此段】

]

#acknowledgements()[

  值此论文完成之际，首先向我的导师……

  致谢正文样式与文章正文相同：宋体、小四；行距：22磅；间距段前段后均为0行。【阅后删除此段】

]

