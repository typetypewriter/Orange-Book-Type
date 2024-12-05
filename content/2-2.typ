#import "../lib/lib.typ": *

#chapter("Presenting Information and Results with a Long Chapter Title", image: image("../fig/orange3.jpg"))

== Table 表格
#index("Table")

#figure(
  table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*Treatments*], [*Response 1*], [*Response 2*],
  [Treatment 1],
  [0.0003262],
  [0.562],
  [Treatment 2],
  [0.0015681],
  [0.910],
  [Treatment 3],
  [0.0009271],
  [0.296],
  ),
  caption: [Table caption. 表格],
) <table> // 可以结尾加一个形如<...>这样的东西来方便后续引用

Referencing @table in-text using its label. 通过label来引用表格 @table1

== Figure 图像
#index("Figure")

#figure(
  image("../fig/creodocs_logo.svg", width: 50%),
  caption: [Figure caption.],
) <figure>

Referencing @figure in-text using its label 通过label来引用图像 @figure1

#figure(
  placement: top,
  table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*Treatments*], [*Response 1*], [*Response 2*],
  [Treatment 1],
  [0.0003262],
  [0.562],
  [Treatment 2],
  [0.0015681],
  [0.910],
  [Treatment 3],
  [0.0009271],
  [0.296],
  ),
  caption: [Floating table.],
) <table1>

#figure(
  placement: bottom,
  image("../fig/creodocs_logo.svg", width: 100%),
  caption: [Floating figure.],
) <figure1>