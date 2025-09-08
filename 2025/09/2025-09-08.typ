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
    周报 向嘉豪(#datetime.today().display("[year]-[month]-[day]"))
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
#redt[本周完成大论文三个核心论文章节中文翻译]。第三章CRAFT算法实现：串行架构面积减少10.16%，展开架构吞吐量提升40.53%。第四章32位处理器SPN密码：指令数减少64.3%，BGC编码加速3.19倍，AES和QARMAv2性能分别改进9.7%和67.6%。第五章GPU SLH-DSA并行架构：实现62,239签名/秒，性能提升1.16倍。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 继续第四篇论文的撰写工作。
  2) 开展后翻译阶段工作，包括全面技术审查、章节间逻辑整合、术语标准化统一，以及大论文最终稿的质量保障工作。])

#v(1em)

= 大论文 三个核心章节翻译

== 第三章：CRAFT密码算法高效实现方法研究

本周完成了第三章的全面中文翻译工作，该章节系统性阐述了CRAFT轻量级密码算法的高效实现方法研究。翻译内容涵盖了FPGA平台上的串行和展开架构实现方案，以及基于SAT求解器和GEC编码的S盒优化技术。通过精确的技术术语转换和学术语言规范化，确保了中文版本完整保持了原有的技术深度和研究贡献。

#bluet[FPGA实现架构翻译] 系统性翻译了串行架构和展开架构两种不同的FPGA实现方案。串行架构的翻译重点强调了其在硬件资源占用方面的优化特性，通过详细的中文技术描述展现了10.16%的面积减少效果。展开架构的翻译则着重体现了并行处理能力的增强，准确传达了40.53%的吞吐量提升这一关键性能指标。

#greent[S盒优化技术的中文表述] 完成了基于SAT求解器和GEC(Gray Equivalence Class)编码的S盒优化方法的专业翻译。这一部分的翻译工作特别注重了密码学专业术语的准确性，确保了技术概念在中文语境下的精确传达。GEC编码优化策略的中文阐述清晰地展现了该技术在硬件实现中的创新价值。

== 第四章：32位处理器上SPN密码的Bitsliced低延迟实现

第四章的翻译工作聚焦于32位处理器平台上SPN(Substitution-Permutation Network)密码的Bitsliced实现技术。该章节的中文翻译全面涵盖了置换优化算法、增强BGC编码技术，以及在AES和QARMAv2算法上的具体性能改进成果。翻译过程中特别注重了技术实现细节的准确传达和性能指标的量化表述。

#redt[置换优化算法的技术突破] 完成了置换优化算法部分的深度翻译，该算法实现了64.3%的指令数减少这一显著成果。中文翻译准确传达了该算法在32位处理器环境下的技术创新性，特别是在指令级优化方面的突破性贡献。通过精确的技术语言转换，确保了算法的核心思想和实现策略在中文版本中的完整体现。

#bluet[增强BGC编码性能提升] 系统性翻译了增强BGC编码技术及其3.19倍的性能加速效果。这一部分的翻译工作特别关注了编码技术的理论基础和实际应用效果的平衡表述，确保中文读者能够准确理解该技术的创新点和实用价值。BGC编码在S盒实现中的优化作用通过详细的中文技术描述得到了充分展现。

#greent[AES和QARMAv2性能验证] 完成了AES算法9.7%性能改进和QARMAv2算法67.6%性能提升的详细翻译工作。这一部分的中文表述重点强调了实验验证的严谨性和结果的可信度，通过准确的性能指标翻译展现了研究工作的实际应用价值。

== 第五章：GPU上SLH-DSA的线程自适应优化并行架构

第五章的翻译工作涵盖了后量子密码学领域的GPU加速实现技术，重点阐述了SLH-DSA(Stateless Hash-based Digital Signature Algorithm)的线程自适应分配(ATA)和函数级并行化(FLP)优化策略。该章节的中文翻译完整保持了后量子密码学的技术严谨性和GPU并行计算的专业深度。

#redt[线程自适应分配技术的创新翻译] 系统性完成了Thread-Adaptive Allocation(ATA)技术的中文翻译，该技术是实现GPU高效并行计算的核心创新。翻译工作特别注重了自适应分配机制的技术原理阐述，确保中文读者能够准确理解该技术在GPU资源优化中的关键作用。ATA技术与传统并行策略的对比分析通过详细的中文技术描述得到了充分体现。

#bluet[函数级并行化策略实现] 完成了Function-Level Parallelization(FLP)技术的专业翻译，该技术进一步增强了GPU并行计算的效率。FLP技术的中文表述重点强调了其在后量子密码算法中的特殊适用性，以及与ATA技术结合时产生的协同优化效果。通过精确的技术术语转换，确保了该技术在中文学术语境下的准确传达。

#greent[性能验证和先进性对比] 系统性翻译了62,239签名/秒的性能成果和1.16倍的先进性改进指标。这一部分的中文翻译特别注重了性能评估方法的严谨性表述和对比实验的公正性说明。通过详细的性能数据翻译和技术对比分析，充分展现了研究工作在后量子密码GPU加速领域的贡献价值。


// Bibliography section
// #bibliography("../../paper/ThirdPaper/tex/biblio.bib", style: "apa")
