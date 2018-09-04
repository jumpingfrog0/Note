# homebrew

## brew 和 brew cask

[brew](https://brew.sh/) 是下载源码解压，然后 `./configure && make install`，同时会安装相关依赖库，并自动配置好各种环境变量，而且易于卸载。

这个对程序员来说简直是福音，简单的指令，就能快速安装和升级本地的各种开发环境。

[brew cask](https://caskroom.github.io/) 是已经编译好了的应用包（.dmg/.pkg），仅仅是下载解压，放在统一的目录中(opt/homebrew-cask/Caskroom)，省掉了自己去下载、解压、拖拽（安装）等蛋疼步骤，同样，卸载相当容易与干净。这个对一般用户来说会比较方便，包含很多在AppStore里没有的常用软件。

`brew` 主要用来安装一些不带界面的命令行工具和第三个库来进行二次开发

`brew cask` 装的大多数是有GUI界面的应用。

### 查看安装目录

	brew info xxx

### 可以使用 homebrew 安装的工具或软件：

安装命令：

	brew install xxx


* jq
* neovim


#### 可以使用 brew cask 安装的工具或软件：

安装命令：

	brew cask install xxx

* java
* python3
* carthage
* libimobiledevice
* cmake
* p7zip
* MacVim
* typora



