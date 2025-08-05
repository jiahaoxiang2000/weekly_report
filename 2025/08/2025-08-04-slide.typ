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
  = 周报 - 第三篇论文修订进展
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

= 概述

== 本周研究摘要

本周专注于第三篇论文《Thread-Adaptive: High-Throughput Parallel Architectures of SLH-DSA on GPUs》的大修回复工作：

- #bluet[完成三项关键修订任务]：新颖性贡献阐述、术语精确性修正、SLH-DSA算法细节回应
- #greent[回应审稿意见1.3、1.4和2.1评论]，明确区分架构创新与现有工作的差异
- #redt[下周重点]：完成两项重要的实验性工作（性能分解分析和GPU性能剖析）

= 已完成修订任务 #bluet[【3/5 完成】]

== 核心修订成果

成功完成计划中五项任务的前三项核心修订工作：

#bluet[任务1：SLH-DSA算法细节补充]
- 针对审稿意见2.1的算法背景不足问题
- 考虑4页篇幅限制，重点阐述架构创新

#greent[任务2：新颖性贡献明确阐述]
- 回应审稿意见1.3和2.1关于技术贡献区分度的关切
- 重组第III.B节内容结构
- 使用蓝色标记区分原创贡献与现有工作基础

#pagebreak()

#redt[任务3：术语精确性修正]
- 响应审稿意见1.4的精确性建议
- 将"理论最优线程数"修正为"经验确定的最优线程数"
- 更准确反映实证性能建模和线程数量扫描实验方法

= 待完成实验性修订要求 #redt[【关键任务】]

== 性能分解分析需求

审稿意见1.1、2.2和3.1的核心技术问题：

#redt[关键要求]：
- 提供自适应线程分配和函数级并行两种技术的独立性能贡献分析
- 量化每种方法对整体性能提升的具体贡献度
- 设计细粒度性能测量框架

#bluet[实现方案]：
- 分别禁用和启用不同优化技术的对照实验
- 包含分析计算负载特征的剖析结果

#pagebreak()

== GPU硬件级性能剖析要求

审稿意见1.2、2.3和3.2强调的硬件级评估：

#greent[NVIDIA Nsight工具分析]：
- 计算单元利用率分析
- 缓存行为和占用率分析

= 总结

== 下周核心计划

#redt[首要任务]：
- 重新组织代码结构，支持选择性启用/禁用优化模块
- 采用NVIDIA Nsight Compute作为主要分析工具
- 结合NVIDIA Visual Profiler进行补充验证

== 老师评语

*继续推进论文修改*

抓紧时间回复审稿人意见
