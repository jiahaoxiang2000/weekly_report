#import "@preview/basic-document-props:0.1.0": simple-page

// Chinese font configuration
#set text(
  font: (
    "Noto Serif CJK SC",
    "Noto Sans CJK SC",
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
    周报 向嘉豪(2025-09-15)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
#redt[本周完成第四篇论文重构工作和ML-DSA密码第一阶段完整实现]。论文方面：重构引用部分以全面涵盖资源受限MQTT环境中的ML-DSA数字签名方案，扩展相关工作章节并完善IoT后量子密码性能分析，识别关键研究空白。代码实现方面：#bluet[完成ML-DSA基础层全部核心组件]，包括域运算、多项式编码、数论变换等关键算法模块。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 继续第四篇论文的撰写工作。
  2) 开展ML-DSA第二阶段核心算法层开发，实现ML-DSA密钥生成、签名和验证算法。])

#v(1em)

= 第四篇论文撰写进展

== 论文结构优化与重构工作

本周针对第四篇论文进行了系统性的结构优化和内容重构工作。重构工作主要聚焦于资源受限MQTT环境中ML-DSA数字签名方案的理论框架完善和技术路径清晰化，确保研究内容与当前后量子密码学发展趋势保持高度一致。

#redt[引用部分深度重构] 对论文抽象进行了全面重构，确保内容清晰且全面覆盖了资源受限MQTT环境中ML-DSA数字签名的核心技术贡献。重构后的抽象更加精确地阐述了研究问题的关键性、技术方案的创新性以及实验验证的系统性。通过优化技术术语表述和逻辑关系梳理，使引用部分能够准确传达研究工作在后量子IoT安全领域的重要价值。

#bluet[相关工作章节扩展与完善] 系统性扩展了相关工作章节，增加了后量子密码学在IoT环境中的详细性能分析内容。该章节的扩展工作重点关注了现有研究在资源受限设备上的技术局限性，以及ML-DSA算法在MQTT协议环境下的适用性分析。通过对比研究和技术gap分析，为本研究的创新点提供了坚实的理论基础和技术背景支撑。

== ARM Cortex-M4性能分析框架

确立了以ARM Cortex-M4微控制器为核心的性能分析框架，该框架针对资源受限IoT设备的特殊需求进行了专门设计。ARM Cortex-M4作为典型的IoT边缘计算平台，其32位架构和有限的计算资源为ML-DSA算法的高效实现提出了严峻挑战。性能分析框架的建立为后续实验设计和技术验证提供了标准化的评估基础。

#greent[研究空白识别与技术路径规划] 通过文献调研和技术分析，明确识别了后量子IoT部署领域的关键研究空白。当前研究主要集中在高性能计算平台上的后量子算法实现，而针对资源严重受限的IoT设备的专门优化研究相对缺乏。基于这一gap分析，制定了涵盖算法优化、内存管理、功耗控制等多维度的技术路径规划。

= ML-DSA-RS密码库实现进展

== 第一阶段基础层架构完成

本周完成了ML-DSA密码库第一阶段基础层的全部核心组件实现工作。成功构建了完整的密码学基础设施框架。该阶段的实现工作为后续ML-DSA核心算法的开发提供了稳固的技术基础和标准化的接口规范。

#redt[Phase 1.1 基础工具组件实现] 完成了module_lattice/util.rs中的核心工具组件开发，实现了Truncate、Flatten和Unflatten三个关键trait。Truncate trait提供了安全的整数截断功能并包含unsafe优化实现，确保了在保证内存安全的前提下实现最优性能。Flatten trait实现了嵌套数组到平坦数组的高效转换，Unflatten trait则提供了逆向的数组分割功能。所有工具组件均通过了完整的测试验证(7/7测试全部通过)。

#bluet[Phase 1.2-1.3 域运算与编码框架] 系统性实现了完整的域运算和编码框架基础设施。Field trait采用Barrett约简算法实现了高效的模运算功能，Elem结构体封装了域元素的所有算术操作。构建了涵盖Polynomial、Vector、NttPolynomial、NttVector、NttMatrix等核心数据类型的完整类型系统。define_field!宏提供了创建具体域实现的标准化接口，ArraySize trait结合typenum实现了编译时大小验证机制。

#greent[FIPS标准编码算法支持] 实现了符合FIPS 203/204标准的SimpleBitPack编码算法支持。EncodingSize trait提供了位级多项式编码/解码功能，VectorEncodingSize trait实现了向量编码并集成了flatten/unflatten操作。编码框架支持完整的往返编码/解码测试验证，确保了数据完整性和算法正确性。所有第一阶段基础层任务已全面完成，为第二阶段核心算法开发奠定了坚实基础。

// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
