CocoaPods Guides
================

Cocoapods 是 iOS 的一个第三方库管理工具。

## 安装

查看官方文档：[https://cocoapods.org/](https://cocoapods.org/)

The Podfile: [http://guides.cocoapods.org/using/the-podfile.html](http://guides.cocoapods.org/using/the-podfile.html)

### 安装过程中可能遇到的问题

##### 1. 执行完install命令半天没反应

这有可能是因为Ruby的默认源使用的是`cocoapods.org`，国内访问这个网址有时候会有问题，网上的一种解决方案是将远替换成淘宝的，替换方式如下：

	$ gem sources --remove https://rubygems.org/
	
等有反应之后再敲入以下命令

	$ gem sources -a https://ruby.taobao.org/

要想验证是否替换成功了，可以执行：

	$ gem sources -l

正常的输出是：

	*** CURRENT SOURCES ***
	http://ruby.taobao.org/

##### 2. gem版本过老

gem是管理Ruby库和程序的标准包，如果它的版本过低也可能导致安装失败，解决方案自然是升级gem，执行下述命令即可：

	$ sudo gem update --system

##### 3. 安装完成后，执行pod setup命令时报错：

```
/Users/wangzz/.rvm/rubies/ruby-1.9.3-p448/lib/ruby/site_ruby/1.9.1/rubygems/dependency.rb:298:in `to_specs': Could not find 'cocoapods' (>= 0) among 6 total gem(s) (Gem::LoadError) 
from /Users/wangzz/.rvm/rubies/ruby-1.9.3-p448/lib/ruby/site_ruby/1.9.1/rubygems/dependency.rb:309:in `to_spec'
from /Users/wangzz/.rvm/rubies/ruby-1.9.3-p448/lib/ruby/site_ruby/1.9.1/rubygems/core_ext/kernel_gem.rb:53:in `gem'
from /Users/wangzz/.rvm/rubies/ruby-1.9.3-p448/bin/pod:22:in `<main>'
```

这就是路径设置的问题，可以通过执行：

	$ rvm use ruby-1.9.3-p448
	
解决该问题。

### 不同版本的Cocoapods

#### uninstall

	sudo gem uninstall cocoapods

#### install

	sudo gem install cocoapods
	
#### 卸载对应的版本

	gem uninstall cocoapods -v 0.20.2
	
#### 安装对应的版本

	sudo gem install cocoapods -v 1.0.1
	
#### 查看已经安装了哪些版本

	sudo gem list cocoapods
	

## Cocoapods Podfile

> refer to: [https://guides.cocoapods.org/using/the-podfile.html](https://guides.cocoapods.org/using/the-podfile.html)


Besides no version, or a specific one, it is also possible to use logical operators:

	'> 0.1' Any version higher than 0.1
	'>= 0.1' Version 0.1 and any higher version
	'< 0.1' Any version lower than 0.1
	'<= 0.1' Version 0.1 and any lower version
In addition to the logic operators CocoaPods has an optimistic operator ~>:

	'~> 0.1.2' Version 0.1.2 and the versions up to 0.2, not including 0.2 and higher
	'~> 0.1' Version 0.1 and the versions up to 1.0, not including 1.0 and higher
	'~> 0' Version 0 and higher, this is basically the same as not having it.
	

From a podspec in the root of a library repo.

Sometimes you may want to use the bleeding edge version of a Pod, a specific revision or your own fork. If this is the case, you can specify that with your pod declaration.

To use the master branch of the repo:

	pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git'
	
To use a different branch of the repo:

	pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :branch => 'dev'
	
To use a tag of the repo:

	pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :tag => '0.7.0'

Or specify a commit:

	pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :commit => '082f8319af'
	
pod install

	pod install --verbose --no-repo-update
	
更新某一个repo

	pod update <SomeRepoName>
	
设置仓库源

	source 'git@gitlab.xiaoenai.net:ios/xspecs.git'
	source 'https://github.com/CocoaPods/Specs.git'
	source 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git'
	
[cocoapods specs 镜像](http://akinliu.github.io/2014/05/03/cocoapods-specs-/)

## 私有Pod

### 验证.podspec文件的合法性

	pod lib lint xxxx.podspec
	
	pod spec lint react-native-sqlite-storage.podspec
	
	pod lib lint React.podspec --verbose --sources=xspecs --allow-warnings
	
### 添加Specs repo到本地

	pod repo add ymtSpecs git@git.yaomaitong.net:iOSPods/ymtSpecs.git
	
添加成功后可以在`/.cocoapods/repos/`目录下可以看到官刚刚加入的`specs:ymtSpecs`

### 将podspec加入私有Sepc repo中

	pod repo push ymtSpecs Category.podspec
	
### 清除缓存

	pod cache clean mzdfoundation

### 清除所有缓存

	rm -rf "${HOME}/Library/Caches/CocoaPods"
	rm -rf "`pwd`/Pods/"
	pod update
	
### 列出本地中有多少Sepc repos

	pod repo list
	
### 更新对应的Sepc repo

	pod repo update xiaoenai-xspecs
	
### 如果搜索不到某个库

搜索不到这个mob_sharesdk时：

1. 请先进行：pod setup
2. 再清空一下搜索索引，让pod重建索引：

```
$ rm ~/Library/Caches/CocoaPods/search_index.json
```
	
### 报错

#### 1. Unable to satisfy the following requirements with Podfile, but they required a higher minimum deployment target.
	
有2个原因：

* s.ios.deployment_target 的版本不能高于依赖库的版本
* 缓存导致的，执行以下命令：

```
$ pod install
$ pod update MZDReactSqlite
```

#### 2. 上传时报错： The repo `MZDReactSqlite ` at `cocoapods/repos/xspecs` is not clean

原因：缓存导致的

```
# 获取 spec repo 的地址 /Users/sheldon/.cocoapods/repos/xspecs
$ pod repo list 

# 删除缓存
$ rm rf MZDReactSqlite

# 更新
$ pod repo update MZDReactSqlite
```

#### 3. 运行 `pod search xxx` 报 skipping `MZDReactSqlite.podspec` because the podspec contains errors

原因：`MZDReactSqlite.podspec` 脚本有错误，pod有巨坑，没有提示详细的报错信息，需要先清空所有缓存，在更新，才会提示具体的错误：

```
# 清空所有缓存
$ rm -rf "${HOME}/Library/Caches/CocoaPods"
$ rm -rf "`pw

# 更新
$ pod update

```

以下是今天遇到的具体报错信息：

```
[!] Invalid `MZDReactSqlite.podspec` file: No such file or directory @ rb_sysopen - /Users/sheldon/.cocoapods/repos/xiaoenai-xspecs/MZDReactSqlite/3.3.4/node_modules/react-native-sqlite-storage/package.json.
```

```
[!] Unable to satisfy the following requirements:

- `MZDReactSqlite (~> 3.3.4)` required by `Podfile`

Specs satisfying the `MZDReactSqlite (~> 3.3.4)` dependency were found, but they required a higher minimum deployment target.
```

### 如何证明 私有 pod 上传成功？

```
pod search xxx
```

能搜索到就证明创建的私有pod没问题。