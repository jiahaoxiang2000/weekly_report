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
  = 周报 - 第三篇论文性能分析完成
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

= 概述

== 本周研究摘要

本周成功完成第三篇论文《Thread-Adaptive: High-Throughput Parallel Architectures of SLH-DSA on GPUs》的核心修订任务4：

- #bluet[完成性能分解分析实验]：量化ATA技术11.7%吞吐量提升和FLP技术额外3.5%性能增益
- #redt[完成分析方法学准确性讨论]：回应审稿意见p1.1、p2.2和p3.1的技术关切


= 论文回复

== 定量性能分解结果 p1.1

通过系统性实验设计，成功量化了自适应线程分配（ATA）和函数级并行（FLP）两种核心技术的独立贡献：

#bluet[基准性能]：Wang et al. 2025实现 → 53,804 tasks/sec

#greent[ATA技术贡献]：
- 吞吐量提升至60,127 tasks/sec
- 性能改进：#redt[+11.7%] (增益6,323 tasks/sec)

#pagebreak()

#greent[FLP技术贡献]：
- 最终吞吐量达到62,239 tasks/sec
- 额外性能提升：#redt[+3.5%] (增益2,112 tasks/sec)
- 综合性能改进：#bluet[+15.7%]


== 架构创新必要性 p2.2

明确展示了后量子密码学实现中架构创新的关键作用：

#redt[传统方法局限性]：
- 未经优化的实现无法满足实际部署需求
- 传统并行化方法存在根本性限制

#bluet[专门化架构优势]：
- 只有通过系统性架构设计才能实现实用级别性能


== 测量可靠性验证 p3.1

针对审稿意见p3.1关于基于剖析的性能模型准确性关切，提供全面验证：

#greent[统计可靠性指标]：
- 20次重复测量 + 中位数绝对偏差离群值过滤
- 交叉验证：#redt[91.3%]预测准确率 (±10%范围内)
- 样本外测试：#redt[87.6%]线程数预测准确性



= 总结

== 修订进展状态

#greent[已完成核心修订]：
- 性能分解分析实验成果 ✓
- 分析方法学准确性讨论 ✓
- 审稿意见p1.1、p2.2和p3.1技术回应 ✓

#redt[下周最终任务]：
- GPU硬件级性能剖析工作
- 审稿意见p1.2、p2.3和p3.2技术回应
- 完成第三篇论文全部修订要求并准备重新提交

== 老师评语

*继续推进完成审稿意见回复*

抓紧推进
