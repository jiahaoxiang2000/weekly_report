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
  2025-12-15
]

=

== 本周研究摘要

#redt[为ML-DSA论文新增5幅TikZ可视化图示]
- 系统展示算法流程、架构与协议结构

== ML-DSA签名流程图

#align(center)[
  #image("fig/mldsa-signing-flow.png", width: 52%)
]

== MQTT架构图

#align(center)[
  #image("fig/mqtt-architecture.png", width: 70%)
]

== 硬件平台架构图

#align(center)[
  #image("fig/hardware-architecture.png", width: 70%)
]

== 软件分层架构图

#align(center)[
  #image("fig/software-stack.png", width: 70%)
]

== TLV消息格式图

#align(center)[
  #image("fig/tlv-message-format.png", width: 70%)
]

= 总结

== 下周计划

#redt[论文完善]：

- 完善Results章节实验数据
- 补充Conclusion章节撰写

== 老师评语

*你这图标蓝是给我看证明做了修改是不？如果是这样可以，否则是不能标蓝，就用黑白图。*

是的，标蓝色表示本周修改。

*再个论文长度现在已经30页了，即使是会议这也基本到极限长度了，注意精简语言突出重点，不冗余*

后精简部分章节，控制论文长度。
