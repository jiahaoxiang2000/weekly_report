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
    周报 向嘉豪(2025-12-01)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
本周#redt[完成论文Discussion章节撰写]，涵盖密码学优化实现细节、计算性能分析强化与部署权衡量化三个核心维度。新增Cryptographic Optimization Implementation子章节(84行代码增量)，详述NTT汇编优化在ARM Cortex-M4平台达到28.1%周期降低(320万周期→230万周期)，延迟模约减策略实现15-25% NTT延迟改进，Barrett模约减技术达到25-35%约减开销降低。#bluet[创建ML-DSA参数集归一化比较表(ML-DSA-44作为1.0×基线)]，量化ML-DSA-65相对基线呈现1.30×签名时间、1.37×签名大小、1.45× SRAM开销，ML-DSA-87呈现1.75×签名时间、1.91×签名大小、1.90× SRAM开销。

#v(1em)

// Week plan box
#rect(width: 100%, stroke: 1pt, inset: 10pt, [
  #text(weight: "bold")[下周计划:]
  1) 实现缺失实验数据采集
  2) Results章节补充完善
])

#v(1em)

= 密码学优化实现细节

完成了Cryptographic Optimization Implementation子章节撰写,系统阐述针对ARM Cortex-M4平台ML-DSA签名验证的三类核心优化技术。NTT汇编优化通过手工优化ARM汇编替代编译器生成代码实现性能突破,利用UMULL指令执行32×32→64位乘法生成完整乘积无溢出,支持高效模乘法无中间截断。条件执行消除蝶形循环内分支指令降低流水线停顿惩罚,寄存器分配优化维护旋转因子、多项式系数与中间结果于13个可用于计算的通用寄存器内最小化存储访问。优化NTT实现结构化计算于256元素块匹配Cortex-M4缓存行特征,循环展开因子2-4降低循环开销并通过双发射执行单元利用指令级并行。预计算旋转因子存储于Flash存储器消除运行时幂运算,以2 KB存储换取消除每NTT操作$256 log_2 256 = 2048$次模幂运算。#bluet[性能剖析量化汇编优化影响:参考C实现NTT执行需要320万周期于Cortex-M4 168 MHz,汇编优化实现达到230万周期(28.1%降低),结合逆向NTT优化(类似26-29%改进),聚合签名延迟降低20-30%相对参考实现]。

延迟模约减策略通过跨多个算术操作推迟模约减降低约减频率,解决参考实现采用每操作约减维持系数于$[0, q)$边界内产生的35-40% NTT计算成本占比问题。延迟约减维持中间值于宽松边界$[0, 2q)$或$[0, 4q)$取决于操作序列深度,实现分析ML-DSA算术确立安全延迟约减链。NTT蝶形操作执行$a + b mod q$和$a - b mod q$容忍输入系数达$2q-1$不溢出于32位算术(对ML-DSA模数$q = 8380417$满足$2 dot 2q < 2^(32)$),乘法结果$(a dot b) mod q$伴随输入界限$2q$产生乘积低于$4q^2 < 2^(64)$,适配64位中间表示由UMULL生成。延迟约减链跨2-4个连续加减操作序列推迟约减然后应用单次约减操作,NTT阶段执行成对蝶形操作$(w_j, w_(j+n)) arrow.l (w_j + t, w_j - t)$采用单次约减于两操作后而非每操作约减,减半约减频率。临界路径分析确保系数边界保持于安全范围遍布计算链防止算术溢出。实现达到15-25% NTT延迟降低通过延迟约减策略相对每操作约减基线,结合汇编优化累积NTT性能改进达40-50%。

Barrett模约减技术以基于乘法的方法替代基于除法的模约减解决ARM Cortex-M4缺乏硬件整数除法问题,传统$a mod q$通过$a - q floor(a \/ q)$计算需要12-18周期软件除法实现产生实质开销。Barrett约减预计算$mu = floor(2^(48) \/ q) = 33554431$对ML-DSA模数$q = 8380417$,32位值$a$的约减通过近似商计算$hat(q) = floor((a dot mu) \/ 2^(48))$经32×32乘法和48位右移实现,后续校正步骤$r = a - hat(q) dot q$产生结果$r$满足$0 lt.eq r < 2q$,条件减法生成最终约减值$r' = r < q ? r : r - q$。ARM Cortex-M4实现利用UMULL指令执行$(a dot mu)$乘法提取高32位作为近似商,后续乘法$hat(q) dot q$与减法采用标准32位算术,条件减法采用比较与条件移动指令(CMP、IT、SUB)无分支开销。#redt[Barrett约减集成于NTT实现内替代所有模约减操作,达到25-35%约减开销改进相对基于除法方法],优化对签名生成特别有效(数十万次约减操作)但对密钥生成等不频繁操作提供最小收益。

= 性能分析与部署权衡量化

完成了计算性能分析强化、安全-性能权衡量化与部署可行性评估三个子章节的扩展撰写。计算性能测量采用pqm4库实现整合多项优化技术,所有报告周期计数反映优化实现利用NTT汇编优化(20-30%延迟降低)、延迟模约减(15-25% NTT改进)、Barrett约减模算术(25-35%开销降低)与预计算旋转因子,组合优化技术达到40-50%性能改进相对参考实现,确立ARM Cortex-M4部署性能上界。测量量化可达成性能于激进优化下而非基线参考实现。#bluet[密钥生成性能呈现100.7-238×计算开销相对ECDSA P-256反映固有格基密码复杂度,优化技术对密钥生成操作提供有限改进因其主导于随机多项式采样与矩阵展开而非NTT算术]。测量执行时间151-357毫秒确立设备配置期间不频繁密钥生成可行性,但禁止高频率轮换策略需要次秒密钥派生。签名生成构成NTT优化技术主要受益者,每次拒绝采样迭代需要多个正向NTT与逆向NTT操作用于多项式算术,优化NTT实现降低每迭代计算成本40-50%直接转换为比例签名延迟降低。然而绝对签名延迟657-1150毫秒跨参数集保持70-122×慢于ECDSA尽管激进优化,确立基于签名IoT认证基本性能约束。验证操作受益于预计算旋转因子与优化NTT实现,达到26-44×开销相对ECDSA对比71-122×开销用于签名生成,但绝对验证延迟416-717毫秒超过次秒界限需要交互式IoT应用跨所有参数集。

安全-性能权衡分析章节创建归一化比较表量化ML-DSA-44/65/87参数集增量权衡。#redt[三个ML-DSA参数集呈现量化安全-性能权衡跨计算、存储、协议维度],ML-DSA-44(NIST安全级别2,AES-128等价)达到657 ms签名延迟、416 ms验证延迟、2420字节签名、22.7 KB总SRAM消耗。ML-DSA-65(级别3,AES-192等价)增加这些指标至853 ms签名、533 ms验证、3309字节签名、32.8 KB SRAM,代表29.8%计算开销、36.8%签名大小增加、44.5%存储增加相对ML-DSA-44。ML-DSA-87(级别5,AES-256等价)进一步提升至1150 ms签名、717 ms验证、4627字节签名、43.1 KB SRAM,即72.3%计算开销、91.2%签名大小增加、89.9%存储增加相对ML-DSA-44。归一化表展示ML-DSA-44作为1.0×基线,ML-DSA-65呈现1.30×签名时间、1.27×验证时间、1.37×签名大小、1.45× SRAM,ML-DSA-87呈现1.75×签名时间、1.72×验证时间、1.91×签名大小、1.90× SRAM。对于5-10年操作生命周期的IoT部署于当前量子计算发展轨迹下,NIST安全级别2(ML-DSA-44)提供充分量子抗性伴随最小资源开销。长期基础设施部署(20+年操作生命周期)需要保守安全边际证明ML-DSA-87尽管75-90%资源开销增加,ML-DSA-65占据中间位置适合需要AES-192等价安全无ML-DSA-87最大资源成本的部署。


// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
