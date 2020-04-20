Mac Command
===========

### 删除多余的模拟器

```shell
$ xcrun simctl delete unavailable
```

### 删除Launchpad残留图标

	$ defaults write com.apple.dock ResetLaunchPad -bool true
	$ killall Dock
	
### 删除 Dashboard

	$ defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock
	
### 显示/隐藏文件

	# 显示
	$ defaults write com.apple.finder AppleShowAllFiles -bool true

	# 隐藏
	$ defaults write com.apple.finder AppleShowAllFiles -bool false
	
快捷键 `Cmd + Option + ESC`，选中 Finder， relaunch

### Fix "The file is damaged and should be moved to the trash."

	$ sudo bash
	$ xattr -cr /Applications/xxx.app
	
### Fix "The application xxx can't be opened."
	
	sudo find Spotify.app -exec chmod 755 {} \;

### 文件权限

	$ sudo chmod 777 xx.txt
	
### 文件 MD5

	$ md5 path/to/filename

### Command

	## cd 到上次的目录
	$ cd - 
	
	## 取消当前输入的命令行
	Ctrl + U 
	Ctrl + C

### 查看网络运营商和IP

	$ curl ip.cn
	$ curl cip.cc
	
### 查看llvm版本

	llvm-gcc -v
	
### 查看视频分辨率

	ffmpeg -i xxx
	
### **Terminal shadowsocks proxy**

### 查看安装目录

	which python

[Using Shadowsocks with Command Line Tools](https://github.com/shadowsocks/shadowsocks/wiki/Using-Shadowsocks-with-Command-Line-Tools)

	# Shadowsocks-NG
	$ export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;
	$ unset https_proxy
	$ unset http_proxy
	
	# ShadowsocksR
	$ export all_proxy=socks5://127.0.0.1:1086
	$ unset all_proxy
	
### proxychains

	$ brew install proxychains-ng
	$ vim /usr/local/etc/proxychains.conf
	
在 [ProxyList] 下面（也就是末尾）加入代理类型，代理地址和端口
	
	socks5  127.0.0.1 1086
	# 使用 dynamic\_chain，注释掉 strict\_chain

在命令的前面加上proxychains4即可代理，如；
	
	$ proxychains4 curl ip.cn
	
下面的意思是把proxychains4放到系统路径，以后可以直接调用proxychains + 命令执行即可

	$ ln -s /usr/local/Cellar/proxychains-ng/4.10/bin/proxychains4 /usr/local/bin/proxychains
	
> OSX 10.11 因为 SIP 机制，git, curl 等部分命令(所有/bin/,/sbin/, /usr/bin/目录下的所有命令)不支持 proxychains-ng。详见：[Not working on OS X 10.11 due to SIP](https://github.com/rofl0r/proxychains-ng/issues/78)

有两种方法可以解决。

#### 1）Run `csrutil disable` in Recovery mode

重启电脑进入 `Recovery mode` ，运行 `csrutil disable` 关闭 SIP。
重新启用 SIP 同样需要在 `Recovery mode` 运行 `csrutil enable`。

#### 2）自带的 git，curl 等版本过低，需要手动更新版本

	$ brew install curl
	$ proxychains4 /usr/local/bin/curl http://ifconfig.co/
	[proxychains] config file found: /Users/me/.proxychains/proxychains.conf
	[proxychains] preloading /usr/local/Cellar/proxychains-ng/4.11/lib/libproxychains4.dylib
	[proxychains] DLL init: proxychains-ng 4.11
	[proxychains] Dynamic chain  ...  127.0.0.1:9050  ...  188.113.88.193:80  ...  OK
	171.25.193.132
	


### 恢复Mac管理员账号

1. 进入单用户模式（Single User Mode）： 开机长按 `Cmd + s`
2. 输入以下4条命令

	```terminal
	$ fsck -y 						# 对文件系统检查修复，输入后会给出一些提示命令，需要等几秒才能完成
	$ mount -uaw / 					# 挂载分区，执行后没有任何提示，并不是命令没执行或执行错误
	$ rm /var/db/.AppleSetupDone 	# 删除系统安装完毕的配置，执行后同样没有任何提示
	$ reboot						# 重启
	```

### 解压缩

	解压

	```terminal
	tar xxx.tar.xz
	```

### Xcode 加载插件命令

```
find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name Info.plist -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add `defaults read /Applications/Xcode.app/Contents/Info.plist DVTPlugInCompatibilityUUID`

```

### 添加右键脚本工具

1. 打开 `Automator.app`
2. 选择 `实用工具` --> `运行Shell脚本` --> 拖动到右边新建一个脚本
3. 传递输入 选择 `作为自变量`
4. 工作流程收到当前选择工具应用的文件类型（如：图像文件）
5. 粘贴脚本，保存，命名脚本工具（如tinypng_compress)
6. 右键 --> 服务 --> tinypng_compress
7. 脚本运行，在右上角的工具栏中会有一个齿轮⚙在转，脚本运行完成后齿轮消失