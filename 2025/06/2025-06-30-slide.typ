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
  = 周报 - ML-DSA学习与论文写作
  #v(2em)



  #v(2em)
  #datetime.today().display()
]

= 研究概述

== 本周研究摘要

本周系统性地分析了ML-DSA FIPS-204标准的数学基础与工程实现，深入阐述了基于模格密码学的数字签名算法在后量子密码学标准化进程中的关键作用。

完成了六个核心功能模块的架构设计。


= ML-DSA算法学习

== 核心算法理论掌握

#redt[系统掌握了ML-DSA的核心技术原理]

=== 数学基础
- 基于模学习误差问题(MLWE)和模短整数解问题(MSIS)
- 在环$R_q = Z_q[X]/(X^{256} + 1)$上操作，其中$q = 8,380,417$
- 采用Fiat-Shamir启发式方法的Schnorr类签名方案

== 密钥生成算法

密钥生成过程确保密钥对的正确性和安全性($(bold(A), bold(T))$公钥,$(s_1,s_2)$私钥)：

1. 使用SHAKE-128生成随机矩阵$bold(A)$
2. 采样具有小系数的私钥向量$bold(s)_1, bold(s)_2$
3. 计算公钥$bold(T) = bold(A)bold(s)_1 + bold(s)_2$

== 签名生成与验证

=== 签名生成过程
采用概率性方法并应用拒绝采样技术：
- 采样随机向量$bold(y)$并计算承诺$bold(w) = bold(A)bold(y)$
- 从消息和承诺中生成挑战$c$
- 计算响应$bold(z) = bold(y) + c bold(s)_1$


=== 签名验证
- 重构验证值并检查边界条件
- 校验 $bold(A)bold(z) - bold(T)bold(c) approx bold(w)_"Approx"$

== 架构设计与实现
依据FIPS-204中给出的#redt[43个算法]，设计了六个核心功能模块
- *代数运算模块*(`algebra.rs`)：环$R_q$上的多项式运算
- *数论变换模块*(`ntt.rs`)：NTT优化多项式乘法
- *密码学原语模块*(`crypto.rs`)：SHAKE-128/256哈希函数

- *采样模块*(`sampling.rs`)：均匀采样、高斯采样和拒绝采样
- *编码模块*(`encode.rs`)：多项式和签名的序列化
- *提示系统*(`hint.rs`)：签名压缩的提示机制


= 论文写作进展

== 引言部分完善

补充了多个ML-DSA研究最新成果，包括ARM Cortex-M性能基准测试、电磁故障注入攻击分析等。


= 总结

== 下周计划

1) #redt[完成ML-DSA核心算法模块]，并将其集成到嵌入式系统中，验证其在资源受限环境下的可行性

2) 设计MQTT协议集成ML-DSA的测试框架，评估签名延迟、网络开销和能耗等性能指标


== 老师评语

*你的工作报告用词不错，比如通过XXXXX建立了XXXX，这个用在摘要中也很高大上，但论文里的内容就得充分来证明你的创新和工作量*

提高论文创新和写作
