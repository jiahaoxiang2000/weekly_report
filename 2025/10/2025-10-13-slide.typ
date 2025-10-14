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
  2025-10-13
]

=

== 本周研究摘要

- #bluet[ARM Cortex-M4性能评估体系建立]
- #greent[实验环境部署：STM32配置完成，pqm4/MQTT集成中]


== 实验平台

#redt[硬件]：STM32F407VG(168MHz Cortex-M4F、1MB Flash、192KB SRAM)

#bluet[密码学库]：pqm4(ML-DSA-44/65/87) + micro-ecc(ECDSA P-256对比基准)

#greent[通信]：Paho MQTT客户端 + ESP32 WiFi

== 测量与评估方法

#oranget[性能测量]：DWT_CYCCNT单周期精度 + 栈水印内存剖析 + INA219能耗

#purplet[基准测试]：密钥生成/签名/验证 × 10/50/100字节载荷 × 1000次迭代

#bluet[评估指标]：计算性能(周期/时间) + 内存(Flash/RAM/栈) + 协议开销

#redt[对比分析]：R = M_{ML-DSA} / M_{ECDSA}

== MQTT 端到端认证

#redt[认证流程]：发布者签名 → MQTT传输 → 订阅者验证

#greent[延迟测量]：签名生成→消息传输→网络传播→代理路由→签名验证

#bluet[QoS测试]：评估QoS 0/1/2三级别的协议开销特征

== 实验环境进展

#greent[已完成]：
- STM32硬件验证(ST-Link + 串口) + 工具链(ARM GCC + OpenOCD)
- pqm4源码分析与核心模块识别

#oranget[进行中]：
- pqm4移植(HAL适配、RNG对接、DWT配置)
- MQTT集成(Paho客户端 + ESP32-STM32 UART方案)


= 总结与下周计划

== 下周计划

#redt[pqm4移植]：完成ARM Cortex-M4平台适配与功能验证

#bluet[基准测试]：采集密钥生成/签名/验证性能基线数据

#greent[MQTT原型]：实现载荷签名系统，测量协议级传输开销

== 老师评语

*注意理论上的写作提升，包括形式化、推导证明等，不要写成纯工程性论文*

算法实现优化部分 添加理论分析
