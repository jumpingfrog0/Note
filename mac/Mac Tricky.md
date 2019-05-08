# Mac Tricky

<!--
create time: 2018-07-02 11:19:22
Author: 黄东鸿
-->

### ftp command not found

masOS High Sierra 把 ftp 命令给移除掉了，得自己安装

```
$ brew install tnftp tnftpd telnet telnetd
```

### Finder 显示 Library

第一种方式：

* Users home folder --> View --> Show View Options
* choose "Show Library Folder"

![](../images/show_library_folder.png)

第二种方式：

1. From the Finder of Mac OS, pull down the “Go” menu and hold down the `OPTION` key
2. Choose “Library” from the drop down list

![](../images/access-library-folder-mac-os-1.jpg)

### 设置 Dropbox 代理

1. 打开代理设置：Preference --> Network --> Proxies
2. Proxy settings 选择 Manual, Proxy type 选择 `SOCKS5`
3. Server 输入 `127.0.0.1` 或者 `localhost`, 端口号 `1086`

### zsh 权限问题

[oh-my-zsh] Insecure completion-dependent directories detected:
drwxrwxrwx 7 hans admin 238 2 9 10:13 /usr/local/share/zsh
drwxrwxrwx 6 hans admin 204 10 1 2017 /usr/local/share/zsh/site-functions

```
$ chmod 755 /usr/local/share/zsh
$ chmod 755 /usr/local/share/zsh/site-functions
```

### 修复Mac OS蓝牙异常

进行 `PRAM` 和 `SMC` 重置。具体步骤如下

#### PRAM 重置

1. 关机，拔掉所有外设，接上电源。
2. 启动时同时按住 Command, Option, p, r ， 听到三次 dang 的开机声音后放开。
3. 启动电脑

#### SMC 重置

1. 关机，拔掉所有外设，接上电源。
2. 同时按住 Shift, Control, Option, 电源键 ，此时电脑没有任何反应，等待十秒放开。
3. 继续等待十秒，启动电脑。

根据苹果客服，电脑出现其他奇葩情况时候也可以使用这个办法解决。

