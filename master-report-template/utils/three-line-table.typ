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
