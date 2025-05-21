#let default-config = (
  info: (
    college: "",
    class: "",
    author: "",
    major: "",
    student-id: "",
    guide-teacher: "",
    date: datetime.today(),
    override-info: (:),
  ),
  page: (
    subject: "",
    title: "",
    title-en: "",
    header: "北京理工大学本科生毕业设计（论文）",
    show-declaration: true,
    show-cover: true,
    show-contents: true,
    abstract: (
      content: [],
      content-en: [],
      keywords: (),
      keywords-en: (),
    ),
    auto-pagebreak: true,
  ),
)

#let merge-config(
  config-a,
  config-b,
) = {
  if config-a.len() == 0 {
    return config-b
  }
  let result = config-a
  for (key, value) in config-b {
    if key in config-a {
      if type(value) == dictionary {
        result.at(key) = merge-config(
          config-a.at(key),
          value,
        )
      } else {
        result.at(key) = value
      }
    }
  }
  return result
}

#let get-config(
  config,
) = {
  return merge-config(
    default-config,
    config,
  )
}
