#import "@preview/cuti:0.3.0": show-cn-fakebold

#let title-font = ("Arial", "SimHei") // 标题字体
#let serif-font = ("Libertinus Serif", "SimSun") // 衬线字体
#let sans-font = ("Arial", "SimHei") // 无衬线字体

#let set-font(body) = {
  set text(font: serif-font)

  show: show-cn-fakebold
  
  body
}