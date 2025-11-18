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
  2025-11-17
]

=

== 本周研究摘要

#redt[完成论文三个维度的系统化改进工作]
- #bluet[Implementation Architecture章节撰写：系统架构与技术实现]
- #greent[Experimental Methodology增强：技术规格与方法论框架]
- #oranget[学术语言优化：全文规范性与精确性提升]


== Implementation Architecture章节撰写

#redt[系统架构]：MQTT发布-订阅拓扑集成ML-DSA签名
- 发布者设备（签名生成）→ MQTT代理（消息路由）→ 订阅者设备（签名验证）
- #bluet[端到端密码学认证，签名嵌入载荷内部，独立于传输层]

#redt[软件架构]：分层设计
- HAL + FreeRTOS + pqm4密码学库 + Paho MQTT客户端

== Experimental Methodology章节增强

#redt[技术规格补充]：
- 编译器：GCC -O3（18-23%速度提升，12-15%体积增加）
- 网络参数：WiFi信号-45至-52 dBm，0.1%丢包率

#redt[测量方法]：
- 栈峰值：32字节间隔水印（±32字节精度）
- 载荷选择：10/50/100字节覆盖92%流量

== 学术语言优化（全文审查）

#redt[Abstract优化]：
- 被动语态转换："This research evaluates" → "is evaluated"
- 冗余消除："imminent threat" → "necessitate migration"

#redt[Introduction优化]：
- 消除夸张修辞："existential threat" → "fundamentally undermines"
- 避免口语："creates a critical gap" → "creates critical challenges"


= 总结

== 下周计划
#redt[论文完善与优化工作]：

- 优化实现架构以提升ML-DSA签名操作性能

== 老师评语

*继续精改写作 继续强化创新和实验对比*

抓紧推进
