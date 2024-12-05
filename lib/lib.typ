#import("./my-outline.typ"): *
#import("./my-index.typ"): *
#import("./theorems.typ"): *
#import("./fonts.typ"): *

#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)
#let mathcal = (it) => {
  set text(size: 1.3em, font: "OPTIOriginal", fallback: false)
  it
  h(0.1em)
}

#let normal-text = 1em
#let large-text = 3em
#let huge-text = 16em
#let title-main-1 = 2.5em
#let title-main-2 = 1.8em
#let title-main-3 = 2.2em
#let title1 = 2.2em
#let title2 = 1.5em
#let title3 = 1.3em
#let title4 = 1.2em
#let title5 = 11pt

#let outline-part = 1.5em;
#let outline-heading1 = 1.3em;
#let outline-heading2 = 1.1em;
#let outline-heading3 = 1.1em;

#let nocite(citation) = {
  place(hide[#cite(citation)])
}

#let language-state = state("language-state", none)
#let main-color-state = state("main-color-state", none)
#let preface-state = state("preface-state", none)
#let preface-state-hide-parent = state("preface-state-hide-parent", none)
#let main-text-environment = state("maintext-environment", false)
#let appendix-state = state("appendix-state", none)
#let appendix-state-hide-parent = state("appendix-state-hide-parent", none)
#let heading-image = state("heading-image", none)
#let supplement-part-state = state("supplement_part", none)
#let part-style-state = state("part-style", 0)
#let part-state = state("part-state", none)
#let part-location = state("part-location", none)
#let part-counter = counter("part-counter")
#let part-change = state("part-change", false)

/*
------------------------------------------------------------------------------
----------------------------- 部分、章节与页头图像 ----------------------------
------------------------------------------------------------------------------
*/

// 制作部分页
#let part(title) = {
  pagebreak(to: "odd")
  part-change.update(x =>
    true
  )
  part-state.update(x =>
    title
  )
  part-counter.step()
  [
    #context{
      let her = here()
      part-location.update(x =>
        her
      )
    }

    #context{
      let main-color = main-color-state.get()
      let part-style = part-style-state.get()
      let supplement_part = supplement-part-state.get()
      if part-style == 0 [
        #set par(justify: false)
        #place(block(width:100%, height:100%, outset: (x: 3cm, bottom: 2.5cm, top: 3cm), fill: main-color.lighten(70%)))
        #place(top+right, text(font: sans-font, fill: black, size: large-text, weight: "regular", box(width: 60%, part-state.get())))
        #place(top+left, text(font: sans-font, fill: main-color, size: huge-text, weight: "regular", part-counter.display("I")))
      ] else if part-style == 1 [
        #set par(justify: false)
        #place(block(width:100%, height:100%, outset: (x: 3cm, bottom: 2.5cm, top: 3cm), fill: main-color.lighten(70%)))
        #place(top+left)[
          #block(text(font: sans-font, fill: black, size: 2.5em, weight: "regular", supplement_part + " " + part-counter.display("I")))
          #v(1cm, weak: true)
          #move(dx: -4pt, block(text(font: sans-font, fill: main-color, size: 6em, weight: "regular", part-state.get())))
        ]
      ]
      align(bottom+right, my-outline-small(title, appendix-state, part-state, part-location, part-change, part-counter, sans-font, main-color, textSize1: outline-part, textSize2: outline-heading1, textSize3: outline-heading2, textSize4: outline-heading3))
    } 
  ]
}

// 创建章节环境
#let chapter(title, image:none, l: none) = {
  heading-image.update(x =>
    image
  )
  if l != none [
    #heading(level: 1, title) #label(l)
  ] else [
    #heading(level: 1, title) 
  ]
}

// 制作假段落（用于完成统一的首行缩进）
#let fakepar = context {
  let b = par[#box()]
  let t = measure([#b #b]);

  b
  v(-t.height)
}

// 修改头部图像
#let update-heading-image(image: none) = {
  heading-image.update(x =>
    image
  )
}

/*
------------------------------------------------------------------------------
------------------------ 前言、附录、索引与参考文献 ----------------------------
------------------------------------------------------------------------------
*/

// 开启附录环境
#let appendices(title, doc, hide-parent: false) = {
  appendix-state.update(x =>
    title
  )
  appendix-state-hide-parent.update(x =>
    hide-parent
  )
  set heading ( numbering: (..nums) => {
      let vals = nums.pos()
      if vals.len() == 1 {
        return str(numbering("A.1", ..vals)) + "."
      }
      else {
        context{
          let main-color = main-color-state.get()
          let color = main-color
          if vals.len() == 4 {
            color = black
          }
          return place(dx:-4.5cm, box(width: 4cm, align(right, text(fill: color)[#numbering("A.1", ..vals)])))
        }
      }
    },
  )
  counter(heading).update(0)

  doc
  appendix-state.update(x => none)
}

// 开启前言环境
#let prefaces(title, doc, hide-parent: false) = {
  preface-state.update(x =>
    title
  )
  preface-state-hide-parent.update(x =>
    hide-parent
  )
  set heading ( numbering: (..nums) => {
      let vals = nums.pos()
      if vals.len() == 1 {
        return str(numbering("I.1", ..vals)) + "."
      }
      else {
        context{
          let main-color = main-color-state.get()
          let color = main-color
          if vals.len() == 4 {
            color = black
          }
          return place(dx:-4.5cm, box(width: 4cm, align(right, text(fill: color)[#numbering("I.1", ..vals)])))
        }
      }
    },
  )
  counter(heading).update(0)

  doc
  preface-state.update(x => none)
}

// 制作参考文献
#let my-bibliography(file, image:none) = {
  counter(heading).update(0)
  heading-image.update(x =>
    image
  )
  file
}

// 制作索引
#let make-index(title: none) = {
  make-index-int(title:title, main-color-state: main-color-state)
}

/*
------------------------------------------------------------------------------
-------------------------------- 页码和页眉管理 -------------------------------
------------------------------------------------------------------------------
*/

/*管理前辅助页页码*/
#let before-page(doc) = {
  set page(
    numbering: "i",
  )
  counter(page).update(1)

  doc
}

/*管理正文页码*/
#let main-page(doc) = {
  pagebreak(to: "odd", weak: true) // 适配部分页停留在奇数页的要求
  set page(
    numbering: "1",
  )
  counter(heading).update(0)
  counter(page).update(1)

  doc
}

/*管理页眉样式*/
#let header(doc) = {
  set page(
    footer: [],
    header: context{
      set text(font: sans-font, size: title5)
      let page_number = here().page()
      let odd_page = calc.odd(page_number)
      let part_change = part-change.get()
      // Are we on an odd page?
      // if odd_page {
      //   return text(0.95em, smallcaps(title))
      // }

      // Are we on a page that starts a chapter? (We also check
      // the previous page because some headings contain pagebreaks.)
      let all = query(heading.where(level: 1))
      if all.any(it => it.location().page() == page_number) or part_change {
        return
      }
      if odd_page {
        let before = query(selector(heading.where(level: 2)).before(here()))
        let counterInt = counter(heading).get()
        if before != () and counterInt.len()> 1 {
          box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
            #if main-text-environment.get() {
              if appendix-state.get() != none {
                text(numbering("A.1", ..counterInt.slice(0,2)) + " " + before.last().body)
                h(1fr)
                counter(page).display("1")
              } else {
                text(numbering("1.1", ..counterInt.slice(0,2)) + " " + before.last().body)
                h(1fr)
                counter(page).display("1")
              }
            } else {
              text(numbering("I.1", ..counterInt.slice(0,2)) + " " + before.last().body)
              h(1fr)
              counter(page).display("i")
            }
          ]
        }
      } else {
        let before = query(selector(heading.where(level: 1)).before(here()))
        let counterInt = counter(heading).get().first()
        if before != () and counterInt > 0 {
          box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
            #if main-text-environment.get() {
              if appendix-state.get() != none {
                counter(page).display("1")
                h(1fr)
                text(numbering("A.1", counterInt) + ". " + before.last().body)
              } else {
                counter(page).display("1")
                h(1fr)
                text(before.last().supplement + " " + str(counterInt) + ". " + before.last().body)
              }
            } else {
              counter(page).display("i")
              h(1fr)
              text(numbering("I.1", counterInt) + ". " + before.last().body)
            }
          ]
        }
      }
    }
  )

  doc
}

/*
------------------------------------------------------------------------------
-------------------------------- 公式定理等环境 -------------------------------
------------------------------------------------------------------------------
*/

#let theorem(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("theorem", if language != "zh" {"Theorem"} else {"定理"},
    stroke: 0.5pt + main-color,
    radius: 0em,
    inset: 0.65em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(weight: "bold", fill: main-color, x), 
    fill: black.lighten(95%), 
    base_level: 1)(name:name, body)
  }
}

#let definition(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("definition", if language != "zh" {"Definition"} else {"定义"},
    stroke: (left: 4pt + main-color),
    radius: 0em,
    inset: (x: 0.65em),
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(weight: "bold", x), 
    base_level: 1)(name:name, body)
  }
}

#let corollary(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("corollary", if language != "zh" {"Corollary"} else {"结论"},
    stroke: (left: 4pt + gray),
    radius: 0em,
    inset: 0.65em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(weight: "bold", x),
    fill: black.lighten(95%), 
    base_level: 1)(name:name, body)
  }
}


#let proposition(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("proposition", if language != "zh" {"Proposition"} else {"命题"},
    radius: 0em,
    inset: 0em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(weight: "bold", fill: main-color, x),
    base_level: 1)(name:name, body)
  }
}


#let notation(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("notation", if language != "zh" {"Notation"} else {"记号"},
    stroke: none,
    radius: 0em,
    inset: 0em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(weight: "bold", x), 
    base_level: 1)(name:name, body)
  }
}

#let exercise(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("exercise", if language != "zh" {"Exercise"} else {"练习"},
    stroke: (left: 4pt + main-color),
    radius: 0em,
    inset: 0.65em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(fill: main-color, weight: "bold", x),
    fill: main-color.lighten(90%), 
    base_level: 1)(name:name, body)
  }
}

#let example(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("example", if language != "zh" {"Example"} else {"例子"},
    stroke: none,
    radius: 0em,
    inset: 0em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(weight: "bold", x), 
    base_level: 1)(name:name, body)
  }
}

#let problem(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("problem", if language != "zh" {"Problem"} else {"问题"},
    stroke: none,
    radius: 0em,
    inset: 0em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => text(fill: main-color, weight: "bold", x), 
    base_level: 1)(name:name, body)
  }
}

#let vocabulary(name: none, body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    thmbox("vocabulary", if language != "zh" {"Vocabulary"} else {"词汇"},
    stroke: none,
    radius: 0em,
    inset: 0em,
    namefmt: x => [*--- #x.*],
    separator: h(0.2em),
    titlefmt: x => [■ #text(weight: "bold", x)], 
    base_level: 1)(name:name, body)
  }
}

// 评注环境
#let remark(body) = {
  context{
    let language = language-state.get()
    let main-color = main-color-state.get()
    set par(first-line-indent: 0em)
    grid(
    columns: (1.2cm, 1fr),
    align: (center, left),
    rows: (auto),
    circle(radius: 0.3cm, fill: main-color.lighten(70%), stroke: main-color.lighten(30%))[
      #set align(center + horizon)
      #set text(fill: main-color, weight: "bold")
      #if language != "zh" {"R"} else {"注"}
    ],
    body)
  }
}

/*
------------------------------------------------------------------------------
-------------------------------- 正式书籍 -------------------------------------
------------------------------------------------------------------------------
*/

#let book(title: "", subtitle: "", date: "", author: (), paper-size: "a4", logo: none, cover: none,image-preface:none, include-preface:true, outline-image-index1: none, body, main-color: blue, copyright: [], lang: "zh", list-of-figure-title: none, outline-image-index2: none, list-of-table-title: none, outline-image-index3: none, supplement-chapter: "Chapter", supplement-part: "Part", par-indent: 2em, par-justify: true, par-leading: 0.5em, par-spacing: 0.5em, font-size: 10pt, part-style: 0, uplower-case-references: none) = {

  set document(author: author, title: title) // 设置PDF元数据的标题和作者
  set par(leading: par-leading) // 设置行间距（放在这里主要是用于应用于版权页）

  /*设置主要文字的文字大小，文字样式以及语言环境*/
  set text(size: font-size, lang: lang)
  show: set-font.with()

  set enum(numbering: "1.a.i.") // 有序列表样式（三级）
  set list(marker: ([•], [--], [◦])) // 项目列表样式（三级）
  show terms: set par(first-line-indent: 0em) // 项目样式
  set underline(offset: 3pt) // 下划线样式

  /*引用补足样式（大小写）*/
  set ref(supplement: it => {
    if uplower-case-references == 1 {lower(it.supplement)}
    else if uplower-case-references == 2 {upper(it.supplement)}
    else {it.supplement}
  })

  /*公式环境*/
  set math.equation(numbering: num =>
    numbering("(1.1)", counter(heading).get().first(), num)
  )

  /*图像环境*/
  set figure(numbering: num =>
    numbering("1.1", counter(heading).get().first(), num)
  )
  set figure(gap: 1.3em)
  show figure: it => align(center)[
    #it
    #if (it.placement == none){
      v(2.6em, weak: true)
    }
  ]

  /*引用样式*/
  show cite: it  => {
    show regex("[\w\W]"): set text(main-color)
    it
  }

  /*页面样式*/
  set page(
    paper: paper-size,
    margin: (x: 3cm, bottom: 2.5cm, top: 3cm),
  )

  /*标题样式*/
  set heading(
    hanging-indent: 0pt,
    numbering: (..nums) => {
      let vals = nums.pos()
      let pattern = if vals.len() == 1 { "1." }
                    else if vals.len() <= 4 { "1.1" }
      if pattern != none { numbering(pattern, ..nums) }
    }
  )
  show heading.where(level: 1): set heading(supplement: supplement-chapter)
  show heading: it => {
    set text(size: font-size)
    if it.level == 1 {
      set text(font: sans-font)
      pagebreak(to: "odd")
      //set par(justify: false)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      context{
        let img = heading-image.get()
        if img != none {
          set image(width: 21cm, height: 9.4cm)
          place(move(dx: -3cm, dy: -3cm, img))
          place( move(dx: -3cm, dy: -3cm, block(width: 21cm, height: 9.4cm, align(right + bottom, pad(bottom: 1.2cm, block(
            width: 86%,
            stroke: (
                right: none,
                rest: 2pt + main-color,
            ),
            inset: (left:2em, rest: 1.6em),
            fill: rgb("#FFFFFFAA"),
            radius: (
                right: 0pt,
                left: 10pt,
            ),
            align(left, text(weight: "regular", size: title1, it))
          ))))))
          v(8.4cm)
      }
      else{
        move(dx: 3cm, dy: -0.5cm, align(right + top, block(
            width: 100% + 3cm,
            stroke: (
                right: none,
                rest: 2pt + main-color,
            ),
            inset: (left:2em, rest: 1.6em),
            fill: white,
            radius: (
                right: 0pt,
                left: 10pt,
            ),
            align(left, text(weight: "regular", size: title1, it))
          )))
        v(1.5cm, weak: true)
      }
      }
      part-change.update(x =>
        false
      )
    }
    else if it.level == 2 or it.level == 3 or it.level == 4 {
      let size
      let space
      let color = main-color
      if it.level == 2 {
        set text(weight: "bold")
        size= title2
        space = 0.5em + par-spacing
      }
      else if it.level == 3 {
        size= title3
        space = 0.4em + par-spacing
      }
      else {
        size= title4
        space = 0.4em + par-spacing
        color = black
      }
      set text(size: size)
      let number = if it.numbering != none {
        set text(fill: main-color) if it.level < 4
        let num = counter(heading).display(it.numbering)
        let width = measure(num).width
        let gap = 7mm
        place(dx: -width - gap, num)
      }
      block(number + it.body)
      fakepar
      v(space, weak: true)
      
    }
    else {
      it
    } 
  }

  // Title page. 封面页与版权页
  page(margin: 0cm, header: none)[
    #set text(fill: black)
    #language-state.update(x => lang)
    #main-color-state.update(x => main-color)
    #part-style-state.update(x => part-style)
    #supplement-part-state.update(x => supplement-part)
    // #place(top, image("../fig/background.svg", width: 100%, height: 50%))
    #if cover != none {
      set image(width: 100%, height: 100%)
      place(bottom, cover)
    }
    #if logo != none {
        set image(width: 3cm)
        place(top + center, pad(top:1cm, logo))
    }
    #align(center + horizon, block(width: 100%, fill: main-color.lighten(70%), height: 7.5cm, pad(x:2cm, y:1cm)[
      #par(leading: 0.4em)[
        #text(font: title-font, size: title-main-1, weight: "black", title)
      ]
      #v(1cm, weak: true)
      #text(font: title-font, size: title-main-2, subtitle)
      #v(1cm, weak: true)
      #text(font: title-font, size: title-main-3, weight: "bold", author)
    ]))
  ]
  if (copyright!=none){
    set text(font: serif-font, size: 10pt)
    show link: it => [
      #set text(fill: main-color)
      #it
    ]
    set par(spacing: 2em)
    align(bottom, copyright)
  }

  show: header.with() // 管理页眉样式
  show: before-page.with() // 管理前辅助页页码

  /*管理段落样式（从前言页开始）*/ 
  set par(
    first-line-indent: par-indent,
    justify: par-justify,
    spacing: par-spacing,
  )
  set block(spacing: 1.2em)

  /*是否引入前言*/ 
  if (include-preface == true){
    show: prefaces.with("Forewords", hide-parent: false)
    show link: set text(fill: main-color) // 链接样式
    include "../content/fore.typ"
  }

  /*制作全书目录页*/
  update-heading-image(image: outline-image-index1)
  my-outline(preface-state, preface-state-hide-parent, appendix-state, appendix-state-hide-parent, part-state, part-location,part-change,part-counter, sans-font, main-color, textSize1: outline-part, textSize2: outline-heading1, textSize3: outline-heading2, textSize4: outline-heading3)

  /*是否制作引入图像目录页*/
  if list-of-figure-title != none{
    update-heading-image(image: outline-image-index2)
    my-outline-sec(list-of-figure-title, figure.where(kind: image), outline-heading3)
  }

  /*是否制作表格目录页*/ 
  if list-of-table-title != none{
    update-heading-image(image: outline-image-index3)
    my-outline-sec(list-of-table-title, figure.where(kind: table), outline-heading3)
  }

  // Main body 正文
  show link: set text(fill: main-color) // 链接样式
  show: main-page.with() // 管理正文页码
  main-text-environment.update(true) // 恢复正文环境

  body

}
