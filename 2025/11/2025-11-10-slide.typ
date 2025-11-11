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
  2025-11-10
]

=

== 本周研究摘要

#redt[完成ML-DSA算法在IoT MQTT环境中的完整实验工作]
- #bluet[计算性能评估：密钥生成、签名生成与验证性能量化]
- #greent[内存利用分析：静态Flash与动态SRAM需求评估]
- #oranget[协议级开销测试：消息大小、端到端延迟与吞吐量]

测试平台：ARM Cortex-M4微控制器（168 MHz）

参数集：ML-DSA-44、ML-DSA-65、ML-DSA-87

== 计算性能数据收集

#redt[密钥生成性能]：
- ML-DSA-44：151.0ms（#redt[100.7倍]开销 vs ECDSA 1.50ms）
- ML-DSA-65/87：249.0ms/357.0ms（166-238倍开销）

#redt[签名生成性能]（主要瓶颈）：
- ML-DSA-44：657.0ms（#redt[71.5倍]开销 vs ECDSA 9.19ms）

#redt[签名验证性能]：
- ML-DSA-44：416.0ms（26.0倍开销 vs ECDSA 16.00ms）

#greent[关键发现]：性能主要取决于核心密码学操作

== 内存利用数据收集

#redt[静态内存（Flash）]：
- ECDSA：9.7 KB
- ML-DSA-44：37.2 KB（#redt[3.8倍]开销）

#redt[动态内存（SRAM）]：
- ECDSA：2.1 KB
- ML-DSA-44：22.7 KB（#redt[10.8倍]开销）

#redt[关键约束]：接近/超过Cortex-M4 SRAM容量限制（64-128 KB）

== 协议级开销数据收集

#redt[MQTT消息大小]：
- ECDSA 10字节载荷：82字节（4.6倍）
- ML-DSA-44 10字节载荷：2,438字节（#redt[135.4倍]）
- ML-DSA-65/87：3,327/4,645字节（185-258倍）

#redt[端到端延迟]（50字节载荷）：
- ECDSA：54.1ms
- ML-DSA-44：1,114.2ms（#redt[20.6倍]开销）

#greent[关键发现]：签名生成构成主要性能瓶颈

= 总结

== 下周计划

#redt[论文写作完善工作]：

1. 优化方法章节的技术细节 突出创新性贡献

2. 进行论文全文的学术化审查和语言优化


== 老师评语

*Hengyang Normal University, College of Computer Science and Technology, Hengyang, China
  就上面这个顺序都是错的，一定要注意细节，细节决定成败！即使投会议，论文语言始终要直接简洁，不要过多冗余和科普，论文本来就是写给领域专家看的*

已按最新一期CHES论文修改好单位

