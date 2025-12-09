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
  2025-12-08
]

=

== 本周研究摘要

#redt[扩展论文Cryptographic Optimization Implementation章节]
- ARM Cortex-M4 NTT汇编优化技术详细阐述
- #bluet[NTT优化性能汇总表：53.8%延迟降低(320K→148K周期)]

== ARM Cortex-M4架构特性

#redt[ARMv7E-M架构Thumb-2指令集]
- 13个通用32位寄存器(R0-R12)
- 三级流水线：取指、译码、执行

#bluet[硬件乘法指令]
- UMULL：单周期32×32→64位乘法
- UMLAL：无符号长乘累加
- MLA：乘累加指令

== NTT蝶形操作优化

#redt[Cooley-Tukey蝶形运算]
- $a' arrow.l a + t dot zeta mod q$
- $b' arrow.l a - t dot zeta mod q$
- 每256点变换执行2048次蝶形操作

#bluet[优化汇编实现]
- 7周期/蝶形 vs 编译C代码18-22周期
- #greent[61-68%延迟降低]

== Montgomery乘法集成

#redt[Montgomery域高效模算术]
- Montgomery表示：$tilde(a) = a dot R mod q$，$R = 2^(32)$
- 4周期延迟实现

#bluet[ARM Cortex-M4汇编序列]
- UMULL计算$T = tilde(a) dot tilde(b)$(1周期)
- MUL计算$m = T_(l o) dot q^(-1) mod 2^(32)$(1周期)
- UMLAL计算$T' = T + m dot q$(1周期)
- MOV提取$t = T' \/ 2^(32)$(1周期)

== 寄存器分配策略

#redt[13个通用寄存器分区]
- 系数寄存器(R0-R7)：8个蝶形输入/输出
- 旋转因子寄存器(R8)：当前旋转因子
- 常量寄存器(R9-R10)：$q^(-1)$与$q$
- 地址寄存器(R11-R12)：数组指针

#bluet[内存访问优化]
- 0.5次加载+0.5次存储/蝶形
- vs 朴素实现3次加载+2次存储/蝶形

== 延迟模约减策略

#redt[约减成本占NTT计算35-40%]
- 延迟约减维持中间值于$[0, 2q)$或$[0, 4q)$
- 完整约减仅发生于NTT阶段边界

#bluet[约减操作消除]
- 4096次→768次约减/变换
- #greent[81%约减操作消除，18-23%延迟降低]

== Barrett约减技术

#redt[Montgomery域外高效模算术]
- 预计算$mu = floor(2^(48) \/ q) = 33554431$
- 乘法移位序列替代除法

#bluet[ARM Cortex-M4实现]
- 6周期 vs 软件除法12-18周期
- #greent[50-67%约减开销改进]

== NTT优化性能汇总

#redt[ARM Cortex-M4 168 MHz周期计数]

#table(
  columns: 3,
  [*优化技术*], [*周期*], [*累积改进*],
  [参考C实现], [320,000], [基线],
  [汇编蝶形], [248,000], [22.5%],
  [Montgomery乘法], [198,000], [38.1%],
  [延迟约减], [172,000], [46.3%],
  [4倍循环展开], [156,000], [51.3%],
  [指令调度], [148,000], [#greent[53.8%]],
)

= 总结

== 下周计划

#redt[论文完善]：

- 完善Results章节实验数据
- 补充Conclusion章节撰写

== 老师评语

*继续推进，注意时间分配，不要一次只能做一件事，一定要学会并行处理事情*

并行规划处理好事项
