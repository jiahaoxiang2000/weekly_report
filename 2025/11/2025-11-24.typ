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
    周报 向嘉豪(2025-11-24)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周完成了ML-DSA签名算法的深入分析与NTT优化策略研究工作。#redt[新增签名算法结构和计算特征章节]，包含签名流程概述（wrapper函数与内部签名程序）、Fiat-Shamir with Aborts范式的拒绝采样机制、数论变换(NTT)正向与逆向算法伪代码。分析ARM Cortex-M4平台四个性能瓶颈（拒绝采样开销、NTT计算主导、模约减开销、哈希函数调用），阐述四类优化策略（NTT汇编优化、延迟模约减、Barrett/Montgomery约减、预计算策略）。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 实现NTT汇编优化或延迟模约减策略
  2) 论文Results and Analysis章节撰写
])

#v(1em)

= 签名算法结构与计算特征分析

完成了ML-DSA签名算法结构和计算特征章节撰写，从算法流程、核心变换和计算复杂度三个维度分析签名操作的计算瓶颈。签名操作包含wrapper函数和内部签名程序两个层级，wrapper函数处理上下文字符串验证（限制255字节）和随机数生成（32字节），确定性变体使用全零随机数实现可重现签名。内部签名程序实现Fiat-Shamir with Aborts范式，展开私钥后进入拒绝采样循环：每次迭代采样掩蔽向量$bold(y)$，计算承诺$bold(w) = bold(A) dot bold(y)$，从承诺哈希推导挑战多项式$c$，评估响应向量$bold(z) = bold(y) + c dot bold(s)_1$。#bluet[响应向量需通过边界检验（阈值$gamma_1 - beta$），超限则重启迭代]。

数论变换(NTT)构成ML-DSA签名的计算核心，实现环$R_q = ZZ_q[X]/(X^256 + 1)$上的高效多项式乘法，其中$q = 8380417$。正向NTT采用Cooley-Tukey蝶形结构，将多项式从系数表示变换到512次本原单位根$zeta = 1753$幂次处的求值表示，通过8个阶段（$log_2 256 = 8$）完成变换，每阶段减半步长。逆向NTT采用Gentleman-Sande蝶形结构配合取反旋转因子，最终乘以缩放因子$f = 8347681 equiv 256^(-1) mod q$归一化输出。#redt[单次NTT执行需要$256 times 8 = 2048$次蝶形操作]，每次蝶形涉及一次模乘和两次模加减，参考实现在每次算术操作后执行模约减。签名流程每次迭代调用多次NTT/INTT：掩蔽向量$bold(y)$的正向NTT、NTT域内矩阵向量乘法$bold(A) dot hat(bold(y))$、承诺计算的逆向NTT，结合拒绝采样迭代（期望次数4.25/5.1/3.85），#bluet[NTT操作在ARM Cortex-M4平台占签名总计算成本的60-70%]。

= 性能瓶颈与优化策略

完成了ML-DSA签名在资源受限平台的性能瓶颈分析与优化策略阐述。性能剖析识别四个主要瓶颈：拒绝采样开销源于Fiat-Shamir with Aborts范式的迭代签名尝试，ML-DSA-44/65/87的期望迭代次数分别为4.25、5.1和3.85，最坏情况可超过20次迭代；NTT计算主导地位明确，参考NTT实现在168 MHz ARM Cortex-M4上每次变换消耗250-300万周期；模约减开销占NTT计算成本的约40%，参考实现采用基于除法的模约减在每次蝶形操作后执行；SHAKE-256哈希函数调用用于矩阵展开、挑战推导和消息哈希，消耗15-20%签名计算量。

针对识别的性能瓶颈，阐述四类优化策略作为后量子嵌入式密码学的研究方向。#redt[NTT汇编优化通过手工优化的ARM汇编实现指令级并行、寄存器分配优化和流水线调度]，利用UMULL指令实现$32 times 32 -> 64$位乘法和条件执行消除分支，相对编译C实现达到20-30%延迟降低。延迟模约减策略通过跨多个蝶形操作推迟模约减降低约减频率，维持中间值在扩展边界内（系数$< 2q$而非$< q$），经过溢出分析后实现15-25% NTT延迟改进。Barrett和Montgomery约减以基于乘法的技术替代基于除法的模约减，Barrett约减预计算$mu = floor(2^48 / q)$通过乘法和移位操作实现约减，Montgomery约减提供高效的融合乘-约减操作，在ARM Cortex-M4上实现25-35%约减开销改进。#bluet[预计算策略将秘密向量$bold(s)_1$、$bold(s)_2$存储为NTT表示消除逐次签名的NTT变换]，以10-13 KB额外Flash存储换取20-25%签名延迟降低，旋转因子预计算（512项，2 KB）消除运行时单位根幂次计算。上述优化技术非互斥，组合实现相对参考实现可达40-50%累积改进，提升ML-DSA在资源受限IoT部署的可行性。

// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
