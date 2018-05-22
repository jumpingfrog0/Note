# 自动化测试 - appium

## 手动安装环境

### 安装nvm和node

	brew install nvm
	nvm install v7.2.0
	nvm use v7.2.0
	node -v
	
### 安装appium和appium-doctor

> 注意：终端翻墙后会导致安装失败，先运行以下代码移除代理
> 
> 	`unset http_proxy`
> 	`unset https_proxy`

	npm install -g appium
	appium -v
	
	npm install -g appium-doctor --ios
	appium-doctor --ios
	
appium 还需要安装 carthage

	brew install carthage
	
### 安装python3和Appium-Python-Client

	brew install python3
	pip3 install Appium-Python-Client
	pip3 install pytest
	
## 运行

### 模拟器

使用对应版本的模拟器提前 build 一下

	$ xcodebuild -sdk iphonesimulator10.3
	
开启本地 Appium Server

	$ appium
	
运行自动化脚本

	$ py.test ios_simple.py
	
> 注意：运行脚本时同样需要移除终端翻墙代理

### 真机

安装必要的软件

	brew install libimobiledevice
	
Xcode8 和 iOS 9.3以上

	npm install -g ios-deploy
	
未完待续...

### Jenkins

[Running Appium on Mac OS X](https://github.com/appium/appium/blob/master/docs/en/appium-setup/running-on-osx.md#authorizing-ios-on-the-computer)