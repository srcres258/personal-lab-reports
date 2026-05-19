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
    experiment-name: "实验1 PacketTrace基本使用",
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

#experiment(title: "实验1 PacketTrace基本使用")[
  == 一. 实验目的

  掌握Cisco Packet Tracer软件的使用方法。

  == 二. 实验内容

  + 在Linux环境下启动Cisco Packet Tracer软件并完成账号注册；
  + 利用交换机和PC构建基本网络拓扑；
  + 配置主机IP地址和子网掩码；
  + 测试网络连通性；
  + 熟悉交换机的基本配置命令。

  == 三. 实验正文

  + 在桌面打开终端，输入`packettracer`启动Cisco packet tracer软件。在登录界面Login Server选择Worldwide后进入注册账号界面。使用邮箱进行注册（QQ邮箱，网易邮箱等），并填写个人信息。

    #img2(
      src1: "../pic/IMG_20260507_223301.jpg",
      src2: "../pic/IMG_20260507_223321.jpg"
    )

    #img(src: "../pic/IMG_20260507_223332.jpg")

  + 利用一台型号为2950-24的交换机作为组网基础，将两台PC互连，组建一个小型局域网。

    #img(src: "../pic/IMG_20260507_223823.jpg")

  + 设置PC的IP地址。双击计算机终端设备PC0图标，随后会显示PC0设置窗口，然后选择"桌面"选项卡，再双击IP地址设置图标，便会出现IP配置窗口，对PC0的IP进行配置：IP地址为192.11-28.0.10，子网掩码为255.255.255.0。用同样的方法，对PC1进行配置：IP址为192.11-28.0.20，子网掩码为255.255.255.0。

    #img2(
      src1: "../pic/IMG_20260507_223856.jpg",
      src2: "../pic/IMG_20260507_223931.jpg"
    )

  + 网络连通性测试。双击计算机终端设备PC0图标显示PC0设置窗口，选择"桌面"选项卡，双击"终端"，出现窗口。在该窗口中输入"ping 192.11-28.0.20"命令，以检查网络的连通性。

    #img2(
      src1: "../pic/IMG_20260507_224029.jpg",
      src2: "../pic/IMG_20260507_224040.jpg"
    )

  + 基本配置命令的使用。双击网络设备图标，随后出现Switch0窗口。单击命令行，即可输入命令对交换机进行配置操作。

    #img(src: "../pic/IMG_20260507_224115.jpg")

  + 通过输入以下命令来熟悉交换机配置操作。

    配置视图转换及安全设置等命令：

    #img(src: "../pic/IMG_20260507_224301.jpg")

  + VLAN配置常用命令

    #img2(
      src1: "../pic/IMG_20260508_084356.jpg",
      src2: "../pic/IMG_20260508_084527.jpg"
    )

    #img2(
      src1: "../pic/IMG_20260508_084622.jpg",
      src2: "../pic/IMG_20260508_084749.jpg"
    )

  + 保存配置信息

    #img(src: "../pic/IMG_20260508_084757.jpg")

  + 查看VTP配置信息

    #img(src: "../pic/IMG_20260508_084811.jpg")

  + 查看当前配置信息

    #img(src: "../pic/IMG_20260508_084826.jpg")

  + 查看VLAN配置信息

    #img(src: "../pic/IMG_20260508_084843.jpg")

  + 查看端口信息

    #img(src: "../pic/IMG_20260508_084855.jpg")

  + 查看指定端口信息

    #img(src: "../pic/IMG_20260508_084911.jpg")
]
