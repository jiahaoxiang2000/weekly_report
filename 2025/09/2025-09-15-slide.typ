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
  = 周报 - 第四篇论文和ML-DSA实现
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

=

== 本周研究摘要

#redt[本周完成第四篇论文重构工作和ML-DSA密码第一阶段完整实现]：

- #greent[第四篇论文系统性重构]：引用部分深度重构，相关工作章节扩展完善，ARM Cortex-M4性能分析框架确立
- #bluet[ML-DSA基础层全部核心组件完成]：域运算、多项式编码、数论变换等关键算法模块实现

== 第四篇论文撰写进展

#bluet[论文结构优化与重构工作]：
- #redt[引用部分深度重构]：全面覆盖资源受限MQTT环境中ML-DSA数字签名方案
- #greent[相关工作章节扩展]：增加后量子密码学在IoT环境中的详细性能分析

#oranget[ARM Cortex-M4性能分析框架]：
- 确立以ARM Cortex-M4为核心的性能分析框架
- 针对资源受限IoT设备的特殊需求专门设计

== 研究空白识别与技术路径

#greent[关键研究空白识别]：
- 现有研究主要集中在高性能计算平台
- 资源严重受限IoT设备的专门优化研究相对缺乏

#bluet[技术路径规划]：
- 算法优化维度
- 内存管理维度
- 功耗控制维度

== ML-DSA 密码实现进展

#bluet[第一阶段基础层架构完成]：
- 完整的密码学基础设施框架构建
- 标准化接口规范建立

#redt[核心组件全面实现]：
- 域运算与编码框架基础设施
- 多项式、向量、NTT相关数据类型
- Barrett约简算法高效模运算

== 基础层核心组件详解

#redt[Phase 1.1 基础工具组件]：
- Truncate trait：安全整数截断功能
- Flatten/Unflatten trait：数组转换功能

#bluet[Phase 1.2-1.3 域运算框架]：
- Field trait + Barrett约简算法
- 完整类型系统：Polynomial, Vector, NTT系列
- define_field!宏标准化接口

= 总结

== 下周计划

- #bluet[第四篇论文撰写工作]
- #greent[ML-DSA第二阶段] 开展核心算法层开发，实现ML-DSA密钥生成、签名和验证算法

== 老师评语

*摘要里一定要体现是怎么做的，而不只是要做的结果，即要体现主要技术创新细节*

论文主要技术创新确定后，对摘要进行补充完善
