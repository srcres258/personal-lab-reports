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
    experiment-name: "实验3 VLAN基本配置",
    location: "实验室E210",
    class-name: "区块链2301",
    student-id: "2023002089",
    student-name: "胡皓文",
    supervisor: "胡钊鸣",
    year: 2026,
    month: 5,
    day: 9,
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

#experiment(title: "实验3 VLAN基本配置")[
  == 一. 实验目的

  掌握交换机上创建VLAN、分配静态VLAN成员的方法。

  == 二. 实验内容

  + 在Packet Tracer软件中构建网络拓扑，创建两个VLAN；
  + 配置各个主机的IP地址和子网掩码；
  + 通过交换机终端为每个VLAN分配成员端口；
  + 配置VLAN接口的IP地址；
  + 进行删除VLAN的操作；
  + 理解VLAN1不能被删除的原因。

  == 三. 实验正文

  + VLAN配置如图所示。

    #img(src: "../pic/20260509-21:27:35.png")

  + 根据实验手册中所提供的示意图，分别为PC0、PC1、PC2、PC3设置IP地址，如下图所示。

    - PC0设置IP地址

      #img(src: "../pic/20260509-21:31:12.png")

    - PC1设置IP地址

      #img(src: "../pic/20260509-21:32:30.png")

    - PC2设置IP地址

      #img(src: "../pic/20260509-21:33:17.png")

    - PC3设置IP地址

      #img(src: "../pic/20260509-21:33:36.png")

  + 查看交换机VLAN划分情况`Switch#show vlan`。

    #img(src: "../pic/20260509-21:38:11.png")

  + 创建VLAN

    `Switch#configure terminal`

    `Switch(config)#vlan 2`

  + 为指定的VLAN增加以太网端口。

    - 为VLAN2增加端口（1）

      #img(src: "../pic/image0.png")

    - 为VLAN2增加端口（2）

      #img(src: "../pic/image1.png")

  + 增加端口后查看VLAN的配置，发现Fa0/1与Fa0/2已成功加入VLAN2。

    #img(src: "../pic/image2.png")

  + 创建VLAN接口以及配置VLAN接口的IP地址。

    `Switch#configure terminal`

    `Enter configuration commands, one per line.  End with CNTL/Z.`

    `Switch(config)#interface vlan 2`

    `Switch(config-if)#ip address 192.11-38.200.100 255.255.255.0`

    `Switch(config-if)#end`

    - 配置VLAN接口的IP地址

      #img(src: "../pic/image3.png")

  + 成功配置好VLAN接口的IP地址后再次查看交换机VLAN划分情况。

    此步骤选用`Switch#show run`指令查看VLAN2接口的IP地址是否配置成功

    - 成功为VLAN2配置IP地址

      #img(src: "../pic/image4.png")

  + 删除VLAN2及其接口。

    `Switch(config)#no int vlan 2  //首先删除VALN接口`

    `Switch(config)#no vlan 2   //删除VLAN`

    #img(src: "../pic/image5.png")
]
