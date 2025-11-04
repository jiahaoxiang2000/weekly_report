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
  2025-11-03
]

=

== 本周研究摘要

#redt[本周主要完成第四篇论文撰写工作]
- #greent[摘要方法论章节优化：提升客观性和学术规范性]
- #oranget[结果章节框架构建：创建三个核心分析维度表格]

== 摘要和方法论章节优化(1/2)

#redt[摘要部分核心优化]：
- 叙述视角转换："Our methodology" → "The methodology"
- 叙述视角转换："We analyze" → "Analysis examines"
- 显著增强论文客观性和学术规范性

#bluet[技术声明优化]：
- 系统性审视表述方式
- 保持技术准确性
- 符合高水平学术期刊写作标准

== 摘要和方法论章节优化(2/2)

#greent[方法论章节改进]：
- 遵循第三人称学术视角转换原则
- "Our experimental platform" → "The experimental platform"

#purplet[系统性优化内容]：
- 软件环境描述
- 评估协议说明
- 基准测试设计
- 集成测试协议细化

== 结果章节框架构建(1/2)

#redt[建立三个核心分析维度表格框架]

#bluet[1. 计算性能分析表格]
- 密钥生成(keygen)性能指标
- 签名生成(signature generation)性能指标
- 签名验证(signature verification)性能指标
- 量化ML-DSA算法在IoT设备上的计算效率

== 结果章节框架构建(2/2)

#greent[2. 内存利用分析表格]
- 静态内存需求
- 动态内存需求
- 资源受限IoT设备部署关键指标

#oranget[3. 协议级开销评估表格]
- 消息大小
- 传输延迟
- 吞吐量等网络性能指标

== 实验工作进展

#redt[实验环境准备完成]：
- ML-DSA算法IoT设备部署测试平台搭建完成
- MQTT协议集成测试环境配置就绪

= 总结

== 下周计划

#redt[完成ML-DSA在IoT MQTT环境中的完整实验工作]

#bluet[收集并填充结果表格所需的定量实验数据]：
- 计算性能数据
- 内存利用数据
- 协议级开销数据


== 老师评语

*工作报告写得很不好，全是主观性描述（而且也不能自己说自己的工作显著：通过将论文叙述从第一人称转换为第三人称视角，显著提升了学术论文的客观性和专业性）
  无法从你工作报告中看出你的详细专业技术含量和工作量
  文字功底是你必须大幅提升的关键问题
*

会将老师的意见作为今后工作报告的准则，进行改进。
