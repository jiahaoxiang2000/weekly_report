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
本周使用#bluet[NVIDIA Nsight Compute]完成了全面的GPU硬件级性能剖析工作。通过系统性的硬件级分析，成功创建了Table.V GPU Hardware Profiling Metrics，展示了从基准实现到ATA再到ATA+FLP的渐进式性能改进。完成了对审稿意见p1.2、p2.3和p3.2的详细技术回应，提供了计算利用率、内存利用率、缓存行为和SM占用率等关键硬件指标的定量分析。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  完成论文最终修订整合工作, 目标是在下周内完成第三篇论文的完整修订并准备重新提交。
])

#v(1em)

= GPU硬件级剖析完成

== NVIDIA Nsight Compute性能剖析实施

本周的核心工作集中于使用NVIDIA Nsight Compute进行全面的GPU硬件级性能剖析，这是回应审稿意见p1.2的关键要求。通过系统性的剖析方法学，我们获得了详细的硬件资源利用率数据，量化了Thread-Adaptive allocation和Function-Level Parallelism两种核心技术在GPU硬件层面的优化效果。

#bluet[剖析方法学和数据收集] 使用NVIDIA Nsight Compute工具对RTX 4090平台进行了三个阶段的性能剖析：基准实现（Wang et al. 2025）、应用ATA技术后的优化版本，以及最终的ATA+FLP完整优化版本。剖析过程覆盖了计算单元利用率、内存子系统性能、缓存行为、SM占用率等关键硬件指标，确保了硬件级验证的全面性和准确性。

#greent[Table.V 创建和硬件指标量化] 成功创建了GPU Hardware Profiling Metrics表格，展示了渐进式优化的量化效果。计算利用率从基准的68.3%提升至ATA的78.9%，最终达到ATA+FLP的84.7%。内存利用率相应地从72.1%改进至81.2%再到87.4%。内存带宽利用率从584.7 GB/s提升至758.9 GB/s，实现了29.8%的内存子系统效率改进。

== 审稿意见p1.2、p2.3、p3.2回应完成

*p1.2 GPU剖析指标分析回应*

针对审稿意见p1.2关于GPU剖析指标的要求，我们提供了全面的硬件级评估数据。#bluet[SM占用率分析]显示了从基准的63.4%到ATA优化的74.8%再到最终ATA+FLP的81.3%的显著改进。平均每SM的warp数量从48.2增加至62.4，直接关联了观察到的1.16×吞吐量改进，证明了我们的架构优化如何转化为可测量的硬件资源利用率提升。

#greent[L2缓存效率验证]展示了从76.2%到89.1%命中率的改进，验证了我们在GPU内存层次结构中的内存访问优化策略。这一缓存行为的改进直接支持了我们关于内存访问模式优化的技术声明，为硬件级验证提供了定量证据。

*p2.3 硬件级评估与缓存/占用率数据*

完成了审稿意见p2.3要求的硬件级评估工作，提供了详细的缓存行为、占用率和执行分解指标。#redt[端到端执行分解]数据显示了跨计算单元的渐进式利用率改进：计算利用率从68.3%提升至84.7%，内存利用率从72.1%推进至87.4%。内存吞吐量效率在优化实现中达到76.5%，证明了对RTX 4090 GDDR6X内存子系统的有效利用。

*p3.2 内存影响和可扩展性分析*

针对审稿意见p3.2关于大规模内存影响的关注，我们进行了全面的内存分析工作。#bluet[内存利用率效率]从基准的72.1%进步至优化版本的87.4%，同时内存带宽利用率从584.7 GB/s增加至758.9 GB/s。

#greent[可扩展性特征分析]特别体现在L2缓存优化结果中，显示了从76.2%到89.1%的命中率改进。这一增强的缓存效率减少了主内存压力，实现了更有效的扩展行为。我们的Thread-Adaptive分配策略通过优化的线程到内存映射解决了内存争用问题，而Function-Level Parallelism通过战略性共享内存利用减少了内存访问延迟。


// Bibliography section
// #bibliography("../../paper/ThirdPaper/tex/biblio.bib", style: "apa")
