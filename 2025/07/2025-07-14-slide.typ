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
  "Noto Sans CJK SC", // Primary Chinese font
  "Noto Serif CJK SC", // Alternative Chinese serif font
  "WenQuanYi Micro Hei", // Chinese fallback font
  "FZShuSong-Z01", // Traditional Chinese font
  "HYZhongSongJ", // Another Chinese font option
  "Noto Sans", // Latin fallback
  "Roboto", // Final fallback
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

#show: simple-theme.with(aspect-ratio: "16-9", footer: [周报])

#title-slide[
  = 周报 - 审稿回复
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

= 研究概述

== 本周研究摘要

本周完成 审稿回复的 #bluet[P1 和 P3 任务]：P1 通过七种 S-box 的实验评估展示 11.7%-86.1% 的优化改进，P3 在相同平台上证明 bitsliced 相比表查找有 22.5% 性能优势。

#redt[更新了两个核心性能表格]，并规划了 P2 任务的 GIFT-COFB 实验验证。

#redt[截至时间：2025年7月29日]

= P1 任务：S-box 优化贡献增强

== 任务完成情况 #bluet[【已完成】]

针对审稿人对新颖性描述不清的关切，完成了 S-box 优化的综合性实验评估。

#redt[核心贡献]：开发了一种改进的约束简化方法，提升了单元传播效率而不影响解决方案质量。

== S-box 优化性能结果

#table(
  columns: 4,
  align: center,
  stroke: 1pt,
  [*S-box*], [*Feng et al. (s)*], [*本研究 (s)*], [*改进倍数*],
  [PRØST], [2.511], [2.217], [1.13×],
  [SKINNY $S_4$], [8.455], [6.399], [1.32×],
  [Piccolo], [16.875], [2.347], [#redt[7.19×]],
  [Keccak], [37.005], [15.947], [2.32×],
  [GIFT], [418.715], [60.154], [#redt[6.96×]],
  [RECTANGLE], [689.812], [155.464], [4.44×],
  [QARMAv2], [4055.519], [2101.336], [1.93×],
)

= P3 任务：性能比较公平性纠正

== 任务完成情况 #bluet[【已完成】]

解决了审稿人指出的跨不同处理器架构性能比较不公平的问题。

#redt[原有比较存在根本性缺陷]：不同处理器架构导致的性能差异使得比较结果无意义。


在相同的 STM32L476 平台上实施标准化比较：

- #redt[表查找实现]：325.25 CPB 处理单个分组
- #bluet[bitsliced 方法]：252.06 CPB 并行处理两个分组
- #bluet[性能优势]：22.5%

== 综合性能评估表

#text(size: 18pt)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    align: center,
    stroke: 1pt,
    [*密码*], [*芯片*], [*语言*], [*实现方式*], [*分组数*], [*周期*], [*CPB*], [*Flash (bytes)*],
    [QARMAv2], [STM32L476], [Assembly], [Bitsliced], [2], [10,952], [#redt[684.50]], [25,340],
    [QARMAv2], [STM32L476], [C], [Lookup Table], [1], [16,910], [2,113.75], [17,220],
    [AES], [STM32L476], [Assembly], [Bitsliced], [2], [8,066], [#redt[252.06]], [25,244],
    [AES \[21\]], [STM32L476], [Assembly], [Bitsliced], [2], [8,932], [279.12], [27,100],
    [#bluet[AES \[23\]]],
    [#bluet[STM32L476]],
    [#bluet[C]],
    [#bluet[Lookup Table]],
    [#bluet[1]],
    [#bluet[5,204]],
    [#bluet[325.25]],
    [#bluet[26,616]],
  )
]

= P2 任务：NIST 轻量级密码适用性验证

== 任务规划 #oranget[【进行中】]

针对审稿人关于技术对 NIST 轻量级密码标准适用性的问题，计划实施 #bluet[GIFT-COFB bitsliced 优化实验]。


与 Adomnicai et al. (2020) TCHES 的 fixslicing 方法进行对比

应用 OPO 算法和改进的 BGC 模型优化：
- GIFT 的线性层
- 4-bit S-box

验证方法在 NIST LWC 标准上的有效性

== 选择 GIFT-COFB 的原因

Ascon 的限制：
- 320-bit 状态分为五个 64-bit 字
- #redt[在 32-bit MCU 上 64-bit 字长要求数据跨越多个寄存器]
- 严重限制并行计算效率

GIFT-64 的优势：
- 架构更适合 32-bit 平台的 bitsliced 优化
- 能够更好地展示我们方法的实际效果

= 总结

== 下周计划

#redt[完成 P2 任务]：
- 实施 GIFT-COFB bitsliced 优化实验
- 与 fixslicing 方法对比
- 验证技术在 NIST LWC 标准上的适用性

#redt[完成编辑意见回复]

== 老师评语

*上面这个摘要就要写在邮件正文，要学会利他思想，我知道别人最想知道什么我就按别人的要求写东西，我们现在很多学生是利己做事。*

学生下次改正

*已修改部分的回复信没写还是没有发给我？？？*

学生想整体修改好后发您

