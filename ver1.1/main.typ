#import "./lib/template.typ": *
// content文件夹里面每个文件都需要 #import "../lib/template.typ": *

/*书籍封面&版权*/

#show: book.with(
  title: "橘色的笔记本", // 标题
  subtitle: "橘色的笔记本的副标题", // 副标题
  author: "你",
  main-color: rgb("#F36619"), // 主题色（默认"#F36619"）
  lang: "zh", // 语言（默认"zh"）
  cover: image("./fig/background.svg"), // 封面的图像
  preface-parent-name: "前言", // 补足总前言名称（不需要可注释掉）
  include-preface: "../content/pre.typ", // 前言（不需要可注释掉，多文件以("", "")这样的数组形式来写）
  outline-image-index: image("./fig/orange1.jpg"), // 目录头图（不需要可注释掉）
  list-of-figure-title: "图像目录", // 图像索引（不需要可以注释掉）
  fig-outline-image-index: image("./fig/orange1.jpg"), // 图像索引头图（不需要可注释掉）
  list-of-table-title: "表格目录", // 表格索引（不需要可以注释掉）
  tab-outline-image-index: image("./fig/orange1.jpg"), // 表格索引头图（不需要可注释掉）
  supplement-chapter: "章节", // 补足章节样式文本
  supplement-part: "部分", // 补足部分样式文本
  part-style: 0, // 两种 部分页 的样式，有1和0两种样式
  par-indent: 2em, // 段落首行缩进参数（默认2字符）
  par-justify: true, // 段落是否两端对齐（默认true）
  par-leading: 1em, // 行间距（默认1倍）
  par-spacing: 1em, // 段间距（默认1倍）
  font-size: 10pt, // 正文字体大小
  copyright: [
    Copyright © 2024 打字机

    PUBLISHED BY PUBLISHER

    原模板位置 #link("https://github.com/flavio20002/typst-orange-template", "TEMPLATE-WEBSITE")

    Licensed under the Apache 2.0 License (the “License”).
    You may not use this file except in compliance with the License. You may obtain a copy of
    the License at https://www.apache.org/licenses/LICENSE-2.0. Unless required by
    applicable law or agreed to in writing, software distributed under the License is distributed on an
    “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.

    _First printing, December 2024_
  ],
  uplower-case-references: 0 //补足部分样式文本整体大小写修正（1代表小写 2代表大写 0代表不改变）
)

/*正文部分（参考文献和附录都可以放在各个part内）*/ 

#part("部分一")
#include "./content/1.typ"

#part("部分二")
#include "./content/2-1.typ"
#include "./content/2-2.typ"

#my-bibliography(bibliography("refs.bib", style: "gb-7714-2015-numeric")) // 参考文献，利用style控制参考文献显示样式

#make-index(title: "Index") // 索引（仅支持英文）

// 附录
#show: appendices.with("Appendices", hide-parent: false)
#include "content/a-1.typ"
