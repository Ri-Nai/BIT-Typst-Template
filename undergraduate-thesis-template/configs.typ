
#let add-dicts(dict-a, dict-b) = {
  let res = dict-a
  for key in dict-b.keys() {
    if key in res and type(res.at(key)) == dictionary and type(dict-b.at(key)) == dictionary {
      res.insert(key, add-dicts(res.at(key), dict-b.at(key)))
    } else {
      res.insert(key, dict-b.at(key))
    }
  }
  return res
}


#let merge-dicts(init-dict, ..dicts) = {
  assert(dicts.named().len() == 0, message: "You must provide dictionaries as positional arguments")
  let res = init-dict
  for dict in dicts.pos() {
    res = add-dicts(res, dict)
  }
  return res
}




#let config-abstract(
  content: [],
  content-en: [],
  keywords: (),
  keywords-en: (),
) = {
  return (
    abstract: (
      content: content,
      content-en: content-en,
      keywords: keywords,
      keywords-en: keywords-en,
    ),
  )
}

#let override-info(
  ..args,
) = {
  return (override-info: args.named())
}


#let config-page(
  show-cover: true,
  show-declaration: true,
  show-contents: true,
  auto-pagebreak: true,
  abstract: config-abstract(),
) = {
  return (
    page: merge-dicts(
      (
        show-cover: show-cover,
        show-declaration: show-declaration,
        show-contents: show-contents,
        auto-pagebreak: auto-pagebreak,
      ),
      abstract,
    ),
  )
}

#let config-info(
  subject: "",
  title: "",
  title-en: "",
  college: "",
  major: "",
  class: "",
  override-info: override-info(),
) = {
  return (
    info: merge-dicts(
      (
        subject: subject,
        title: title,
        title-en: title-en,
        college: college,
        major: major,
        class: class,
      ),
      override-info,
    ),
  )
}


#let default-config = merge-dicts(
  config-page(),
  config-info(),
)
#let config(
  ..args,
) = {
  let args = (default-config,) + args.pos()
}
