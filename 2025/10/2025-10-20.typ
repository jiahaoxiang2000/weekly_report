#import "@preview/basic-document-props:0.1.0": simple-page

// Chinese font configuration
#set text(
  font: (
    "Source Han Serif",
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
    周报 向嘉豪(2025-10-20)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
#redt[本周完成第二篇论文R2小修审稿意见Point 2与Point 3核心修订任务]。针对#bluet[QARMAv2基准选择疑问(Point 2)]，在第IV-C2节性能分析部分添加明确基准选型说明，阐述查找表基准作为首个软件位切片QARMAv2实现对比标准的合理性。完成#greent[全部编辑性修订(Point 3)]，修正Sec. II-C术语错误、Fig. 1上标标记、Ref [23]格式问题，补充Table VI组件分类注释。更新审稿意见回复文档，提供Point 2与Point 3详细修订说明。截至目前已完成R2修订5项任务中的2项，余下完成安全性分析(Point 1)、图表质量提升(Point 4)、Default/Baksheesh密码评估(Point 5)。投稿截止时间:10月30日。

#v(1em)

// Week plan box
#rect(
  width: 100%,
  stroke: 1pt,
  inset: 10pt,
  [
    #text(weight: "bold")[下周计划:]
    1) 完成Point 1安全性分析章节撰写，添加位切片恒定时间特性与侧信道防护说明。
    2) 提升Table 1与Figure 4视觉质量，转换矢量图格式确保可读性。
    3) 评估Default/Baksheesh密码实现可行性，确定基准测试或未来工作方案。
    4) 完成审稿意见回复文档全部Response部分撰写。
    5) 最终稿件校对与提交准备工作。
  ],
)

#v(1em)

= 编辑性修订完成(Point 3)


#redt[术语错误修正] 完成Sec. II-C术语修正，将"trivial forms"替换为"transformations"，准确反映线性与非线性变换技术描述。该修正提升论文技术术语准确性，避免读者误解。修改通过`\revised{}`宏标记蓝色高亮，便于审稿人识别修订内容。

#bluet[图表标记统一] 修正Fig. 1图注中上标标记错误，将$b^i_j$统一为$b^j_i$，确保与符号表定义一致。修订后标记表述为"$b^j_i$表示第$j$个块的第$i$位"，消除原有混淆。该修正强化论文符号体系一致性，提升可读性。

#greent[参考文献格式] 更新Ref [23]参考文献格式，将"riscvOVPsim"规范化为"RISC-V OVPsim"，符合RISC-V基金会官方命名规范。该修正体现学术严谨性，确保引用格式专业性。


#bluet[表格组件说明] 为Table VI添加脚注，明确"Others"组件包含数据移动与轮密钥异或操作。脚注内容:"Data movement and round key XOR"，消除审稿人关于组件分类疑问。该补充强化性能分析透明度，便于读者理解周期开销分配。

#redt[文献与专有名词] 验证参考文献[6]、[7]、[22]、[23]无重复条目，确认全部25条引用唯一性。术语一致性决策:保持"bitslicing"单词写法，遵循密码学文献[21]、[22]、[23]惯例。

= QARMAv2基准选择说明(Point 2)

== Baseline阐述

#redt[对比标准缺失] 审稿人Point 2指出QARMAv2查找表基准选择需明确说明。根本原因在于QARMAv2原始论文未提供软件性能评估，本工作提出首个软件位切片QARMAv2实现。文献中不存在可直接对比的位切片实现，需选择合适软件基准建立性能参照。

#bluet[查找表基准合理性] 在Sec. IV-C2性能分析段落添加基准选型原理阐述，说明查找表方法代表分组密码常规软件实现策略。添加内容:"性能评估采用查找表实现作为基准，因文献中不存在可直接对比的位切片QARMAv2实现。查找表方法代表分组密码常规软件实现策略，为评估资源受限平台位切片优势提供有意义基准。"该补充长度2句话，遵循简洁修订原则。


#greent[Response撰写] 在response中为Point 2撰写详细回复说明，包含4项要点:(1)本工作提出首个软件位切片QARMAv2实现，原工作专注硬件无软件性能评估;(2)不存在可直接对比的位切片实现;(3)查找表方法代表常规软件实现策略;(4)QARMAv2硬件导向设计特性利于位切片。回复引用添加内容原文，以蓝色高亮展示修订位置。


= 修订进度与下周重点

== 当前进度总结

截至10月20日，R2小修5项任务完成2项(40%进度)。已完成任务:Point 2 QARMAv2基准说明、Point 3编辑性修订。待完成任务:Point 1安全性分析(需添加位切片恒定时间特性与侧信道防护说明)、Point 4图表质量提升(Table 1格式优化、Figure 4矢量化)、Point 5 Default/Baksheesh密码基准测试(需评估实现可行性)。

== 时间规划

投稿截止时间10月30日，余下10天计划用6天完成3项核心任务。Point 1安全性分析预计1-2天(文献调研、段落撰写、引用整合)。Point 4图表优化预计1-2天(TikZ/Matplotlib重绘、格式调整)。Point 5密码评估预计2天(实现可行性分析、基准测试或未来工作方案确定)。审稿意见回复文档完善与稿件最终校对预计1天。余下4天作为缓冲时间应对突发问题，确保按时提交高质量修订稿件。

// Bibliography section
// #bibliography("../../paper/SecondPaper/biblio.bib", style: "apa")
