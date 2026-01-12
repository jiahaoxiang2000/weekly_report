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
    周报 向嘉豪(2026-01-12)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周#redt[完成硕士学位论文第一章绪论与第二章基础知识的撰写工作]。论文围绕SPN结构密码的软硬件优化实现展开研究，第一章绪论部分完成了选题背景及研究意义的阐述、国内外研究现状的综述以及三个主要研究方向的介绍；#bluet[第二章完成了SPN结构密码基本原理、密码算法的软件实现技术和硬件实现技术三个方面的基础知识论述]，为后续章节的具体优化实现方法奠定了理论基础。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  继续完成第三章面向资源受限环境的CRAFT密码FPGA高效实现的撰写工作
])

#v(1em)

= 第一章绪论撰写

完成了论文第一章绪论部分的撰写工作。#bluet[该章节包括选题背景及研究意义、国内外研究现状和研究内容三个主要部分]。选题背景部分阐述了SPN结构密码在现代分组密码设计中的主流地位及其在物联网安全领域的应用需求。国内外研究现状部分从轻量级密码硬件实现、比特切片密码软件实现和GPU并行密码实现三个方向对相关研究进行了系统综述，涵盖了PRESENT、LED、Midori、GIFT、CRAFT等轻量级密码的设计与实现进展，以及针对32位处理器和GPU平台的优化技术发展。

研究内容部分明确了论文的三个主要研究方向：面向资源受限环境的CRAFT密码FPGA高效实现、面向32位处理器的SPN密码比特切片低延迟实现、以及面向GPU的AES算法线程自适应并行优化实现。每个研究方向均阐述了主要贡献，包括串行与展开两种FPGA架构设计、置换分解算法和改进的门复杂度模型编码方法、以及自适应线程分配和函数级并行化方法等技术创新点。

= 第二章基础知识撰写

完成了第二章SPN结构密码的软硬件优化实现基础知识的撰写工作。#bluet[该章节系统介绍了SPN密码基本原理、软件实现技术和硬件实现技术三个方面的理论基础]。在SPN密码基本原理部分，从数学角度形式化定义了S盒变换和线性变换，详细分析了AES-128的SubBytes、ShiftRows、MixColumns和AddRoundKey四个基本操作的设计原理与实现方式，阐述了SPN结构通过替代层和线性层的协同作用实现Shannon混淆和扩散原理的安全机制。

软件实现技术部分介绍了查找表实现、比特切片实现和SIMD向量化实现三种主要技术路线，分析了各自的优势与局限性。#redt[比特切片技术的核心思想是将密码操作映射到位级布尔运算]，利用处理器的位并行性同时处理多个数据分组，具有高吞吐率和恒定时间执行的优势。硬件实现技术部分介绍了ASIC和FPGA两类平台，详细阐述了迭代架构、串行架构和展开架构三种实现架构的特点与适用场景，分析了S盒的查找表方法和逻辑门电路方法，以及线性层比特置换和矩阵乘法的硬件实现优化策略。

= 论文撰写进展展示

#figure(
  grid(
    columns: 3,
    gutter: 5pt,
    image("figures/thesis_page-06.png"),
    image("figures/thesis_page-07.png"),
    image("figures/thesis_page-08.png"),
    image("figures/thesis_page-09.png"),
    image("figures/thesis_page-10.png"),
    image("figures/thesis_page-11.png"),
  ),
  caption: [第一章与第二章论文页面展示（第1-6页）]
)

#figure(
  grid(
    columns: 3,
    gutter: 5pt,
    image("figures/thesis_page-12.png"),
    image("figures/thesis_page-13.png"),
    image("figures/thesis_page-14.png"),
    image("figures/thesis_page-15.png"),
    image("figures/thesis_page-16.png"),
  ),
  caption: [第二章论文页面展示（第7-11页）]
)

// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
