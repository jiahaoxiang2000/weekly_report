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
  2025-12-01
]

=

== 本周研究摘要

#redt[论文Discussion章节撰写]
- Cryptographic Optimization Implementation子章节
- NTT优化：周期降低(320万→230万周期)

== 密码学优化实现细节 - NTT汇编优化

#redt[手工ARM汇编优化]
- UMULL指令：32×32→64位乘法
- 寄存器分配优化：13个通用寄存器
- 循环展开因子2-4、预计算旋转因子

#bluet[性能剖析量化]
- 参考C实现：320万周期
- 汇编优化：230万周期(28.1%降低)
- 聚合签名延迟降低：20-30%

== 密码学优化实现细节 - 延迟模约减与Barrett约减

#redt[延迟模约减策略]
- 维持中间值于宽松边界$[0, 2q)$或$[0, 4q)$
- 延迟约减链跨2-4个连续操作

#redt[Barrett模约减技术]
- 预计算$mu = floor(2^(48) \/ q) = 33554431$
- 替代除法操作，基于乘法的约减

== 性能分析与部署权衡 - 计算性能

#greent[组合优化技术达到40-50%性能改进]

#bluet[密钥生成性能]
- 100.7-238×开销相对ECDSA P-256
- 执行时间：151-357毫秒

#bluet[签名生成与验证]
- 签名延迟：657-1150毫秒(70-122×慢于ECDSA)
- 验证延迟：416-717毫秒(26-44×开销相对ECDSA)

= 总结

== 下周计划

#redt[论文实验数据采集与Results章节完善]：

- MQTT协议性能实验数据
- Results章节补充完善

== 老师评语

*继续推进定稿可投*

抓紧推进论文写作
