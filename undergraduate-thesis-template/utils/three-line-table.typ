#let three-line-table(
  header: (),
  footer: (),
  inset: (
    x: 1.5em,
    y: 0.5em,
  ),
  ..values,
) = {
  // 计算最大列数
  let columns = calc.max(..(values.pos().map(it => it.len())))
  let fill-blank(arr) = arr + (columns - arr.len()) * ("",)
  let cell = x => table.cell(inset: inset)[#x]
  table(
    columns: columns,
    stroke: none,
    table.hline(stroke: 1.5pt),
    ..if header != () {
      (
        table.header(..header.map(cell)),
        table.hline(stroke: 0.5pt),
      )
    },
    ..values.pos().map(fill-blank).flatten().map(cell),
    ..if footer != () {
      (
        table.hline(stroke: 0.5pt),
        table.footer(..footer.map(cell)),
      )
    },
    table.hline(stroke: 1.5pt)
  )
}
