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
  2025-12-22
]

=

== 本周研究摘要

#redt[ML-DSA论文全文内容精炼与学术表达优化]

== Introduction章节优化

#bluet[内容精炼]：
- 消除冗余强调副词（"fundamentally" → 直接陈述）
- 避免主观程度判断（"severe/prohibitive" → "degradation/overhead"）

#bluet[贡献陈述重构为可测量技术指标]：
- Computational Performance：周期级测量，ARM Cortex-M4  168 MHz
- Memory Utilization：Flash/Stack/SRAM峰值量化
- Protocol Integration：端到端延迟与消息开销评估

== Related Work章节改进

#bluet[学术表达规范化]：
- 消除冗余连接词（"While...have undergone" → 直接陈述）
- 明确研究空白（"IoT-specific protocols remain underexplored"）

#bluet[技术准确性提升]：
- 性能数据量化（"order-of-magnitude throughput reductions"）
- 参数格式统一（"1.38--1.51"标准化表示）

== ML-DSA Algorithm章节优化

#bluet[技术参数精确化]：
- 拒绝采样迭代次数：建立参数集直接对应（4.25/5.1/3.85）
- 密钥尺寸：标准化单位表示（1.3--4.9\,KB）

#bluet[算法描述简化]：
- 采用直接算法引用方式
- 确定性签名变体表述压缩
- NTT性能瓶颈描述精简（2.5--3.0 million cycles）

= 总结

== 下周计划

- 完善Results章节实验数据分析
- *1月初 博士申请复试*

== 老师评语

*现在就要根据拟投期刊风格与格式去写了*

已初步修改

