#import "@preview/basic-document-props:0.1.0": simple-page

// Chinese font configuration
#set text(
  font: (
    "Source Han Serif",
  ),
  lang: "zh",
  region: "cn",
)

// Document setup
#set document(title: "周报 isomo", author: "isomo", date: datetime.today())

// Page setup
#set page(
  numbering: "1",
  number-align: center,
)

// Heading styles and numbering
#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")

// Citation styling - make citations blue and clickable-looking
#show cite: set text(fill: blue)

// Table caption positioning - put captions above tables
#show figure.where(kind: table): it => [
  #it.caption
  #it.body
]

// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

// Title page
#align(center)[
  #text(size: 18pt, weight: "bold")[
    周报 向嘉豪(2025-10-13)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
#redt[本周完成ML-DSA论文实验方法论体系构建与实验环境部署准备]。#bluet[完成第4节实验方法论框架设计]，建立ARM Cortex-M4性能评估体系。实验平台采用STM32F407VG(168MHz、1MB Flash、192KB SRAM)配合pqm4库实现ML-DSA测试。测量框架利用DWT单元实现周期级计时与栈水印内存剖析。基准测试覆盖密钥生成、签名、验证全流程，包含10/50/100字节IoT载荷，建立ECDSA P-256对比基线。评估指标涵盖计算性能、内存占用、协议开销三维度。实验环境已完成STM32配置与工具链部署，pqm4移植与MQTT集成进行中。

#v(1em)

// Week plan box
#rect(
  width: 100%,
  stroke: 1pt,
  inset: 10pt,
  [
    #text(weight: "bold")[下周计划:]
    1) 完成pqm4库ARM Cortex-M4平台移植与功能验证。
    2) 启动ML-DSA基准测试数据采集，完成密钥生成、签名、验证性能基线测量。
    3) 实现MQTT载荷嵌入式签名原型系统，测量协议级传输开销。
  ],
)

#v(1em)

= ML-DSA论文第4节实验方法论体系完成

== 实验平台架构设计

#redt[硬件平台选型] 本周完成实验平台架构设计，采用ARM Cortex-M4微控制器作为评估平台，代表工业监控、智慧农业等中端IoT设备典型配置。硬件选型为STM32F407VG开发板，搭载168MHz主频ARM Cortex-M4F内核，配备1MB Flash与192KB SRAM，真实反映需要密码学认证的资源约束环境。软件采用ARM GCC 10.3.1工具链，启用-O3优化以实现最佳性能。

#bluet[密码学库集成] ML-DSA实现源自pqm4参考库，提供ARM Cortex-M4优化的全部三个参数集(ML-DSA-44/65/87)并通过NIST测试向量验证。集成micro-ecc库实现ECDSA P-256作为对比基准，采用相同编译优化确保可比性。MQTT集成采用Eclipse Paho嵌入式C客户端，配置QoS 1与5秒保活间隔，通信目标为Mosquitto 2.0.15代理。网络连接利用ESP32-WROOM-32模块提供WiFi接入。

== 性能测量框架建立

#greent[计算性能测量] 利用ARM Cortex-M4 DWT硬件单元通过DWT_CYCCNT寄存器提供周期精度计时。该硬件方法消除软件剖析开销，实现单周期分辨率。测量涵盖完整操作流程，包括预处理、核心计算、结果格式化阶段。

#redt[内存占用剖析] 采用静态与动态测量相结合的方法。静态消耗通过arm-none-eabi-size从编译输出提取，量化代码与数据段Flash需求。动态剖析采用栈水印技术，以0xDEADBEEF哨兵值初始化栈区域，执行后扫描确定峰值利用。能耗评估采用INA219传感器以100Hz频率测量供电电流，支持电池供电设备功率分析。

== 基准测试方案设计

#bluet[密码学操作评估] 基准测试涵盖全部ML-DSA操作的系统性评估。密钥生成测量完整公私钥对生成，签名生成捕获端到端延迟包括拒绝采样迭代，验证测量签名验证计算成本。每个参数集横跨10字节传感器读数、50字节遥测包、100字节状态报告三类IoT载荷，捕获真实通信模式。ECDSA P-256基线执行相同操作序列，全部测量在相同环境条件下执行。

#greent[统计严谨性] 每项操作执行1000次迭代并消除离群值。报告中位数执行时间提供稳健估计，配合四分位距量化变异性。对签名生成额外报告最小与最大执行时间以刻画性能边界。

== MQTT集成测试协议

#redt[端到端认证工作流] MQTT集成评估载荷内嵌入ML-DSA签名的认证工作流。发布者生成签名并附加到载荷，通过MQTT PUBLISH传输复合消息。订阅者接收消息，提取签名，检索公钥并验证真实性。端到端延迟测量涵盖签名生成、消息传输、网络传播、代理路由、接收反序列化、签名验证完整生命周期。测试评估QoS 0/1/2三个级别的开销特征。

== 评估指标体系

#bluet[多维评估框架] 指标涵盖计算性能(CPU周期、执行时间、操作速率)、内存占用(代码尺寸、静态RAM、栈消耗)、协议影响(消息尺寸开销、传输延迟、验证延迟)三大维度。比较分析采用开销比率R = M_{ML-DSA} / M_{ECDSA}量化后量子迁移成本，为资源受限IoT环境的部署规划提供洞察。

= 实验环境搭建进展

== STM32开发板平台配置

#redt[硬件验证] 已获取STM32F407VG开发板并完成硬件验证。通过ST-Link建立稳定主机-目标板通信，确认USB供电与串口通信正常。配置ARM GCC 10.3.1工具链与OpenOCD调试服务器，实现程序烧录、断点调试功能。配置115200波特率串口终端用于测试输出与数据采集。

== pqm4密码学库移植

#greent[项目结构分析] 从GitHub获取pqm4源码，完成项目结构分析，识别核心模块包括poly.c、ntt.c、sign.c、randombytes.c等组件。库采用模块化设计，支持通过编译标志选择不同参数集。

#redt[移植适配] 正在进行STM32平台移植适配。主要挑战包括硬件抽象层适配、RNG外设对接、DWT计数器配置。需整合pqm4 Makefile与STM32 HAL构建脚本。已完成基础编译环境配置，正解决头文件路径与链接器脚本适配。

== MQTT客户端集成

#bluet[Paho MQTT库] 评估Eclipse Paho嵌入式C客户端集成可行性。该库提供轻量级MQTT 3.1.1实现，符合资源受限要求。识别关键配置参数包括最大消息尺寸(容纳2.4-4.6KB签名载荷)、网络缓冲区、QoS支持。模块化网络接口支持对接ESP32 WiFi模块。

#greent[ESP32对接方案] 规划ESP32-WROOM-32与STM32的UART串口AT指令通信方案。ESP32处理网络协议栈，STM32专注密码学运算与MQTT逻辑，符合性能测量隔离原则。正准备固件烧录与AT接口验证。

== 进度与挑战

实验环境已完成硬件验证、工具链配置、库源码分析等基础工作。当前核心任务为pqm4平台移植与MQTT集成，预计1-2周完成。待解决挑战包括RNG外设对接确保密码学随机性、DWT计数器精确配置验证测量准确性、MQTT签名消息格式设计。这些问题是下周核心目标，直接影响实验数据采集阶段。


// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
