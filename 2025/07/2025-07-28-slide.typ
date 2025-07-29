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
  = 周报 - 论文审稿回复
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

= 概述

== 本周研究摘要

本周完成三项核心工作：

- #bluet[7月25日完成第二篇论文审稿回复和提交]，回应编辑和审稿人所有关切
- #redt[深入研读第三篇论文大修意见]，明确三个改进方向

#redt[下周计划]：集中精力回应第三篇论文的大修意见，重点完成性能分解分析和GPU性能剖析。

= 第二篇论文审稿回复 #bluet[【已完成】]

== 提交完成情况

7月25日完成《Low-Latency Implementation of Bitsliced SPN-Cipher on IoT Processors》最终审稿回复和提交。

#bluet[编辑关注的四个主要问题均已充分解决：]

- #bluet[新颖贡献清晰阐述]：通过Table IV展示7种S盒详细时序对比
- #redt[NIST标准适用性论证]：通过GIFT-COFB实验验证19.5%性能提升
- #greent[公平性能比较]：修正跨平台比较问题，证明22.5%性能优势
- #purplet[参考文献和写作质量]：全面校对和更新

= 第三篇论文大修意见研读 #redt[【进行中】]

== 审稿人意见分析

深入研读《Thread-Adaptive: High-Throughput Parallel Architectures of SLH-DSA on GPUs》大修意见：


#bluet[审稿人1（小修建议）]：
- 线程分配优化和函数级并行的具体贡献分解
- GPU计算和内存利用率的详细剖析数据

#pagebreak()

#redt[审稿人2（拒稿）]：
- SLH-DSA算法细节缺乏
- 数据流和架构设计动机不明确
- 硬件级评估工具使用不足

#greent[审稿人3（大修）]：
- 性能模型的剖析精度损失讨论不足
- 内存影响分析缺失
- 大规模应用场景下的内存含义需深入探讨


== 三个核心改进方向

#bluet[1. 性能分解分析强化]
- 实现更细粒度的性能测量框架
- 分别量化ATA和FLP技术的具体贡献
- 提供GPU利用率、缓存行为、占用率等详细指标

#redt[2. 算法背景补充]
- 大幅扩展SLH-DSA算法技术细节介绍
- 包括WOTS+、FORS、Hypertree等核心组件工作原理
- 补充并行化设计动机和实现细节

#pagebreak()

#greent[3. 工具验证增强]
- 集成NVIDIA Nsight Compute等专业GPU性能分析工具
- 提供硬件级执行分析和优化验证
- 增强技术贡献的可信度

= 总结

== 下周核心计划

#redt[集中任务]：
- 回应第三篇论文大修意见
- 重点完成 #redt[性能分解分析和GPU性能剖析]
- 补充算法实现细节和相关背景介绍

== 老师评语

*重点完成审稿意见*

抓紧时间，争取在8月中旬完成第三篇论文的修订。
