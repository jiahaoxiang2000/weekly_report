#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Set Chinese fonts for the presentation
#set text(font: (
  "Source Han Serif", // Alternative Chinese serif font
))

// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

// Additional font customization options:
#show heading: set text(font: "Source Han Sans", weight: "bold")
#show raw: set text(font: "Source Han Mono SC")

#show heading: set text(font: "Source Han Sans")
#show: simple-theme.with(aspect-ratio: "16-9", footer: [周报])

#title-slide[
  = 周报
  #v(2em)

  #v(2em)
  2026-01-12
]

=

== 本周研究摘要

#redt[硕士学位论文第一章绪论与第二章基础知识的撰写工作]

#bluet[第二章完成了SPN结构密码基本原理、密码算法的软件实现技术和硬件实现技术三个方面的基础知识论述]

== 第一章绪论撰写

#bluet[该章节包括选题背景及研究意义、国内外研究现状和研究内容三个主要部分]

- 选题背景：SPN结构密码在现代分组密码设计中的主流地位及物联网安全领域应用需求
- 国内外研究现状：轻量级密码硬件实现、比特切片密码软件实现、GPU并行密码实现
- 研究内容：三个主要研究方向的技术创新点

== 第二章基础知识撰写

#bluet[系统介绍了SPN密码基本原理、软件实现技术和硬件实现技术三个方面的理论基础]

- SPN密码基本原理：S盒变换、线性变换、AES-128四个基本操作
- 软件实现技术：查找表实现、比特切片实现、SIMD向量化实现
- 硬件实现技术：ASIC/FPGA平台、迭代/串行/展开架构

#redt[比特切片技术的核心思想是将密码操作映射到位级布尔运算]

== 第一章绪论

#figure(
  grid(
    columns: 2,
    gutter: 10pt,
    image("figures/thesis_page-06.png", height: 70%), image("figures/thesis_page-11.png", height: 70%),
  ),
)

== 第二章基础知识

#figure(
  grid(
    columns: 2,
    gutter: 10pt,
    image("figures/thesis_page-12.png", height: 70%), image("figures/thesis_page-16.png", height: 70%),
  ),
)

= 总结

== 下周计划

- 继续撰写大论文
- 重新梳理第四篇小论文

== 老师评语

*小论文没有进展报告了，做事要让别人放心，不是自私让自己方便*

后续每周汇报小论文进展

