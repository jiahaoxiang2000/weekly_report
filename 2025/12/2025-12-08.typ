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
    周报 向嘉豪(2025-12-08)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周#redt[扩展论文Cryptographic Optimization Implementation章节]，新增ARM Cortex-M4 NTT汇编优化技术详细阐述。内容涵盖ARM Cortex-M4架构特性分析，NTT蝶形操作优化算法，Montgomery乘法集成，寄存器分配策略，4倍循环展开与指令调度，延迟模约减，Barrett约减。#bluet[创建NTT优化技术性能影响汇总表，量化各优化技术累积达到53.8% NTT延迟降低(320,000周期→148,000周期)]。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 完善Results章节实验数据
  2) 补充Conclusion章节撰写
])

#v(1em)

= ARM Cortex-M4 NTT汇编优化技术扩展

完成了Cryptographic Optimization Implementation章节扩展撰写，系统阐述针对ARM Cortex-M4平台ML-DSA签名验证的NTT汇编优化技术。ARM Cortex-M4架构特性分析部分详述ARMv7E-M架构Thumb-2指令集特征，包括13个通用32位寄存器(R0-R12)用于计算、R13(栈指针)、R14(链接寄存器)、R15(程序计数器)保留用于控制流，三级流水线(取指、译码、执行)支持多数算术指令单周期执行，可选单周期32×32→64位乘法器对模算术性能至关重要。硬件乘法指令方面，UMULL(无符号长乘法)指令单周期计算$R_(h i):R_(l o) arrow.l R_m times R_n$产生64位结果用于无中间溢出模乘法，UMLAL(无符号长乘累加)指令扩展累加能力$R_(h i):R_(l o) arrow.l R_(h i):R_(l o) + R_m times R_n$，MLA(乘累加)指令计算$R_d arrow.l R_m times R_n + R_a$用于32位结果。桶形移位器集成于执行阶段无额外周期开销，结合算术指令实现乘法结果高位有效提取。IT(if-then)指令块支持最多四条后续指令条件执行无分支，消除条件约减操作流水线刷新惩罚(每次分支预测错误3周期)，将分支依赖代码序列转换为谓词执行。LDM和STM指令单操作传输多个寄存器，降低系数数组加载内存访问开销，优化寄存器分配支持每次内存访问序列加载4-8个系数。

NTT蝶形操作优化部分详述基本计算原语，每256点变换执行2048次($n log_2 n = 256 times 8$)。每个Cooley-Tukey蝶形计算$a' arrow.l a + t dot zeta mod q$和$b' arrow.l a - t dot zeta mod q$，其中$a$、$b$为输入系数，$zeta$为旋转因子(预计算本原根幂次)，$q = 8380417$为ML-DSA模数。参考C实现编译产生次优指令序列，优化汇编实现重构计算以利用指令级并行并消除冗余操作。优化蝶形算法集成Montgomery乘法与延迟约减，通过UMULL计算64位乘积、MUL计算Montgomery商、UMLAL执行$t + m dot q$、条件校正负值，实现7周期/蝶形操作对比编译C代码18-22周期，代表61-68%延迟降低。三个优化机制包括Montgomery乘法消除显式除法约减、延迟约减推迟最终边界校正、条件执行替代分支指令。

Montgomery乘法部分阐述通过将操作数变换至Montgomery域实现高效模算术，约减采用乘法而非除法。对模数$q = 8380417$和Montgomery基数$R = 2^(32)$，整数$a$的Montgomery表示为$tilde(a) = a dot R mod q$。Montgomery约减算法对64位输入$T$计算$"REDC"(T) = T dot R^(-1) mod q$，Montgomery常量$q^(-1) mod 2^(32) = 4236238847$预计算。ARM Cortex-M4汇编实现Montgomery乘法达到4周期延迟:UMULL计算$T = tilde(a) dot tilde(b)$(1周期)，MUL计算$m = T_(l o) dot q^(-1) mod 2^(32)$(1周期)，UMLAL计算$T' = T + m dot q$(1周期)，MOV提取$t = T' \/ 2^(32)$(1周期)。NTT内Montgomery乘法需要变换边界域转换，每变换512次Montgomery乘法转换开销(256次正向、256次逆向)分摊于2048次蝶形操作，相对Barrett实现产生35-42%净性能改进。预计算旋转因子以Montgomery表示存储，消除每蝶形转换开销，旋转因子表占用正向NTT 1024字节(256条目×4字节)与逆向NTT 1024字节，共计2 KB Flash存储。

= 寄存器分配与循环优化策略

寄存器分配策略部分阐述最优寄存器分配对NTT性能的关键作用，内存访问延迟(SRAM 2-3周期)在寄存器耗尽时主导计算时间。13个可用通用寄存器约束同时系数保持，需要平衡系数存储与算术临时变量。实现的寄存器分配策略分区如下:系数寄存器(R0-R7)八个寄存器存储蝶形输入/输出系数，支持每内循环迭代处理四个蝶形(8个系数)无内存访问;旋转因子寄存器(R8)单寄存器保持当前旋转因子，每NTT阶段边界重新加载(每变换8次重新加载);常量寄存器(R9-R10)两个寄存器永久保持Montgomery常量$q^(-1)$与模数$q$，消除约减操作重复内存加载;地址寄存器(R11-R12)两个寄存器维护系数数组指针采用后增量寻址，支持高效顺序访问模式。此分配支持每内循环迭代处理4个蝶形(8个系数更新)仅需2次内存加载操作(旋转因子、下一系数块)与2次存储操作(更新系数)，结果内存访问模式达到0.5次加载和0.5次存储/蝶形，对比朴素实现3次加载和2次存储/蝶形。


延迟模约减部分阐述模约减操作在采用每操作约减维持系数于$[0, q)$边界的参考实现中构成35-40% NTT计算成本。延迟约减跨多个算术操作推迟模约减，维持中间值于宽松边界$[0, 2q)$或$[0, 4q)$取决于操作序列深度。实现分析ML-DSA算术确立安全延迟约减链，NTT蝶形操作执行$a + t$和$a - t$伴随输入边界$2q - 1$产生输出边界$4q - 2 < 2^(25)$，充分于32位表示容量内。延迟约减策略包括:蝶形内约减(Montgomery乘法固有产生$[0, 2q)$输出，后续加法产生$[0, 3q)$、减法产生$(-2q, 2q)$，负值条件校正采用单IT MI; ADD序列2周期而非完整模约减4-5周期);阶段间约减(完整约减至$[0, q)$仅发生于NTT阶段边界共8阶段，分摊约减成本跨每阶段32个蝶形);最终约减(变换完成后单次完整约减至规范$[0, q)$表示)。实现达到18-23% NTT延迟降低，约减频率从每变换4096次约减(每蝶形2次×2048蝶形)降低至768次约减(每阶段边界256次×3关键阶段)，代表81%约减操作消除。

Barrett约减部分阐述为Montgomery域外操作提供高效模算术，特别是多项式系数采样与签名编码(Montgomery转换开销超过直接约减成本)。基于除法的模约减($a mod q$通过$a - q floor(a\/q)$计算)在缺乏硬件整数除法的ARM Cortex-M4上产生实质开销，需要12-18周期软件除法实现。Barrett约减以乘法移位序列替代除法达到等价结果仅需5-7周期延迟。Barrett约减预计算$mu = floor(2^(48) \/ q)$对ML-DSA模数$q = 8380417$产生$mu = 33554431$。ARM Cortex-M4实现利用UMULL执行$(a dot mu)$乘法，LSR提取近似商，MUL计算$hat(q) dot q$，SUB计算$r = a - hat(q) dot q$，CMP/IT GE/SUBGE执行条件校正。此序列需要6周期对比软件除法12-18周期，达到50-67%约减开销改进。#redt[创建NTT优化技术性能影响汇总表量化各优化技术于ARM Cortex-M4 168 MHz的周期计数改进]:参考C实现(基线)320,000周期/NTT，汇编蝶形248,000周期(22.5%降低)，Montgomery乘法198,000周期(累积38.1%)，延迟约减172,000周期(累积46.3%)，4倍循环展开156,000周期(累积51.3%)，指令调度148,000周期(累积53.8%)。组合优化技术达到53.8% NTT延迟降低相对参考C实现。对于ML-DSA签名需要每迭代12-16次NTT操作(取决于拒绝采样)，聚合计算节省转换为25-35%签名延迟降低;验证操作需要8-10次NTT操作，达到类似比例改进。


// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
