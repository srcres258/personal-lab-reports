#import "../template/lib.typ": documentclass

#let (
  doc, cover, outline-page, experiment,
  content-area, reset-page-number,
) = documentclass(
  is-practice: false,
  show-day: true,
  university-logo: "../assets/tyut-logo.png",
  info: (
    course-name: "计算机网络",
    experiment-name: "实验4 路由器的基本配置",
    location: "实验室E210",
    class-name: "区块链2301",
    student-id: "2023002089",
    student-name: "胡皓文",
    supervisor: "胡钊鸣",
    year: 2026,
    month: 5,
    day: 7,
  ),
)

#show: doc

#cover()

#outline-page()

#reset-page-number
#show: content-area

#let img(src: str) = align(center, image(src, width: 6cm))

#let img2(src1: str, src2: str) = align(center, grid(
  columns: 2,
  align(center, image(src1, width: 6cm)),
  align(center, image(src2, width: 6cm))
))

#experiment(title: "实验4 路由器的基本配置")[
  == 一. 实验目的

  1、掌握利用超级终端配置路由器时的连接和参数设置。
  2、掌握用配置向导配置路由器的步骤和方法。
  3、掌握检查路由器配置和状态的路由器命令。
  4、掌握手工对路由器进行初始配置的步骤和方法。

  == 二. 实验内容

  + 构建包含路由器的网络拓扑；
  + 配置路由器不同模式间的转换；
  + 使用常用的配置命令和状态查询命令；
  + 配置路由器接口的IP地址；
  + 按拓扑结构图给路由器各端口配置IP地址。

  == 三. 实验正文

  路由器配置示意图

  #img(src: "../pic/image34.png")

  + 分别为PC0、PC1、PC2、PC3设置PC地址。

    #img(src: "../pic/image35.png")

  + 对路由器进行配置。

    #img(src: "../pic/image36.png")

  + 启用路由器与交换机连接的接口，使路由器与交换机能够正常通信。

    #img(src: "../pic/image37.png")
]
