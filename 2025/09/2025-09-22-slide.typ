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
  = 周报
  #v(2em)

  #v(2em)
  2025-09-22
]

=

== 本周研究摘要

- #greent[ML-DSA介绍写作]
- #bluet[基金申请书研究方案设计]：构建分组密码实现技术与性能评估研究的四大研究方向综合技术框架

== ML-DSA介绍写作

#bluet[核心算法]：
- #redt[ML-DSA三大核心算法规范化]：密钥生成、签名生成、签名验证算法的完整形式化
- #greent[ML-DSA参数集合与安全性能分析框架]：ML-DSA-44、ML-DSA-65、ML-DSA-87三套完整参数集合技术规范

#oranget[模学习理论与计算复杂度分析]：
- 建立模学习困难问题(MLWE)和模短整数解问题(MSIS)的背景
- 集成多项式环运算和数论变换(NTT)优化技术的分析

== 基金申请书研究方案设计

#redt[四大核心研究方向架构设计]：
- 研究方向一：分组密码的硬件实现技术研究(FPGA、ASIC平台优化)
- 研究方向二：分组密码的软件实现技术研究(通用处理器和嵌入式系统)
- 研究方向三：分组密码的软硬件协同设计研究
- 研究方向四：跨平台分组密码性能评估系统构建

= 总结

== 下周计划

- #bluet[继续深化ML-DSA论文技术内容]：重点完善IoT环境部署优化策略分析
- #greent[开展ML-DSA实验验证框架设计]：准备性能基准测试环境搭建

== 老师评语

*优先推进论文完稿*

抓紧论文进度

*《分组密码实现技术与性能评估研究》 基金这个题目你内容写得再好也不行，项目申报你找1-2个同学（包括研2也可以）开会研究确定：题目、4个研究内容我们再定*

已与岳兴起和谢抗同学讨论

