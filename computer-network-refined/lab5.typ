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
    experiment-name: "实验5 静态路由配置",
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

#experiment(title: "实验5 静态路由配置")[
  == 一. 实验目的

  掌握静态路由配置方法。

  == 二. 实验内容

  + 构建包含两个路由器的网络拓扑；
  + 为路由器安装串行接口模块（HWIC-2T）；
  + 配置路由器各个接口的IP地址；
  + 为每个路由器添加静态路由条目；
  + 验证静态路由配置的正确性和网络连通性。

  == 三. 实验正文

  路由器静态路由配置拓扑图如下图所示

  #img(src: "../pic/image38.png")

  + 安装HWIC-2T（两路由器连接需要其提供的serial port）。

    #img(src: "../pic/image39.png")

  + Router2配置

    #img2(src1: "../pic/image40.png", src2: "../pic/image41.png")

  + Router3配置（第7行修改为`interface Serial 0/1/0`），两个路由器配置完成连接成功则两局域网连通

    #img2(src1: "../pic/image42.png", src2: "../pic/image43.png")

  + 在做好上面的配置操作后，开始测试，以验证配置操作是否正确合理。在PC0电脑上运行Ping命令，可以Ping通，配置是合理的。

    #img(src: "../pic/image44.png")
]
