#import "template/lib.typ": documentclass

#let (
  doc, cover, outline-page, experiment,
  content-area, reset-page-number,
) = documentclass(
  is-practice: false,
  show-day: true,
  university-logo: "../assets/tyut-logo.png",
  info: (
    course-name: "计算机网络",
    experiment-name: "计算机网络实验",
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
      src1: "pic/IMG_20260507_223301.jpg",
      src2: "pic/IMG_20260507_223321.jpg"
    )

    #img(src: "pic/IMG_20260507_223332.jpg")

  + 利用一台型号为2950-24的交换机作为组网基础，将两台PC互连，组建一个小型局域网。

    #img(src: "pic/IMG_20260507_223823.jpg")

  + 设置PC的IP地址。双击计算机终端设备PC0图标，随后会显示PC0设置窗口，然后选择"桌面"选项卡，再双击IP地址设置图标，便会出现IP配置窗口，对PC0的IP进行配置：IP地址为192.11-28.0.10，子网掩码为255.255.255.0。用同样的方法，对PC1进行配置：IP址为192.11-28.0.20，子网掩码为255.255.255.0。

    #img2(
      src1: "pic/IMG_20260507_223856.jpg",
      src2: "pic/IMG_20260507_223931.jpg"
    )

  + 网络连通性测试。双击计算机终端设备PC0图标显示PC0设置窗口，选择"桌面"选项卡，双击"终端"，出现窗口。在该窗口中输入"ping 192.11-28.0.20"命令，以检查网络的连通性。

    #img2(
      src1: "pic/IMG_20260507_224029.jpg",
      src2: "pic/IMG_20260507_224040.jpg"
    )

  + 基本配置命令的使用。双击网络设备图标，随后出现Switch0窗口。单击命令行，即可输入命令对交换机进行配置操作。

    #img(src: "pic/IMG_20260507_224115.jpg")

  + 通过输入以下命令来熟悉交换机配置操作。

    配置视图转换及安全设置等命令：

    #img(src: "pic/IMG_20260507_224301.jpg")

  + VLAN配置常用命令

    #img2(
      src1: "pic/IMG_20260508_084356.jpg",
      src2: "pic/IMG_20260508_084527.jpg"
    )

    #img2(
      src1: "pic/IMG_20260508_084622.jpg",
      src2: "pic/IMG_20260508_084749.jpg"
    )

  + 保存配置信息

    #img(src: "pic/IMG_20260508_084757.jpg")

  + 查看VTP配置信息

    #img(src: "pic/IMG_20260508_084811.jpg")

  + 查看当前配置信息

    #img(src: "pic/IMG_20260508_084826.jpg")

  + 查看VLAN配置信息

    #img(src: "pic/IMG_20260508_084843.jpg")

  + 查看端口信息

    #img(src: "pic/IMG_20260508_084855.jpg")

  + 查看指定端口信息

    #img(src: "pic/IMG_20260508_084911.jpg")
]

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

    #img(src: "pic/IMG_20260508_085044.jpg")

  + 从用户模式进入特权模式

  + 进入配置模式，修改交换机名称，输入以下命令

    #img(src: "pic/IMG_20260508_085133.jpg")

  + 显示当前活动的交换机配置文件，输入以下命令

    #img(src: "pic/IMG_20260508_085159.jpg")

  + 输入以下命令，以便显示接口1的统计和状态信息

    #img(src: "pic/IMG_20260508_085233.jpg")

  + 查看VLAN信息。其中，VLAN1是默认的管理VLAN，未对交换机进行配置时所有的接口默认属于VLAN1。

    #img(src: "pic/IMG_20260508_085244.jpg")

  + 查看Flash缓存内容

    #img(src: "pic/IMG_20260508_085258.jpg")

  + 输入以下命令，以查看IOS版本号以及系统硬件的配置情况、引导镜像等（注：IOS为Cisco网络设备的操作系统）

    #img(src: "pic/IMG_20260508_085311.jpg")

  + 恢复交换机到默认设置。输入以下命令，以恢复交换机到默认设置

    #img(src: "pic/IMG_20260508_085335.jpg")

  + 配置主机名称和控制端密码。输入以下命令，以配置主机名称和控制端密码

    #img(src: "pic/IMG_20260508_085445.jpg")

  + 为第二层交换机设置管理VLAN与默认网关。输入以下命令，为第二层交换机设置管理VLAN与默认网关。

    #img(src: "pic/IMG_20260508_085554.jpg")

  + 查看配置后的默认VLAN虚接口信息。输入以下命令，查看配置后的默认VLAN虚接口信息

    #img(src: "pic/IMG_20260508_085625.jpg")

  + 查看MAC地址表。输入以下命令，查看MAC地址表

    #img(src: "pic/IMG_20260508_085638.jpg")
]

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

    #img(src: "pic/20260509-21:27:35.png")

  + 根据实验手册中所提供的示意图，分别为PC0、PC1、PC2、PC3设置IP地址，如下图所示。

    - PC0设置IP地址

      #img(src: "pic/20260509-21:31:12.png")

    - PC1设置IP地址

      #img(src: "pic/20260509-21:32:30.png")

    - PC2设置IP地址

      #img(src: "pic/20260509-21:33:17.png")

    - PC3设置IP地址

      #img(src: "pic/20260509-21:33:36.png")

  + 查看交换机VLAN划分情况`Switch#show vlan`。

    #img(src: "pic/20260509-21:38:11.png")

  + 创建VLAN

    `Switch#configure terminal`

    `Switch(config)#vlan 2`

  + 为指定的VLAN增加以太网端口。

    - 为VLAN2增加端口（1）

      #img(src: "pic/image0.png")

    - 为VLAN2增加端口（2）

      #img(src: "pic/image1.png")

  + 增加端口后查看VLAN的配置，发现Fa0/1与Fa0/2已成功加入VLAN2。

    #img(src: "pic/image2.png")

  + 创建VLAN接口以及配置VLAN接口的IP地址。

    `Switch#configure terminal`

    `Enter configuration commands, one per line.  End with CNTL/Z.`

    `Switch(config)#interface vlan 2`

    `Switch(config-if)#ip address 192.11-38.200.100 255.255.255.0`

    `Switch(config-if)#end`

    - 配置VLAN接口的IP地址

      #img(src: "pic/image3.png")

  + 成功配置好VLAN接口的IP地址后再次查看交换机VLAN划分情况。

    此步骤选用`Switch#show run`指令查看VLAN2接口的IP地址是否配置成功

    - 成功为VLAN2配置IP地址

      #img(src: "pic/image4.png")

  + 删除VLAN2及其接口。

    `Switch(config)#no int vlan 2  //首先删除VALN接口`

    `Switch(config)#no vlan 2   //删除VLAN`

    #img(src: "pic/image5.png")
]

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

  #img(src: "pic/image34.png")

  + 分别为PC0、PC1、PC2、PC3设置PC地址。

    #img(src: "pic/image35.png")

  + 对路由器进行配置。

    #img(src: "pic/image36.png")

  + 启用路由器与交换机连接的接口，使路由器与交换机能够正常通信。

    #img(src: "pic/image37.png")
]

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

  #img(src: "pic/image38.png")

  + 安装HWIC-2T（两路由器连接需要其提供的serial port）。

    #img(src: "pic/image39.png")

  + Router2配置

    #img2(src1: "pic/image40.png", src2: "pic/image41.png")

  + Router3配置（第7行修改为`interface Serial 0/1/0`），两个路由器配置完成连接成功则两局域网连通

    #img2(src1: "pic/image42.png", src2: "pic/image43.png")

  + 在做好上面的配置操作后，开始测试，以验证配置操作是否正确合理。在PC0电脑上运行Ping命令，可以Ping通，配置是合理的。

    #img(src: "pic/image44.png")
]

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

  #img(src: "pic/image45.png")

  + Switch0 配置：

    #img(src: "pic/image46.png")

  + Switch1 配置：

    #img2(src1: "pic/image47.png", src2: "pic/image48.png")

  + Router0 配置：

    #img2(src1: "pic/image49.png", src2: "pic/image50.png")

    - 完成配置后，Router0的路由表：

      #img(src: "pic/image51.png")

  + Router1配置：

    #img(src: "pic/image52.png")

    - 完成配置后，Router1的路由器表：

      #img(src: "pic/image53.png")

  + 主机IP配置

    - 配置PC0以太网0端口IP为192.168.100.10，PC1以太网0端口IP为192.168.100.12，PC2以太网0端口IP为192.168.200.11

      #img(src: "pic/image54.png")

  + 主机网关配置

    - 配置PC0网关192.168.100.1，PC2网关192.168.200.1

      #img(src: "pic/image55.png")

  + 完成配置操作后，进行网络连通性测试:

    - 在 PC0 的命令窗口中 Ping PC1 的 IP 地址，可以成功

      #img(src: "pic/image56.png")

    - Ping 交换机的 IP 地址，成功

      #img(src: "pic/image57.png")

    - Ping 自己网关的 IP 地址，成功

      #img(src: "pic/image58.png")

    - Ping 对方路由器的 IP 地址，成功

      #img(src: "pic/image59.png")

    - Ping 对方 PC 机的 IP 地址，成功

      #img(src: "pic/image60.png")

  == 四. 动态路由

  本次实验的网络拓扑结构图如下图所示。

  #img(src: "pic/image61.png")

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

    #img2(src1: "pic/image62.png", src2: "pic/image63.png")

    #img2(src1: "pic/image64.png", src2: "pic/image65.png")

  + Switch1配置

    #img2(src1: "pic/image66.png", src2: "pic/image67.png")

  + Router0配置

    #img2(src1: "pic/image68.png", src2: "pic/image69.png")

  + Router1配置

    #img(src: "pic/image70.png")

  + 同上一实验，注意主机IP与网关的配置，若ping不通，优先检查网关是否配置正确。

  + 配置好 PC 机、交换机以及路由器后，进行网络连通性测试:

    - 在 PC0 的命令窗口中，ping 交换机，成功

      #img(src: "pic/image71.png")

    - 在 PC0 的命令窗口中，ping 对方路由器，成功

      #img(src: "pic/image72.png")

    - 在 PC0 的命令窗口中，ping 对方 PC 机，成功

      #img(src: "pic/image73.png")

  == 五. 路由器动态路由2

  + 本次实验的网络拓扑结构图如下图所示：

    #img(src: "pic/image83.png")

  + Switch 0配置：

    #img2(src1: "pic/image84.png", src2: "pic/image85.png")

    #img2(src1: "pic/image86.png", src2: "pic/image87.png")

  + Switch 1配置:

    #img2(src1: "pic/image88.png", src2: "pic/image89.png")

    #img(src: "pic/image90.png")

  + Router 0配置:

    #img2(src1: "pic/image91.png", src2: "pic/image92.png")

  + 配置 Router1:

    #img2(src1: "pic/image93.png", src2: "pic/image94.png")

    #img2(src1: "pic/image95.png", src2: "pic/image96.png")

  + 配置好 PC 机、交换机以及路由器后，进行网络连通性测试:

    - 配置完成后进行连通性实验：在PC0的命令行方式下运行`ping 202.38.1.254`

      #img(src: "pic/image97.png")

    - 在PC1的命令行方式下运行`ping 192.168.4.11`

      #img(src: "pic/image98.png")

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

#experiment(title: "实验7 单区域OSPF路由协议配置")[
  == 一. 实验目的

  掌握OSPF动态路由协议的配置、诊断方法。

  == 二. 实验内容

  + 启动IPMininet仿真网络；
  + 编写Python代码创建包含OSPF路由器的网络拓扑；
  + 配置主机和路由器IP地址；
  + 配置路由器OSPF协议，实现路由之间互通；
  + 查看OSPF路由表和协议状态；
  + 验证OSPF协议的网络连通性。

  == 三. 启动IPMininet仿真网络

  右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务。

  #img(src: "pic/image150.png")

  + 实验时请按照规划的网段进行实验。

    #img(src: "pic/image151.png")

  + 由于原生Mininet不支持网络层的路由器仿真，因此使用拓展过的IPMininet，需要我们通过代码创建自定义网络。进入/home/headless/ipmininet/ipmininet/examples文件夹，在此处打开终端。

    #img(src: "pic/image152.png")

  + 输入`sudo gedit simple_ospf4_network.py`创建新的网络拓扑文件，填入如所示的python代码。这里在创建路由器的时候ipmininet默认使用ospf协议获取路由表，无需特殊声明。（可能现需要手动下载gedit，下载指令：`sudo apt-get install gedit -y`。如果不用gedit也可以用vim打开编辑文件）

    #img(src: "pic/image153.png")

  + 终端中输入`sudo gedit main.py`打开main文件注册刚刚创建的网络拓扑，填入如下两图所示的代码，保存后退出。

    #img2(src1: "pic/image154.png", src2: "pic/image155.png")

  + 执行`cd ../..`退出到第一个ipmininet文件夹，右键打开终端输入`sudo python3 -m ipmininet.examples --topo=simple_ospf4_network`，启动包含两个路由器和两个主机的网络。

    #img(src: "pic/image156.png")

  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。

  + 在h1的终端内输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址和子网掩码不符合实验要求。

    #img(src: "pic/image157.png")

  + 执行如下命令，将主机1的eth0网卡的ip地址和子网掩码设置为实验要求。

    - `sudo ifconfig h1-eth0 10.0.0.2`

  + 输入`xterm h2`，打开h2的终端，输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址不符合实验要求。

    #img(src: "pic/image158.png")

  + 执行如下命令，将主机2的eth0网卡的ip地址和子网掩码设置为实验要求。

    - `sudo ifconfig h2-eth0 10.0.2.2`

  == 五. 配置路由器

  + 在mininet终端中输入`xterm r1`打开路由器1的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。该路由器有两块网卡，eth0和eth1。

    #img(src: "pic/image159.png")

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r1-eth0 10.0.0.1/24`命令，配置网卡eth0的IP地址为10.0.0.1/24

    - 执行`ifconfig r1-eth1 10.0.1.1/24`命令，配置网卡eth1的IP地址为10.0.1.1/24

    #img(src: "pic/image160.png")

  + 在mininet终端中输入`xterm r2`打开路由器2的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。

    #img(src: "pic/image161.png")

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r2-eth0 10.0.1.2/24`命令，配置网卡eth0的IP地址为10.0.1.2/24

    - 执行`ifconfig r2-eth1 10.0.2.1/24`命令，配置网卡eth1的IP地址为10.0.2.1/24

    #img(src: "pic/image162.png")

  + 配置主机路由。

    - 查看主机1路由信息。主机1没有默认路由，从主机1出去的流量不能到达eth0的网关，即不能到达路由器1。

    - 查看命令：`route -n`

      #img(src: "pic/image163.png")

    - 执行如下命令，修改主机1的默认网关

    - `sudo route add default gw 10.0.0.1`

    - 查看修改后的路由信息，主机1的默认网关为网卡eth0的网关

    - 再次执行：`route -n`

      #img(src: "pic/image164.png")

    - 查看主机2的路由信息。主机2没有默认路由，从主机2出去的流量不能达到eth1网关，即不能到达路由1

    - 查看命令：`route -n`

      #img(src: "pic/image165.png")

    - 同样的，我们修改路由信息：`sudo route add default gw 10.0.2.1`

    - 查看修改后的路由信息，主机2的默认网关为网卡eth0的网关。

    - 查看指令：`route -n`

      #img(src: "pic/image166.png")

  == 六. 配置路由器OSPF协议

  + 在mininet终端上执行r1 route查看路由器1的路由表，可以发现虽然网卡的ip地址更新了，但是却没有通向主机2网络的路由条目，这需要我们手动更新OSPF协议中路由器所连接的网络。

    - 执行指令：`r1 route`

      #img(src: "pic/image167.png")

  + 打开路由器1的终端，输入`telnet localhost ospfd`，使用telnet工具连ospf进程，输入默认密码：zebra。

  + 依次输入下列三条指令，进入ospf的配置模式。

    - `enable`

    - `configure terminal`

    - `router ospf`

  + 输入下列命令查看ospf信息，可以发现network只有刚创建网络时的ip地址，需要我们手动添加更新后的。

    - `show running-config`

      #img(src: "pic/image168.png")

  + 依次输入下列三条指令，添加新的network。

    - `network 10.0.0.0/24 area 0.0.0.0`

    - `network 10.0.1.0/24 area 0.0.0.0`

    - `write`

    #img(src: "pic/image169.png")

  + 再次查看ospf信息，可以发现已经添加成功。查看指令：`show running-config`

    #img(src: "pic/image170.png")

  + 同样的方式，更新路由器2的网络信息。即在r2的终端，重复上述r1的操作。

    #img(src: "pic/image171.png")

  == 七. 验证OSPF协议

  + 打开主机1的终端，ping主机2的地址，发现可以ping通。

    - 指令：`ping 10.0.2.2`

      #img(src: "pic/image172.png")

  + 在mininet终端上再次查看r1和r2的路由表，发现已经有了由ospf发现的目标网络，标志UG表示连接的网络是可达的且邻接路由器是网关路由器。

    - 执行:`r1 route`,`r2 route`

      #img(src: "pic/image173.png")

  + 新开一个路由器1终端，登录ospf进程后，输入`show ip ospf route`后同样可以看到通过`ospf`协议获取的路由表。

    - `telnet localhost ospfd`

    - `enable`

    - `configure terminal`

    - `router ospf`

    - `show ip ospf route`

    #img(src: "pic/image174.png")

  + 再新开一个r1终端，输入`tcpdump -i r1-eth0 proto ospf -v`可以看到路由器收到的ospf协议包

    #img(src: "pic/image175.png")
]

#experiment(title: "实验8 DHCP的配置")[
  == 一. 实验目的

  1.掌握IP地址的结构、分类及目前遇到的问题。
  2.理解DHCP服务的概念、深刻体会DHCP在灵活利用IP过程中的作用。
  3.学会在思科路由器上配置DHCP服务。

  == 二. 实验内容

  + 构建包含DHCP服务器和中继的网络拓扑；
  + 在路由器上配置DHCP Server；
  + 在路由器上配置DHCP Relay；
  + 验证主机自动获取IP地址；
  + 观察DHCP地址池分配情况。

  == 三. 实验正文

  + 本次实验的网络拓扑结构图如下图所示：

    #img(src: "pic/image74.png")

  + Router 0配置：

    #img2(src1: "pic/image75.png", src2: "pic/image76.png")

  + Router 1配置：

    #img2(src1: "pic/image77.png", src2: "pic/image78.png")

  + 完成配置操作后，查看PC0、PC1、PC2、PC3的IP地址，发现：

    - PC0、PC1获取的IP地址在192.168.3.2\~192.168.3.254之间

    - PC2、PC3获取的IP地址在192.168.4.2\~192.168.4.254之间

    #img2(src1: "pic/image79.png", src2: "pic/image80.png")

    #img2(src1: "pic/image81.png", src2: "pic/image82.png")
]
