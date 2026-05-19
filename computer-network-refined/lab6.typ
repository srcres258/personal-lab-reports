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
    experiment-name: "实验6 RIP路由协议配置",
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

#experiment(title: "实验6 RIP路由协议配置")[
  == 一. 实验目的

  掌握RIP动态路由协议的配置、诊断方法。

  == 二. 实验内容

  + 构建包含多台路由器的复杂网络拓扑；
  + 配置路由器接口IP地址和主机IP地址；
  + 配置RIP动态路由协议；
  + 验证网络连通性；
  + 比较静态路由与RIP动态路由的区别；
  + 理解RIP协议的工作原理。

  == 三. 路由器动态路由

  本次实验的网络拓扑结构图如下图所示。

  #img(src: "../pic/image45.png")

  + Switch0 配置：

    #img(src: "../pic/image46.png")

  + Switch1 配置：

    #img2(src1: "../pic/image47.png", src2: "../pic/image48.png")

  + Router0 配置：

    #img2(src1: "../pic/image49.png", src2: "../pic/image50.png")

    - 完成配置后，Router0的路由表：

      #img(src: "../pic/image51.png")

  + Router1配置：

    #img(src: "../pic/image52.png")

    - 完成配置后，Router1的路由器表：

      #img(src: "../pic/image53.png")

  + 主机IP配置

    - 配置PC0以太网0端口IP为192.168.100.10，PC1以太网0端口IP为192.168.100.12，PC2以太网0端口IP为192.168.200.11

      #img(src: "../pic/image54.png")

  + 主机网关配置

    - 配置PC0网关192.168.100.1，PC2网关192.168.200.1

      #img(src: "../pic/image55.png")

  + 完成配置操作后，进行网络连通性测试:

    - 在 PC0 的命令窗口中 Ping PC1 的 IP 地址，可以成功

      #img(src: "../pic/image56.png")

    - Ping 交换机的 IP 地址，成功

      #img(src: "../pic/image57.png")

    - Ping 自己网关的 IP 地址，成功

      #img(src: "../pic/image58.png")

    - Ping 对方路由器的 IP 地址，成功

      #img(src: "../pic/image59.png")

    - Ping 对方 PC 机的 IP 地址，成功

      #img(src: "../pic/image60.png")

  == 四. 动态路由

  本次实验的网络拓扑结构图如下图所示。

  #img(src: "../pic/image61.png")

  + 说明:

    - PC0、PC1分别连接Switch0的2号和3号端口;
    - Switch0的2号端口和3号端口分别在VLAN2和VLAN3中;
    - PC2、PC3分别连接Switch1的2号和3号端口;
    - Switch1的2号和3号端口分别在VLAN4和VLAN5中;
    - Switch0的1号端口连接Router0的以太网口Fa0/0;
    - Switch1的1号端口连接Router1的以太网口Fa0/0;
    - Router0的以太网口Fa0/0的两个虚拟子接口分别为:Fa0/0.1 192.168.2.1 Fa0/0.2 192.168.3.1
    - Router1的以太网口Fa0/0的两个虚拟子接口分别为:Fa0/0.1 192.168.4.1 Fa0/0.2 192.168.5.1

  + Switch0配置

    #img2(src1: "../pic/image62.png", src2: "../pic/image63.png")

    #img2(src1: "../pic/image64.png", src2: "../pic/image65.png")

  + Switch1配置

    #img2(src1: "../pic/image66.png", src2: "../pic/image67.png")

  + Router0配置

    #img2(src1: "../pic/image68.png", src2: "../pic/image69.png")

  + Router1配置

    #img(src: "../pic/image70.png")

  + 同上一实验，注意主机IP与网关的配置，若ping不通，优先检查网关是否配置正确。

  + 配置好 PC 机、交换机以及路由器后，进行网络连通性测试:

    - 在 PC0 的命令窗口中，ping 交换机，成功

      #img(src: "../pic/image71.png")

    - 在 PC0 的命令窗口中，ping 对方路由器，成功

      #img(src: "../pic/image72.png")

    - 在 PC0 的命令窗口中，ping 对方 PC 机，成功

      #img(src: "../pic/image73.png")

  == 五. 路由器动态路由2

  + 本次实验的网络拓扑结构图如下图所示：

    #img(src: "../pic/image83.png")

  + Switch 0配置：

    #img2(src1: "../pic/image84.png", src2: "../pic/image85.png")

    #img2(src1: "../pic/image86.png", src2: "../pic/image87.png")

  + Switch 1配置:

    #img2(src1: "../pic/image88.png", src2: "../pic/image89.png")

    #img(src: "../pic/image90.png")

  + Router 0配置:

    #img2(src1: "../pic/image91.png", src2: "../pic/image92.png")

  + 配置 Router1:

    #img2(src1: "../pic/image93.png", src2: "../pic/image94.png")

    #img2(src1: "../pic/image95.png", src2: "../pic/image96.png")

  + 配置好 PC 机、交换机以及路由器后，进行网络连通性测试:

    - 配置完成后进行连通性实验：在PC0的命令行方式下运行`ping 202.38.1.254`

      #img(src: "../pic/image97.png")

    - 在PC1的命令行方式下运行`ping 192.168.4.11`

      #img(src: "../pic/image98.png")

  == 六. 静态路由与动态RIP路由的区别

  + 静态路由：

    - 由网络管理员在路由器上手动配置路由条目
    - 当网络拓扑改变时，需要管理员手动更新路由条目
    - 路由过程必须根据管理员的配置进行转发
    - 适合于小型网络

  + 动态路由：

    - 当拓扑改变时，可以自动更新路由条目
    - 通过交换和路由更新来学习和维护远端的路由，动态路由器定期会同步各个路由器之间的路由信息，保持一致
    - 路由器发现的新网络是通过共享路由表来实现的
    - 适合于大型网络

  == 七. RIP工作原理

  - 每个路由器每隔30s给自己所有的邻居路由器广播RIP报文，报文的内容是这个路由器当前的路由信息；
  - 收到邻居路由器的路由表信息后，更新自己的路由表，下次将更新后的路由表告诉自己的邻居；
  - 长时间没有收到某个路由器的路由表信息，就认为这个路由器出现故障，路由表中将所有以这个出现故障的路由器为下一站的表项距离修改，表示不可达。再过一段时间依然没有回复，从路由表删除。
]
