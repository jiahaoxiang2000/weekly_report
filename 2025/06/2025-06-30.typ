#import "@preview/basic-document-props:0.1.0": simple-page

// Chinese font configuration
#set text(
  font: (
    "Noto Sans CJK SC", // Primary Chinese font
    "Noto Serif CJK SC", // Alternative Chinese serif font
    "Noto Sans", // Latin fallback
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

// Heading styles
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
    周报 向嘉豪(#datetime.today().display("[year]-[month]-[day]"))
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周分析了ML-DSA FIPS-204标准的数学基础与工程实现，深入阐述了基于模格密码学的数字签名算法在后量子密码学标准化进程中的关键作用。通过对环$R_q = Z_q[X]/(X^{256} + 1)$上多项式运算机制和Fiat-Shamir启发式变换的理论研究，完成了六个核心功能模块的架构设计。在学术研究方面，#redt[建立了物联网环境下MQTT协议与ML-DSA算法优化集成的完整研究框架]，通过理论分析与实验验证相结合的方法论，为资源受限设备的后量子认证机制提供了系统性的技术解决方案和学术贡献。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[本周计划]
  1) 完整实现ML-DSA FIPS-204标准的核心算法模块
  2) 完成ML-DSA在ARM Cortex-M4平台上的移植优化，验证资源受限环境下的部署可行性
])


= ML-DSA FIPS-204学习与实现

ML-DSA (Module-Lattice-Based Digital Signature Algorithm) FIPS-204标准的学习和实现进展。ML-DSA是基于模格密码学的数字签名算法，为后量子密码学的重要组成部分。

== 核心算法理论学习

通过深入研读FIPS-204标准文档，#redt[系统掌握了ML-DSA的核心技术原理]。在数学基础方面，ML-DSA基于模学习误差问题(Module Learning With Errors, MLWE)，其安全性依赖于求解MLWE问题和模短整数解问题(Module Short Integer Solution, MSIS)的困难性。算法在环$R_q = Z_q[X]/(X^{256} + 1)$上操作，其中$q = 8,380,417$。

在签名机制设计上，该算法采用Fiat-Shamir启发式方法的Schnorr类签名方案，通过拒绝采样技术避免签名泄露私钥信息。签名过程包含承诺生成、挑战计算和响应验证三个关键步骤，确保了签名的安全性和不可伪造性。

标准定义了三个不同的安全级别参数集：ML-DSA-44等效于AES-128安全强度，适用于一般应用场景；ML-DSA-65等效于AES-192安全强度，提供更高的安全保障；ML-DSA-87等效于AES-256安全强度，满足最高安全要求。

== 架构设计与实现

基于对标准的理解，#bluet[完成了ML-DSA的模块化架构设计]，采用Rust语言实现，便于集成进嵌入式系统。

=== 核心模块结构

系统实现了六个核心功能模块。代数运算模块(`algebra.rs`)负责实现环$R_q$上的多项式运算，包括加法、乘法和无穷范数计算等基础操作。数论变换模块(`ntt.rs`)通过NTT优化多项式乘法，使用预计算的单位根显著提高运算效率。密码学原语模块(`crypto.rs`)实现了SHAKE-128/256哈希函数和可扩展输出函数，为算法提供必要的密码学基础。采样模块(`sampling.rs`)实现了均匀采样、高斯采样和拒绝采样算法，确保随机数生成的安全性。编码模块(`encode.rs`)处理多项式和签名的序列化与反序列化，保证数据传输的正确性。提示系统(`hint.rs`)实现了签名压缩的提示机制，有效减少签名大小。

=== 算法流程实现

密钥生成算法首先使用SHAKE-128生成随机矩阵$bold(A)$，然后采样具有小系数的私钥向量$bold(s)_1, bold(s)_2$，最后计算公钥$bold(t) = bold(A)bold(s)_1 + bold(s)_2$。整个过程确保了密钥对的正确性和安全性。

签名生成过程采用概率性方法，首先采样随机向量$bold(y)$并计算承诺$bold(w) = bold(A)bold(y)$，然后从消息和承诺中生成挑战$c$，接着计算响应$bold(z) = bold(y) + c bold(s)_1$。为确保安全性，算法应用拒绝采样技术，只有满足特定条件的签名才会被接受，有效防止私钥信息泄露。

签名验证算法通过重构验证值并检查边界条件来验证签名的有效性。验证过程包括挑战一致性检验和提示正确性验证，确保签名确实由相应私钥生成且未被篡改。


= 论文写作

== 引言部分的深化完善

通过广泛的文献调研，引言部分整合了多个研究领域的最新成果，包括Banegas等人关于ARM Cortex-M处理器上CRYSTALS-Dilithium性能基准测试的开创性工作，Li等人关于格基密码学电磁故障注入攻击的安全性分析，以及Kim和Seo关于MQTT协议后量子认证机制的初步探索。这些文献不仅为本研究提供了坚实的理论基础，也明确了现有研究的局限性和改进空间。

== 章节架构的系统化设计

基于研究内容的逻辑关系和学术论文的标准结构，#bluet[确定了七个主要章节的组织框架]。Introduction章节已完成并经过多次修订，确保了研究动机的清晰表达和问题定义的准确性。Background and Related Work章节将系统回顾后量子密码学发展历程、ML-DSA算法的技术细节、IoT安全挑战以及MQTT协议的安全扩展机制。ML-DSA Algorithm Overview章节将深入阐述算法的数学基础、安全性分析和标准化参数选择。Implementation Architecture章节将详细描述针对资源受限设备的优化实现策略。Experimental Methodology章节将说明性能测试平台搭建和基准测试设计。Results and Analysis章节将呈现实验数据并进行深入分析。Conclusion章节将总结研究贡献并展望未来研究方向。


// Bibliography section

// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
