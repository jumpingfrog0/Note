# unix-command

<!--
create time: 2018-11-15 00:17:32
Author: 黄东鸿
-->

## Debian/Ubuntu

更新软件包

```shell
apt update -y
```

安装依赖包

```shell
apt install xxx
```

安装 nano

```
sudo apt-get install nano
```

## Unix

查看进程

```
$ ps aux
$ ps -A
```

查看端口占用

```
$ lsof -i:<端口号>
$ netstat -anp | grep <端口号>
```

查看系统版本

```
$ cat /etc/issue
$ cat /proc/version
```

获取管理员权限

```
sudo -i
sudo su
```

### 7zip

解压

```
7z x filename.7z
```

压缩

```
7z a myfile.7z mydirectory
```