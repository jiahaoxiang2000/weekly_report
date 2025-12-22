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
    周报 向嘉豪(2025-12-22)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周#redt[ML-DSA论文全文内容精炼与学术表达优化]，系统改进Introduction、Related Work、ML-DSA Algorithm、Implementation Architecture及Experimental Methodology章节的文本清晰度与技术准确性。#bluet[重点优化包括：贡献陈述重构为具体可测量的技术指标、冗余表述消除、被动语态规范化应用、以及技术参数的精确量化表达]。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 完善Results章节实验数据分析
  2) 补充Conclusion章节撰写
])

#v(1em)

= Introduction章节优化

完成了Introduction章节的内容精炼，#bluet[将原有冗长表述压缩为简洁的技术陈述]。IoT系统部署挑战描述从"fundamentally constrain cryptographic implementation choices"简化为"constrain cryptographic implementation choices"，消除不必要的强调副词。MQTT协议性能影响描述从"exhibits severe performance degradation when post-quantum signatures introduce prohibitive overhead"修订为"experiences performance degradation when post-quantum signatures introduce overhead"，避免主观程度判断词汇。

#bluet[研究贡献陈述重构为具体可测量的技术指标]：Computational Performance Benchmarking从泛化描述改为"Cycle-accurate measurements of ML-DSA signature operations on ARM Cortex-M4 microcontrollers at 168 MHz, quantifying execution latency and throughput across all three standardized parameter sets"；Memory Utilization Analysis改为"Static and dynamic memory profiling measuring Flash storage requirements, stack consumption, and peak SRAM utilization during signature operations"；Protocol-Level MQTT Integration Assessment改为"End-to-end latency and message size overhead evaluation within MQTT publish-subscribe workflows, comparing ML-DSA against ECDSA P-256 baseline"。

= Related Work章节改进

完成了Related Work章节的学术表达规范化。#bluet[消除冗余连接词与过度修饰]：开篇从"While conventional network protocols have undergone extensive analysis"简化为"Conventional network protocols have undergone post-quantum migration analysis"，同时明确指出"IoT-specific communication protocols remain underexplored"作为研究空白。

ML-DSA Performance Benchmarks小节精简了Banegas等人研究的描述，从"quantified these performance implications through comprehensive benchmarking"改为直接陈述"benchmarked CRYSTALS-Dilithium on embedded systems"。pqm4基准测试描述整合引用格式，将分散的性能数据统一为连贯的技术陈述。

Deployment Bottlenecks小节改进了安全漏洞描述的技术准确性，#bluet[将Marchsreiter研究结果从泛化描述改为具体的"order-of-magnitude transaction throughput reductions on embedded blockchain nodes"量化表述]。Alternative Approaches小节将Barrett乘法优化的性能提升数据格式统一为"1.38--1.51"和"6.37--7.27"的标准化表示。

= ML-DSA Algorithm章节技术表述优化

完成了ML-DSA Algorithm Characteristics小节的技术参数精确化。#bluet[拒绝采样迭代次数描述从泛化的"expected iteration counts of 4.25, 5.1, and 3.85 across parameter sets"改为明确的"expected iteration counts of 4.25, 5.1, and 3.85 for ML-DSA-44, ML-DSA-65, and ML-DSA-87 respectively"]，建立参数集与迭代次数的直接对应关系。密钥尺寸范围采用标准化单位表示"1.3--4.9\,KB"。

Signing Algorithm Structure小节优化了算法描述的简洁性。#bluet[签名过程概述从"The signing wrapper (Algorithm~\ref{alg:mldsa-sign}) processes context strings"改为"Algorithm~\ref{alg:mldsa-sign} presents the signing wrapper, which processes context strings"]，采用更直接的算法引用方式。确定性签名变体描述从"this randomness is substituted with zeros to enable reproducible signatures"简化为"deterministic variants substitute zeros for reproducible signatures"。

Signing Performance Bottlenecks小节精简了性能瓶颈描述。NTT Computational Dominance从详细的周期数描述"reference NTT implementations consume 2.5-3.0 million cycles per transformation"压缩为"Reference Cortex-M4 implementations consume 2.5--3.0 million cycles per NTT"，消除冗余的"establishing NTT as the dominant computational primitive"结论性陈述。

= Implementation Architecture与Methodology章节改进

完成了Implementation Architecture章节的表述简化。#bluet[章节引言从"This section presents the system architecture for ML-DSA signature integration within MQTT-based IoT communication frameworks. The implementation encompasses hardware platform configuration, software stack organization, and protocol-level integration patterns enabling post-quantum authenticated messaging on resource-constrained devices"压缩为单句"This section presents the system architecture for ML-DSA signature integration within MQTT-based IoT communication frameworks, encompassing hardware platform configuration, software stack organization, and protocol-level integration patterns"]。

Hardware Platform Architecture小节统一了技术参数格式，#bluet[将"168 MHz system clock frequency"改为"168\,MHz"，"1 MB Flash memory"改为"1\,MB Flash memory"，"192 KB SRAM"改为"192\,KB SRAM"]，采用标准化的数值与单位间距表示。

Experimental Methodology章节开篇精简为"The experimental framework evaluates ML-DSA integration within MQTT-based IoT systems through performance benchmarking on ARM Cortex-M4 microcontrollers, memory utilization analysis, and protocol-level overhead assessment"，消除"comprehensive"、"systematic"等主观修饰词，保持客观技术陈述风格。

// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
