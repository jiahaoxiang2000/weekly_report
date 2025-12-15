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
    周报 向嘉豪(2025-12-15)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周#redt[为ML-DSA论文新增5幅TikZ可视化图示]，系统展示算法流程、系统架构与协议结构。内容涵盖ML-DSA签名流程图(Fiat-Shamir with Aborts范式与拒绝采样循环)，MQTT发布-订阅架构与ML-DSA集成图示，硬件平台架构图(STM32F407VG与ESP32 UART互连)，软件分层架构栈(Application→MQTT/Crypto→FreeRTOS→HAL→Hardware)，以及TLV编码消息格式结构图。#bluet[所有图示遵循TikZ相对定位设计原则确保嵌套环境兼容性]。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 完善Results章节实验数据
  2) 补充Conclusion章节撰写
])

#v(1em)

= 论文可视化元素扩展

完成了Implementation Architecture章节与ML-DSA Algorithm章节的TikZ图示扩展，共新增5幅技术图示系统展示ML-DSA在MQTT环境中的部署架构与算法特征。图示设计遵循统一的风格规范:采用蓝色(`\color{blue}`)作为主色调增强视觉区分度;使用TikZ相对定位语法(`right=of`、`below=of`)确保图示在各种LaTeX环境(itemize、minipage、multicol等)中的稳健渲染;避免使用anchor偏移量、绝对坐标与xshift/yshift修饰符以提升跨环境兼容性。

图示分布于论文核心章节:ML-DSA签名流程图(fig:mldsa-signing)，展示Fiat-Shamir with Aborts范式的拒绝采样循环结构;MQTT架构图(fig:mqtt-mldsa)位于MQTT Protocol and Security Integration小节，阐明发布者-代理-订阅者消息流与加密操作分布;硬件架构图(fig:hardware-architecture)与软件架构图(fig:software-stack)位于Implementation Architecture章节，分别展示计算与网络职责分离的硬件设计与模块化软件分层;消息格式图(fig:message-format)位于Message Format and Signature Integration小节，图解TLV编码复合消息结构。

= ML-DSA签名流程图设计

设计了ML-DSA签名流程图展示Fiat-Shamir with Aborts范式核心结构。流程图采用紧凑垂直布局，包含开始/结束节点(圆角矩形、灰色填充)、处理节点(矩形、白色填充)、NTT操作节点(矩形、浅灰填充突出计算密集特性)与决策节点(菱形)。主流程从私钥$s k$与消息$M$输入开始，经密钥展开(Expand Key)、消息哈希($mu arrow.l H(M)$)、掩码向量采样(Sample $bold(y)$)、NTT变换($hat(bold(w)) arrow.l bold(A) hat(bold(y))$)、挑战计算($c arrow.l H(bold(w)_1, mu)$)、响应向量计算($bold(z) arrow.l bold(y) + c bold(s)_1$)，至范数检验决策节点($||bold(z)||_infinity < gamma_1 - beta$)。

拒绝采样循环通过决策节点右侧分支实现，"No"路径返回至Sample $bold(y)$节点形成闭环，标注"4--5 iter."表示期望迭代次数;决策节点下方"Yes"路径通向签名输出节点。关键性能标注包括:NTT节点左侧"60--70% cost"说明NTT操作占签名计算60-70%开销;Sample节点右侧"4--5 iter."标注期望拒绝采样迭代次数。图示尺寸控制在单栏宽度内，节点间距0.55cm确保紧凑布局同时保持可读性。

= MQTT架构与消息格式图示

设计了MQTT发布-订阅架构图展示ML-DSA签名集成于IoT消息流的完整路径。架构图采用水平三节点布局:Publisher(IoT Sensor)、Broker(Route)、Subscriber(Gateway)，通过PUBLISH与FORWARD箭头连接表示消息流向。各端点下方标注加密操作节点:Publisher下方"Sign (657--1150 ms)"表示签名延迟范围(ML-DSA-44至ML-DSA-87)，Subscriber下方"Verify (416--717 ms)"表示验证延迟范围。Broker上方消息结构框展示复合消息组成:Payload 10--100 B与Sig. 2.4--4.6 KB，直观呈现签名数据相对载荷的尺寸主导地位。端点两侧标注密钥符号($s k$、$p k$)表示私钥与公钥分布。

TLV编码消息格式图采用水平字段链布局，各字段以紧邻矩形呈现:Type(1B)、Len(2B)构成Header区域;Payload(10--100 B)为应用数据区域;Alg(1B)、Key(2B)、Time(4B)、Len(2B)构成Sig. Metadata区域;Signature(2.4--4.6 KB)为签名数据区域(深色填充突出尺寸主导)。字段下方使用花括号分组标注Header与Sig. Metadata区域，上方标注"Data"与"Dominates size"说明功能与尺寸特征，顶部跨越式标注"Total message: 2.4--4.7 KB"显示完整消息尺寸范围。

= 硬件与软件架构图设计

设计了硬件平台架构图展示加密计算与网络协议处理的职责分离设计。架构图采用双核心水平布局:左侧STM32F407VG节点(ARM Cortex-M4F、168 MHz、1 MB Flash、192 KB SRAM)负责加密操作(Crypto Operations: ML-DSA Sign/Verify)，右侧ESP32节点(WiFi 802.11n、TCP/IP Stack)负责网络协议(Network Protocol: MQTT Transport)。双向箭头标注"UART 115.2k"连接两核心表示串口互连。外围组件包括:左侧Sensors(ADC/I2C)通过箭头连接STM32输入，右侧WiFi Network通过箭头连接ESP32输出;下方电源子系统3.3V Regulator与INA219 Current传感器节点以虚线连接表示供电与能耗监测。

软件分层架构图采用垂直栈式布局展示五层模块化设计。顶层Application Layer(Publish/Subscribe Workflows, Sensor Data Processing)为应用逻辑层;第二层并列MQTT Client(Paho Embedded C、QoS 0/1/2)与ML-DSA Crypto(pqm4 Library、Sign/Verify/KeyGen)分别处理协议与加密;第三层FreeRTOS(Task Scheduling, Queues, Synchronization)提供实时操作系统支持;第四层ARM Cortex-M4 HAL(Peripheral Access, Clock Config, Interrupts)实现硬件抽象;底层Hardware(STM32F407VG规格)为物理硬件。各层采用渐进深色填充区分层级，侧边标注Network API与Crypto API说明接口边界，顶层至第二层的箭头表示应用层对协议层与加密层的调用依赖。

// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
