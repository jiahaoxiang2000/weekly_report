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
本周主要完成的审稿意见系统性回复工作。针对编辑和两位审稿人提出的关键问题进行了深入分析和响应。#redt[重点突破在于S-box编码方法创新性的明确阐述和NIST轻量级密码学标准适用性讨论的扩展]。完成了语言校对和参考文献更新工作，审稿人意见4和5已全部完成。当前正在推进审稿人意见1、2、3的详细回复，包括与现有SAT方法的实验对比、轻量级密码算法适用性分析以及公平性实验设计。#bluet[通过初步实验验证，我们的方法在QARMAv2 4-bit S-box优化上相比Feng等人的方法实现了4.3倍的性能提升]。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[本周计划]

  1. 完成审稿人1所有意见的详细回复：
     - 完善S-box编码方法与现有SAT方法的对比实验和数据表格
     - 扩展NIST轻量级密码学标准适用性讨论
     - 实施[23] [21]公平的性能比较实验，确保相同硬件平台条件

  2. 基于审稿人1意见完成情况，综合回复编辑的整体关注点

])

= 回复审稿意见

== 编辑意见

"The reviewers' main concerns revolve around the novelty and contributions of the paper. To address these, please focus on: #oranget[【待完成-依赖审稿人1所有意见完成】]
- Clearly articulating the novel contribution.
- Discussing the applicability of the technique to NIST standards.
- Revising the comparison with table-based implementations to ensure a fair evaluation.
- Updating the references and improving the overall writing quality."

编辑提出的主要关注点包括新颖性阐述、NIST标准适用性、实验比较公平性和整体写作质量。由于编辑意见实际上是#redt[对审稿人1各项意见的总结]，因此我们的策略是先完成审稿人1的所有具体意见，然后基于这些具体回复来综合回应编辑的整体关注点。


== 审稿人1

审稿人1对论文的两项技术贡献给予了积极评价，但指出了几个需要改进的重要问题：

*审稿人意见1：*"Unlike the first contribution, the second contribution that aims to optimize the S-box implementation, is not clearly described. In particular, it is unsure which part of III.B is novel, compared to existing work, which requires a #redt[more detailed comparison]." #oranget[【正在进行】]

目前，我们初步测试了Feng[24]和我们的方法在QARMAv2 4-bit S-box 20个串行排列上的时间分别是2101和486秒，测试环境为100线程下cryptominisat求解。
数据完善后，我们将在#bluet[实验章节添加结果数据表]，同时在#bluet[第二章中添加SAT的相关背景介绍]。

*审稿人意见2：*"It seems like the technique is only applicable to certain block ciphers that are similar to AES. How about more recent NIST lightweight cryptography schemes? The authors are #redt[encourage to discuss] this aspect in detail." #oranget[【正在进行】]

#bluet[添加讨论章节]，包括对Ascon、Elephant、ISAP等入围算法的适用性分析。去详细解释最优排列排序算法如何应用于不同的结构，以及S-box优化技术如何适配5位、8位等不同位宽的变化。

*审稿人意见3：*"It is unfair to say that #redt[table based implementation is faster than bitsliced implementation] by comparing [23] with [21]. They are using a completely different processor, so it is natural to have very different performance. Moreover, availability of registers is also key to the performance of bitsliced implementation, which can be very different for various processor architectures." #oranget[【正在进行】]

此处审稿人指出的是通过[23]与[21]的对比，不能说明比特切片下AES算法比表实现要慢的结论。而我们的核心在于，对现有比特切片实现的优化，因此该问题不是对我们工作的直接批评，而是对现有文献的比较方式，提出了质疑。我们将#bluet[在实验章节中添加更公平的比较，确保相同环境下对比[23]和[21]]。

*审稿人意见4：*"This article needs proofreading. Some obvious errors can be found easily. For example, pg. 6 first sentence, it should be 'An encoding method....' Ref[12] is also not formatted correctly in the last page." #bluet[【已完成】]

语言质量的全面提升通过系统性校对得以实现。修正了"A encoding method"到"An encoding method"的语法错误，纠正了处理器名称从"Tensilica LX"到"Xtensa LX"的技术准确性问题。参考文献[12]的格式也已修正，确保符合期刊要求。

*审稿人意见5：*"Reference [8] seems to be old, there are other more recent GPU implementations of bitsliced AES." #bluet[【已完成】]

已按照审稿人建议更新了相关参考文献，使用更新的GPU实现研究来替换过时的引用。

== 审稿人2

审稿人2对论文给予了积极评价，表示接受我们的工作。



// Bibliography section

// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
