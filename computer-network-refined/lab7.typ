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
    experiment-name: "实验7 单区域OSPF路由协议配置",
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

  #img(src: "../pic/image150.png")

  + 实验时请按照规划的网段进行实验。

    #img(src: "../pic/image151.png")

  + 由于原生Mininet不支持网络层的路由器仿真，因此使用拓展过的IPMininet，需要我们通过代码创建自定义网络。进入/home/headless/ipmininet/ipmininet/examples文件夹，在此处打开终端。

    #img(src: "../pic/image152.png")

  + 输入`sudo gedit simple_ospf4_network.py`创建新的网络拓扑文件，填入如所示的python代码。这里在创建路由器的时候ipmininet默认使用ospf协议获取路由表，无需特殊声明。（可能现需要手动下载gedit，下载指令：`sudo apt-get install gedit -y`。如果不用gedit也可以用vim打开编辑文件）

    #img(src: "../pic/image153.png")

  + 终端中输入`sudo gedit main.py`打开main文件注册刚刚创建的网络拓扑，填入如下两图所示的代码，保存后退出。

    #img2(src1: "../pic/image154.png", src2: "../pic/image155.png")

  + 执行`cd ../..`退出到第一个ipmininet文件夹，右键打开终端输入`sudo python3 -m ipmininet.examples --topo=simple_ospf4_network`，启动包含两个路由器和两个主机的网络。

    #img(src: "../pic/image156.png")

  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。

  + 在h1的终端内输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址和子网掩码不符合实验要求。

    #img(src: "../pic/image157.png")

  + 执行如下命令，将主机1的eth0网卡的ip地址和子网掩码设置为实验要求。

    - `sudo ifconfig h1-eth0 10.0.0.2`

  + 输入`xterm h2`，打开h2的终端，输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址不符合实验要求。

    #img(src: "../pic/image158.png")

  + 执行如下命令，将主机2的eth0网卡的ip地址和子网掩码设置为实验要求。

    - `sudo ifconfig h2-eth0 10.0.2.2`

  == 五. 配置路由器

  + 在mininet终端中输入`xterm r1`打开路由器1的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。该路由器有两块网卡，eth0和eth1。

    #img(src: "../pic/image159.png")

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r1-eth0 10.0.0.1/24`命令，配置网卡eth0的IP地址为10.0.0.1/24

    - 执行`ifconfig r1-eth1 10.0.1.1/24`命令，配置网卡eth1的IP地址为10.0.1.1/24

    #img(src: "../pic/image160.png")

  + 在mininet终端中输入`xterm r2`打开路由器2的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。

    #img(src: "../pic/image161.png")

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r2-eth0 10.0.1.2/24`命令，配置网卡eth0的IP地址为10.0.1.2/24

    - 执行`ifconfig r2-eth1 10.0.2.1/24`命令，配置网卡eth1的IP地址为10.0.2.1/24

    #img(src: "../pic/image162.png")

  + 配置主机路由。

    - 查看主机1路由信息。主机1没有默认路由，从主机1出去的流量不能到达eth0的网关，即不能到达路由器1。

    - 查看命令：`route -n`

      #img(src: "../pic/image163.png")

    - 执行如下命令，修改主机1的默认网关

    - `sudo route add default gw 10.0.0.1`

    - 查看修改后的路由信息，主机1的默认网关为网卡eth0的网关

    - 再次执行：`route -n`

      #img(src: "../pic/image164.png")

    - 查看主机2的路由信息。主机2没有默认路由，从主机2出去的流量不能达到eth1网关，即不能到达路由1

    - 查看命令：`route -n`

      #img(src: "../pic/image165.png")

    - 同样的，我们修改路由信息：`sudo route add default gw 10.0.2.1`

    - 查看修改后的路由信息，主机2的默认网关为网卡eth0的网关。

    - 查看指令：`route -n`

      #img(src: "../pic/image166.png")

  == 六. 配置路由器OSPF协议

  + 在mininet终端上执行r1 route查看路由器1的路由表，可以发现虽然网卡的ip地址更新了，但是却没有通向主机2网络的路由条目，这需要我们手动更新OSPF协议中路由器所连接的网络。

    - 执行指令：`r1 route`

      #img(src: "../pic/image167.png")

  + 打开路由器1的终端，输入`telnet localhost ospfd`，使用telnet工具连ospf进程，输入默认密码：zebra。

  + 依次输入下列三条指令，进入ospf的配置模式。

    - `enable`

    - `configure terminal`

    - `router ospf`

  + 输入下列命令查看ospf信息，可以发现network只有刚创建网络时的ip地址，需要我们手动添加更新后的。

    - `show running-config`

      #img(src: "../pic/image168.png")

  + 依次输入下列三条指令，添加新的network。

    - `network 10.0.0.0/24 area 0.0.0.0`

    - `network 10.0.1.0/24 area 0.0.0.0`

    - `write`

    #img(src: "../pic/image169.png")

  + 再次查看ospf信息，可以发现已经添加成功。查看指令：`show running-config`

    #img(src: "../pic/image170.png")

  + 同样的方式，更新路由器2的网络信息。即在r2的终端，重复上述r1的操作。

    #img(src: "../pic/image171.png")

  == 七. 验证OSPF协议

  + 打开主机1的终端，ping主机2的地址，发现可以ping通。

    - 指令：`ping 10.0.2.2`

      #img(src: "../pic/image172.png")

  + 在mininet终端上再次查看r1和r2的路由表，发现已经有了由ospf发现的目标网络，标志UG表示连接的网络是可达的且邻接路由器是网关路由器。

    - 执行:`r1 route`,`r2 route`

      #img(src: "../pic/image173.png")

  + 新开一个路由器1终端，登录ospf进程后，输入`show ip ospf route`后同样可以看到通过`ospf`协议获取的路由表。

    - `telnet localhost ospfd`

    - `enable`

    - `configure terminal`

    - `router ospf`

    - `show ip ospf route`

    #img(src: "../pic/image174.png")

  + 再新开一个r1终端，输入`tcpdump -i r1-eth0 proto ospf -v`可以看到路由器收到的ospf协议包

    #img(src: "../pic/image175.png")
]
