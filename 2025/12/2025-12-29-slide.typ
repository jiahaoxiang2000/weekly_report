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
  2025-12-29
]

=

== 本周研究摘要

#redt[完成ML-DSA论文核心技术贡献扩展]

新增Adaptive Security Level Selection Protocol章节

== Adaptive Protocol设计

#bluet[协议核心]：根据消息关键性、设备资源状态动态选择ML-DSA参数集

#bluet[设计原则]：
- Message Criticality Classification：按安全敏感度分类消息
- Minimum Security Guarantees：强制每类消息最低安全级别


== 自适应选择算法

#bluet[选择逻辑]：
- $R >= 0.7$：使用默认安全级别
- $0.4 <= R < 0.7$：触发一级降级
- $R < 0.4$：选择最低安全级别
- Critical消息始终使用ML-DSA-87

#bluet[协议开销]：23--38 $mu$s/消息（占ML-DSA-44签名延迟 < 0.006%）

= 总结

== 下周计划

- *1月5日(周一)博士复试*

== 老师评语

*全力准备好博士考试，特别去问下上一届的如何考*

全力准备


