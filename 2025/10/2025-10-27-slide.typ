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
  2025-10-27
]

=

== 本周研究摘要

#redt[本周完成第二篇论文R2小修全部修订任务并成功提交]
- #bluet[安全性分析章节(Point 1)：新增Security Considerations子章节]
- #greent[图表质量提升(Point 4)：Table 1优化与全部图表矢量化]
- #oranget[2025年10月26日成功提交R2修订版本]


== 安全性分析章节完成(Point 1)

#redt[章节定位]：在Sec. IV-C3新增"Security Considerations"子章节

#bluet[恒定时间执行特性]：
- 位切片实现固有的恒定时间与恒定流特性
- 引用[25] Aldaya et al., TCHES 2019

#purplet[门级掩码优势]：
- 引用[26] Balasch et al., CHES 2015
- 相比查找表实现更系统化且开销更低

== 图表质量全面提升(Point 4)

#redt[Table 1格式优化]：
- 增加行间距避免内容拥挤
- 采用左对齐描述列增强视觉舒适度
- 扩展列间水平间距至2em消除视觉混淆

#bluet[DrawIO矢量图转换]：
- 全部5幅图表(Fig. 1-5)重新绘制为PDF矢量格式
- 满足IEEE出版质量标准
- 任意缩放下保持清晰度

== 图表质量全面提升(Point 4续)

#greent[字体大小提升]：
- 统一将全部图表字体从35px提升至45px
- 28.6%增幅显著增强可读性
- 符合IEEE会刊图表规范

#purplet[冗余元素清理]：
- 优化画布尺寸移除不必要空白
- Fig. 5移除重复位置框
- 强化核心置换变换逻辑表达


= 总结

== 下周计划

#redt[推进第四篇论文写作与实验]

#redt[pqm4移植]：完成ARM Cortex-M4平台适配与功能验证

#greent[MQTT原型]：实现载荷签名系统，测量协议级传输开销

== 老师评语

*继续推进第4篇论文写作工作, 报告一定要有详细下周计划
*

继续推进论文写作

