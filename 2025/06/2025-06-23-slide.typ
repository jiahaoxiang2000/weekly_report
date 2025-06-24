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
// If the fonts are not installed, you can find new fonts to replace them. by the `typst fonts`.
#set text(
  font: (
    "Noto Sans CJK SC", // Primary Chinese font
    "Noto Serif CJK SC", // Alternative Chinese serif font
    "WenQuanYi Micro Hei", // Chinese fallback font
    "FZShuSong-Z01", // Traditional Chinese font
    "HYZhongSongJ", // Another Chinese font option
    "Noto Sans", // Latin fallback
    "Roboto", // Final fallback
  ),
  // lang: "zh",
  // region: "cn",
)

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
// For headings, you can use a different font:
#show heading: set text(font: "Noto Serif CJK SC", weight: "bold")
// For code blocks, you can use a monospace font:
#show raw: set text(font: "Noto Sans Mono CJK SC")

#show: simple-theme.with(aspect-ratio: "16-9", footer: [周报])

#title-slide[
  = 周报 - 论文选题
  #v(2em)

  向嘉豪

  #v(2em)
  #datetime.today().display()
]

= 研究概述

== 本周研究摘要

本周报告分析了后量子密码学（PQC）算法标准化现状，重点关注数字签名算法（DSA）在网络协议迁移中面临的技术挑战。


资源约束环境下物联网协议的算法优化实现，具有较大研究意义。

#pause

#redt[关键发现：后量子签名算法的大签名尺寸是协议迁移的主要瓶颈]

#bluet[研究方向：ML-DSA在MQTT协议下的迁移实现优化]


= NIST标准化进程 - 2025

== 后量子密码学标准化现状

=== 密钥封装机制（KEM）
- #bluet[FIPS 203（ML-KEM）基于CRYSTALS-Kyber已于2024年正式发布]
- 为密钥交换提供了标准化解决方案

#pause

=== 数字签名算法（DSA）
- #bluet[FIPS 204（ML-DSA）基于CRYSTALS-Dilithium]
- FIPS 205（SLH-DSA）基于SPHINCS+
- FIPS 206（FN-DSA）基于FALCON（预计2025年夏季发布）

== 标准化时间线

2025年3月重要进展：
- HQC算法被选中，作为ML-KEM备选
- 14个第二轮On-Ramp签名候选算法确定

#pause

#redt[重要时间节点：旧签名和密钥封装算法标准将于2035年废止]

迫切需要向后量子安全算法迁移

= 协议迁移挑战

== 协议迁移技术挑战分析

基于NCCoE SP 1800-38C的协议迁移测试结果：

#redt[数字签名算法(DSA)迁移比密钥交换迁移面临更严峻的挑战]

#pause

=== TLS 1.3性能表现
- Kyber-768：681次握手/秒
- 经典P384：223次握手/秒
- Kyber显示出优异性能优势

== 签名算法挑战

#bluet[Dilithium证书大小达到18-22 KB，在QUIC协议中触发了额外的往返传输]

导致的问题：
- 放大保护机制启动
- 拥塞控制窗口限制
- 网络开销显著增加

= DSA算法实现进展

== ML-DSA（FIPS 204）

NIST主要推荐算法，性能与安全性平衡良好

#bluet[GPU加速研究显示cuML-DSA在服务器GPU上实现了170.7×到294.2×的性能提升]


优化方法：
- 深度优先稀疏三元多项式乘法优化
- 分支消除方法
- 为高吞吐量服务器环境提供可行解决方案


== SLH-DSA（FIPS 205）

基于哈希函数的保守安全基础


#redt[限制因素：极大的签名尺寸和较慢的签名速度限制了实际应用场景]


硬件加速：
- SLotH实现可达到300×性能提升
- 仍难以满足高频次签名需求和资源受限环境

== FN-DSA（FIPS 206）

优势：
- 最小的签名尺寸
- 快速验证

#redt[安全挑战：2025年发现的Rowhammer攻击显示单个比特翻转可以通过数亿次签名恢复完整密钥]

其他限制：
- 浮点运算敏感性
- 侧信道漏洞

= 研究方向选择

== ML-DSA与MQTT协议研究方向

经过综合评估，确定ML-DSA与MQTT物联网协议结合作为主要研究方向

=== 算法选择理由
- NIST主要推荐的后量子签名算法
- 相对成熟的安全分析和实现基础
- GPU加速研究进展为服务器端优化提供参考
- 模格假设具有更好的理论基础

== 协议选择理由

2025年KEM-MQTT研究成果：
- 在8位AVR设备上优化实现
- 发表于25-CCS（CCF-A）安全顶会
- 证明了资源受限环境下实现后量子安全的研究价值

#redt[25CCS文章未将DSA迁移入MQTT实现，ML-DSA-MQTT协议集成研究为空白]

= 总结

== 下周计划

制定ML-DSA在MQTT协议中的实现优化研究计划


具体任务：
- 深入分析ML-DSA算法特性
- 研究MQTT协议的资源约束特点
- 设计针对IoT环境的优化策略
- 制定详细的实现方案

== 老师评语

#figure(image("abstrat.png", width: 45%))

*1）先看下这个摘要的第一句话，作为研究生写得如此不通顺的中文我比较少见。*

“相关性”此处是错误的 应该是攻击性✔

#pagebreak()

*2）论文要用第3人称，这个说了很多次吧，你看下你这用了多少第1人称，一个人不去思考不听取教育那如何进步？？？*

是的老师说了很多次了，学生会努力改正的。

*3）你这摘要创新是在堆砌几个点还是围绕着一个点在递进？至少我从摘要写作上看不出是围绕一个核心困难问题在递进解决。*

现在的摘要是对该方向下，可研究点的汇总，随着研究的深入，学生会围绕一个核心问题进行深入研究。
