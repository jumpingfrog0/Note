# CocoaPods Guides

<!--
create time: 2019-12-05 10:10:00
Author: <黄东鸿>
-->

Cocoapods 是 iOS 的一个第三方库管理工具。

参考：[使用私有Cocoapods仓库 中高级用法](https://www.jianshu.com/p/d6a592d6fced)

## 安装

官方文档：[https://cocoapods.org/](https://cocoapods.org/)

The Podfile: [http://guides.cocoapods.org/using/the-podfile.html](http://guides.cocoapods.org/using/the-podfile.html)

使用 `Bundle` 进行安装

```
$ sudo gem install bundler

## 可以把 Gemfile 放在任意目录
$ cd ~/Documents/dev
$ bundle init
$ vim Gemfile (添加 gem 'cocoapods', '~> 1.7.5')
$ bundle install

## 查看 cocoapods 安装的路径
$ bundle info cocoapods 

## 查看 cocoapods 版本
$ pod --version
```

## Podfile 配置

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

## 制作Pod

### 使用 pod 模板创建代码仓库

```
pod lib create repoName --template-url=git@github.com:jumpingfrog0/pod-template.git
```

### Push

#### 推到公有远程仓库

```
pod trunk push [PATH] --verbose --allow-warning
```

#### 添加私有Specs repo到本地

	pod repo add ymtSpecs git@git.yaomaitong.net:iOSPods/ymtSpecs.git
	
添加成功后可以在`/.cocoapods/repos/`目录下可以看到官刚刚加入的`specs:ymtSpecs`

#### 推送私有到远程仓库

	pod repo push private-pod-repo Category.podspec
	pod repo push private-pod-repo Category.podspec --allow-warnings --verbose --sources=xspecs,master
	
### Lint & Cache
	
#### 验证.podspec文件的合法性

	# 从本地和远程验证你的pod能否通过验证
	pod spec lint react-native-sqlite-storage.podspec
	
	# 只从本地验证你的pod能否通过验证
	pod lib lint React.podspec --verbose --sources=xspecs --allow-warnings
	
#### 清除缓存

	pod cache clean mzdfoundation

#### 清除所有缓存

	rm -rf "${HOME}/Library/Caches/CocoaPods"
	rm -rf "`pwd`/Pods/"
	pod update
	
#### 列出本地中有多少Sepc repos

	pod repo list
	
#### 更新对应的Sepc repo

	pod repo update xiaoenai-xspecs


### podspec 配置

podspec 语法文档: [Podspec Syntax Reference](https://guides.cocoapods.org/syntax/podspec.html#group_build_settings)

基础配置示例：

```
#
# Be sure to run `pod lib lint MZDXlib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MZDXlib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MZDXlib.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitlab.xiaoenai.net/iOS-Abilities/MZDXlib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jumpingfrog0' => 'donghong.huang@enai.im' }
  s.source           = { :git => 'git@gitlab.xiaoenai.net:iOS-Abilities/MZDXlib.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MZDXlib/Classes/category/**/*', 'MZDXlib/Classes/xlib/include/*.{h}'
  
  # s.resource_bundles = {
  #   'MZDXlib' => ['MZDXlib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
```

#### .a 静态库依赖

添加如下配置：

```
s.vendored_libraries = 'MZDXlib/Classes/xlib/Release/lib/*.{a}'
s.static_framework = true
s.libraries = 'iconv', 'c++','stdc++.6.0.9','z'
```

配置了 `static_framework` 为 true 后，如果被其他私有库依赖，pod install 时会报如下错误：

`target has transitive dependencies that include static frameworks:`


解决办法：在pod install 之前跳过静态库依赖的校验

```
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end
```

#### 修改编译选项

```
  other_frameworks =  ['MZDXlib']
  other_ldflags = '$(inherited) -Objc' + other_frameworks.join(' -framework') + ' -w'

  valid_archs = ['armv64',
			   'x86_64',]

  s.user_target_xcconfig = {
#'OTHER_LDFLAGS'          => '$(inherited) -Objc -framework "MZDXlib" -w'
	'OTHER_LDFLAGS'		 => other_ldflags,
  	'VALID_ARCHS'		 =>  valid_archs.join(' '),
  }
  s.pod_target_xcconfig = {
	'OTHER_LDFLAGS'          => '-w',
  	'VALID_ARCHS'		 =>  valid_archs.join(' '),
  }
```

### 如果搜索不到某个库

搜索不到这个mob_sharesdk时：

1. 请先进行：pod setup
2. 再清空一下搜索索引，让pod重建索引：

```
$ rm ~/Library/Caches/CocoaPods/search_index.json
```
	
### 如何证明 私有 pod 上传成功？

```
pod search xxx
```

能搜索到就证明创建的私有pod没问题。

## Fuck Error 汇总

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

#### 4. 运行 `pod install` 报错 `Unable to find a specification for [PrivateSpec] depended upon by [PrivateClientSpec]`

需要先 lint 一下私有 specs 

> 注意：必须是 http 或 https，ssh 不支持

```
pod spec lint xxx.podspec --sources='https://gitlab.xiaoenai.net/ios/xspecs.git,https://github.com/CocoaPods/Specs.git' --allow-warnings
```

如果 lint 成功了，pod install 还是提示相同的错误，需要更新一下 repo

```
pod repo update
```

#### 5. pod repo push 报错 `[!] The repo `xspecs` at `../../../../.cocoapods/repos/xspecs` is not clean`

`xspecs` 其实也是一个 git 仓库，查看 xspecs 发现有 untracked 的文件，只需要清空就行了。

```
git clean -f
```

#### 6. pod trudk push 报错 `Authentication token is invalid or unverified. Either verify it with the email that was sent or register a new session.`

主要注册一个 cocoapods 的账号

```
pod trunk register yourEmail@example.com 'Your Name'
pod trunk register jumpingfrog0@gmail.com jumpingfrog0
```

#### 7. pod truck push 报错 `Source code for your Pod was not accessible to CocoaPods Trunk. Is it a private repo or behind a username/password on http?`

source 要使用 https, 不能使用 ssh 的方式

#### 8. [!] [Xcodeproj] Generated duplicate UUIDs:

在 Podfile 中添加：

```
install! 'cocoapods', :deterministic_uuids => false
```

#### 9. fatal: ambiguous argument 'HEAD' error while updating pod

```
$ pod repo remove master
$ pod setup
```

### lint 报错问题汇总

#### 1. 不支持 bitcode

报错信息如下：

```
ld: '/Users/sheldon/Desktop/xiaoenai/ios-abilities/MZDXlib/MZDXlib/Classes/xlib/Release/lib/libvaliant.a(MZDXCrypto.mm.o)' does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target. for architecture arm64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```

解决办法：

Step 1. 配置 Podfile，在 install 的时候关闭 bitcode

	```
	post_install do |installer|
	  installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
		  config.build_settings['ENABLE_BITCODE'] = 'NO'
		end
	  end
	end
	```

Step 2. 修改 Xcode 编译选项，关闭 bitcode

`project -> target -> build settings` 搜索 `enable bitcode` 设置为 `NO`

![](https://i.stack.imgur.com/BGTkB.png)		

#### 2. Undefined symbols for architecture i386

目前没有找到好的办法，只能使用 `--skip-import-validation` 跳过校验

```
pod lib lint MZDXlib.podspec --verbose --sources=xspecs --allow-warnings --no-clean --use-libraries --skip-import-validation
```
