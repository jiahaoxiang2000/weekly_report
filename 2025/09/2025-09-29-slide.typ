#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Set Chinese fonts for the presentation
#set text(font: (
  "Source Han Serif SC", // Alternative Chinese serif font
))

// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

// Additional font customization options:
#show heading: set text(font: "Noto Serif CJK SC", weight: "bold")
#show raw: set text(font: "Noto Sans Mono CJK SC")

#show heading: set text(font: "Noto Sans CJK SC")
#show: simple-theme.with(aspect-ratio: "16-9", footer: [周报])

#title-slide[
  = 周报
  #v(2em)

  #v(2em)
  2025-09-29
]

=

== 本周研究摘要

- #redt[ML-DSA论文重构优化]：第3节内容架构重组，12个子节合并为4个重点技术节，精简约60%
- #bluet[后量子MQTT迁移技术调研]：建立MQTT协议基础理论框架，识别ML-DSA四个关键影响点

== ML-DSA论文重构优化进展

#redt[第3节结构优化]：
- 建立4个重点技术节架构：ML-DSA算法特征、参数集合与安全性、MQTT协议与安全集成、ML-DSA集成挑战
- 新增4个参考文献强化学术基础
- 研究贡献重构为条目化展示，提升可读性

#bluet[核心技术内容]：
- 量化分析ML-DSA签名尺寸增长对IoT设备的性能影响
- 整合数学基础与计算要求分析

== MQTT协议基础与ML-DSA影响分析

#bluet[MQTT协议特征]：
- 轻量级发布-订阅消息传输协议，专为物联网设计

#figure(
  rect(width: 100%, height: 200pt, stroke: 1pt, inset: 8pt)[
    #align(center)[
      #text(size: 14pt, weight: "bold")[MQTT协议中ML-DSA影响点]
    ]
    #v(5pt)
    #grid(
      columns: (1fr, 1.5fr, 1fr),
      rows: (28pt, 28pt, 28pt, 28pt),
      gutter: 4pt,

      // MQTT Client Side
      rect(fill: rgb("#E3F2FD"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt, weight: "bold")[MQTT客户端]
        ]
      ],

      // Connection & Authentication
      rect(fill: rgb("#FFCDD2"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt, weight: "bold")[TLS握手 ❶]
        ]
      ],

      rect(fill: rgb("#E3F2FD"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt, weight: "bold")[MQTT代理]
        ]
      ],

      // MQTT Protocol Layer
      rect(fill: rgb("#E8F5E8"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt)[CONNECT]
        ]
      ],

      rect(fill: rgb("#FFE0B2"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt, weight: "bold")[客户端认证 ❷]
        ]
      ],

      rect(fill: rgb("#E8F5E8"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt)[CONNACK]
        ]
      ],

      // Message Exchange
      rect(fill: rgb("#F3E5F5"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt)[PUBLISH]
        ]
      ],

      rect(fill: rgb("#FFF3E0"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt, weight: "bold")[消息签名 ❸]
        ]
      ],

      rect(fill: rgb("#F3E5F5"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt)[SUBSCRIBE]
        ]
      ],

      // Session Management
      rect(fill: rgb("#E0F2F1"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt)[会话管理]
        ]
      ],

      rect(fill: rgb("#FFEBEE"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt, weight: "bold")[会话令牌 ❹]
        ]
      ],

      rect(fill: rgb("#E0F2F1"), inset: 4pt)[
        #align(center)[
          #text(size: 11pt)[QoS保证]
        ]
      ],
    )
    #v(2pt)
    #text(size: 10pt)[
      #text(weight: "bold")[影响点：] ❶TLS证书 ❷客户端认证 ❸消息签名 ❹会话令牌
    ]
  ],
)

== ML-DSA在MQTT协议中的迁移角色

#figure(
  rect(width: 100%, height: 270pt, stroke: 1pt, inset: 10pt)[
    #align(center)[
      #text(size: 15pt, weight: "bold")[MQTT协议栈中ML-DSA迁移层次结构]
    ]
    #v(8pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      rows: (42pt, 42pt, 42pt, 42pt),
      gutter: 5pt,

      // MQTT Application Layer
      rect(fill: rgb("#E3F2FD"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[MQTT应用层]
          #linebreak()
          #text(size: 10pt)[发布/订阅消息]
        ]
      ],
      rect(fill: rgb("#E3F2FD"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[消息完整性]
          #linebreak()
          #text(size: 10pt)[载荷签名验证]
        ]
      ],
      rect(fill: rgb("#FFE0B2"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[ML-DSA替换点]
          #linebreak()
          #text(size: 10pt)[消息级签名]
        ]
      ],

      // TLS Layer
      rect(fill: rgb("#F3E5F5"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[TLS 1.3协议层]
          #linebreak()
          #text(size: 10pt)[握手认证]
        ]
      ],
      rect(fill: rgb("#F3E5F5"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[证书验证]
          #linebreak()
          #text(size: 10pt)[DSA → ML-DSA]
        ]
      ],
      rect(fill: rgb("#FFCDD2"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[关键迁移点]
          #linebreak()
          #text(size: 10pt)[TLS握手签名]
        ]
      ],

      // Transport Layer
      rect(fill: rgb("#E8F5E8"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[TCP传输层]
          #linebreak()
          #text(size: 10pt)[连接管理]
        ]
      ],
      rect(fill: rgb("#E8F5E8"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[会话建立]
          #linebreak()
          #text(size: 10pt)[密钥协商]
        ]
      ],
      rect(fill: rgb("#E8F5E8"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[ML-KEM集成]
          #linebreak()
          #text(size: 10pt)[密钥交换]
        ]
      ],

      // Physical Layer
      rect(fill: rgb("#FFF3E0"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[IoT设备层]
          #linebreak()
          #text(size: 10pt)[硬件限制]
        ]
      ],
      rect(fill: rgb("#FFF3E0"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[资源约束]
          #linebreak()
          #text(size: 10pt)[内存/计算]
        ]
      ],
      rect(fill: rgb("#FFEBEE"), inset: 6pt)[
        #align(center)[
          #text(size: 11pt)[性能挑战]
          #linebreak()
          #text(size: 10pt)[签名尺寸]
        ]
      ],
    )
  ],
)

== 迁移关键技术分析

#redt[MQTT代理数字签名迁移路径]：
- TLS握手阶段的服务器认证和客户端证书验证
- 替换底层密码学原语，保持MQTT协议兼容性

#greent[协议层级影响]：
- 应用层：可选择性集成ML-DSA消息级签名
- TLS层：更新握手流程支持ML-DSA证书链验证
- 设备层：ML-DSA签名尺寸增大(2420-4627字节)对内存受限设备的影响

= 总结

== 下周计划

- #bluet[深化ML-DSA论文IoT环境部署优化分析]：完善资源受限设备性能评估框架
- #greent[启动ML-DSA实验验证系统设计]：准备ARM Cortex-M4微控制器性能基准测试

== 老师评语

*CHES最近一期截稿时间是什么时候？*

- TCHES Volume 2026/2 ： #bluet[_2025.10.15_] Submission
- TCHES Volume 2026/3 ： _2026.01.15_ Submission



