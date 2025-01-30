#import "@preview/pointless-size:0.1.0": zh, zihao

#let chinese-overrides = (
  ("初号", 42pt),
  ("小初", 36pt),
  ("一号", 26pt),
  ("小一", 24pt),
  ("二号", 22pt),
  ("小二", 18pt),
  ("三号", 16pt),
  ("小三", 15pt),
  ("四号", 14pt),
  ("小四", 12pt),
  ("五号", 10.5pt),
  ("小五", 9pt),
  ("六号", 7.5pt),
  ("小六", 6.5pt),
  ("七号", 5.5pt),
  ("八号", 5pt),
  ("初", 42pt),
  ("一", 26pt),
  ("二", 22pt),
  ("三", 16pt),
  ("四", 14pt),
  ("五", 10.5pt),
  ("六", 7.5pt),
  ("七", 5.5pt),
  ("八", 5pt),
)
#let cn-zihao(size) = zihao(size, overrides: chinese-overrides)
#let cn-zh(size) = zh(size, overrides: chinese-overrides)
#let songti = ("Times New Roman", "SimSun")
#let heiti = ("Times New Roman", "SimHei")
