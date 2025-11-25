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
  2025-11-24
]

=

== 本周研究摘要

#redt[完成ML-DSA签名算法深入分析与NTT优化策略研究]
- #bluet[签名算法结构和计算特征章节撰写]：签名流程、Fiat-Shamir with Aborts、NTT算法伪代码
- #greent[性能瓶颈识别]：拒绝采样、NTT主导(60-70%)、模约减、哈希函数
- #oranget[优化策略阐述]：汇编优化、延迟约减、预计算

== 签名算法结构分析

#redt[签名流程两层结构]：
- Wrapper函数：上下文验证(255字节限制)、随机数生成(32字节)
- 内部签名：Fiat-Shamir with Aborts范式、拒绝采样循环

#redt[拒绝采样机制]：
- 采样掩蔽向量$bold(y)$ → 计算承诺$bold(w) = bold(A) dot bold(y)$ → 推导挑战$c$
- 响应向量$bold(z) = bold(y) + c dot bold(s)_1$需通过边界检验(阈值$gamma_1 - beta$)
- #bluet[期望迭代次数：ML-DSA-44/65/87分别为4.25、5.1、3.85次]

== NTT计算特征

#redt[NTT算法结构]：
- 环$R_q = ZZ_q[X]/(X^256 + 1)$，模数$q = 8380417$
- 正向NTT：Cooley-Tukey蝶形，本原根$zeta = 1753$
- 逆向NTT：Gentleman-Sande蝶形，缩放因子$f = 256^(-1) mod q$

#redt[计算复杂度]：
- #bluet[单次NTT：$256 times 8 = 2048$次蝶形操作]
- 每次蝶形：1次模乘、2次模加减
- #bluet[NTT占签名总成本60-70%]

== 性能瓶颈识别

#redt[四个主要瓶颈]：
- 拒绝采样：迭代开销，最坏情况>20次
- NTT计算主导：60-70%总计算成本
- 模约减：占NTT成本~40%，每次蝶形后执行
- SHAKE-256哈希：15-20%签名计算量

== 优化策略框架

#redt[NTT汇编优化]：
- 手工ARM汇编：指令级并行、寄存器优化、流水线调度
- UMULL指令：$32 times 32 -> 64$位乘法、条件执行消除分支

#redt[延迟模约减]：
- 跨多个蝶形操作推迟约减、维持系数$< 2q$而非$< q$
- Montgomery：融合乘-约减操作

#redt[预计算策略]：
- 秘密向量$bold(s)_1$、$bold(s)_2$存储为NTT表示, 旋转因子预计算


= 总结

== 下周计划
#redt[论文实现优化与结果分析撰写]：

- 实现NTT汇编优化或延迟模约减策略
- 论文Results and Analysis章节撰写

== 老师评语

*继续推进定稿可投*

抓紧推进论文和实验
