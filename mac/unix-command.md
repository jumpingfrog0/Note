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

监听端口号的数据

```
$ nc -lk 12345
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

### 登录远程服务器

	$ ssh username@127.0.0.1
	
### 修改服务器Shadowsocks配置文件

	$ vim /etc/shadowsocks.json
	
### 远程服务器下载

	$ wget https://xxxx.zip
	
### 从服务器下载文件到本地

	$ scp jumpingfrog0@104.238.160.7:/home/jumpingfrog0/Paper-osx-1.1.2.zip ~/Desktop
	
### 查看命令行历史记录

	$ history
		
### openssh 加密文件

	$ openssl aes-256-cbc -k "<password>" -in "<fileYouWantToDecryptPath>" -out "<decryptedFilePath>" -a -d