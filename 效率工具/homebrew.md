# homebrew

## brew 和 brew cask

[brew](https://brew.sh/) 是下载源码解压，然后 `./configure && make install`，同时会安装相关依赖库，并自动配置好各种环境变量，而且易于卸载。

这个对程序员来说简直是福音，简单的指令，就能快速安装和升级本地的各种开发环境。

[brew cask](https://caskroom.github.io/) 是已经编译好了的应用包（.dmg/.pkg），仅仅是下载解压，放在统一的目录中(opt/homebrew-cask/Caskroom)，省掉了自己去下载、解压、拖拽（安装）等蛋疼步骤，同样，卸载相当容易与干净。这个对一般用户来说会比较方便，包含很多在AppStore里没有的常用软件。

`brew` 主要用来安装一些不带界面的命令行工具和第三个库来进行二次开发

`brew cask` 装的大多数是有GUI界面的应用。

```
# install brew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install cask
$ brew tap caskroom/cask
```

[brew tap](https://docs.brew.sh/Taps) 可以为 brew 的软件的跟踪, 更新, 安装添加更多的 `tap formulae`。如果你在核心仓库没有找到你需要的软件, 那么你就需要安装第三方的仓库去安装你需要的软件。

tap 命令的仓库源默认来至于 Github，但是这个命令也不限制于这一个地方。更多资料参考这篇[文章](https://segmentfault.com/a/1190000012826983)

### 查看安装目录

	brew info xxx
    
### install without updating

编辑 `~/.zshrc` 或 `~/.bashrc` 或 `~/.bash_profile`

    export HOMEBREW_NO_AUTO_UPDATE=1
    
保存，然后运行 `source ~/.zshrc` 时更改生效

### 可以使用 homebrew 安装的工具或软件：

安装命令：

	brew install xxx


* jq
* neovim
* appledoc
* rbenv
* vundle
* tree
* node
* 7zip
* nginx


#### 可以使用 brew cask 安装的工具或软件：

安装命令：

	brew cask install xxx

查看已安装的软件：

	berw cask list

* java
* python3
* carthage
* libimobiledevice
* cmake
* MacVim
* typora
* vlc
* iterm2
* shiftit
* macdown
* visual-studio-code
* clion
* dash
* docker


