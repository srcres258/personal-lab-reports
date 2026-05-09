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

#experiment(title: "实验1-1 常用网络命令的使用")[
  == 一. 实验目的

  + 掌握ping、ifconfig、traceroute、netstat、arp、nslookup等命令含义和基本用法；
  + 学会运用ping、ifconfig、traceroute、netstat、arp、nslookup等命令去解决遇到的基本问题。

  == 二. 实验内容

  + 使用ping命令测试网络连通性；
  + 使用ifconfig命令显示正在使用的计算机的IP信息情况，如：IP地址、子网掩码、默认网关。通过IP地址可以进行扫描、远程管理、入侵检测等；
  + 使用tracert命令列出本地计算机与目标计算机之间所有经过的计算机信息，traceroute命令也能够提供关于路径数据包的信息，通过该命令可以知道本地计算机和远程计算机之间经过了多少跳数；
  + 使用netstat命令列出当前所有的网络连接、连接统计以及路由表信息。默认情况下，netstat命令将会罗列出本地计算机所有开启的端口情况，以及它所连接的外部计算机情况；
  + 查看ARP表及其所有条目，同时练习向表中增加一个新的条目并随后删除它。（ARP命令是确定IP地址和MAC地址对于关系正确与否的最简单方式）；
  + 使用nslookup命令从本地DNS服务器中查看所有的IP地址和域名信息（互联网电话薄）；

  == 三. 实验正文

  === 第1关 ping命令的使用

  - 桌面右键打开terminal终端。

  - 输入 `ping www.baidu.com` 测试百度网站的连通性。过程中可以按ctrl+c来停止。

    ```
    PING www.a.shifen.com (39.156.70.46) 56(84) bytes of data.
    64 bytes from 39.156.70.46: icmp_seq=1 ttl=52 time=17.9 ms
    64 bytes from 39.156.70.46: icmp_seq=2 ttl=52 time=17.9 ms
    64 bytes from 39.156.70.46: icmp_seq=3 ttl=52 time=17.5 ms
    64 bytes from 39.156.70.46: icmp_seq=4 ttl=52 time=17.9 ms
    64 bytes from 39.156.70.46: icmp_seq=5 ttl=52 time=18.0 ms
    64 bytes from 39.156.70.46: icmp_seq=6 ttl=52 time=18.0 ms
    64 bytes from 39.156.70.46: icmp_seq=7 ttl=52 time=17.7 ms
    64 bytes from 39.156.70.46: icmp_seq=8 ttl=52 time=17.8 ms
    64 bytes from 39.156.70.46: icmp_seq=9 ttl=52 time=17.1 ms
    ^C
    --- www.a.shifen.com ping statistics ---
    9 packets transmitted, 9 received, 0% packet loss, time 8012ms
    rtt min/avg/max/mdev = 17.102/17.769/18.024/0.275 ms
    ```

  - 输入 `ping www.baidu.com -c 5`。-c参数可以指定发送的包的数量，本例中发送到5个包时就会自动停止。

    ```
    PING www.a.shifen.com (39.156.70.46) 56(84) bytes of data.
    64 bytes from 39.156.70.46: icmp_seq=1 ttl=52 time=17.9 ms
    64 bytes from 39.156.70.46: icmp_seq=2 ttl=52 time=18.0 ms
    64 bytes from 39.156.70.46: icmp_seq=3 ttl=52 time=17.9 ms
    64 bytes from 39.156.70.46: icmp_seq=4 ttl=52 time=18.0 ms
    64 bytes from 39.156.70.46: icmp_seq=5 ttl=52 time=18.2 ms

    --- www.a.shifen.com ping statistics ---
    5 packets transmitted, 5 received, 0% packet loss, time 4005ms
    rtt min/avg/max/mdev = 17.871/17.991/18.153/0.093 ms
    ```

  - 通过ping -c这个命令自己定义发送数据包的个数，对衡量网络速度很有帮助。在本例中，我们想要测试发送5个数据包的返回的平均时间是多少，最快的时间是多少，最慢的时间是多少。从图可知：在给百度发送5个数据包的过程当中，返回了5个，丢失了0个数据包，这5个数据包当中返回速度最快为17.871ms，最慢18.153ms，平均速度为17.991ms。

  === 第2关 ifconfig命令的使用

  - 打开终端，输入ifconfig查看网卡信息，可以看到ip地址为`172.16.0.132`，掩码为`255.255.0.0`

    ```
    enp5s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
            inet 172.16.0.132  netmask 255.255.0.0  broadcast 172.16.255.255
            inet6 fdd8:2c67:ba3e::80c  prefixlen 128  scopeid 0x0<global>
            inet6 fdd8:2c67:ba3e:0:6728:429e:ac01:ad86  prefixlen 64  scopeid 0x0<global>
            inet6 fdd8:2c67:ba3e:0:facb:bf26:63fa:417b  prefixlen 64  scopeid 0x0<global>
            inet6 fe80::b041:2c31:8dab:95f4  prefixlen 64  scopeid 0x20<link>
            ether 04:7c:16:7f:e7:5c  txqueuelen 1000  (Ethernet)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
            inet 127.0.0.1  netmask 255.0.0.0
            inet6 ::1  prefixlen 128  scopeid 0x10<host>
            loop  txqueuelen 1000  (Local Loopback)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    wlo1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
            ether 2e:31:be:76:40:89  txqueuelen 1000  (Ethernet)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
    ```

  - 查看指定网卡的信息，例如查看`enp5s0`网卡的信息：

    ```
    enp5s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
            inet 172.16.0.132  netmask 255.255.0.0  broadcast 172.16.255.255
            inet6 fdd8:2c67:ba3e::80c  prefixlen 128  scopeid 0x0<global>
            inet6 fdd8:2c67:ba3e:0:6728:429e:ac01:ad86  prefixlen 64  scopeid 0x0<global>
            inet6 fdd8:2c67:ba3e:0:facb:bf26:63fa:417b  prefixlen 64  scopeid 0x0<global>
            inet6 fe80::b041:2c31:8dab:95f4  prefixlen 64  scopeid 0x20<link>
            ether 04:7c:16:7f:e7:5c  txqueuelen 1000  (Ethernet)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
    ```

  - 输入`ifconfig --help`可以查看具体帮助信息

    ```
    Usage:
      ifconfig [-a] [-v] [-s] <interface> [[<AF>] <address>]
      [add <address>[/<prefixlen>]]
      [del <address>[/<prefixlen>]]
      [[-]broadcast [<address>]]  [[-]pointopoint [<address>]]
      [netmask <address>]  [dstaddr <address>]  [tunnel <address>]
      [outfill <NN>] [keepalive <NN>]
      [hw <HW> <address>]  [mtu <NN>]
      [[-]trailers]  [[-]arp]  [[-]allmulti]
      [multicast]  [[-]promisc]
      [mem_start <NN>]  [io_addr <NN>]  [irq <NN>]  [media <type>]
      [txqueuelen <NN>]
      [name <newname>]
      [[-]dynamic]
      [up|down] ...

      <HW>=Hardware Type.
      List of possible hardware types:
        loop (Local Loopback) slip (Serial Line IP) cslip (VJ Serial Line IP)
        slip6 (6-bit Serial Line IP) cslip6 (VJ 6-bit Serial Line IP) adaptive (Adaptive Serial Line IP)
        ether (Ethernet) netrom (AMPR NET/ROM) tunnel (IPIP Tunnel)
        ppp (Point-to-Point Protocol) arcnet (ARCnet) dlci (Frame Relay DLCI)
        frad (Frame Relay Access Device) sit (IPv6-in-IPv4) irda (IrLAP)
        infiniband (InfiniBand) eui64 (Generic EUI-64)
      <AF>=Address family. Default: inet
      List of possible address families:
        unix (UNIX Domain) inet (DARPA Internet) inet6 (IPv6)
        netrom (AMPR NET/ROM) ipx (Novell IPX) ddp (Appletalk DDP)
    ```

  === 第3关 traceroute命令的使用

  - 输入`traceroute www.baidu.com`可以列出本地计算机同`www.baidu.com`之间经过的每一个节点

    ```
     1  2409:8a0c:22e:c660:fed5:86ff:fed4:c490 (2409:8a0c:22e:c660:fed5:86ff:fed4:c490)  0.675 ms  0.601 ms 0.494 ms
     2  2409:800c:10:1006::1 (2409:800c:10:1006::1)  2.526 ms  3.431 ms  3.289 ms
     3  2409:800c:10:2006:: (2409:800c:10:2006::)  2.335 ms  2.461 ms  2.744 ms
     4  *  *  *
     5  *  *  *
     6  2409:8080:0:2:106:161:0:1 (2409:8080:0:2:106:161:0:1)  17.516 ms  2409:8080:0:2:106:166:0:1 (2409:8080:0:2:106:166:0:1)  12.384 ms  13.453 ms
     7  2409:8000:3018:3:: (2409:8000:3018:3::)  14.592 ms  17.490 ms  2409:8000:3008:3:: (2409:8000:3008:3::)  16.404 ms
     8  2409:8000:3018:2:: (2409:8000:3018:2::)  16.996 ms  2409:8c00:6c20:2::1 (2409:8c00:6c20:2::1)  14.396 ms  11.235 ms
     9  2409:8c00:6c20:2::1 (2409:8c00:6c20:2::1)  10.980 ms  2409:8c00:6c20:9::1 (2409:8c00:6c20:9::1)  14.923 ms  2409:8c00:6c20:2::1 (2409:8c00:6c20:2::1)  14.879 ms
    10  240c:4001:1010::eb2:ec1:2 (240c:4001:1010::eb2:ec1:2)  19.312 ms  240c:4001:1010::eb1:eb2:2 (240c:4001:1010::eb1:eb2:2)  22.395 ms  240c:4051:1101:100:0:ef2:eb1:2 (240c:4051:1101:100:0:ef2:eb1:2)  16.150ms
    11  240c:4051:1102:100:0:ef1:eb1:2 (240c:4051:1102:100:0:ef1:eb1:2)  15.242 ms  240c:4051:1102:100:0:ef2:eb1:2 (240c:4051:1102:100:0:ef2:eb1:2)  13.141 ms  240c:4051:1101:100:0:8:ef3:2 (240c:4051:1101:100:0:8:ef3:2)  15.033 ms
    12  240c:4051:1102:100:0:3:ef3:2 (240c:4051:1102:100:0:3:ef3:2)  17.697 ms  240c:4051:1102:100:0:ef1:eb1:2 (240c:4051:1102:100:0:ef1:eb1:2)  19.586 ms  240c:4051:1101:100:0:1:ef2:2 (240c:4051:1101:100:0:1:ef2:2)  16.982 ms
    13  240c:4051:1101:100:0:8:ef1:2 (240c:4051:1101:100:0:8:ef1:2)  13.257 ms  *  *
    14  *  *  *
    15  *  *  *
    ```

  - `-m`参数可以指定跳转次数. 如运行 `traceroute www.baidu.com -m 4`

    ```
     1  2409:8a0c:22e:c660:fed5:86ff:fed4:c490 (2409:8a0c:22e:c660:fed5:86ff:fed4:c490)  0.675 ms  0.608 ms 0.542 ms
     2  2409:800c:10:1006::1 (2409:800c:10:1006::1)  2.591 ms  3.068 ms  2.324 ms
     3  2409:800c:10:2006:: (2409:800c:10:2006::)  2.084 ms  *  4.378 ms
     4  2409:8080:0:2:1203:1252:: (2409:8080:0:2:1203:1252::)  2.786 ms  *  2409:8080:0:2:1204:1251:: (2409:8080:0:2:1204:1251::)  5.798 ms
    ```

  === 第4关 traceroute命令的使用

  - `netstat`是一个非常有用的命令行工具，它可以帮助我们监控和诊断网络问题。在 NixOS 系统中，我们可以使用`netstat`命令来查看网络连接、路由表、接口统计等信息。

    显示所有活动的 TCP 连接：

    ```
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State
    tcp        0      0 localhost:37415         0.0.0.0:*               LISTEN
    tcp        0      0 localhost:44637         0.0.0.0:*               LISTEN
    tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN
    tcp        0      0 srcres-desktop:54564    cdn-185-199-110-1:https ESTABLISHED
    tcp        0      0 srcres-desktop:41626    117.161.124.75:https    ESTABLISHED
    tcp        0      0 srcres-desktop:43478    93.243.107.34.bc.:https ESTABLISHED
    tcp        0      0 srcres-desktop:48438    120.221.204.185:7826    ESTABLISHED
    tcp        0      0 srcres-desktop:46452    4.249.131.160:https     ESTABLISHED
    tcp        0      0 srcres-desktop:38470    13.89.179.11:https      ESTABLISHED
    tcp        0      0 srcres-desktop:45904    120.220.166.9:https     ESTABLISHED
    tcp        0      0 srcres-desktop:59098    120.221.204.185:7826    ESTABLISHED
    tcp        0      0 srcres-desktop:38408    143.244.210.202:https   TIME_WAIT
    tcp        0      0 srcres-desktop:57550    143.244.210.202:https   TIME_WAIT
    tcp        0      0 srcres-desktop:57562    143.244.210.202:https   TIME_WAIT
    tcp        0      0 srcres-desktop:42186    cdn-185-199-111-1:https ESTABLISHED
    tcp        0      0 srcres-desktop:52790    36.150.52.253:https     ESTABLISHED
    tcp        0      0 srcres-desktop:53954    36.150.52.253:https     TIME_WAIT
    tcp        0      0 srcres-desktop:60716    36.150.52.253:https     ESTABLISHED
    tcp        0      0 srcres-desktop:60912    36.150.52.253:https     TIME_WAIT
    tcp        0      0 srcres-desktop:58850    111.19.247.143:https    ESTABLISHED
    tcp        0      0 localhost:40886         localhost:37415         ESTABLISHED
    tcp        0      0 srcres-desktop:51854    183.201.224.90:https    ESTABLISHED
    tcp        0      0 srcres-desktop:46486    223.111.123.18:https    ESTABLISHED
    tcp        0      0 srcres-desktop:56712    ec2-35-178-239-20:https ESTABLISHED
    tcp        0      0 srcres-desktop:45190    146.75.45.91:https      ESTABLISHED
    tcp        0      0 srcres-desktop:51296    client-west.ibsob:https ESTABLISHED
    tcp        0      0 srcres-desktop:45708    150.171.110.135:https   TIME_WAIT
    tcp        0      0 srcres-desktop:41340    .:https                 ESTABLISHED
    tcp        0      0 srcres-desktop:33754    104.244.42.197:https    ESTABLISHED
    tcp        0      0 srcres-desktop:40130    31.13.85.2:https        ESTABLISHED
    tcp        0      0 srcres-desktop:56430    localhost:https         ESTABLISHED
    tcp        0      0 localhost:37415         localhost:40886         ESTABLISHED
    tcp        0      0 srcres-desktop:32804    lb-140-82-113-26-:https ESTABLISHED
    tcp        0     25 srcres-desktop:59402    lb-140-82-113-21-:https LAST_ACK
    tcp        0      0 srcres-desktop:54860    104.21.39.212:https     ESTABLISHED
    tcp        0      0 srcres-desktop:57770    120.192.82.79:https     ESTABLISHED
    tcp        0      0 srcres-desktop:54628    111.6.167.135:https     ESTABLISHED
    tcp        0     25 srcres-desktop:54190    lb-140-82-112-21-:https FIN_WAIT1
    tcp        0      0 srcres-desktop:40624    cdn-185-199-109-1:https ESTABLISHED
    tcp        0      0 srcres-desktop:40648    cdn-185-199-109-1:https ESTABLISHED
    tcp        0      0 srcres-desktop:51162    151.101.129.91:https    ESTABLISHED
    tcp6       0      0 [::]:ssh                [::]:*                  LISTEN
    tcp6       0      0 [::]:cypress-stat       [::]:*                  LISTEN
    ```

    显示所有活动的 UDP 连接：

    ```
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State
    udp        0      0 srcres-desktop:bootpc   _gateway:bootps         ESTABLISHED
    udp        0      0 0.0.0.0:mdns            0.0.0.0:*
    udp6       0      0 srcres-de:dhcpv6-client [::]:*
    ```

    显示所有监听的套接字：

    ```
    Active Internet connections (only servers)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State
    tcp        0      0 localhost:37415         0.0.0.0:*               LISTEN
    tcp        0      0 localhost:44637         0.0.0.0:*               LISTEN
    tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN
    tcp6       0      0 [::]:ssh                [::]:*                  LISTEN
    tcp6       0      0 [::]:cypress-stat       [::]:*                  LISTEN
    udp        0      0 0.0.0.0:mdns            0.0.0.0:*
    udp6       0      0 srcres-de:dhcpv6-client [::]:*
    raw6       0      0 [::]:ipv6-icmp          [::]:*                  7
    Active UNIX domain sockets (only servers)
    Proto RefCnt Flags       Type       State         I-Node   Path
    unix  2      [ ACC ]     STREAM     LISTENING     3761     /run/user/1000/systemd/private
    unix  2      [ ACC ]     STREAM     LISTENING     3763     /run/user/1000/systemd/io.systemd.Manager
    unix  2      [ ACC ]     STREAM     LISTENING     3771     /run/user/1000/bus
    unix  2      [ ACC ]     STREAM     LISTENING     16925    /tmp/.X11-unix/X0
    unix  2      [ ACC ]     STREAM     LISTENING     3772     /run/user/1000/gcr/ssh
    unix  2      [ ACC ]     STREAM     LISTENING     3773     /run/user/1000/gnupg/S.gpg-agent.ssh
    unix  2      [ ACC ]     STREAM     LISTENING     3774     /run/user/1000/gnupg/S.gpg-agent
    unix  2      [ ACC ]     STREAM     LISTENING     3775     /run/user/1000/pulse/native
    unix  2      [ ACC ]     STREAM     LISTENING     3776     /run/user/1000/pipewire-0
    unix  2      [ ACC ]     STREAM     LISTENING     3777     /run/user/1000/pipewire-0-manager
    unix  2      [ ACC ]     STREAM     LISTENING     3778     /run/user/1000/speech-dispatcher/speechd.sock
    unix  2      [ ACC ]     STREAM     LISTENING     8632     /run/user/1000/kwallet5.socket
    unix  2      [ ACC ]     STREAM     LISTENING     13050    /run/user/1000/keyring/control
    unix  2      [ ACC ]     STREAM     LISTENING     16908    /run/user/1000/wayland-1
    unix  2      [ ACC ]     STREAM     LISTENING     16909    /run/user/1000/niri.wayland-1.2103.sock
    unix  2      [ ACC ]     STREAM     LISTENING     9592     /run/systemd/io.systemd.BootControl
    unix  2      [ ACC ]     STREAM     LISTENING     7045     /run/user/1000/keyring/pkcs11
    unix  2      [ ACC ]     STREAM     LISTENING     9936     /run/user/1000/xwls-1
    unix  2      [ ACC ]     STREAM     LISTENING     7659     /run/dbus/system_bus_socket
    unix  2      [ ACC ]     STREAM     LISTENING     7661     /run/ssh-unix-local/socket
    unix  2      [ ACC ]     STREAM     LISTENING     7662     /run/systemd/io.systemd.Hostname
    unix  2      [ ACC ]     STREAM     LISTENING     8072     /run/user/1000/wayland-proxy-2550
    unix  2      [ ACC ]     STREAM     LISTENING     34930    /run/user/1000/gnupg/S.scdaemon
    unix  2      [ ACC ]     STREAM     LISTENING     17895    /run/user/1000/vscode-5571de24-1.10-main.sock
    unix  2      [ ACC ]     STREAM     LISTENING     33372    /run/user/1000/nvim.5128.0
    unix  2      [ ACC ]     STREAM     LISTENING     35045    /run/user/1000/vscode-git-8927c80bc0.sock
    unix  2      [ ACC ]     STREAM     LISTENING     21126    /run/systemd/private
    unix  2      [ ACC ]     STREAM     LISTENING     21127    /run/systemd/userdb/io.systemd.DynamicUser
    unix  2      [ ACC ]     STREAM     LISTENING     21128    /run/systemd/io.systemd.ManagedOOM
    unix  2      [ ACC ]     STREAM     LISTENING     21129    /run/systemd/io.systemd.Manager
    unix  2      [ ACC ]     SEQPACKET  LISTENING     21147    /run/systemd/coredump
    unix  2      [ ACC ]     STREAM     LISTENING     21148    /run/systemd/io.systemd.Credentials
    unix  2      [ ACC ]     STREAM     LISTENING     9664     /run/systemd/io.systemd.Login
    unix  2      [ ACC ]     STREAM     LISTENING     21153    /run/systemd/journal/stdout
    unix  2      [ ACC ]     STREAM     LISTENING     21154    /run/systemd/oom/io.systemd.ManagedOOM
    unix  2      [ ACC ]     SEQPACKET  LISTENING     21155    /run/udev/control
    unix  2      [ ACC ]     STREAM     LISTENING     46154    /run/user/1000/nvim.7926.0
    unix  2      [ ACC ]     STREAM     LISTENING     35549    /run/user/1000/vscode-git-17496bd06b.sock
    unix  2      [ ACC ]     STREAM     LISTENING     13433    /run/systemd/journal/io.systemd.journal
    unix  2      [ ACC ]     STREAM     LISTENING     7660     /nix/var/nix/daemon-socket/socket
    unix  2      [ ACC ]     STREAM     LISTENING     31873    /var/run/nscd/socket
    unix  2      [ ACC ]     STREAM     LISTENING     472      /run/udev/io.systemd.Udev
    unix  2      [ ACC ]     STREAM     LISTENING     3548     /run/greetd-1789.sock
    unix  2      [ ACC ]     STREAM     LISTENING     16924    @/tmp/.X11-unix/X0
    ```

    显示路由表：

    ```
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
    default         _gateway        0.0.0.0         UG        0 0          0 enp5s0
    172.16.0.0      0.0.0.0         255.255.0.0     U         0 0          0 enp5s0
    ```

    显示每种协议的统计信息：

    ```
    Ip:
        Forwarding: 2
        1599183 total packets received
        1 with invalid addresses
        0 forwarded
        0 incoming packets discarded
        1599182 incoming packets delivered
        904714 requests sent out
        202 outgoing packets dropped
        43 dropped because of missing route
        OutTransmits: 904714
    Icmp:
        587 ICMP messages received
        0 input ICMP message failed
        ICMP input histogram:
            destination unreachable: 546
            timeout in transit: 25
            echo replies: 16
        534 ICMP messages sent
        0 ICMP messages failed
        ICMP output histogram:
            destination unreachable: 518
            echo requests: 16
    IcmpMsg:
            InType0: 16
            InType3: 546
            InType11: 25
            OutType3: 518
            OutType8: 16
    Tcp:
        1825 active connection openings
        20 passive connection openings
        21 failed connection attempts
        66 connection resets received
        18 connections established
        1594514 segments received
        933763 segments sent out
        438 segments retransmitted
        3 bad segments received
        611 resets sent
    Udp:
        3550 packets received
        517 packets to unknown port received
        0 packet receive errors
        4279 packets sent
        0 receive buffer errors
        0 send buffer errors
        IgnoredMulti: 5
    UdpLite:
    TcpExt:
        982 TCP sockets finished time wait in fast timer
        72 packets rejected in established connections because of timestamp
        PAWSOldAck: 1
        3865 delayed acks sent
        Quick ack mode was activated 2486 times
        84621 packet headers predicted
        23132 acknowledgments not containing data payload received
        34573 predicted acknowledgments
        1 times recovered from packet loss due to fast retransmit
        TCPSackRecovery: 5
        Detected reordering 218 times using SACK
        4 congestion windows fully recovered without slow start
        TCPDSACKUndo: 1
        3 congestion windows recovered without slow start after partial ack
        TCPLostRetransmit: 257
        TCPSackFailures: 2
        10 fast retransmits
        5 retransmits in slow start
        TCPTimeouts: 349
        TCPLossProbes: 95
        TCPLossProbeRecovery: 6
        TCPBacklogCoalesce: 3780
        TCPDSACKOldSent: 3049
        TCPDSACKOfoSent: 873
        TCPDSACKRecv: 55
        TCPDSACKOfoRecv: 1
        108 connections reset due to unexpected data
        4 connections reset due to early user close
        9 connections aborted due to timeout
        TCPDSACKIgnoredNoUndo: 39
        TCPSackShifted: 21
        TCPSackMerged: 30
        TCPSackShiftFallback: 321
        TCPRcvCoalesce: 344584
        TCPOFOQueue: 298313
        TCPOFOMerge: 873
        TCPChallengeACK: 3
        TCPSYNChallenge: 3
        TCPSpuriousRtxHostQueues: 3
        TCPAutoCorking: 1452
        TCPFromZeroWindowAdv: 106
        TCPToZeroWindowAdv: 106
        TCPWantZeroWindowAdv: 14
        TCPSynRetrans: 238
        TCPOrigDataSent: 82031
        TCPHystartTrainDetect: 106
        TCPHystartTrainCwnd: 3507
        TCPACKSkippedPAWS: 52
        TCPACKSkippedSeq: 10
        TCPWinProbe: 1
        TCPKeepAlive: 1306
        TCPDelivered: 82900
        TCPAckCompressed: 235095
        TcpTimeoutRehash: 340
        TCPDSACKRecvSegs: 56
    IpExt:
        OutMcastPkts: 2
        InBcastPkts: 5
        InOctets: 1652391525
        OutOctets: 140598926
        OutMcastOctets: 80
        InBcastOctets: 1640
        InNoECTPkts: 1608661
    MPTcpExt:
    ```

  === 第5关 arp命令的使用

  - `arp`命令用于管理和查看内核ipv4网络ARP缓存。它可用于向缓存表中添加和删除记录。ARP是地址解析协议（Address Resolution Protocol）的缩写，用于找出给定ipv4地址的mac地址

    ```
    Address                  HWtype  HWaddress           Flags Mask            Iface
    _gateway                 ether   00:30:18:0a:17:d4   C                     enp5s0
    srcres-orange-pi.lan     ether   62:47:0b:55:70:b8   C                     enp5s0
    ```

  - `arp -s`指令可以增加arp表项，`-d`可以删除表项

  === 第6关 nslookup命令的使用

  - `nslookup`命令可以查询DNS服务器指定类型的记录，通过域名获取ip地址

    ```
    Server:		172.16.0.1
    Address:	172.16.0.1#53

    www.baidu.com	canonical name = www.a.shifen.com.
    Name:	www.a.shifen.com
    Address: 39.156.70.46
    Name:	www.a.shifen.com
    Address: 39.156.70.239
    ```
]

#let img(src: str) = align(center, image(src, width: 6cm))

#let img2(src1: str, src2: str) = align(center, grid(
  columns: 2,
  align(center, image(src1, width: 6cm)),
  align(center, image(src2, width: 6cm))
))

#experiment(title: "实验1-2 模拟器的配置与使用")[
  == 一. 实验目的

  + 掌握Packet Tracer软件的用法；
  + 掌握交换机基本信息的配置管理以及配置基本命令的用法。

  == 二. 实验内容

  运用Packet Tracer软件，进行基本配置与管理、交换机端口的基本配置、路由器的基本配置操作。

  == 三. 基本配置与管理

  + 在桌面打开终端，输入`packettracer`启动Cisco packet tracer软件。在登录界面Login Server选择Worldwide后进入注册账号界面。使用邮箱进行注册（QQ邮箱，网易邮箱等），并填写个人信息。

    #img2(
      src1: "pic/IMG_20260507_223301.jpg",
      src2: "pic/IMG_20260507_223321.jpg"
    )

    #img(src: "pic/IMG_20260507_223332.jpg")

  + 利用一台型号为2950-24的交换机作为组网基础，将两台PC互连，组建一个小型局域网。

    #img(src: "pic/IMG_20260507_223823.jpg")

  + 设置PC的IP地址。双击计算机终端设备PC0图标，随后会显示PC0设置窗口，然后选择“桌面”选项卡，再双击IP地址设置图标，便会出现IP配置窗口，对PC0的IP进行配置：IP地址为192.11-28.0.10，子网掩码为255.255.255.0。用同样的方法，对PC1进行配置：IP址为192.11-28.0.20，子网掩码为255.255.255.0。

    #img2(
      src1: "pic/IMG_20260507_223856.jpg",
      src2: "pic/IMG_20260507_223931.jpg"
    )

  + 网络连通性测试。双击计算机终端设备PC0图标显示PC0设置窗口，选择“桌面”选项卡，双击“终端”，出现窗口。在该窗口中输入“ping 192.11-28.0.20”命令，以检查网络的连通性。

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

  == 四. 交换机端口的基本配置

  本次实验的网络拓扑结构如图所示

    #img(src: "pic/IMG_20260508_085044.jpg")

  + 从用户模式进入特权模式

  + 进入配置模式，修改交换机名称，输入以下命令

    #img(src: "pic/IMG_20260508_085133.jpg")

  + 显示当前活动的交换机配置文件，输入以下命令

    #img(src: "pic/IMG_20260508_085159.jpg")

  + 输入以下命令，以便显示接口1的统计和状态信息

    #img(src: "pic/IMG_20260508_085233.jpg")

  + 查看VLAN信息.其中，VLAN1是默认的管理VLAN，未对交换机进行配置时所有的接口默认属于VLAN1。

    #img(src: "pic/IMG_20260508_085244.jpg")

  + 查看Flash缓存内容

    #img(src: "pic/IMG_20260508_085258.jpg")

  + 输入以下命令，以查看IOS版本号以及系统硬件的配置情况、引导镜像等（注：IOS为Cisco网络设备的操作系统）

    #img(src: "pic/IMG_20260508_085311.jpg")

  + 恢复交换机到默认设置。输入以下命令，以恢复交换机到默认设置

    #img(src: "pic/IMG_20260508_085335.jpg")

  + 配置主机名称和控制端密码。输入以下命令，以配置主机名称和控制端密码

    #img(src: "pic/IMG_20260508_085445.jpg")

  + 为第二层交换机设置管理VLAN与默认网关。输入以下命令，为第二层交换机设置管理VLAN与默认网关.

    #img(src: "pic/IMG_20260508_085554.jpg")

  + 查看配置后的默认VLAN虚接口信息。输入以下命令，查看配置后的默认VLAN虚接口信息

    #img(src: "pic/IMG_20260508_085625.jpg")

  + 查看MAC地址表。输入以下命令，查看MAC地址表

    #img(src: "pic/IMG_20260508_085638.jpg")
]

#experiment(title: "实验1-3 交换机及其VLAN的配置")[
  == 一. 实验目的

  + 熟悉交换机的配置环境；
  + 了解交换机基于端口的VLAN的设置。

  == 二. 实验内容

  + 在packettracer软件中构建网络拓扑，产生两个VLAN，配置各个主机的IP和子网掩码；
  + 在packettracer软件中通过交换机终端操作，为每个VLAN分配交换机成员端口；
  + 进行删除VLAN的操作；
  + 理解VLAN1为什么不能被删除。

  == 三. 三层交换机VLAN配置

  + VLAN配置如图所示。

  + 根据实验手册中所提供的示意图，分别为PC0、PC1、PC2、PC3设置IP地址，如下图所示。

    - PC0设置IP地址

    - PC1设置IP地址

    - PC2设置IP地址

    - PC3设置IP地址

  + 查看交换机VLAN划分情况`Switch#show vlan`。

  + 创建VLAN

    `Switch#configure terminal`

    `Switch(config)#vlan 2`

  + 为指定的VLAN增加以太网端口。

    - 为VLAN2增加端口（1）

    - 为VLAN2增加端口（2）

  + 增加端口后查看VLAN的配置，发现Fa0/1与Fa0/2已成功加入VLAN2。

  + 创建VLAN接口以及配置VLAN接口的IP地址。

    `Switch#configure terminal`

    `Enter configuration commands, one per line.  End with CNTL/Z.`

    `Switch(config)#interface vlan 2 `

    `Switch(config-if)#ip address 192.11-38.200.100 255.255.255.0`

    `Switch(config-if)#end`

    - 配置VLAN接口的IP地址

  + 成功配置好VLAN接口的IP地址后再次查看交换机VLAN划分情况。

    此步骤选用`Switch#show run`指令查看VLAN2接口的IP地址是否配置成功

    - 成功为VLAN2配置IP地址

  + 删除VLAN2及其接口。

    `Switch(config)#no int vlan 2  //首先删除VALN接口`

    `Switch(config)#no vlan 2   //删除VLAN`
]

#experiment(title: "实验1-4 协议分析--ARP协议")[
  == 一. 实验目的

  + 熟练并掌握Wireshark的基本使用；
  + 分析以太网帧；
  + 分析MAC地址和ARP。

  == 二. 实验内容

  + Wireshark的打开方式和基本使用；
  + 通过Wireshark捕获arp协议包并分析。

  == 三. Wireshark的使用

  + 打开终端输入`wireshark`来启动Wireshark。

  + 在界面顶部的网卡选项菜单中选择用户自己的网卡。

  + 启动桌面的chrome浏览器。

  + 开始分组捕获。点击工具栏中的“捕获”按钮，开始分组捕获。

  + 在运行分组捕获的同时，在浏览器地址栏中输入南京师范大学的网址：`http://www.nnu.edu.cn/`。

  + 当完整的页面加载完成后，单击捕获对话框中的“停止捕获”按钮，停止分组捕获。此时，Wireshark主窗口显示已捕获的本次通信的所有协议报文。

  + 在协议筛选框中输入`http`，按回车键，分组列表窗口中将只显示HTTP报文。

  + 滑动窗口找到带有`GET/HTTP/1.1`的行，该行的底部显示着`www.nnu.edu.cn`。

  + 选择该行。

  + 查看该数据包中的内容，点击`Destination`行，我们可以看到接收方的MAC地址，为`4e b5 cb 0c d2 25（48位）`

  + 点击`Source`行，我们可以看到发送方的MAC地址。在终端中使用`ifconfig`命令获取主机的MAC地址，与抓包软件所抓取的MAC地址相吻合。

  + 点击`Type`行，我们可以看到版本号为IPV4。

  + 在抓包软件的显示界面中，我们还可以抓取到的主机的IP地址以及访问的目标网页的IP地址。

    - 抓取到主机的IP地址

    - 抓取到目标网页的IP地址

  == 四. 分析地址ARP

  在协议筛选框中输入`arp`，按回车键，分组列表窗口中将只显示ARP报文。
]

#experiment(title: "实验1-5 协议分析--IP协议")[
  == 一. 实验目的

  + 分析IP协议；
  + 分析IP数据报分片。

  == 二. 实验内容

  + 通过ping命令发送ip协议包；
  + 通过wireshark捕获ip包并进行分析。

  == 三. 分析IPV4中的分片

  在本例中，我们将考察IP数据报首部。捕获此分组的步骤如下。

  + 终端输入wireshark启动wireshark，开始分组捕获。

  + 打开另一个终端，输入`ping www.baidu.com -s 4500 -c 1`，向百度发送一个大小为4500的icmp数据包。

  + 停止Wireshark。设置过滤方式为ip.dst=180.101.51.73，即目的地为百度的ip地址。Wireshark窗口中将会看到如图8-2所示的界面。

  下面对此分组进行简要分析：

  + 从捕捉到的信息可以看出IPV4协议的头部占20字节，全长为1500字节，那么数据部分的长度就为1480字节。

  + 从捕获到的分组，我们可以看出先后发送了3个数据包，第一个数据包。

    根据More fagements和Fragement offset可以判定这个数据包是分片数据包的一部分。

  + 第二个数据包

  + 第四个数据包，可以看到icmp数据包包含的ip分片。
]

#experiment(title: "实验1-6 协议分析--ICMP协议")[
  == 一. 实验目的

  掌握ICMP协议；

  == 二. 实验内容

  + 通过ping命令和traceroute命令发送ICMP协议包；
  + 通过wireshark捕获协议包并分析。

  == 三. Ping和ICMP

  利用Ping程序产生ICMP分组。Ping向因特网中的某个特定主机发送特殊的探测报文并等待主机在线的回复。具体做法如下：

  + 桌面右键打开终端terminal；

  + 输入wireshark命令启动Wireshark数据包嗅探器，在过滤显示窗口中输入`icmp`，开始wireshark分组捕获。

  + 输入`ping www.baidu.com -c 5`。其中`-c 5`指明应该返回5条ping信息。

  + 当Ping程序终止时，停止Wireshark分组捕获。

  + 分组内容显示了ICMP的详细信息，观察ICMP分组，我们可以得到许多信息：

    - 我所在的主机的IP地址为：172.16.48.15

    - 查看ICMP请求分组，ICMP的type为：8，code为：0

    - 查看ICMP响应信息，type为：0，code为：0

  == 四. ICMP和Traceroute

  在Wireshark下，用Traceroute程序捕获ICMP分组。Traceroute能够映射出通往特定的因特网主机中间途经的所有主机。

  + 启动Wireshark数据包嗅探器，开始分组捕获。

  + 在终端中输入`traceroute www.baidu.com`。

  + 当Tracerouter程序终止时，停止分组捕获；

  + 在Wireshark捕获到的分组中，我们可以获得以下信息：

    - 查看ICMP echo分组，我们发现这个分组与前面使用ping命令的ICMP echo是一样的。其中，都有type、code、checksum、identifier、Seq number；

    - 查看ICMP错误分组，它比ICMP echo分组包括的信息多，超时错误信息中，type为11，code为0；checksum备注为：unverified

    - 端口不可达的错误信息中还显示了NetBIOS Name Service相关信息：
]

#experiment(title: "实验1-7 路由器及其基本配置")[
  == 一. 实验目的

  + 熟悉在思科模拟器下对路由器的基本操作以及基本命令的使用；
  + 掌握思科中路由器的各种模式以及模式间的转换；
  + 熟悉掌握静态路由的设置方式；
  + 熟悉掌握在思科模拟器下，路由器设置静态路由的基本命令；

  == 二. 实验内容

  + 路由器配置模式及其转换；
  + 一些常用的配置命令和状态查询命令；
  + 配置路由器接口的IP地址；
  + 按拓扑结构图给路由器各端口配置IP地址；
  + 为每个路由器添加静态路由指令；
  + 验证静态路由的正确性。

  == 三. 路由器基本配置

  路由器配置示意图

  + 分别为PC0、PC1、PC2、PC3设置PC地址。

  + 对路由器进行配置。

  + 启用路由器与交换机连接的接口，使路由器与交换机能够正常通信。

  == 四. 配置静态路由

  路由器静态路由配置拓扑图如下图所示

  + 安装HWIC-2T（两路由器连接需要其提供的serial port）。

  + Router2配置

  + Router3配置（第7行修改为`interface Serial 0/1/0`），两个路由器配置完成连接成功则两局域网连通

  + 在做好上面的配置操作后，开始测试，以验证配置操作是否正确合理。在PC0电脑上运行Ping命令，可以Ping通，配置是合理的。
]

#experiment(title: "实验1-8 路由器及其动态路由协议")[
  == 一. 实验目的

  + 用模拟器Packet Tracer练习启动RIP协议配置动态路由的调试方法；
  + 掌握在Packet Tracer环境下进行路由器网络连通性测试命令。

  == 二. 实验内容

  + 路由器配置模式及其转换；
  + 一些常用的配置命令和状态查询命令；
  + 配置路由器接口和IP地址；
  + 根据实验室网络拓扑结构配置动态路由；
  + 总结静态路由与RIP动态路由的区别。

  == 三. 路由器动态路由

  本次实验的网络拓扑结构图如下图所示。

  + Switch0 配置：

  + Switch1 配置：

  + Router0 配置：

    - 完成配置后，Router0的路由表：

  + Router1配置：

    - 完成配置后，Router1的路由器表：

  + 主机IP配置

    - 配置PC0以太网0端口IP为192.168.100.10，PC1以太网0端口IP为192.168.100.12，PC2以太网0端口IP为192.168.200.11

  + 主机网关配置

    - 配置PC0网关192.168.100.1，PC2网关192.168.200.1

  + 完成配置操作后，进行网络连通性测试:

    - 在 PC0 的命令窗口中 Ping PC1 的 IP 地址，可以成功

    - Ping 交换机的 IP 地址，成功

    - Ping 自己网关的 IP 地址，成功

    - Ping 对方路由器的 IP 地址，成功

    Ping 对方 PC 机的 IP 地址，成功

  == 四. 动态路由

  本次实验的网络拓扑结构图如下图所示。

  + 说明:

    - PC0、PC1分别连接Switch0的2号和3号端口;
    - Switch0的2号端口和3号端口分别在VLAN2和VLAN3中;
    - PC2、PC3分别连接Switch1的2号和3号端口;
    - Switch1的2号和3号端口分别在VLAN4和VLAN5中;
    - Switch0的1号端口连接Router0的以太网口Fa0/0;
    - Switch1的1号端口连接Router1的以太网口Fa0/0;
    - Router0的以太网口Fa0/0的两个虚拟子接口分别为:Fa0/0.1 192.168.2.1 Fa0/0.2 192.168.3.1
    - Router1的以太网口Fa0/0的两个虚拟子接口分别为:Fa0/0.1  192.168.4.1 Fa0/0.2  192.168.5.1

  + Switch0配置

  + Switch1配置

  + Router0配置

  + Router1配置

  + 同上一实验，注意主机IP与网关的配置，若ping不通，优先检查网关是否配置正确。

  + 配置好 PC 机、交换机以及路由器后，进行网络连通性测试:

    - 在 PC0 的命令窗口中，ping 交换机，成功

    - 在 PC0 的命令窗口中，ping 对方路由器，成功

    - 在 PC0 的命令窗口中，ping 对方 PC 机，成功

  == 五. 静态路由与动态RIP路由的区别

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

  == 六. RIP工作原理

  - 每个路由器每隔30s给自己所有的邻居路由器广播RIP报文，报文的内容是这个路由器当前的路由信息；
  - 收到邻居路由器的路由表信息后，更新自己的路由表，下次将更新后的路由表告诉自己的邻居；
  - 长时间没有收到某个路由器的路由表信息，就认为这个路由器出现故障，路由表中将所有以这个出现故障的路由器为下一站的表项距离修改，表示不可达。再过一段时间依然没有回复，从路由表删除。
]

#experiment(title: "实验1-9 路由器DHCP与NAT配置")[
  == 一. 实验目的

  + 学习DHCP Server与DHCP Relay的配置和调试方法，加深对动态主机配置协议的理解；
  + 学习路由器NAT的含义与配置方法，加深对网络地址转换的理解。

  == 二. 实验内容

  + DHCP Server的配置；
  + DHCP Relay的配置；
  + 观察计算机自动获取IP地址；
  + NAT的配置。

  == 三. DHCP配置

  + 本次实验的网络拓扑结构图如下图所示：

  + Router 0配置：

  + Router 1配置：

  + 完成配置操作后，查看PC0、PC1、PC2、PC3的IP地址，发现：

    - PC0、PC1获取的IP地址在192.168.3.2\~192.168.3.254之间

    - PC2、PC3获取的IP地址在192.168.4.2\~192.168.4.254之间

  == 四. 路由器动态路由2

  + 本次实验的网络拓扑结构图如下图所示：

  + Switch 0配置：

  + Switch 1配置:

  + Router 0配置:

  + 配置 Router1:

  + 配置好 PC 机、交换机以及路由器后，进行网络连通性测试:

    - 配置完成后进行连通性实验：在PC0的命令行方式下运行`ping 202.38.1.254`

    - 在PC1的命令行方式下运行`ping 192.168.4.11`
]

#experiment(title: "实验2-1 交换机部署及配置")[
  == 一. 实验目的

  + 了解交换机的作用和工作原理。
  + 掌握交换机的基本配置方法。
  
  == 二. 实验内容

  + 搭建基于交换机的二层网络，配置交换机使网络连通；
  + 配置交换机工作于普通模式状态，正常转发数据包；
  + 抓取交换机中数据流，分析CAM表及交换机工作流程。
  
  == 三. 启动IPMininet仿真网络

  右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务。

  实验时请按照如下图所示规划的网段进行实验。

  右键打开终端输入`sudo mn --controller=remote`，启动包含一个交换机和两个主机的最基本网络。
  
  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。
  
  + 在`h1`的终端内输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址为`10.0.0.1`，子网掩码为`255.0.0.0`，不符合实验要求。

  + 执行如下命令，将主机1的eth0网卡的ip地址和子网掩码设置为实验要求。

  + 对主机2进行相同的配置，将其ip地址改为`10.0.0.3`，子网掩码改为`255.255.255.0`。

  == 五. 配置交换机

  + 在启动Mininet后的终端内输入`xterm s1`，打开交换机的终端。

  + 执行`ovs-vsctl show`命令，查看交换机信息。

    若如下图所示，即交换机的`fail_mode`为`secure`，表示交换机必须借助SDN中的控制器才能进行转发操作，我们需要在实验前先执行`ovs-vsctl del-fail-mode s1`命令，退出Secure模式。

  + 若如下图所示，表示交换机为普通交换机模式，请继续执行下面的操作步骤。

  == 六. 分析CAM表及数据流

  + 在主机1上执行`ping 10.0.0.3 -c 4`，测试网络连通性。

  + 主机2上执行`ping 10.0.0.2 -c 4`，测试网络连通性。

  + 在交换机上执行`ovs-appctl fdb/show s1`命令，看交换机中保存的CAM表。
]

#experiment(title: "实验2-2 路由器部署及配置")[
  == 一. 实验目的

  + 掌握路由器的概念、作用及工作原理；
  + 掌握路由器的基本配置方法；
  + 掌握路由表的查看方式。
  
  == 二. 实验内容

  + 启动ipmininet网络；
  + 配置主机与路由器ip；
  + 分析路由器基于IP地址转发数据包的工作原理；
  + 分析路由器中路由表，解析路由表的生成和功能。
  
  == 三. 启动IPMininet仿真网络

  右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务。
  
  实验时请按照如下图所示规划的网段进行实验。
  
  + 由于原生Mininet不支持网络层的路由器仿真，因此使用拓展过的IPMininet，需要我们通过代码创建自定义网络。

    - 进入/home/headless/ipmininet/ipmininet/examples文件夹，在此处打开终端

    - 输入`sudo gedit simple_router_network.py`创建新的网络拓扑文件，填入如下图所示的python代码
    
    - 终端中输入`sudo gedit __main__.py`打开main文件注册刚刚创建的网络拓扑，填入如下两图所示的代码，保存后退出

  + 退出到`/home/headless/ipmininet`文件夹，右键打开终端输入`sudo python3 -m ipmininet.examples --topo=simple_router_network`，启动包含一个路由器和两个主机的网络。

  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。

  + 在h1的终端内输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的不sip地址和子网掩码符合实验要求。
  
  + 执行如下命令，将主机1的eth0网卡的ip地址和子网掩码设置为实验要求。

  + 输入`xterm h2`，打开h2的终端，输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址不符合实验要求。

  + 执行如下命令，将主机2的eth0网卡的ip地址和子网掩码设置为实验要求。

  == 五. 配置路由器

  + 在mininet终端中输入`r1 route`，查看路由器1的路由表

  + 在mininet终端中输入`xterm r1`打开路由器1的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。
  
    - 该路由器有两块网卡，eth0和eth1。

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r1-eth0 192.168.0.1/24`命令，配置网卡eth0的IP地址为192.168.0.1/24

    - 执行`ifconfig r1-eth1 10.0.0.1/24`命令，配置网卡eth1的IP地址为10.0.0.1/24

  + 在mininet终端中再次执行`r1 route`命令，查看路由器1的路由表。

    - 127.0.0.0/24代表环回口路由，环回口习惯上被称为Loopback接口，是路由器上的一个逻辑、虚拟接口，任何主机中都会有。

    - 10.0.0.0/24是eth1网口连接的网段，是配置在网卡上的路由。

    - 192.168.0.0/24是eth0网口连接的网段。

  + 配置主机路由。

    - 查看主机1路由信息。主机1没有默认路由，从主机1出去的流量不能到达eth0的网关，即不能到达路由器1。

    - 执行如下命令，修改主机1的默认网关

    - 查看修改后的路由信息，主机1的默认网关为网卡eth0的网关

    - 查看主机2的路由信息。主机2没有默认路由，从主机2出去的流量不能达到eth1网关，即不能到达路由1

    - 执行如下命令，修改主机2的默认网关

  == 六. 验证路由器功能

  + 在主机1上执行`ping 10.0.0.2`，主机2上执行`ping 192.168.0.2`，验证路由器路由功能。

    - 主机1Ping通主机2。

    - 主机2Ping通主机1

  + 打开路由器1的终端，在主机ping的过程中执行`tcpdump -i r1-eth0`命令，抓取路由器上的数据包。可以看到路由器将192.168.0.0/24网段的数据转发到10.0.0.0/24网段。
]

#experiment(title: "实验2-3 RIP路由协议验证")[
  == 一. 实验目的

  + 理解RIP路由的原理；
  + 掌握RIP路由的配置方法。
  
  == 二. 实验内容

  + 启动ipmininet网络；
  + 配置主机和路由器ip；
  + 抓取查看rip协议包。
  
  == 三. 启动IPMininet仿真网络

  右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务。

  实验时请按照如下图所示规划的网段进行实验。

  + 由于原生Mininet不支持网络层的路由器仿真，因此使用拓展过的IPMininet，需要我们通过代码创建自定义网络。

    - 进入/home/headless/ipmininet/ipmininet/examples文件夹，在此处打开终端。

    - 输入`sudo gedit simple_rip_network.py`创建新的网络拓扑文件，填入如下图所示的python代码。由于ipmininet并未提供rip协议的守护进程，因此本实验使用服务于IPV6协议RIPng协议。

    - 终端中输入`sudo gedit __main__.py`打开main文件注册刚刚创建的网络拓扑，填入如下两图所示的代码，保存后退出。

    - 退出到/home/headless/ipmininet文件夹，右键打开终端输入`sudo python3 -m ipmininet.examples --topo=simple_rip_network`，启动包含一个路由器和两个主机的网络
  
  == 四. 配置主机和路由器IP地址

  + 在mininet终端上分别输入下列命令查看主机和路由器的ipv6地址。

  == 五. 配置主机和路由器地址

  + 由于在创建网络的时候就指定了使用RIP协议，因此本次实验无需手动配置RIP协议。在mininet终端上输入`r1 route -6`查看路由器的IPV6路由表。
  
    - 第一和第二条为直连路由，连接h1和r2；第三条则是由rip协议得到的路由条目，下一跳为r2，通往h2的网段

    - r2的路由表也是同理
  
  + 主机1与主机2互ping，验证网络连通性。

    - h1 ping h2：

    - h2 ping h1：

  + 在路由器1的终端上执行`tcpdump -i r1-eth0 -v`，抓取RIP交互信息数据包。可以看到rip的请求数据包和应答数据包。
]

#experiment(title: "实验2-4 OSPF路由协议验证")[
  == 一. 实验目的

  + 熟练掌握OSPF协议工作原理；
  + 掌握OSPF协议命令配置；
  + 掌握OSPF数据交互流程。
  
  == 二. 实验内容

  + 启动ipmininet网络；
  + 配置主机与路由器ip；
  + 配置OSPF协议，实现路由之间互通；
  + 验证OSPF协议。
  
  == 三. 启动IPMininet仿真网络

  右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务。

  + 实验时请按照规划的网段进行实验。

  + 由于原生Mininet不支持网络层的路由器仿真，因此使用拓展过的IPMininet，需要我们通过代码创建自定义网络。进入/home/headless/ipmininet/ipmininet/examples文件夹，在此处打开终端。

  + 输入`sudo gedit simple_ospf4_network.py` 创建新的网络拓扑文件，填入如所示的python代码。这里在创建路由器的时候ipmininet默认使用ospf协议获取路由表，无需特殊声明。(可能现现需要手动下载gedit,下载指令：`sudo apt-get install gedit -y`。如果不用gedit也可以用vim打开编辑文件)

  + 终端中输入`sudo gedit main.py`打开main文件注册刚刚创建的网络拓扑，填入如下两图所示的代码，保存后退出。

  执行`cd ../..`退出到第一个ipmininet文件夹，右键打开终端输入`sudo python3 -m ipmininet.examples --topo=simple_ospf4_network`，启动包含两个路由器和两个主机的网络。

  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。

  + 在h1的终端内输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址和子网掩码不符合实验要求。
  
  + 执行如下命令，将主机1的eth0网卡的ip地址和子网掩码设置为实验要求。

    - `sudo ifconfig h1-eth0 10.0.0.2`

  + 输入`xterm h2`，打开h2的终端，输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址不符合实验要求。

  + 执行如下命令，将主机2的eth0网卡的ip地址和子网掩码设置为实验要求。

    - `sudo ifconfig h2-eth0 10.0.2.2`

  == 五. 配置路由器

  + 在mininet终端中输入`xterm r1`打开路由器1的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。该路由器有两块网卡，eth0和eth1。

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r1-eth0 10.0.0.1/24`命令，配置网卡eth0的IP地址为10.0.0.1/24
    
    - 执行`ifconfig r1-eth1 10.0.1.1/24`命令，配置网卡eth1的IP地址为10.0.1.1/24
    
  + 在mininet终端中输入`xterm r2`打开路由器2的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。
  
  + 修改两块网卡的ip地址。

    - 执行`ifconfig r2-eth0 10.0.1.2/24`命令，配置网卡eth0的IP地址为10.0.1.2/24
    
    - 执行`ifconfig r2-eth1 10.0.2.1/24`命令，配置网卡eth1的IP地址为10.0.2.1/24
  
  + 配置主机路由。

    - 查看主机1路由信息。主机1没有默认路由，从主机1出去的流量不能到达eth0的网关，即不能到达路由器1。

    - 查看命令：`route -n`

    - 执行如下命令，修改主机1的默认网关

    - `sudo route add default gw 10.0.0.1`

    - 查看修改后的路由信息，主机1的默认网关为网卡eth0的网关

    - 再次执行：`route -n`
    
    - 查看主机2的路由信息。主机2没有默认路由，从主机2出去的流量不能达到eth1网关，即不能到达路由1

    - 查看命令：`route -n`

    - 同样的，我们修改路由信息：`sudo route add default gw 10.0.2.1`
    
    - 查看修改后的路由信息，主机2的默认网关为网卡eth0的网关。

    - 查看指令：`route -n`
    
  == 六. 配置路由器OSPF协议

  + 在mininet终端上执行r1 route查看路由器1的路由表，可以发现虽然网卡的ip地址更新了，但是却没有通向主机2网络的路由条目，这需要我们手动更新OSPF协议中路由器所连接的网络。
  
    - 执行指令：`r1 route`
    
  + 打开路由器1的终端，输入`telnet localhost ospfd`，使用telnet工具连ospf 进程，输入默认密码：zebra。
  
  + 依次输入下列三条指令，进入ospf的配置模式。

    - `enable`

    - `configure terminal`

    - `router ospf`

  + 输入下列命令查看ospf信息，可以发现network只有刚创建网络时的ip地址，需要我们手动添加更新后的。

    - `show running-config`

  + 依次输入下列三条指令，添加新的network。

    - `network 10.0.0.0/24 area 0.0.0.0`

    - `network 10.0.1.0/24 area 0.0.0.0`

    - `write`

  + 再次查看ospf信息，可以发现已经添加成功。查看指令：`show running-config`

  + 同样的方式，更新路由器2的网络信息。即在r2的终端，重复上述r1的操作。

  == 七. 验证OSPF协议

  + 打开主机1的终端，ping主机2的地址，发现可以ping通。

    - 指令：`ping 10.0.2.2`
    
  + 在mininet终端上再次查看r1和r2的路由表，发现已经有了由ospf发现的目标网络，标志UG表示连接的网络是可达的且邻接路由器是网关路由器。

    - 执行:`r1 route`,`r2 route`
    
  + 新开一个路由器1终端，登录ospf进程后，输入`show ip ospf route`后同样可以看到通过`ospf`协议获取的路由表。
  
    - `telnet localhost ospfd`

    - `enable`

    - `configure terminal`

    - `router ospf`

    - `show ip ospf route`

  + 再新开一个r1终端，输入`tcpdump -i r1-eth0 proto ospf -v`可以看到路由器收到的ospf协议包
]

#experiment(title: "实验2-5 BGP路由协议验证")[
  == 一. 实验目的

  + 掌握BGP工作原理和协议交互过程；
  + 掌握BGP的部署配置的方法。
  
  == 二. 实验内容

  + 启动ipmininet网络；
  + 配置主机与路由器ip；
  + 在两个自治区域之间配置BGP协议，使网络互通；
  + 查看BGP协议路由表，分析BGP产生的路由条目；
  + 分析BGP报文，学习其工作原理。
  
  == 三. 启动IPMininet仿真网络

  右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务。

  实验时请按照如下图规划的网段进行实验。

  + 由于原生Mininet不支持网络层的路由器仿真，因此使用拓展过的IPMininet，需要我们通过代码创建自定义网络。进入/home/headless/ipmininet/ipmininet/examples文件夹，在此处打开终端。
  
    - 输入`sudo gedit simple_bgp4_network.py`创建新的网络拓扑文件，填入如下图所示的python代码。这里在创建路由器

    - 终端中输入`sudo gedit __main__.py`打开main文件注册刚刚创建的网络拓扑，填入如下两图所示的代码，保存后退出

  + 退出到第一层ipmininet文件夹，右键打开终端输入`sudo python3 -m ipmininet.examples --topo=simple_bgp4_network`，启动包含两个路由器和两个主机的网络。
  
  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。

  + 在h1的终端内输入`sudo ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址和子网掩码不符合实验要求。

  + 执行如下命令，将主机1的eth0网卡的ip地址和子网掩码设置为实验要求。
  
    - 执行指令：`sudo ifconfig h1-eth0 10.0.0.2`

  + 输入`xterm h2`，打开h2的终端，输入`ifconfig`查看ip信息。可以看到此时eth0网卡的ip地址不符合实验要求。
  
  + 执行如下命令，将主机2的eth0网卡的ip地址和子网掩码设置为实验要求。

    - 执行指令：`sudo ifconfig h2-eth0 192.168.0.2`
    
  == 五. 配置路由器

  + 在mininet终端中输入`xterm r1`打开路由器1的终端，并在其终端上执行`ifconfig`命令，查看网卡端口信息。该路由器有两块网卡，eth0和eth1。

  + 修改两块网卡的ip地址。

    - 执行`ifconfig r1-eth0 10.0.0.1/24`命令，配置网卡eth0的IP地址为`10.0.0.1/24` // TODO: Here the '`' character is not united with contents above. Consider removing it or whatever else???

    - 执行`ifconfig r1-eth1 10.0.5.1/24`命令，配置网卡eth1的IP地址为`10.0.5.1/24`

  + 配置主机路由。

    - 查看主机1路由信息。执行`route-n`。如下图所示，主机1没有默认路由，从主机1出去的流量不能到达eth0的网关，即不能到达路由

    - 执行如下命令，修改主机1的默认网关

    - 执行指令：`sudo route add default gw 10.0.0.1`

    - 查看修改后的路由信息，主机1的默认网关为网卡eth0的网关。

    - 查看命令：`route -n`
    
    - 同理查看主机2的路由信息。主机2没有默认路由，从主机2出去的流量不能达到eth1网关，即不能到达路由1

    - 执行如下命令，修改主机2的默认网关。

    - 执行命令：`sudo route add default gw 192.168.0.1`

    - 查看修改后的路由信息，主机2的默认网关为网卡eth0的网关。

    - 查看指令：`route -n`
    
  == 六. 配置路由器BGP协议

  + 在mininet终端上执行`r1 route`查看路由器1的路由表，可以发现虽然网卡的ip地址更新了，但是却没有通向主机2网络的路由条目，这需要我们手动更新BGP协议中路由器所连接的网络。
  
  + 打开路由器1的终端，输入`telnet localhost bgpd`，使用telnet工具连接bgp进程，输入默认密码：zebra。
  
  + 依次输入下列两条指令，进入bgp的配置模式。

    - `enable`

    - `Configure terminal`
  
  + 输入`router bgp 100`，设置自身为的自治域号为100。
  
  + 依次输入下列四条指令，配置BGP协议。

    - `no bgp ebgp-requires-policy` \- 取消 RFC-8212 中对于 incoming and outgoing filters 的需要
    
    - `neighbor 10.0.5.2 remote-as 200` \- 添加 BGP 邻居，即 AS 200 区域
    
    - `neighbor 10.0.5.2 description "router 2"` \- 添加 AS 200 区域的描述

    - `write`
    
  + 输入两次quit后退出配置模式，再输入`show ip bgp summary`查看bgp信息，可以发现已经添加成功，但状态为active,表示路由器正在积极寻找邻居
  
  + 同样的方式，更新路由器2的bgp信息。

  + 输入`show ip bgp summary`查看bgp信息，可以发现已经添加成功，但这时的状态已经不为active，表示路由器已经找到邻居，但此时PfxRcd字段为0，表示暂未得知网络前缀号。
  
  + 在r1终端中再次进入bgp配置模式，输入`network 10.0.0.0/24`，声明r1负责的AS区域的网络前缀为10.0.0.0/2
  
  + 在r2终端中再次进入bgp配置模式，输入`network 192.168.0.0/24`，声明r2负责的AS区域的网络前缀为192.168.0.0/24
  
  + 在r1的终端，输入`show ip bgp summary`查看bgp信息，可以发现已经添加成功，但这时PfxRcd字段为1，表示得知了邻居的一个网络前缀号。
  
  == 七. 验证BGP协议
  
  + 打开主机1的终端，ping主机2的地址，发现可以ping通

    - 指令：`ping 192.168.0.2`
    
  + 在mininet终端上再次查看r1和r2的路由表，发现已经有了由bgp发现的目标网络，标志UG表示连接的网络是可达的且邻接路由器是网关路由器。
]

#experiment(title: "实验2-6 VLAN及VLAN间路由选择")[
  == 一. 实验目的

  + 掌握VLAN的分类及作用；
  + 掌握VLAN的配置方法。
  
  == 二. 实验内容

  + 创建mininet网络；
  + 配置主机ip；
  + 创建VLAN，为VLAN划分端口；
  + 配置VLAN，并验证连通性。
  
  == 三. 启动IPMininet仿真网络

  + 实验时请按照下图规划的网段进行实验。

  + 右键打开终端首先输入`ovs-vswitchd --pidfile --detach`启动服务，然后输入`sudo mn --topo=single,3 --controller=remote`，启动包含一个交换机和三个主机的基本网络。
  
  == 四. 配置主机IP地址

  + 在启动Mininet后的终端内输入`xterm h1`，打开主机1的终端。
  
  + 在h1终端输入`sudo ifconfig`查看ip信息。可看到此时eth0网卡的ip地址为10.0.0.1，子网掩码为255.0.0.0，不符合要求。
  
  + 执行如下命令，修改子网掩码。

  + 同样地，对h2和h3的子网掩码进行修改。

  == 五. 配置交换机

  + 在启动Mininet后的终端内输入`xterm s1`，打开交换机的终端。
  
  + 执行`ovs-vsctl show`命令，查看交换机信息。
  
    - 若交换机的fail_mode为secure，表示交换机必须借助SDN中的控制器才能进行转发操作，我们需要在实验前先执行`ovs-vsctl del-fail-mode s1`命令，退出Secure模式。
  
    - 若如下所示，表示交换机为普通交换机模式，请继续执行下面的操作步骤。

  == 六. 配置VLAN

  + 查看主机在交换机上的连接端口。执行`ovs-appctl fdb/show s1`命令，查看交换机保存的端口对应的MAC表。
  
    - port是对应交换机上的网卡。
    - VLAN是该端口上的VLAN值。
    - MAC是该端口对应的主机的MAC。
    - Age是时间。
    
  + 登录主机终端，执行`ifconfig`命令，分别查看主机1，主机2和主机3的MAC地址。
  
    - 根据MAC地址对应可知，port2连接主机2，port3连接主机3，port1连接主机1

  + 执行下列命令，给网卡打上VLAN id。

    #for (i, tag) in ((1, 100), (2, 100), (3, 200)) [
    - #raw("ovs-vsctl set port s1-eth" + str(i) + " tag=" + str(tag))
    ]
    
  + 执行`ovs-appctl fdb/show s1`，查看端口信息。其中port1和port2的VLAN ID是100，port3的VLAN是200。
  
  + 执行`ovs-vsctl show`，查看基本交换机信息。
  
    - 其中eht1和eth2两个端口上有Tag标签100，eth3上有Tag标签200。所有从主机进入交换机的s1的数据帧都会在port上打上相应的标签。

  == 七. 验证主机间连通性

  + 打开主机1的终端，用主机1ping主机2
  
    - 主机1能够ping通主机2，因为两个主机处于同一个VLAN中。

  + 打开主机1的终端，用主机1ping主机3

    - 主机1ping不通主机3，因为两个主机处于不同的VLAN中。

  + 打开主机2的终端，用主机2ping主机3

    - 主机2输入ping命令，连不通主机3，因为两个主机处于不同的VLAN中
]
