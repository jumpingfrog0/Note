# iOS静态链接库和动态链接库制作

###.framework和.a 语言支持情况

| 库类型/语言类型 | OC | Swift |
|:----- |:-----:| -----:|
| 静态库 | iOS7+ | 不支持 |
| 动态库 | iOS8+ | iOS8+ |

### 集成第三方库

原本SDK已经作为别人APP工程里的第三方了，假如SDK中需要引用AFNetworking类似的三方库。

| 库类型/引用 | 内部引用 | 外部引用 |
|:----- |:-----:| :-----:|
| 静态库 | 静态库无法再包含其他的.a静态库。只能把源码放进去一起编译。 | 静态库无法把第三方放在外部，否则就不叫“静态”了。只能打包进SDK内部，并修改类名，防止外部冲突。
| 动态库 | 如果用Swift可以直接引入源码，由于Swift含有命名空间，所以不会有冲突。 | 第三方库不打进去，放在外部，比如cocoapods的方式。别人编译的时候需要在他的环境里有该第三方依赖库。当提供给别人SDK的时候，你还需要给别人一个podfile。 |

## 静态链接库

### 制作静态链接库

 1. 创建静态链接库工程：`Cocoa Touch Static Library`
 2. 编写核心代码
 3. 将头文件暴露出来：将头文件添加到`Build Phases`的`Copy Files`中去
 4. 更改编译选项：修改 `Build Settings`的`Build Active Architecture Only`的值为`NO`，以满足可以运行在不同CPU环境中
 5. 编译生成不同环境的静态链接库
 
 ```
 $ xcodebuild -configuration Debug -sdk iphonesimulator
 $ xcodebuild -configuration Debug -sdk iphoneos
 $ xcodebuild -configuration Release -sdk iponesimulator
 $ xcodebuild -configuration Release -sdk iphoneos
 ```

> iOS 中有四种不同编译环境的静态链接库：
> 
> * debug 模拟器
> * debug 真机
> * release 模拟器
> * release 真机

编译后就能如下四个目录了，其中目录中的 libHelloLib.a 就是编译后的静态库，include 文件夹是对外暴露的头文件。
	
![](./images/static-lib-compile.png)
	
可以使用命令 `lipo -info xxx`查看静态库所支持的CPU环境

	$ lipo -info build/Release-iphoneos/libHelloLib.a
	$ lipo -info build/Release-iphonesimulator/libHelloLib.a
	
分别输出：

	Architectures in the fat file: build/Release-iphoneos/libHelloLib.a are: armv7 arm6
	Architectures in the fat file: build/Release-iphonesimulator/libHelloLib.a are: i386 x86_64
		
 6. 合并静态库

	```
	lipo -create 静态库1 静态库2 -output 新静态库名称.a
 	```
 	
### 使用静态链接库
 
* 直接将 `.a` 文件和头文件拖进项目工程中即可
* 如果编译报错，检查 `Build Phases` --> `Link Binary With Libraries` 选项是否有添加 `.a` 文件
* 如果静态链接库中有分类的话，必须在 `Build Settings` --> `Other Linker Flags` 中添加 `-Objc`，如果还崩溃的话，还得加上 `-all_load`
* 关于在静态库中添加资源，一般使用的是 bundle 文件夹。注意，默认的静态库编译是不会将bundle一起编译进去的，所以这个文件夹需要我们手动添加到使用静态库的工程中去。

## 动态链接库

动态库分为两种：**动态链接库** 和 **动态加载库**

* 对于动态链接库而言，build可执行文件的时候需要指定它依赖哪些库，当可执行文件运行时，如果操作系统没有加载过这些库，那就会把这些库随着可执行文件的加载而加载进内存中，供可执行程序运行。如果多个可执行文件依赖同一个动态链接库，那么内存中只会有一份动态链接库的代码，然后把它共享给所有相关可执行文件的进程使用，所以它也叫共享库(shared library)。比如pthread就是一个这样的库。

* 对于动态加载库而言，build可执行文件的时候就不需要指定它依赖哪些库，当可执行文件运行时，如果需要加载某个库，就用dlopen、dlsym、dlclose等函数来动态地把库加载到内存，并调用库里面的函数。各大软件的插件模块基本上就都是这样的库。事实上，静态库和动态链接库也可以被动态加载，只是由于使用方式的不同，才多了一个动态加载库这样的类别。

> 注意：在iOS中，真正的动态链接库可以使用但是不能上架！
> 
> iOS仍然不允许进程间共享动态库，即iOS上的动态库只能是私有的，因为我们仍然不能将动态库文件放置在除了自身沙盒以外的其它任何地方。只有iOS系统自身的framework才是真正的动态链接库。
> 
> 因此，我们制作framework时是将其编译成静态库，可以说framework是升级版的静态库。
> 
> 不过iOS10上开放了App Extension功能，可以为一个应用创建插件，这样主app和插件之间共享动态库还是可行的。

### 制作动态链接库

1. 创建动态链接库工程：`Cocoa Touch Framework`
2. 更改编译选项为静态库：设置 `Build Settings` --> `Mach-O Type` 为 `Static Library`
3. 暴露头文件和资源文件：将头文件添加到 `Build Phases` --> `Headers` 的 `Public` 分组中，将 bundle 文件添加到 `Build Phases` --> `Copy Bundle Resource`中
4. 编译

	```
	xcodebuild -configuration Release -sdk iphonesimulator
	xcodebuild -configuration Release -sdk iphoneos
	```
	编译后的目录
	
	![](./images/ios-framework-compile.png)
	
5. 合并

	注意：我们要合并的并不是 `xxx.framework`，而是 `xxx.framework` 目录下的 `xxx`，以上图为例，我们要合并的文件就是 `HelloSDK`。

	```
	lipo -create build/Release-iphonesimulator/HelloSDK.framework/HelloSDK build/Release-iphoneos/HelloSDK.framework/HelloSDK -output build/HelloSDK
	```
	
注意：这里必须编译成 Release 选项，不然将framework引入项目工程后不能在模拟器上运行，会报错：

	"_OBJC_CLASS_$_xxxx", referenced from: xxx
	Linker command failed with exit code 1(use -v to see invocation)

以及一个warning：

	Ignoring file xxx/xxx.framework/xxx, missing required architecture x86_64 in file xxx/xxx.framework/xxx (2 slices)
	
从warning中，我们可以看出原因是，动态库中缺少 x86_64 的架构，我们查看一下动态库对不同环境的支持，就能看出端倪了。

	lipo -info build/Release-iphoneos/HelloSDK.framework/HelloSDK
	lipo -info build/Release-iphonesimulator/HelloSDK.framework/HelloSDK
	lipo -info build/Debug-iphoneos/HelloSDK.framework/HelloSDK
	lipo -info build/Debug-iphonesimulator/HelloSDK.framework/HelloSDK	
分别输出

	Architectures in the fat file: build/Release-iphoneos/HelloSDK.framework/HelloSDK are: armv7 arm64 
	Architectures in the fat file: build/Release-iphonesimulator/HelloSDK.framework/HelloSDK are: i386 x86_64
	Non-fat file: build/Debug-iphoneos/HelloSDK.framework/HelloSDK is architecture: armv7
	Non-fat file: build/Debug-iphonesimulator/HelloSDK.framework/HelloSDK is architecture: i386
	
### 使用动态链接库

* 将合并后的文件替换掉编译后的 xxx.framework 中的对应的动态库文件
* 将 xxx.framework 拖进项目工程即可
* 一般情况下，我们会把 xxx.framework 中的 xxx.bundle 拖出来，放到与 xxx.framework 同级目录下的 resources 文件夹中

	![](./images/framework-resources.png)

-------

参考：[Xcode动态链接库与静态链接库讲解及制作方式
](http://www.jianshu.com/p/5eea9a56d249)