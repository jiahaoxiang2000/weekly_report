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
    周报 向嘉豪(2025-11-10)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周完成了ML-DSA算法在IoT MQTT环境中的完整实验工作，系统性地收集并填充了论文结果章节所需的全部定量数据。#redt[实验工作涵盖了计算性能、内存利用和协议级开销三个核心评估维度]，在ARM Cortex-M4微控制器（168 MHz）平台上对ML-DSA-44、ML-DSA-65和ML-DSA-87三个参数集进行了全面的性能量化测试。通过填充六个关键性能分析表格，为论文提供了完整的实验证据支持，包括密钥生成性能、签名生成与验证性能、静态与动态内存占用、MQTT消息开销、端到端延迟以及可持续吞吐量等关键指标。为后量子密码学在资源受限IoT设备上的部署提供了系统化的性能基准。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 完成论文结果章节的深入分析和讨论部分
  2) 优化方法论章节的技术细节和实验设计描述
  3) 进行论文全文的学术化审查和语言优化
])

#v(1em)

= ML-DSA实验数据收集工作

== 计算性能数据收集

完成了ML-DSA算法在ARM Cortex-M4微控制器上的完整计算性能测试，系统性地量化了三个关键密码学操作的性能特征。密钥生成性能测试覆盖了ECDSA P-256基准算法与ML-DSA三个参数集的对比分析。#bluet[实验数据显示ML-DSA-44参数集的密钥生成需要25,368,000个时钟周期（151.0毫秒），相对于ECDSA P-256的252,000个时钟周期（1.50毫秒）产生了100.7倍的计算开销]。ML-DSA-65和ML-DSA-87参数集分别需要41,832,000和59,976,000个时钟周期，对应的计算开销分别为166.0倍和238.0倍，清晰地展现了后量子安全性与计算性能之间的权衡关系。

签名生成性能测试针对10字节、50字节和100字节三种不同消息载荷规模进行了系统化评估。数据表明签名生成操作构成了ML-DSA算法的主要计算瓶颈，ML-DSA-44处理10字节载荷需要110,376,000个时钟周期（657.0毫秒），相比ECDSA P-256的1,544,400个时钟周期（9.19毫秒）产生了71.5倍的性能开销。载荷规模的增加对ML-DSA性能影响相对有限，100字节载荷下ML-DSA-44的执行时间仅增加至669.0毫秒，显示了算法性能主要取决于核心密码学操作而非消息处理。签名验证性能测试同样覆盖了三种载荷规模，ML-DSA-44验证10字节载荷需要69,888,000个时钟周期（416.0毫秒），相对ECDSA P-256的2,688,000个时钟周期（16.00毫秒）产生26.0倍开销，验证操作的相对性能优于签名生成操作。

== 内存利用数据收集

内存利用分析从静态和动态两个维度完整量化了ML-DSA算法的内存需求特征。静态内存占用测试评估了Flash存储器中代码段和数据段的空间需求。#bluet[ECDSA P-256实现需要9.7 KB总存储空间（8.2 KB代码，1.5 KB数据），而ML-DSA-44单参数集实现需要37.2 KB（32.4 KB代码，4.8 KB数据）]，存储空间需求增加了3.8倍。ML-DSA-65和ML-DSA-87参数集的静态内存需求分别为54.8 KB和73.9 KB，支持全部三个参数集的完整实现需要112.7 KB存储空间，相对ECDSA基准增加了11.6倍，这对资源受限的IoT设备Flash容量提出了实际约束。

动态内存分析量化了SRAM运行时内存的峰值需求，涵盖了栈空间峰值、密钥存储和操作缓冲区三个组成部分。实验数据显示ECDSA P-256运行时需要2.1 KB SRAM（0.8 KB栈峰值，0.1 KB密钥存储，1.2 KB缓冲区），而ML-DSA-44需要22.7 KB SRAM（6.4 KB栈峰值，3.8 KB密钥存储，12.5 KB缓冲区），动态内存需求增加了10.8倍。ML-DSA-65和ML-DSA-87的SRAM需求分别达到32.8 KB和43.1 KB，接近甚至超过了典型ARM Cortex-M4微控制器的SRAM容量限制（通常为64-128 KB），这对算法在低端IoT设备上的实际部署构成了关键约束因素。

== 协议级开销数据收集

协议级性能评估系统性地量化了ML-DSA集成对MQTT消息传输的实际影响，涵盖了消息大小开销、端到端延迟和可持续吞吐量三个关键网络性能维度。MQTT消息大小分析对比了签名消息与未签名消息的字节开销。#redt[对于10字节消息载荷，ECDSA P-256签名后消息大小为82字节（4.6倍开销），而ML-DSA-44签名后消息达到2,438字节（135.4倍开销）]，显示了后量子签名方案的大签名尺寸特征。随着载荷增大至100字节，ML-DSA-44的相对开销降低至23.4倍，但绝对消息大小仍达2,528字节。ML-DSA-65和ML-DSA-87对10字节载荷产生的消息开销分别为184.8倍和258.1倍，对应的签名消息大小为3,327字节和4,645字节，这对带宽受限的IoT网络环境构成了实质性挑战。

端到端延迟分析量化了从消息发布到验证完成的完整通信周期，包括签名生成时间、网络传输延迟和签名验证时间三个组成部分。基于50字节载荷的测试数据显示，ECDSA P-256的端到端延迟为54.1毫秒（9.39毫秒签名，28.5毫秒网络传输，16.20毫秒验证），而ML-DSA-44的总延迟达到1,114.2毫秒（663.0毫秒签名，31.2毫秒网络传输，420.0毫秒验证），总延迟增加了20.6倍。ML-DSA-65和ML-DSA-87的端到端延迟分别为1,419.8毫秒（26.2倍开销）和1,883.4毫秒（34.8倍开销），延迟主要由签名生成和验证操作的计算时间主导，网络传输时间因大签名尺寸仅略有增加。

可持续吞吐量测试量化了连续操作模式下的消息发布速率，识别了系统可扩展性的计算瓶颈。实验数据确认签名生成操作构成了所有ML-DSA参数集的主要性能瓶颈。ECDSA P-256可维持104-109条消息每秒的吞吐量，而ML-DSA-44、ML-DSA-65和ML-DSA-87的可持续吞吐量分别降低至1.49-1.52、1.16-1.18和0.87-0.89条消息每秒，相对ECDSA基准分别产生70-72倍、90-92倍和120-122倍的吞吐量降低。这一量化结果直接限制了ML-DSA在高频率传感器网络部署中的可行性，要求系统架构设计必须考虑吞吐量约束对应用场景的适用性。

= 论文写作

完成了论文Results and Analysis章节中六个核心性能分析表格的完整数据填充工作。密钥生成性能表（tab:keygen-performance）、签名生成性能表（tab:sign-performance）和签名验证性能表（tab:verify-performance）系统化地呈现了计算性能维度的定量证据。静态内存占用表（tab:static-memory）和动态内存需求表（tab:dynamic-memory）完整量化了内存利用特征。MQTT消息开销表（tab:message-overhead）、端到端延迟表（tab:e2e-latency）和可持续吞吐量表（tab:throughput）全面展现了协议级性能影响。


// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
