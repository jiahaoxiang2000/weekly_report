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
  "Noto Serif CJK SC", // Alternative Chinese serif font
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
#show heading: set text(font: "Noto Serif CJK SC", weight: "bold")
#show raw: set text(font: "Noto Sans Mono CJK SC")

#show heading: set text(font: "Noto Sans CJK SC")
#show: simple-theme.with(aspect-ratio: "16-9", footer: [周报])

#title-slide[
  = 周报 - 大论文三个核心章节翻译
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

=

== 本周研究摘要

本周完成#redt[大论文三个核心论文章节中文翻译]工作：

- #greent[第三章CRAFT算法实现]：串行架构面积减少10.16%，展开架构吞吐量提升40.53%
- #bluet[第四章32位处理器SPN密码]：指令数减少64.3%，BGC编码加速3.19倍，AES和QARMAv2性能分别改进9.7%和67.6%
- #redt[第五章GPU SLH-DSA并行架构]：实现62,239签名/秒，性能提升1.16倍

== 第三章：CRAFT密码算法高效实现

#bluet[FPGA实现架构优化]：
- 串行架构：#greent[面积减少10.16%]
- 展开架构：#greent[吞吐量提升40.53%]

#redt[S盒优化技术创新]：
- SAT求解器 + GEC编码优化
- 硬件实现效率提升

== 第四章：32位处理器SPN密码Bitsliced实现

#bluet[置换优化算法突破]：
- #greent[指令数减少64.3%]
- 增强BGC编码：#greent[性能加速3.19倍]

#redt[性能验证成果]：
- AES算法：#greent[性能改进9.7%]
- QARMAv2算法：#greent[性能提升67.6%]

== 第五章：GPU SLH-DSA线程自适应优化

#bluet[核心技术创新]：
- Thread-Adaptive Allocation (ATA)
- Function-Level Parallelization (FLP)

#redt[性能成果验证]：
- #greent[62,239签名/秒] 处理能力
- #greent[性能提升1.16倍] 先进性改进

= 总结

== 下周计划

- #bluet[第四篇论文撰写工作] 继续推进
- #greent[大论文摘要和目录] 完善

== 老师评语

*你这那有第4篇论文的内容报告？？*

本周主要完成小论文翻译，下周重点推进第四篇论文撰写工作
