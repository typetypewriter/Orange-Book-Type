#import "../lib/template.typ": *

#chapter("Mathematics", image: image("../fig/orange2.jpg"))

== Theorems 定理
#index("Theorems")
=== Several equations 几行公式 <heading2>
#index("Theorems!Several equations")
This is a theorem consisting of several equations. 这是包含几行方程的定理
#theorem(name: "Name of the theorem")[
  In $E=bb(R)^n$ all norms are equivalent. It has the properties:
  $ abs(norm(bold(x)) - norm(bold(y))) <= norm(bold(x-y)) $
  $ norm(sum_(i=1)^n bold(x)_i) <= sum_(i=1)^n norm(bold(x)_i) quad "where" n "is a finite integer" $
]

=== Single Line 一行公式
#index("Theorems!Single Line")
This is a theorem consisting of just one line. 这是包含一行方程的定理
#theorem()[
  A set $scr(D)(G)$  in dense in $L^2(G)$, $|dot|_0$.
]
== Definitions 定义
#index("Definitions")
A definition can be mathematical or it could define a concept. 定义包含数学公式以及文字
#definition(name: "Definition name")[
  Given a vector space $E$, a norm on $E$ is an application, denoted $norm(dot)$, $E$ in $bb(R)^+ = [0,+∞[$ such that:
  $ norm(bold(x)) = 0 arrow.r.double bold(x) = bold(0) $
  $ norm(lambda bold(x)) = abs(lambda) dot norm(bold(x)) $
  $ norm(bold(x) + bold(y)) lt.eq norm(bold(x)) + norm(bold(y))  $
]
== Notations 记号
#index("Notations")

#notation()[
  Given an open subset $G$ of $bold(R)^n$, the set of functions $phi$ are:
  #v(0.5em, weak: true)
  + Bounded support $G$;
  + Infinitely differentiable;
  #v(0.5em, weak: true)
	a vector space is denoted by $scr(D)(G)$. 
]
== Remarks 评注
#index("Remarks")
This is an example of a remark. 这是评注的一个例子

#remark()[
  The concepts presented here are now in conventional employment in mathematics. Vector spaces are taken over the field $bb(K)=bb(R)$, however, established properties are easily extended to $bb(K)=bb(C)$.
]

== Corollaries 结论
#index("Corollaries")
#corollary(name: "Corollary name")[
	The concepts presented here are now in conventional employment in mathematics. Vector spaces are taken over the field $bb(K)=bb(R)$, however, established properties are easily extended to $bb(K)=bb(C)$.
]
== Propositions 命题
#index("Propositions")
=== Several equations 几行公式
#index("Propositions!Several equations")

#proposition(name: "Proposition name")[
	It has the properties:
  $ abs(norm(bold(x)) - norm(bold(y))) <= norm(bold(x-y)) $
  $ norm(sum_(i=1)^n bold(x)_i) <= sum_(i=1)^n norm(bold(x)_i) quad "where" n "is a finite integer" $
]
=== Single Line 一行公式
#index("Propositions!Single Line")

#proposition()[
  	Let $f,g in L^2(G)$; if $forall phi in scr(D) (G)$, $(f,phi)_0=(g,phi)_0$ then $f = g$. 
]
== Examples 例子
#index("Examples")
=== Equation Example 公式例子
#index("Examples!Equation")
#example()[
  Let $G=\(x in bb(R)^2:|x|<3\)$ and denoted by: $x^0=(1,1)$; consider the function:

  $ f(x) = cases(
    e^(abs(x)) quad & "si" |x-x^0| lt.eq 1 slash 2,
    0 & "si" |x-x^0| gt 1 slash 2
  ) $
	
	The function $f$ has bounded support, we can take $A={x in bb(R)^2:|x-x^0| lt.eq 1 slash 2+ epsilon}$ for all $epsilon in lr(\] 0\;5 slash 2-sqrt(2) \[, size: #70%) $.
]

=== Text Example 文字例子
#index("Examples!Text")

#example(name: "Example name")[
  Aliquam arcu turpis, ultrices sed luctus ac, vehicula id metus. Morbi eu feugiat velit, et tempus augue. Proin ac mattis tortor. Donec tincidunt, ante rhoncus luctus semper, arcu lorem lobortis justo, nec convallis ante quam quis lectus. Aenean tincidunt sodales massa, et hendrerit tellus mattis ac. Sed non pretium nibh. Donec cursus maximus luctus. Vivamus lobortis eros et massa porta porttitor.
]

== Exercises 练习
#index("Exercises")
#exercise()[
  This is a good place to ask a question to test learning progress or further cement ideas into students' minds.
]
== Problems 问题
#index("Problems")

#problem()[
  What is the average airspeed velocity of an unladen swallow?
]

== Vocabulary 词汇
#index("Vocabulary")

Define a word to improve a students' vocabulary.

#vocabulary(name: "Word")[
  Definition of word.
]