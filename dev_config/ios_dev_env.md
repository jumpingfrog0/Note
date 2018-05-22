## iOS 开发环境配置文档
===

统一使用 `Cocoapods 1.0.1` 

* rbenv : ruby 版本管理工具
* rvm : 也是 ruby 版本管理工具
* bundler : ruby 项目的依赖管理工具

#### 安装Homebrew & brew-cask

	$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$ brew tap caskroom/cask

#### 安装 rvm 或 rbenv

	## rvm
	$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
	$ source ~/.rvm/scripts/rvm
	$ rvm -v
	
	## rbenv
	$ brew install rbenv
	$ rbenv init
	
> 如果安装过程卡住很久，那就要终端代理（shadowsocks）翻墙
> `export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;`
	
#### 安装ruby

**使用2.3.1版本**
	
	## 使用 rbenv
	$ rbenv install 2.3.1
	$ rbenv local 2.3.1

	## 或使用rvm
	$ rvm install 2.3.1
	$ rvm use 2.3.1
	$ rvm list

#### 安装 bundler

	$ gem install bundler
	
#### 使用 bundler 安装 cocoapods
	
	## 可以把 Gemfile 放在任意目录
	$ cd ~/Documents/dev
	$ bundle init
	$ vim Gemfile (添加 gem 'cocoapods', '~> 1.0.1')
	$ bundle install
	
	## 查看 cocoapods 安装的路径
	$ bundle info cocoapods 
	
	## 查看 cocoapods 版本
	$ pod --version
	
#### 安装 fastlane

 ```
 $ brew cask install fastlane
 
 ## 安装完后修改 '~/.zshrc' 或 '~/.bashrc'，添加以下代码
 export PATH="$HOME/.fastlane/bin:$PATH"
 
 ## 重新加载 '~/.zshrc'
 $ source ~/.zshrc
 ```
  
#### Node 淘宝源
 
	$ npm config set registry https://registry.npm.taobao.org
	
	$ npm install -g cnpm --registry=https://registry.npm.taobao.org
	$ cnpm install [name]