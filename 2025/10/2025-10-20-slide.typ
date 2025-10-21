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
  2025-10-20
]

=

== 本周研究摘要

#redt[完成第二篇论文R2小修审稿意见Point 2与Point 3核心修订任务]
- #bluet[QARMAv2基准选择疑问(Point 2)：添加基准选型说明]
- #greent[全部编辑性修订(Point 3)：术语修正、图表标记、参考文献格式]


== R2修订进度概览

#redt[已完成]：2/5项任务(40%进度)
- Point 2：QARMAv2基准说明
- Point 3：编辑性修订

#bluet[待完成]：3项核心任务
- Point 1：安全性分析
- Point 4：图表质量提升
- Point 5：Default/Baksheesh密码评估

#oranget[截止]：10月30日

== 编辑性修订完成(Point 3)

#redt[术语错误修正]：Sec. II-C "trivial forms" → "transformations"

#bluet[图表标记统一]：Fig. 1图注上标 $b^i_j$ → $b^j_i$，确保符号一致性

#greent[参考文献格式]：Ref [23] "riscvOVPsim" → "RISC-V OVPsim"

#purplet[表格组件说明]：Table VI添加脚注，明确"Others"包含数据移动与轮密钥XOR

== QARMAv2基准选择说明(Point 2)

#redt[问题根源]：QARMAv2原始论文未提供软件性能评估，本工作为首个软件位切片实现

#bluet[回复]：在Sec. IV-C2添加基准选型原理阐述
- 查找表方法代表分组密码常规软件实现策略
- 文献中不存在可直接对比的位切片QARMAv2实现
- 为评估资源受限平台位切片优势提供有意义基准

= 总结

== 下周计划

- #redt[Point 1 安全性分析]
- #bluet[Point 4 图表质量提升]
- #greent[Point 5 密码评估]
- #oranget[审稿回复与校对]

预计10-26号完成

== 老师评语

*认真修改，到这步千万别拒稿了*

仔细认真修改



