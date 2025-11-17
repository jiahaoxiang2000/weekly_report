#import "@preview/basic-document-props:0.1.0": simple-page

// Chinese font configuration
#set text(
  font: (
    "Source Han Serif",
  ),
  lang: "zh",
  region: "cn",
)

// Paragraph layout - full justification with hyphenation
#set par(justify: true)
#set text(hyphenate: true)

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
    周报 向嘉豪(2025-11-17)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周完成了论文三个维度的系统化改进工作。#redt[新增Implementation Architecture章节]，描述MQTT发布-订阅拓扑、硬件平台、软件架构、TLV消息格式、密钥管理和错误处理机制。增强Experimental Methodology章节，、编译器优化分析、网络参数、环境控制、栈水印方法、载荷分布论证、统计措施，阐述五个创新方法论框架（DWT硬件剖析±1周期精度、多维资源特征化、六阶段协议层评估、多阶段延迟归因、度量框架）。完成全文学术语言优化，转换被动语态，消除口语表达，提升数值精度，统一时态。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 优化实现架构以提升ML-DSA签名操作性能
  2) 论文Results and Analysis章节的深入分析和讨论部分撰写
])

#v(1em)

= 实现架构章节撰写

完成了Section 3 Implementation Architecture章节撰写，从系统层级、硬件平台、软件架构和协议集成四个维度描述ML-DSA签名集成在MQTT通信框架中的实现架构。系统架构描述了MQTT发布-订阅拓扑在引入ML-DSA签名认证后的消息流程，包含发布者设备（签名生成）、MQTT代理（消息路由）和订阅者设备（签名验证）三个组件。#bluet[该架构实现端到端密码学认证，ML-DSA签名嵌入MQTT载荷内部，提供独立于传输层的不可否认性和身份认证能力]。硬件平台采用STM32F407VG（ARM Cortex-M4F，168 MHz，1 MB Flash，192 KB SRAM）配合ESP32-WROOM-32无线模块（UART 115,200波特率，IEEE 802.11n WiFi），电源架构包含3.3V±1%稳压和INA219电流传感器（12位分辨率，±0.8 mA精度）支持能耗剖析。软件架构分层设计包含HAL硬件抽象层、FreeRTOS任务调度、pqm4密码学库（ML-DSA-44/65/87参数集）和Paho MQTT客户端（MQTT 3.1.1协议）。#bluet[密码学库导出crypto_sign_keypair()、crypto_sign()、crypto_sign_verify()三个核心API]。消息格式采用TLV编码封装传感器数据和签名，密钥管理使用预分发模型配合Flash读保护机制，错误处理覆盖签名失败、连接中断和超时场景（指数退避重连：1-60秒，5秒超时）。

= 实验方法论章节增强

完成了Section 4 Experimental Methodology章节增强，补充技术参数规格和阐述创新性评估方法论框架。平台选择合理性通过ARM Cortex-M4市场数据支撑（38%份额，127亿片年出货量），编译器配置采用GCC -O3（18-23%速度提升，12-15%体积增加），网络参数控制WiFi信号-45至-52 dBm和0.1%丢包率，环境规格包括25°C±2°C温度、3.3V±1%电压和5分钟热稳定化。栈峰值测量采用32字节间隔水印方法（±32字节精度），载荷选择10/50/100字节覆盖92%流量（23%/51%/18%分布），统计措施使用IQR检测配合100次重复测量（0.8-2.3%剔除率），QoS测试规格包含5秒超时和指数退避重传（500毫秒基础延迟，8秒最大延迟，3次重传上限）。引入五个创新方法论框架填补后量子密码学IoT性能评估空白。#redt[硬件辅助剖析利用DWT单元实现±1周期精度的指令级测量]，超越软件计时器方法（典型±100周期精度）。多维资源特征化同时量化CPU时间、内存占用和能耗三个维度。协议层评估框架通过六阶段插桩（发布准备、签名开始、签名完成、传输开始、传输完成、验证完成）实现延迟归因，多阶段延迟归因区分计算延迟、网络延迟和系统延迟，度量框架解决现有研究缺乏协议级开销量化、可持续吞吐量测试和多参数集对比的空白。

= 学术语言优化

完成了全文学术语言优化，提升文本规范性和技术精确性，涵盖Abstract、Introduction、Related Work、Results等章节，修改类型包括语态转换、口语消除、数值精度提升和时态统一。Abstract优化聚焦被动语态转换和冗余消除，将"This research evaluates"改为"is evaluated"符合学术惯例，"imminent threat"简化为"necessitate migration"消除修饰词，"remains unexplored"修改为"remains inadequately characterized"避免绝对化，长度从7句压缩至6句。Introduction消除口语表达并提升技术精确性，"existential threat"改为"fundamentally undermines"避免夸张修辞，"extend beyond"简化为"extending beyond"提升简洁性，"30-70× size increases"补充"2,420-4,627 bytes"提供完整信息，"creates a critical gap"改为"creates critical challenges"避免口语表达。Related Work聚焦数值精度和术语规范，"approximately 45% additional"改为"1.45×"消除模糊限定词并统一倍数表达，"migrating to newer cores"改为"migration to newer cores"使用名词短语提升学术性，"keeping near the edge"改为"positioning at the threshold"采用技术术语。Results针对时态一致性和表述精确性，统一使用一般现在时替代混用的现在时和将来时，"reduce latency"补充"maintain in tens-of-milliseconds regime"提供具体时间范围，"substantially exceeding"改为"exceeding sub-second latency constraints"替换模糊表述，消除"firmly"和"acceptable"等冗余修饰词。

// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
