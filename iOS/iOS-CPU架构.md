# iOS-CPU架构

<!--
create time: 2018-08-03 17:16:13
Author: <黄东鸿>
-->

### 概念

#### ARM

ARM处理器，特点是体积小、低功耗、低成本、高性能，几乎所有的手机处理器都基于ARM，苹果当然也不例外。

#### ARM 处理器指令集

armv6、armv7、armv7s、arm64 都是ARM处理器的指令集，所有指令集原则上都是向下兼容的。如 iPhone 4s的CPU默认指令集为armv7指令集，但它可以同时也兼容armv6的指令集，只是在使用armv6的时候无法充分发挥其性能(无法发挥armv7指令集中得新特性)。

#### Mac 处理器指令集

i386、x86_64 是Mac处理器的指令集。

i386 是针对intel通用微处理器32位处理器的，x86_64 是针对x86架构64位处理器的。

因为模拟器的cpu就是用到电脑的cpu,所以模拟器只能使用上诉两种的指令集。

#### 说明

* 模拟器32位处理器需要i386架构
* 模拟器64位处理器需要x86_64架构
* 真机32位处理器需要armv7,或者armv7s架构
* 真机64位处理器需要arm64架构

### 设备的CPU架构

#### 模拟器

* i386: iPhone 4s\5 
* x86_64: iPhone 5s及以上

#### 真机

* armv6: iPhone, iPhone 2, iPhone 3G, iPod Touch 1, iPod Touch 2
* armv7: iPhone 3Gs, iPhone 4, iPhone 4s, iPad, iPad2
* armv7s: iPhone 5, iPhone 5C
* arm64: iPhone 5s, iPhone 6, iPhone 6 Plus, iPhone 6s, iPhone 6s Plus, iPhone 7, iPhone 7 Plus, iPad Air, iPad Air2, iPad mini2, iPad mini3, iPad mini4, iPad Pro

**注意：静态库只要支持了armv7,就可以在armv7s的架构上运行**

### Xcode中指令集相关选项

#### 1.Architectures

`Architectures` 的作用是指明选定的Target要求被编译生成的二进制包所支持的指令集，而支持的指令集越多，就会编译出包含多个指令集代码的数据包，对应生成二进制包就越大，也就是ipa包会变大。

![](http://os3yasu4i.bkt.clouddn.com/xcode_architectures.jpeg)

#### 2.Valid Architectures

`Valid Architectures`的作用是限制可能被支持的指令集的范围，也就是Xcode编译出来的二进制包类型最终从这些类型产生，而编译出哪种指令集的包，将由 `Architectures` 与 `Valid Architectures`（因此这个不能为空）的交集来确定。

比如: 将 `Architectures` 支持arm指令集设置为: armv7, armv7s, 对应的 `Valid Architectures` 的支持的指令集设置为: armv7s, arm64, 那么此时Xcode生成二进制包所支持的指令集只有armv7s。

#### 3.Build Active Architecture Only

`Build Active Architecture Only` 的作用是指定是否只对当前连接设备所支持的指令集编译,当其值设置为YES，这个属性设置为yes，是为了debug的时候编译速度更快，它只编译当前的architecture版本，而设置为no时，会编译所有的版本。 所以，一般debug的时候可以选择设置为yes，release的时候要改为no，以适应不同设备。

当`Build Active Architecture Only`起作用时：连接的手机指令集匹配是由高到低（arm64 > armv7s > armv7）依次匹配的。

所以当连接的手机是指令集为arm64时,若Architectures列表为armv7, armv7s,则会选取armv7s指令集为目标指令集，如果此时Valid Architectures列表中包含该指令集，则成功生成的二进制包只支持armv7s指令集; 

若Valid Architectures列表不包含此指令集，则编译将会出错 `No architectures to compile for (ONLY_ACTIVE_ARCH=YES, active arch=arm64, VALID_ARCHS=armv7 armv7s)`

### 最后

要发挥手机的64位处理器性能，就要包含64位包，那么系统最低要求为 iOS 6。 如果要兼容ios5以及更低的系统，只能打32位的包，系统都能通用，但是会丧失64位处理器性能。当然现在一般都支持iOS 8以上了，但是为了能在4s上运行，仍需要支持32位的包。

在平时开发中，为了优化包体，不管是我们作为SDK提供方还是使用第三方SDK，都要求 .a 支持的架构仅保持最小可用限度就行了，也就是能在4s以上的真机运行即可。

所以，一般情况下，制作的静态库只需要支持 armv7 和 arm64 架构就可以了。


#### 参考

[iOS CPU架构(ARM指令集)](https://www.jianshu.com/p/461edde66d02?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)

[armv7,armv7s,arm64,i386,x86_64的区别](https://www.jianshu.com/p/b87e6f0bac54)
