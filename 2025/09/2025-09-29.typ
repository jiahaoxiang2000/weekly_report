#import "@preview/basic-document-props:0.1.0": simple-page

// Chinese font configuration
#set text(
  font: (
    "Source Han Serif SC",
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
    周报 向嘉豪(2025-09-29)
  ]
]

#v(1em)

#text(size: 14pt, weight: "bold")[摘要:]
#redt[本周完成ML-DSA论文重构优化与后量子MQTT代理技术调研]。论文方面：#bluet[重构第3节ML-DSA与MQTT协议集成内容]，将12个子节合并为4个重点技术节，精简约60%并保持技术准确性。新增4个参考文献强化学术基础，重构三大研究贡献为条目化展示。识别ML-DSA在MQTT协议中的四个关键影响点：TLS证书验证、客户端认证、消息级签名、会话令牌管理。建立MQTT协议基础理论框架，量化分析ML-DSA签名尺寸增长对IoT设备的性能影响。

#v(1em)

// Week plan box
#rect(
  width: 100%,
  stroke: 1pt,
  inset: 10pt,
  [
    #text(weight: "bold")[下周计划:]
    1) 深化ML-DSA论文IoT环境部署优化分析，完善资源受限设备性能评估框架。
    2) 启动ML-DSA实验验证系统设计，准备ARM Cortex-M4微控制器性能基准测试。
  ],
)

#v(1em)

= ML-DSA论文重构优化进展

== 第3节ML-DSA与MQTT协议集成


#redt[节结构优化重组] 系统性重组第3节内容架构，建立4个重点技术节：3.1 ML-DSA算法特征整合数学基础与计算要求，3.2 参数集合与安全性分析保留核心比较表格，3.3 MQTT协议与安全集成合并协议基础与QoS级别，3.4 ML-DSA集成挑战结合性能影响与权衡分析。重构过程通过合并相关内容、消除重复描述、强化技术逻辑链条，实现内容密度的显著提升。

#bluet[学术基础强化与引用优化] 新增4个参考文献以强化学术基础：Khalid2019(IoT量子世界中的格基密码学)、Ghosh2019(IoT轻量级后量子数字签名)、HwangKim2024(多项式乘法优化)、MLDSAHardware2024(ML-DSA硬件实现改进)。

#greent[研究贡献结构化展示] 重构三大研究贡献为条目化列表格式，采用蓝色高亮强化展示效果：计算性能基准测试量化ARM Cortex-M4微控制器上ML-DSA签名操作的计算开销，内存利用分析测量约束环境下ML-DSA部署的静态存储和动态内存模式，协议级MQTT集成评估分析ML-DSA集成对MQTT通信框架的协议级开销影响。条目化展示提升研究贡献的可读性和学术影响力。

= ML-DSA MQTT代理迁移技术分析

== MQTT协议基础与ML-DSA影响分析

#bluet[MQTT协议概述] MQTT(Message Queuing Telemetry Transport)是专为物联网设计的轻量级发布-订阅消息传输协议。协议采用客户端-代理架构，支持多个客户端通过中央MQTT代理进行消息交换。核心特征包括最小化网络带宽占用、减少设备资源需求、提供可靠消息传递机制，使其成为资源受限IoT环境的理想选择。MQTT支持三种服务质量(QoS)级别：QoS 0(最多一次)、QoS 1(至少一次)、QoS 2(恰好一次)，为不同应用场景提供灵活的可靠性保证。

#figure(
  rect(width: 90%, height: 180pt, stroke: 1pt, inset: 8pt)[
    #align(center)[
      #text(size: 13pt, weight: "bold")[MQTT协议中ML-DSA影响点]
    ]
    #v(5pt)
    #grid(
      columns: (1fr, 1.5fr, 1fr),
      rows: (25pt, 25pt, 25pt, 25pt),
      gutter: 4pt,

      // MQTT Client Side
      rect(fill: rgb("#E3F2FD"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt, weight: "bold")[MQTT客户端]
        ]
      ],

      // Connection & Authentication
      rect(fill: rgb("#FFCDD2"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt, weight: "bold")[TLS握手 ❶]
        ]
      ],

      rect(fill: rgb("#E3F2FD"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt, weight: "bold")[MQTT代理]
        ]
      ],

      // MQTT Protocol Layer
      rect(fill: rgb("#E8F5E8"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt)[CONNECT]
        ]
      ],

      rect(fill: rgb("#FFE0B2"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt, weight: "bold")[客户端认证 ❷]
        ]
      ],

      rect(fill: rgb("#E8F5E8"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt)[CONNACK]
        ]
      ],

      // Message Exchange
      rect(fill: rgb("#F3E5F5"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt)[PUBLISH]
        ]
      ],

      rect(fill: rgb("#FFF3E0"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt, weight: "bold")[消息签名 ❸]
        ]
      ],

      rect(fill: rgb("#F3E5F5"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt)[SUBSCRIBE]
        ]
      ],

      // Session Management
      rect(fill: rgb("#E0F2F1"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt)[会话管理]
        ]
      ],

      rect(fill: rgb("#FFEBEE"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt, weight: "bold")[会话令牌 ❹]
        ]
      ],

      rect(fill: rgb("#E0F2F1"), inset: 3pt)[
        #align(center)[
          #text(size: 10pt)[QoS保证]
        ]
      ]
    )
    #v(1pt)
    #text(size: 9pt)[
      #text(weight: "bold")[影响点：] ❶TLS证书 ❷客户端认证 ❸消息签名 ❹会话令牌
    ]
  ],
  caption: [MQTT协议中ML-DSA的四个关键影响点],
)

== ML-DSA在MQTT协议中的迁移角色分析

#redt[MQTT代理数字签名迁移路径] MQTT协议中的数字签名主要应用于TLS握手阶段的服务器认证和客户端证书验证。传统DSA/ECDSA算法在MQTT代理的TLS层承担证书签名验证、消息完整性保护、身份认证等关键安全功能。ML-DSA迁移需要在保持MQTT协议兼容性的前提下，替换底层密码学原语，确保IoT设备与代理之间的安全通信。

#figure(
  rect(width: 100%, height: 220pt, stroke: 1pt, inset: 10pt)[
    #align(center)[
      #text(size: 12pt, weight: "bold")[MQTT协议栈中ML-DSA迁移层次结构]
    ]
    #v(10pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      rows: (40pt, 40pt, 40pt, 40pt),
      gutter: 5pt,

      // MQTT Application Layer
      rect(fill: rgb("#E3F2FD"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[MQTT应用层]
          #linebreak()
          #text(size: 8pt)[发布/订阅消息]
        ]
      ],
      rect(fill: rgb("#E3F2FD"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[消息完整性]
          #linebreak()
          #text(size: 8pt)[载荷签名验证]
        ]
      ],
      rect(fill: rgb("#FFE0B2"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[ML-DSA替换点]
          #linebreak()
          #text(size: 8pt)[消息级签名]
        ]
      ],

      // TLS Layer
      rect(fill: rgb("#F3E5F5"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[TLS 1.3协议层]
          #linebreak()
          #text(size: 8pt)[握手认证]
        ]
      ],
      rect(fill: rgb("#F3E5F5"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[证书验证]
          #linebreak()
          #text(size: 8pt)[DSA → ML-DSA]
        ]
      ],
      rect(fill: rgb("#FFCDD2"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[关键迁移点]
          #linebreak()
          #text(size: 8pt)[TLS握手签名]
        ]
      ],

      // Transport Layer
      rect(fill: rgb("#E8F5E8"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[TCP传输层]
          #linebreak()
          #text(size: 8pt)[连接管理]
        ]
      ],
      rect(fill: rgb("#E8F5E8"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[会话建立]
          #linebreak()
          #text(size: 8pt)[密钥协商]
        ]
      ],
      rect(fill: rgb("#E8F5E8"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[ML-KEM集成]
          #linebreak()
          #text(size: 8pt)[密钥交换]
        ]
      ],

      // Physical Layer
      rect(fill: rgb("#FFF3E0"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[IoT设备层]
          #linebreak()
          #text(size: 8pt)[硬件限制]
        ]
      ],
      rect(fill: rgb("#FFF3E0"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[资源约束]
          #linebreak()
          #text(size: 8pt)[内存/计算]
        ]
      ],
      rect(fill: rgb("#FFEBEE"), inset: 5pt)[
        #align(center)[
          #text(size: 9pt)[性能挑战]
          #linebreak()
          #text(size: 8pt)[签名尺寸]
        ]
      ]
    )
  ],
  caption: [MQTT协议栈中ML-DSA迁移的技术层次与关键替换点分析],
)

#greent[MQTT代理认证机制转换] ML-DSA在MQTT代理中主要替换两个关键认证点：TLS服务器证书签名和客户端证书验证。服务器证书中的DSA签名需要替换为ML-DSA签名，确保IoT设备能够验证代理身份。客户端证书验证过程中，代理需要支持ML-DSA签名的IoT设备证书，建立双向认证机制。这种迁移要求MQTT代理同时支持传统DSA和ML-DSA算法，实现渐进式迁移策略。

#bluet[协议层级影响分析] ML-DSA迁移对MQTT协议栈各层级产生不同程度影响。应用层的发布/订阅消息可选择性地集成ML-DSA消息级签名，提供端到端完整性保护。TLS层是主要迁移焦点，需要更新握手流程支持ML-DSA证书链验证。传输层的密钥协商需要配合ML-KEM算法，形成完整的后量子密码学解决方案。设备层面临的挑战包括ML-DSA签名尺寸增大(2420-4627字节)对内存受限设备的影响。


// Bibliography section
// #bibliography("../../paper/FourthPaper/tex/biblio.bib", style: "apa")
