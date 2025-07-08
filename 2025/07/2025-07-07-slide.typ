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
  = 周报 - 审稿意见回复工作
  #v(2em)

  #v(2em)
  #datetime.today().display()
]

= 研究概述

== 本周研究摘要

本周主要完成的审稿意见系统性回复工作。针对编辑和两位审稿人提出的关键问题进行了深入分析和响应。

#redt[截至时间：2025年7月29日]

= 审稿人1意见回复

== 意见1：S-box实现优化描述 #oranget[【正在进行】]

"Unlike the first contribution, the second contribution that aims to optimize the S-box implementation, is not clearly described. In particular, it is unsure which part of III.B is novel, compared to existing work, which requires a #redt[more detailed comparison]."

- 初步测试结果：QARMAv2 4-bit S-box 20个串行排列
  - Feng[24]方法：2101秒
  - 我们的方法：486秒
  - 测试环境：100线程下cryptominisat求解

== 意见2：NIST轻量级密码学适用性 #oranget[【正在进行】]

"It seems like the technique is only applicable to certain block ciphers that are similar to AES. How about more recent NIST lightweight cryptography schemes? The authors are #redt[encourage to discuss] this aspect in detail."

- 学长建议优先#bluet[添加GIFT-COFB对比实验结果]

== 意见3：实验比较公平性 #oranget[【正在进行】]

"It is unfair to say that #redt[table based implementation is faster than bitsliced implementation] by comparing [23] with [21]. They are using a completely different processor, so it is natural to have very different performance. Moreover, availability of registers is also key to the performance of bitsliced implementation, which can be very different for various processor architectures."

- #bluet[在实验章节中添加更公平的比较，确保相同环境下对比[23]和[21]]

== 意见4 - 语言校对 #bluet[【已完成】]

"This article needs proofreading. Some obvious errors can be found easily. For example, pg. 6 first sentence, it should be 'An encoding method....' Ref[12] is also not formatted correctly in the last page."

- 修正了"A encoding method"到"An encoding method"的语法错误
- 纠正了处理器名称从"Tensilica LX"到"Xtensa LX"的技术准确性问题
- 参考文献[12]的格式已修正，确保符合期刊要求

== 意见5 - 参考文献更新 #bluet[【已完成】]

"Reference [8] seems to be old, there are other more recent GPU implementations of bitsliced AES."

- 已按照审稿人建议更新了相关参考文献
- 使用更新的GPU实现研究来替换过时的引用

= 编辑意见策略

== 回复策略

"The reviewers' main concerns revolve around the novelty and contributions of the paper. To address these, please focus on: #oranget[【待完成-依赖审稿人1所有意见完成】]
- Clearly articulating the novel contribution.
- Discussing the applicability of the technique to NIST standards.
- Revising the comparison with table-based implementations to ensure a fair evaluation.

#pagebreak()

- Updating the references and improving the overall writing quality."

编辑意见是#redt[对审稿人1各项意见的总结]：

策略：先完成审稿人1的所有具体意见，然后基于这些具体回复来综合回应编辑的整体关注点。

= 审稿人2

== 意见
“Y”

审稿人2没有提出具体意见，我们认为其，接受我们的工作。

= 下周计划

== 主要任务

1. #redt[完成审稿人1所有意见的详细回复]：
   - P1 完善S-box编码方法与现有SAT方法的对比实验和数据表格
   - P2 扩展GIFT-COFB对比实验结果
   - P3 实施[23] [21]公平的性能比较实验，确保相同硬件平台条件

2. #bluet[基于审稿人1意见完成情况，综合回复编辑的整体关注点]

== 老师评语

*要尽全力仔细理解审稿人每句话的真正含义，并认真修改好，确保能录用*

全力以赴修改好审稿人意见
