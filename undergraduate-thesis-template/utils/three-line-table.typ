#let three-line-table(
  header: (),
  footer: (),
  ..values,
) = {
  // 计算最大列数
  let columns = calc.max(..(values.pos().map(it => it.len())))
  let fill-blank(arr) = arr + (columns - arr.len()) * ("",)
  table(
    columns: columns,
    stroke: none,
    table.hline(stroke: 1.5pt),
    ..if header != () {
      (
        table.header(..header.map(x => [#x])),
        table.hline(stroke: 0.5pt),
      )
    },
    ..values.pos().map(fill-blank).flatten().map(x => [#x]),
    ..if footer != () {
      (
        table.hline(stroke: 0.5pt),
        table.footer(..footer.map(x => [#x])),
      )
    },
    table.hline(stroke: 1.5pt)
  )
}
