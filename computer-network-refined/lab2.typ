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
    experiment-name: "实验2 交换机配置",
    location: "实验室E210",
    class-name: "区块链2301",
    student-id: "2023002089",
    student-name: "胡皓文",
    supervisor: "胡钊鸣",
    year: 2026,
    month: 5,
    day: 8,
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

#experiment(title: "实验2 交换机配置")[
  == 一. 实验目的

  1、掌握交换机基本配置的步骤和方法。
  2、掌握查看和测试交换机基本配置的步骤和方法。

  == 二. 实验内容

  + 配置交换机的基本参数（主机名、密码等）；
  + 查看交换机的各种配置信息和运行状态；
  + 恢复交换机到默认设置；
  + 配置交换机的管理VLAN和默认网关；
  + 查看交换机的MAC地址表。

  == 三. 实验正文

  本次实验的网络拓扑结构如图所示

    #img(src: "../pic/IMG_20260508_085044.jpg")

  + 从用户模式进入特权模式

  + 进入配置模式，修改交换机名称，输入以下命令

    #img(src: "../pic/IMG_20260508_085133.jpg")

  + 显示当前活动的交换机配置文件，输入以下命令

    #img(src: "../pic/IMG_20260508_085159.jpg")

  + 输入以下命令，以便显示接口1的统计和状态信息

    #img(src: "../pic/IMG_20260508_085233.jpg")

  + 查看VLAN信息。其中，VLAN1是默认的管理VLAN，未对交换机进行配置时所有的接口默认属于VLAN1。

    #img(src: "../pic/IMG_20260508_085244.jpg")

  + 查看Flash缓存内容

    #img(src: "../pic/IMG_20260508_085258.jpg")

  + 输入以下命令，以查看IOS版本号以及系统硬件的配置情况、引导镜像等（注：IOS为Cisco网络设备的操作系统）

    #img(src: "../pic/IMG_20260508_085311.jpg")

  + 恢复交换机到默认设置。输入以下命令，以恢复交换机到默认设置

    #img(src: "../pic/IMG_20260508_085335.jpg")

  + 配置主机名称和控制端密码。输入以下命令，以配置主机名称和控制端密码

    #img(src: "../pic/IMG_20260508_085445.jpg")

  + 为第二层交换机设置管理VLAN与默认网关。输入以下命令，为第二层交换机设置管理VLAN与默认网关。

    #img(src: "../pic/IMG_20260508_085554.jpg")

  + 查看配置后的默认VLAN虚接口信息。输入以下命令，查看配置后的默认VLAN虚接口信息

    #img(src: "../pic/IMG_20260508_085625.jpg")

  + 查看MAC地址表。输入以下命令，查看MAC地址表

    #img(src: "../pic/IMG_20260508_085638.jpg")
]
