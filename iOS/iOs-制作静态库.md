制作静态库
=========

## 简介

### 什么是库？

库是程序代码的集合，是共享程序代码的一种方式

根据源代码的公开情况，库可以分为2种类型

- 开源库
    - 公开源代码，能看到具体实现
    - 比如SDWebImage、AFNetworking
- 闭源库
    - 不公开源代码，是经过编译后的二进制文件，看不到具体实现
    - 主要分为：静态库、动态库

静态库和动态库的存在形式

- 静态库：.a 和 .framework
- 动态库：.dylib 和 .framework

静态库和动态库在使用上的区别

- 静态库：链接时，静态库会被完整地复制到可执行文件中，被多次使用就有多份冗余拷贝（左图所示）

- 动态库：链接时不复制，程序运行时由系统动态加载到内存，供程序调用，系统只加载一次，多个程序共用，节省内存（下图所示）

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/04D6FA65-A0E1-4203-95B6-5D1757F1EB3A.png)
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/343B221E-877A-4D1B-A52D-07A9E0B96EBC.png)

> 需要注意的是：项目中如果使用了自制的动态库，不能被上传到AppStore

## .a的制作

1. 选择“Cocoa Touch Static Library”
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/5DBD530C-CD65-4770-A655-98D984F1E448.png)

2. 输入静态库名称
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/8BF7FD35-A838-4F7B-ACD8-38A102EE713F.png)

3. 添加库需要包含的源代码
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/9F9A072F-F9FE-43B4-9765-BE0CAAC09329.png)
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/F9F269A5-1EEF-4AEE-B06D-B827A0D2886F.png)

4. 选择需要暴露出来的.h文件，.m文件会自动编译到.a文件中
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/17939988-A94F-4ABF-8A3F-D19FC2D9FFE0.png)

5. 选择真机设备，然后 Command+B 编译，libMJRefresh.a文件从红色变为黑色
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/EE498C05-51BE-4CDD-B2D3-9D66FF9915B2.png)

6. 选择模拟器，依然 Command+B ，模拟器和真机环境下用的.a文件是分开的
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/3879481C-78DD-4CC8-9D2D-BEBFAD0C522C.png)

7. 右击“Show In Finder”，查看制作好的.a文件
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/22007056-37D9-40D2-86D3-6EFCE43B9A5C.png)

	- Debug-iphoneos文件夹里面的东西是用在真机上的
	- Debug-iphonesimulator文件夹里面的东西是用在模拟器上的
	- 如果Scheme是Release模式，生成的文件夹就以Release开头

如果想让一个.a文件能同时用在真机和模拟器上，需要进行合并,在终端输入指令

	lipo -create [Debug-iphoneos/libMJRefresh.a] [Debug-iphonesimulator/libMJRefresh.a] -output [libMJRefresh.a]
	
没在方括号的是固定指令，在方括号里面的分别是真机、模拟器.a文件的路径和所合成.a文件的路径。

#### .a文件的体积（一般情况下）

- p真机用的.a > 模拟器用的.a
- p所合成.a == 真机用的.a + 模拟器用的.a

通过

	lipo –info libMJRefresh.a
	
可以查看 .a 的类型（模拟器还是真机）

#### 如何使用.a

直接将.a、.h、资源文件拖拽到其他项目中即可

## 模板制作.framework

模板地址：[https://github.com/kstenerud/iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework)

### 安装模板

- 在终端下进入iOS-Universal-Framework/Fake Framework文件夹
- 执行指令

		./install.sh
	
- 安装模板后，完全重启Xcode

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/D1424F50-ED9E-40D0-BF6E-983FD6726E45.png)

### 制作静态库的注意点

- 无论是 .a 静态库还是 .framework 静态库，最终需要的都是：
    - 二进制文件 + .h + 其它资源文件
- .a 和 .framework 的使用区别
    - .a 本身是一个二进制文件，需要配上 .h 和 其它资源文件 才能使用
    - .framework 本身已经包含了 .h 和 其它资源文件，可以直接使用
- 图片资源的处理
    - 如果静态库中用到了图片资源，一般都放到一个bundle文件中，bundle名字一般跟 .a 或 .framework 名字一致
    - bundle的创建：新建一个文件夹，修改扩展名为 .bundle 即可，右击bundle文件，显示包内容，就可以往bundle文件中放东西
- 多文件处理
    - 如果静态库需要暴露出来的 .h比较多，可以考虑创建一个主头文件（一般 主头文件 和 静态库 同名）
    - 在主头文件中包含所有其他需要暴露出来的 .h 文件
    - 使用静态库时，只需要#import 主头文件
    - 实际上苹果官方就是这么做的，例如：#import <UIKit/UIKit.h>
- .framework为什么既是静态库又是动态库
    - 系统的 .framework 是动态库
    - 我们自己建立的 .framework 是静态库
- 静态库中包含了Category
    - 如果静态库中包含了Category，有时候在使用静态库的工程中会报“方法找不到”的错误（unrecognized selector sent to instance）
    - 解决方案：在使用静态库的工程中配置Other Linker Flags为 `-ObjC`
    
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/3888FA40-578A-406B-9794-5C67E766511F.png)