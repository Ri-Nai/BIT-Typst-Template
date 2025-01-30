#import "@preview/cetz:0.3.1"
#import "@preview/fletcher:0.5.2" as fletcher: node, edge
#import "@preview/touying:0.5.5": *
#import "@preview/lovelace:0.3.0": *
#import "../touying-bit.typ": *
// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)
#let algorithm = figure.with(supplement: "算法", kind: "algorithm")

#set bibliography(title: "参考文献", style: "gb-7714-2015-numeric")



#let cell(
  content,
  bottom: 0pt,
  top: 0pt,
) = align(
  center + horizon,
  rect(
    stroke: (top: top, bottom: bottom),
    width: 100%,
    [#content],
  ),
)

#let three-line-table(
  header: (),
  footer: (),
  ..values,
) = {
  // 计算最大列数
  let columns = calc.max(..(values.pos().map(it => it.len())))
  if header != none {
    columns = calc.max(columns, header.len())
  }
  if footer != none {
    columns = calc.max(columns, footer.len())
  }

  let fill-blank(arr) = arr + (columns - arr.len()) * ("",)
  rect(
    stroke: (top: 1pt, bottom: 1pt), // 表格外框线
    width: 100%,
    inset: 0pt,
    outset: 0pt,
    grid(
      columns: columns,
      rows: auto,
      ..if header != () {
        fill-blank(header).map(c => cell(c, bottom: 1pt))
      },
      ..values.pos().map(row => fill-blank(row).map(c => cell(c))).flatten(),
      ..if footer != () {
        fill-blank(footer).map(c => cell(c, top: 1pt))
      }
    ),
  )
}


#show: bit-theme.with(
  // Lang and font configuration
  lang: "zh",

  // Basic information
  config-info(
    title: [数据结构研学报告展示],
    subtitle: [AC自动机的原理及应用],
    author: [杨紫诺],
    date: datetime.today(),
    institution: [北京理工大学],
  ),

  config-common(
    preamble: pdfpc.config(
      duration-minutes: 30,
      start-time: datetime(hour: 14, minute: 10, second: 0),
      end-time: datetime(hour: 14, minute: 40, second: 0),
      last-minutes: 5,
      note-font-size: 12,
      disable-markdown: false,
      default-transition: (
        type: "push",
        duration-seconds: 2,
        angle: ltr,
        alignment: "vertical",
        direction: "inward",
      ),
    ),
  ),
)

#title-slide()
#outline-slide()

= 引言

== 引言

#tblock(title: "AC自动机")[
  AC自动机（Aho-Corasick Automaton）是一种用于多模式字符串匹配的高效算法结构，主要用于快速查找多个模式串在目标字符串中的出现位置。相比于单模式串匹配的KMP算法，AC自动机在面对多模式串时表现出极高的效率，广泛应用于文本检索、词语过滤、DNA序列分析等领域。
]

本文将详细介绍AC自动机的原理，并探讨其在实际场景中的应用。

= AC自动机的原理

== 有限自动机

AC自动机首先是一个*有限自动机*。

#pause

这里给出非确定性有限自动机（Non-deterministic Finite Automaton, NFA）的形式化定义。

#pause

#let definitionNFA = tblock(title: "非确定性有限自动机")[
  非确定性有限自动机是 $N$ 是一个五元组 $(Q, Sigma, delta, q_0, F)$，其中：

  - $Q$是有限状态集合；
  - $Sigma$是有限输入字母表；
  - $delta: Q times Sigma_epsilon -> P(Q)$是状态转移函数；
  - $q_0 in Q$是初始状态；
  - $F subset.eq Q$是接受状态集合。
]

#definitionNFA

---

#definitionNFA

#pause

AC 自动机就是一个以多个模式串为语言的有限自动机，每个模式串对应一个接受状态。

#pause

AC 自动机的构建基于 #link(<touying:trie>)[*字典树*] 和 #link(<touying:kmp>)[*KMP算法*]，前者是确定DFA的基本结构以及成功匹配时的状态转移，后者用于处理失败匹配时的状态回退。

== 字典树 <touying:trie>

=== 字典树的定义

字典树（Trie）是一种用于高效存储和检索字符串的树形数据结构，它在字符串的前缀匹配和查询方面具有显著优势。

本质上，字典树也是一种有限自动机。当遇到属于模式串的字符时，自动机会继续向下进行状态转移；如果遇到非模式串的字符，则会进入拒绝状态。

---


#slide[
  === 字典树的构建
  例如给出字符串集合
  #pause


  #figure(
    three-line-table(
      header: ("", "string_name", ""),
      ("", "Reina", ""),
      ("", "Rin", ""),
      ("", "Rinai", ""),
      ("", "Rena", ""),
    ),
    kind: table,
    caption: "模式串集合",
  )
  #pause
  我们可以构造出如 @triepic 所示的字典树
][
  #pause
  #set text(size: 13.5pt)
  #figure(
    fletcher-diagram(
      node-stroke: 0.5pt,
      node-shape: circle,
      let step = 0.8,
      node((0, 0), "", name: <1>, extrude: (0, -20), radius: 1.4em),
      pause,
      edge(<1>, <2>, "-|>", label: "R", label-side: right),
      node((0, step), "R", name: <2>, radius: 1.4em),
      pause,
      edge(<2>, <3>, "-|>", label: "e"),
      node((0, step * 2), "Re", name: <3>, radius: 1.4em),
      pause,
      edge(<3>, <4>, "-|>", label: "i"),
      node((0, step * 3), "Rei", name: <4>, radius: 1.4em),
      pause,
      edge(<4>, <5>, "-|>", label: "n", label-side: right),
      node((0, step * 4), "Rein", name: <5>, radius: 1.4em),
      pause,
      edge(<5>, <6>, "-|>", label: "a"),
      node((0, step * 5), "Reina", name: <6>, extrude: (0, -4), radius: 1.4em),

      pause,
      edge(<2>, <7>, "-|>", label: "i"),
      node((step * 1, step * 2), "Ri", name: <7>, radius: 1.4em),
      edge(<7>, <8>, "-|>", label: "n"),
      node((step * 1, step * 3), "Rin", name: <8>, extrude: (0, -4), radius: 1.4em),
      pause,
      edge(<8>, <9>, "-|>", label: "a"),
      node((step * 1, step * 4), "Rina", name: <9>, radius: 1.4em),
      edge(<9>, <10>, "-|>", label: "i"),
      node((step * 1, step * 5), "Rinai", name: <10>, extrude: (0, -4), radius: 1.4em),
      pause,

      node((-1 * step, 3 * step), "Ren", name: <11>, radius: 1.4em),
      node((-1 * step, 4 * step), "Rena", name: <12>, extrude: (0, -4), radius: 1.4em),
      edge(<3>, <11>, "-|>", label: "n"),
      edge(<11>, <12>, "-|>", label: "a"),
    ),
    caption: "模式串集合的字典树",
  )<triepic>
]

---
#let figureCount = counter(figure.where(kind: image))
#figureCount.update(n => n - 1)

#slide(composer: (auto, 1fr))[
  #set text(size: 13.5pt)
  #figure(
    fletcher-diagram(
      node-stroke: 0.5pt,
      node-shape: circle,
      let step = 0.8,
      node((0, 0), "", name: <1>, extrude: (0, -20), radius: 1.4em),
      node((0, step), "R", name: <2>, radius: 1.4em),
      edge(<1>, <2>, "-|>", label: "R", label-side: right),
      edge(<2>, <3>, "-|>", label: "e"),
      node((0, step * 2), "Re", name: <3>, radius: 1.4em),
      edge(<3>, <4>, "-|>", label: "i"),
      node((0, step * 3), "Rei", name: <4>, radius: 1.4em),
      edge(<4>, <5>, "-|>", label: "n", label-side: right),
      node((0, step * 4), "Rein", name: <5>, radius: 1.4em),
      edge(<5>, <6>, "-|>", label: "a"),
      node((0, step * 5), "Reina", name: <6>, extrude: (0, -4), radius: 1.4em),

      edge(<2>, <7>, "-|>", label: "i"),
      node((step * 1, step * 2), "Ri", name: <7>, radius: 1.4em),
      edge(<7>, <8>, "-|>", label: "n"),
      node((step * 1, step * 3), "Rin", name: <8>, extrude: (0, -4), radius: 1.4em),
      edge(<8>, <9>, "-|>", label: "a"),
      node((step * 1, step * 4), "Rina", name: <9>, radius: 1.4em),
      edge(<9>, <10>, "-|>", label: "i"),
      node((step * 1, step * 5), "Rinai", name: <10>, extrude: (0, -4), radius: 1.4em),

      node((-1 * step, 3 * step), "Ren", name: <11>, radius: 1.4em),
      node((-1 * step, 4 * step), "Rena", name: <12>, extrude: (0, -4), radius: 1.4em),
      edge(<3>, <11>, "-|>", label: "n"),
      edge(<11>, <12>, "-|>", label: "a"),
    ),
    caption: "模式串集合的字典树",
  )
][
  #pause
  从图中可以看出字典树的：
  - 每一条边（转移函数）对应一个字符；
  - 每一条从根节点到接受状态的路径对应一个模式串；
  - 每一条根节点到其他节点的路径对应模式串的一个前缀。
  #pause
  #tblock(title: "例子")[
    - 从根节点到节点 `Reina` 的路径对应模式串 `Reina`。
    - 从根节点到节点 `Rin` 的路径对应模式串 `Rin`，也对应模式串 `Rinai` 的前缀。
  ]
]
---
=== 字典树的基本应用

因为字典树的形态是固定的，所以可以通过遍历字典树的方式，判断目标串是否：
- 是模式串的前缀；
- 包含模式串。

#pause

#tblock(title: "算法复杂度")[
  #set text(size: 15pt)
  如果采用二维数组存储转移函数。

  字典树的构建时间复杂度为 $O(sum m_i)$，其中 $m_i$ 为第 $i$ 个模式串的长度，空间复杂度为 $O(sum m_i times |Sigma|)$，其中 $|Sigma|$ 为字母表的大小。


  查询目标串是否是模式串的前缀的时间复杂度为 $O(n)$，其中 $n$ 为目标串的长度。

  若采用红黑树（std::map）等数据结构存储转移函数，空间复杂度可降至 $O(sum m_i)$，但是查询和构建的时间复杂度要乘上 $log |Sigma|$ 的因子。#[]<tblock-algorithm-trie>

]


---

由于字典树可以轻松的查找模式串的前缀，在算法竞赛中常使用 $0-1$ 字典树来维护最大异或值。#cite(<oiwiki_trie>)

#pause

例如以下题目：


#let problem = tblock(title: "最大异或对" + cite(<luogu_P10471>))[
  给定 $n$ 个数，求出异或值最大的两个数的异或值。
]

#pause

#problem

---

#problem


#tblock(title: "Solution")[
  1. 将所有数转换为二进制表示，高位补零。
  2. 每个数在插入字典树前，贪心地与字典树中的数异或，并更新最大异或值。
    - 从高位到低位，若当前位为 $0$，优先选择 $1$，否则选择 $0$ 的路径。
    - 到达叶子节点时，更新最大异或值。
  3. 将当前数插入字典树。

]

#pause

时间复杂度为 $O(n log max)$，其中 $log max$ 为最大数的二进制位数。

---

这里也能看到字典树的一个缺点，即只能判断与模式串的前缀关系匹配，无法判断其*子串*与模式串的关系。

为了解决这个问题，AC自动机引入了#link(<touying:kmp>)[*KMP算法*]的思想，构建了一个更加强大的多模式匹配算法。


== KMP算法 <touying:kmp>

KMP算法（Knuth-Morris-Pratt Algorithm）是由 Kruth、Morris 和 Pratt 三位计算机科学家于 1977 年提出的一种高效的字符串匹配算法。
#cite(<kmp>)
用于判断一个字符串是否包含另一个字符串作为子串，以及在匹配时出现的位置、次数等信息。

KMP算法的朴素思想就是在匹配失败时，利用已经匹配的信息，尽量减少重复匹配的次数。

而KMP在这方面的实现形式是*前缀函数*。

---

#tblock(title: "前缀函数的定义")[
  对于字符串 $s$，其前缀函数定义为
  $
    pi(i) = cases(
    #[$0, i = 0$],
    #[$max{k | k < i, s[0...k-1] = s[i-(k-1)...i]}, 0 < i < n$]
  )
  $
]

其中 $s[l...r]$ 表示字符串 $s$ 的子串 $s[l], s[l+1], ..., s[r]$。

即 $s[0...k-1]$ 是 $s$ 的前缀 $s[0...i]$ 的前 $k$ 个字符，$s[i-(k-1)...i]$ 是 $s$ 的后缀 $s[0...i]$ 的后 $k$ 个字符。

也就是对于任意一个前缀，它前缀函数的值为*最长的*能使得前缀与后缀相等的长度。



---
#let tableCounter = counter(figure.where(kind: table))
#tableCounter.update(0)

例如对于字符串 `ababaca`，其前缀函数为
#figure(
  three-line-table(
    header: (
      $s[0...i]$,
      "a",
      "ab",
      text(red)[a] + "b" + text(blue)[a],
      text(red)[ab] + text(blue)[ab],
      text(red)[ab] + text(purple)[a] + text(blue)[ba],
      "ababac",
      text(red)[a] + "babac" + text(blue)[a],
    ),
    ($pi(i)$, "0", "0", "1", "2", "3", "0", "1"),
  ),
  kind: table,
  caption: "字符串" + `ababaca` + "的前缀函数",
)

---
#tblock(title: "前缀函数的性质")[
  + $pi(i + 1) <= pi(i) + 1$，当且仅当 $s[pi(i)] = s[i]$ 时等号成立；即前缀函数在相邻位置转移时，若增加，最多只能增加 $1$。
  + 若 $s[0...k-1] = s[i-(k-1)...i]$ 且 $pi(k) > 0$，则 $s[0...pi(k) - 1] = s[i-(pi(k)-1)...i]$。也就是说相等的前后缀，其前缀函数对应的相等的前后缀也是原串中的前后缀。
    - 如 #text(red)[ab]#text(purple)[a]#text(blue)[ba]中的前缀 #text(green)[a]b#text(orange)[a] 的前后缀 #text(green)[a] 同样也是 #text(green)[a]bab#text(orange)[a] 的前后缀。
]
#pause
根据这两个性质，我们可以快速的构造出一个字符串的前缀函数。

---
#tblock(title: "前缀函数的构造算法")[
  + 初始化 $pi(0) = 0$；
  + 找到最大的 $k$ 使得 $s[0...k-1] = s[i-(k-1)...i]$；
    - 即对 $k$ 根据 $pi(k-1)$ 递减，直到找到满足条件的 $k$（性质 2）；这样 $k$ 是依次递减且不遗漏的。
  + 若 $s[k] = s[i]$，则 $pi(i) = k + 1$；否则 $pi(i) = 0$。
]
#box()<tblock-algorithm-prefix-function>
---
#show figure.where(kind: "algorithm"): set text(font: "Times New Roman", fill: rgb("#05261e"), size: 16pt)
#let algorithmCounter = counter(figure.where(kind: "algorithm"))
#algorithmCounter.update(0)


伪代码如 @algorithm-prefix-function 所示。
#pause

#algorithm(caption: "前缀函数的构造算法")[
  #pseudocode-list(indentation: 3em, line-gap: 0.5em)[
    + *function* $#[prefix]\_#[function]""(s: #[string])$ *returns* $#[array]_#[int]$
      + $pi[0] <- 0$
      + *for* $i <- 1$ *to* $n - 1$ *do*
        + $k <- pi[i - 1]$
        + *while* $k > 0$ *and* $s[k] != s[i]$ *do*
          + $k <- pi[k - 1]$
        + *end*
        + *if* $s[k] = s[i]$ *then*
          + $k <- k + 1$
        + *end*
        + $pi[i] <- k$
      + *end*
      + *return* $pi$
    + *end*
  ]
]<algorithm-prefix-function>

---

#tblock(title: "前缀函数构造的时间复杂度")[
  构造前缀函数时的时间复杂度主要由指针变化引起，即以下两个部分：

  + $k <- pi[k - 1]$
  + $k <- k + 1$
]

#pause

由于 $k$ 恒不为负，而 1 操作最少使得 $k$ 减少 $1$，因此 1 操作的次数不会超过 2 操作的次数。

#pause

而 2 操作的次数不会超过 $n$（每次匹配成功后 $k$ 会增加 $1$，而匹配次数最多为 $n$），因此构造前缀函数的时间复杂度为 $O(n)$。

---

#tblock(title: "KMP算法的实现")[

  直接采用前缀函数构造的思路，我们可以实现KMP算法。

  将目标串称为 $s$，模式串称为 $p$，我们可以通过构造 $p+s$ 的前缀函数，来判断 $s$ 中是否包含 $p$。

  当 $p+s$ 的某个前缀函数值等于 $|p|$ 时，说明 $s$ 中存在 $p$。

  当然可能出现前缀函数超过 $|p|$ 的情况，因此我们需要在连接字符串时插入一个特殊字符，以确保前缀函数的值不会超过 $|p|$。
]
---

伪代码如 @algorithm-kmp-search 所示：
#algorithm(caption: "KMP算法的实现")[
  #pseudocode-list(indentation: 3em, line-gap: 0.5em)[
    + *function* $#[kmp]\_#[search]""(s: #[string], p: #[string])$ *returns* $#[array]_#[int]$
      + $n <- |s|, m <- |p|$
      + $pi <- #[prefix]\_#[function]""(p + \'\#\' + s)$
      + $italic("ans") <- []$
      + *for* $i <- 0$ *to* $n - 1$ *do*
        + *if* $pi[m + i + 1] = m$ *then*
          + $italic("ans").#[push]""($i - m + 1$)$
        + *end*
      + *end*
      + *return* $italic("ans")$
    + *end*
  ],
]<algorithm-kmp-search>

---

#tblock(title: "时间复杂度分析")[
  KMP字符串匹配的时间复杂度即为构造 $p+s$ 的前缀函数的时间复杂度，为 $O(n + m)$。
]

#pause

#tblock(title: "KMP算法的思想总结")[
  通过前缀函数的性质以及存下来已知的信息，我们只需要在*失败匹配*的时候找到前缀匹配的尽量多的部分，将指针移动到这个位置，而不需要重新匹配。

  我们如果能在字典树中使用这个思想，就能够在匹配失败时，快速的找到下一个匹配的位置。不需要每次重新遍历整个字典树就能快速的找到目标串种是否包含某个模式串。
]


== AC自动机 <touying:acam>

AC自动机是一个建立在字典树的基础之上的有限自动机，除了字典树中*成功匹配*的状态转移外，还引入了KMP算法中的*失败匹配*的状态回退，即在匹配失败时找到模式串中与当前已匹配状态的后缀相同的最长前缀，将状态回退到这个位置。

---

#slide[
  === AC自动机的结构
  例如给出字符串集合：

  #pause

  #figure(
    three-line-table(
      header: ("", "string_name", ""),
      ("", "he", ""),
      ("", "she", ""),
      ("", "his", ""),
      ("", "hers", ""),
      ("", "is", ""),
    ),
    kind: table,
    caption: "模式串集合",
  )

  #pause

  对应的AC自动机如 @diagram-ac-automaton 所示：
][
  #figureCount.update(1)
  #set text(size: 13.5pt)
  #figure(
    fletcher-diagram(
      node-stroke: 0.5pt,
      node-shape: circle,
      let step = 0.8,
      node((0 * step, 0 * step), "", name: <empty>, extrude: (0, -20), radius: 1.6em),

      pause,

      node((-1 * step, 1 * step), "h", name: <h>, radius: 1.6em),
      node((-2 * step, 2 * step), "he", name: <he>, extrude: (0, -4), radius: 1.6em),
      edge(<empty>, <h>, "-|>", label: "h"),
      edge(<h>, <he>, "-|>", label: "e"),

      pause,

      node((1 * step, 1 * step), "s", name: <s>, radius: 1.6em),
      node((1 * step, 2 * step), "sh", name: <sh>, radius: 1.6em),
      node((1 * step, 3 * step), "she", name: <she>, extrude: (0, -4), radius: 1.6em),

      edge(<empty>, <s>, "-|>", label: "s"),
      edge(<s>, <sh>, "-|>", label: "h"),
      edge(<sh>, <she>, "-|>", label: "e"),

      pause,

      node((-1 * step, 2 * step), "hi", name: <hi>, radius: 1.6em),
      node((-1 * step, 3 * step), "his", name: <his>, extrude: (0, -4), radius: 1.6em),
      edge(<h>, <hi>, "-|>", label: "i"),
      edge(<hi>, <his>, "-|>", label: "s"),

      pause,

      node((-2 * step, 3 * step), "her", name: <her>, radius: 1.6em),
      node((-2 * step, 4 * step), "hers", name: <hers>, extrude: (0, -4), radius: 1.6em),
      edge(<he>, <her>, "-|>", label: "r"),
      edge(<her>, <hers>, "-|>", label: "s"),

      pause,

      node((0 * step, 1 * step), "i", name: <i>, radius: 1.6em),
      node((0 * step, 2 * step), "is", name: <is>, extrude: (0, -4), radius: 1.6em),
      edge(<empty>, <i>, "-|>", label: "i"),
      edge(<i>, <is>, "-|>", label: "s"),


      let quad(a, b, label, paint: red, ..args) = {
        paint = paint.darken(25%)
        edge(a, b, text(paint, label), "-|>", stroke: paint, ..args)
      },

      pause,

      quad(<hi>, <i>, $epsilon$),
      quad(<his>, <is>, $epsilon$),
      quad(<sh>, <h>, $epsilon$, bend: -110deg, label-side: left),
      quad(<she>, <he>, $epsilon$, bend: 60deg),
      quad(<hers>, <s>, $epsilon$, bend: -90deg),
      quad(<is>, <s>, $epsilon$),
    ),
    caption: "模式串集合的AC自动机",
  )<diagram-ac-automaton>
]

---
#figureCount.update(1)
#let acam-structure = figure(
  fletcher-diagram(
    node-stroke: 0.5pt,
    node-shape: circle,
    let step = 0.8,
    node((0 * step, 0 * step), "", name: <empty>, extrude: (0, -20), radius: 1.6em),


    node((-1 * step, 1 * step), "h", name: <h>, radius: 1.6em),
    node((-2 * step, 2 * step), "he", name: <he>, extrude: (0, -4), radius: 1.6em),
    edge(<empty>, <h>, "-|>", label: "h"),
    edge(<h>, <he>, "-|>", label: "e"),


    node((1 * step, 1 * step), "s", name: <s>, radius: 1.6em),
    node((1 * step, 2 * step), "sh", name: <sh>, radius: 1.6em),
    node((1 * step, 3 * step), "she", name: <she>, extrude: (0, -4), radius: 1.6em),

    edge(<empty>, <s>, "-|>", label: "s"),
    edge(<s>, <sh>, "-|>", label: "h"),
    edge(<sh>, <she>, "-|>", label: "e"),


    node((-1 * step, 2 * step), "hi", name: <hi>, radius: 1.6em),
    node((-1 * step, 3 * step), "his", name: <his>, extrude: (0, -4), radius: 1.6em),
    edge(<h>, <hi>, "-|>", label: "i"),
    edge(<hi>, <his>, "-|>", label: "s"),


    node((-2 * step, 3 * step), "her", name: <her>, radius: 1.6em),
    node((-2 * step, 4 * step), "hers", name: <hers>, extrude: (0, -4), radius: 1.6em),
    edge(<he>, <her>, "-|>", label: "r"),
    edge(<her>, <hers>, "-|>", label: "s"),


    node((0 * step, 1 * step), "i", name: <i>, radius: 1.6em),
    node((0 * step, 2 * step), "is", name: <is>, extrude: (0, -4), radius: 1.6em),
    edge(<empty>, <i>, "-|>", label: "i"),
    edge(<i>, <is>, "-|>", label: "s"),


    let quad(a, b, label, paint: red, ..args) = {
      paint = paint.darken(25%)
      edge(a, b, text(paint, label), "-|>", stroke: paint, ..args)
    },


    quad(<hi>, <i>, $epsilon$),
    quad(<his>, <is>, $epsilon$),
    quad(<sh>, <h>, $epsilon$, bend: -110deg, label-side: left),
    quad(<she>, <he>, $epsilon$, bend: 60deg),
    quad(<hers>, <s>, $epsilon$, bend: -90deg),
    quad(<is>, <s>, $epsilon$),
  ),
  caption: "模式串集合的AC自动机",
)

#slide(composer: (auto, 1fr))[
  #set text(size: 13.5pt)
  #figureCount.update(1)
  #acam-structure
][
  #pause

  图中的 $epsilon$ 表示非确定性有限自动机中的 $epsilon$ 转移#cite(<nfa_wiki>)，即不消耗任何输入，直接转移到下一个状态。在AC自动机中被称为 *fail* 指针。

  图中未画出的 *fail* 指针均指向根节点。

]
---
#slide(composer: (auto, 1fr))[
  #set text(size: 13.5pt)
  #figureCount.update(1)
  #acam-structure
][

  #pause

  - 可以清楚地看到，每个 *fail* 指针指向的状态都是当前状态的最长前缀，即在匹配失败时，可以直接跳转到这个状态，而不需要重新遍历整个字典树。

  #pause

  - 由 *fail* 指针的性质知道，只可能由深的节点指向浅的节点，因此在构建时，我们可以通过层序遍历的方式构建 *fail* 指针。

  #pause

  - 同时，*fail* 指针的连接构成了一棵内向树，根节点为根节点。
]
---

=== AC自动机的构建

与构建字典树相比，AC自动机的构建过程多了一个 *fail* 指针的构建。

#pause

#tblock(title: "fail指针的构建")[
  + 初始所有状态的 *fail* 指针指向根节点；
  + 层序遍历字典树，构建 *fail* 指针；
  + 若 $v = delta(u, c)$，则 $#[fail]""(v) = delta(#[fail]""(u), c)$；
  + 若 $delta(#[fail]""(u), c)$ 不存在，则继续从 $#[fail]""(#[fail]""(u))$ 转移，以此类推，直到转移到根节点或者找到一个存在的转移。
]

#pause

可以发现这个过程与KMP算法中的#link(<tblock-algorithm-prefix-function>)[*前缀函数*]的构建过程非常相似，只不过是在字典树上扩展。

---

=== AC自动机的匹配

与AC自动机的构建类似，匹配过程如下：

#tblock(title: "AC自动机的匹配")[
  + 初始化当前状态为根节点。
  + 逐个读入目标串中的字符：
    - 若下一个转移状态存在，则转移到该状态。
    - 若下一个转移状态不存在，则通过 *fail* 指针退回到直到一个存在的转移状态或根节点。
  + 读入字符后，当前状态表示以该字符为结尾的子串能在模式串中匹配的最长前缀。
  + 记录每个经过的状态，若状态为接受状态，则表示匹配成功。
]

---

=== AC自动机的匹配

由于某一个状态匹配成功了，那么它的 *fail* 指针指向的状态也一定匹配成功，因此我们可以通过 *fail* 指针的回溯来找到所有匹配成功的状态。

最后收集答案的时候可以使用类似于拓扑排序的方式，从 *fail* 树的叶节点开始，逐层向上回溯，找到所有匹配成功的状态。

---


=== 字典图优化

在AC自动机的构建和匹配中，我们需要重复进行 *fail* 指针的回溯直到匹配成功。

类比KMP算法，的时间复杂度分析，匹配过程的时间复杂度为 $O(n + sum m_i)$。

但是构建过程时无法保证 *fail* 指针的回溯次数，这是因为你并没有用到模式串中的有效信息，只知道 $delta(#[fail]""(u), c)$ 不存在，但是不知道具体需要到哪一个 *fail* 指针才能保证 $delta(#[fail]""(u), c)$ 存在。

我们构建的AC自动机中或字典树中，存在很多个空状态，而我们遇到这个状态的时候需要回溯到根节点，这是一个很大的开销。

---

#slide(composer: (1fr, auto))[

  一个朴素的想法就是，在构建的时候直接将这些空状态连接到应该回溯的状态上，这样在匹配的时候就不需要回溯到根节点，而是直接跳转到应该回溯的状态。

  例如我们可以在 @diagram-ac-automaton 中加入如 @diagram-ac-automaton-optimized 所示的边来优化AC自动机，构建字典图。
][
  #pause
  #figureCount.update(2)
  #set text(size: 13.5pt)
  #figure(
    fletcher-diagram(
      node-stroke: 0.5pt,
      node-shape: circle,
      let step = 0.8,
      node((0 * step, 0 * step), "", name: <empty>, extrude: (0, -20), radius: 1.6em),


      node((-1 * step, 1 * step), "h", name: <h>, radius: 1.6em),
      node((-2 * step, 2 * step), "he", name: <he>, extrude: (0, -4), radius: 1.6em),
      edge(<empty>, <h>, "-|>", label: "h"),
      edge(<h>, <he>, "-|>", label: "e"),


      node((1 * step, 1 * step), "s", name: <s>, radius: 1.6em),
      node((1 * step, 2 * step), "sh", name: <sh>, radius: 1.6em),
      node((1 * step, 3 * step), "she", name: <she>, extrude: (0, -4), radius: 1.6em),

      edge(<empty>, <s>, "-|>", label: "s"),
      edge(<s>, <sh>, "-|>", label: "h"),
      edge(<sh>, <she>, "-|>", label: "e"),


      node((-1 * step, 2 * step), "hi", name: <hi>, radius: 1.6em),
      node((-1 * step, 3 * step), "his", name: <his>, extrude: (0, -4), radius: 1.6em),
      edge(<h>, <hi>, "-|>", label: "i"),
      edge(<hi>, <his>, "-|>", label: "s"),


      node((-2 * step, 3 * step), "her", name: <her>, radius: 1.6em),
      node((-2 * step, 4 * step), "hers", name: <hers>, extrude: (0, -4), radius: 1.6em),
      edge(<he>, <her>, "-|>", label: "r"),
      edge(<her>, <hers>, "-|>", label: "s"),


      node((0 * step, 1 * step), "i", name: <i>, radius: 1.6em),
      node((0 * step, 2 * step), "is", name: <is>, extrude: (0, -4), radius: 1.6em),
      edge(<empty>, <i>, "-|>", label: "i"),
      edge(<i>, <is>, "-|>", label: "s"),


      let quad(a, b, label, paint: red, ..args) = {
        paint = paint.darken(25%)
        edge(a, b, text(paint, label), "-|>", stroke: paint, ..args)
      },


      quad(<hi>, <i>, $epsilon$),
      quad(<his>, <is>, $epsilon$),
      quad(<sh>, <h>, $epsilon$, bend: -110deg, label-side: left),
      quad(<she>, <he>, $epsilon$, bend: 60deg),
      quad(<hers>, <s>, $epsilon$, bend: -90deg),
      quad(<is>, <s>, $epsilon$),


      pause,
      quad(<she>, <her>, "r", paint: blue, bend: 60deg),
      quad(<hers>, <sh>, "h", paint: blue, bend: -75deg),
      quad(<his>, <sh>, "h", paint: blue, bend: -20deg),
      quad(<is>, <sh>, "h", paint: blue),
    ),
    caption: "字典图优化后的AC自动机",
  )<diagram-ac-automaton-optimized>
]

---

#let acam-structure-optimized = figure(
  fletcher-diagram(
    node-stroke: 0.5pt,
    node-shape: circle,
    let step = 0.8,
    node((0 * step, 0 * step), "", name: <empty>, extrude: (0, -20), radius: 1.6em),


    node((-1 * step, 1 * step), "h", name: <h>, radius: 1.6em),
    node((-2 * step, 2 * step), "he", name: <he>, extrude: (0, -4), radius: 1.6em),
    edge(<empty>, <h>, "-|>", label: "h"),
    edge(<h>, <he>, "-|>", label: "e"),


    node((1 * step, 1 * step), "s", name: <s>, radius: 1.6em),
    node((1 * step, 2 * step), "sh", name: <sh>, radius: 1.6em),
    node((1 * step, 3 * step), "she", name: <she>, extrude: (0, -4), radius: 1.6em),

    edge(<empty>, <s>, "-|>", label: "s"),
    edge(<s>, <sh>, "-|>", label: "h"),
    edge(<sh>, <she>, "-|>", label: "e"),


    node((-1 * step, 2 * step), "hi", name: <hi>, radius: 1.6em),
    node((-1 * step, 3 * step), "his", name: <his>, extrude: (0, -4), radius: 1.6em),
    edge(<h>, <hi>, "-|>", label: "i"),
    edge(<hi>, <his>, "-|>", label: "s"),


    node((-2 * step, 3 * step), "her", name: <her>, radius: 1.6em),
    node((-2 * step, 4 * step), "hers", name: <hers>, extrude: (0, -4), radius: 1.6em),
    edge(<he>, <her>, "-|>", label: "r"),
    edge(<her>, <hers>, "-|>", label: "s"),


    node((0 * step, 1 * step), "i", name: <i>, radius: 1.6em),
    node((0 * step, 2 * step), "is", name: <is>, extrude: (0, -4), radius: 1.6em),
    edge(<empty>, <i>, "-|>", label: "i"),
    edge(<i>, <is>, "-|>", label: "s"),


    let quad(a, b, label, paint: red, ..args) = {
      paint = paint.darken(25%)
      edge(a, b, text(paint, label), "-|>", stroke: paint, ..args)
    },


    quad(<hi>, <i>, $epsilon$),
    quad(<his>, <is>, $epsilon$),
    quad(<sh>, <h>, $epsilon$, bend: -110deg, label-side: left),
    quad(<she>, <he>, $epsilon$, bend: 60deg),
    quad(<hers>, <s>, $epsilon$, bend: -90deg),
    quad(<is>, <s>, $epsilon$),

    quad(<she>, <her>, "r", paint: blue, bend: 60deg),
    quad(<hers>, <sh>, "h", paint: blue, bend: -75deg),
    quad(<his>, <sh>, "h", paint: blue, bend: -20deg),
    quad(<is>, <sh>, "h", paint: blue),
  ),
  caption: "字典图优化后的AC自动机",
)

#slide(composer: (auto, 1fr))[
  #figureCount.update(2)
  #set text(size: 13.5pt)
  #acam-structure-optimized
][
  @diagram-ac-automaton-optimized 中的蓝色边表示字典图优化后的边（省略了到根节点后转移的边），可以看到，我们将原本需要回溯到根节点的状态直接连接到了应该回溯的状态上。

  #pause

  #tblock(title: "例子")[
    例如状态`she`匹配失败时，若读入 `r`，则直接转移到状态`her`，而不需要回溯到根节点。其他状态直接转移回根节点。
  ]

]

#slide(composer: (auto, 1fr))[
  #figureCount.update(2)
  #set text(size: 13.5pt)
  #acam-structure-optimized
][
  #tblock(title: "时间复杂度分析")[
    此时在匹配时只需要按照状态转移即可，不需要根据 *fail* 指针回溯，时间复杂度仍然为 $O(n + sum m_i)$。

    在构建时，每个节点只会用到它父亲与父亲的 *fail* 指针的状态，不会逐层回溯，因此构建的时间复杂度为 $O(|Sigma| times sum m_i)$。其中 $|Sigma|$ 为字母表大小，$m_i$ 为模式串长度。

    若用数组的方式存储状态转移，空间复杂度为 $O(|Sigma| times sum m_i)$，与字典树相同。
  ]
]

= AC自动机的应用
---
自 1975 年 Aho 和 Corasick 提出 AC 自动机以来，AC 自动机在字符串匹配领域有着广泛的应用。

== 多模式串匹配

作为 AC 自动机最基本的应用，多模式串匹配是 AC 自动机的一个重要应用。主要用于在一个目标串中匹配多个模式串。

#pause

#tblock(title: "多模式串匹配的应用")[
  + 字符串匹配：搜索引擎中的关键词匹配；代码编辑器中的代码提示...
  + 文本过滤：游戏中过滤敏感词；过滤垃圾邮件#cite(<丁川芸2019基于AC自动机和贝叶斯方法的垃圾内容识别>)
  + 中文分词：使用动态规划概率推断的中文分词#cite(<徐懿彬2017基于Aho-Corasick自动机算法的概率模型中文分词CPACA算法>)...
  + 基因匹配：基因序列匹配#cite(<thambawita2016optimized>)...
  + ...
]

== 压缩字符串集合

AC自动机通过构建多模式匹配树，优化字符串排序，帮助生成高重复性的BWT字符串，从而提升压缩效率。#cite(<cazaux2018strong>)。

== 各类有限自动机在算法竞赛中的应用

由AC自动机衍生出的各类有限自动机在算法竞赛中有着广泛的应用，例如：

#pause


#tblock(title: "有限自动机的应用")[
  + KMP自动机：类似于单串情况下的AC自动机，主要用于动态 / 可持久化字符串匹配等。#cite(<luogu_KMPAM>)
  + 后缀自动机：又称 SAM（Suffix Automaton），功能最为强大，主要用于与单模式串的后缀匹配 / 后缀树 / k大子串匹配 / LCP（Longest Common Prefix）等。#cite(<oiwiki_sam>)
  + 回文自动机：又称 PAM（Palindrome Automaton）或回文树，主要用于回文串匹配 / 回文子串个数统计 / 回文子串最长长度等。#cite(<oiwiki_pam>)
]

---

#bibliography("./ref.bib")
