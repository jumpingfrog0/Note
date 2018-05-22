# iOS Develop Error

<!-- create time: 2015-09-16 10:42:07  -->

<!-- This file is created from $MARBOO_HOME/.media/starts/default.md
本文件由 $MARBOO_HOME/.media/starts/default.md 复制而来 -->

#### UIImageView Aspect fill

[UIImageView Aspect fill](http://stackoverflow.com/questions/32274549/uiimageview-aspect-fill)

	Make sure to set the clipsToBounds property of the UIImageView to YES (or true in Swift).

#### Pod Error in Xcode “Id: framework not found Pods”

[Pod Error in Xcode “Id: framework not found Pods”](http://stackoverflow.com/questions/31139534/pod-error-in-xcode-id-framework-not-found-pods)

This has fixed it for me:

Open up the workspace.

1. Click on the blue project icon (that expands into your file tree) on the left hand side of the screen
2. Just to the right, select "Targets" (as opposed to "Project"--Project is blue, Target is like a pencil and a 3. ruler and a paintbrush making a triangle)
4. Click on the General tab
5. Go to the "Linked Frameworks and Libraries" section (all the way at the bottom)
6. Delete the Pods frameworks
7. Add Alamofire and SwiftyJSON
8. 
In my case, it didn't work unless I removed the pods frameworks, but I get the feeling that this is a workaround. Perhaps someone with more experience can comment.

#### 为一个类新建xib，运行时奔溃

原因：没有设置 xib 的 `File’s Owner`

解决：将 xib 的 `File’s Owner`的 class 设置为该类，并且连线关联 xib 的 view

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/7721BEB0-FFC3-40C7-9848-D69892F6C09C.png) 
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/6749CA50-EA5E-4865-B851-C9E2D0791571.png) 
![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/67D7864C-2783-4778-A714-F0715CBF560D.png)

-----

#### 自定义cell，出现一条横线

原因： `layoutSubviews`没有调用`super`方法

解决：调用 `[super layoutSubviews];`
          
-----

#### EXC_BREAKPOINT

It cause always because of **zombie**

refer to : [http://blog.csdn.net/top123xcode/article/details/8935815](http://blog.csdn.net/top123xcode/article/details/8935815)

------

#### 在iPhone显示没问题，但是在iPad上周围边框有黑边

如下图所示： 

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/AEBBFE2F-B902-4723-A512-3C463FA6B597.png)

解决方案：

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/40CA0F9B-8EFA-492E-B6C8-B415F79FAEAC.png)

------

#### 创建类时，自动添加类前缀

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/84EE1DCE-D748-47CB-967C-1BFAF18E6D9B.png)

---

问题：

有一个新闻详情界面，右上角有一个“评论”按钮，要求点击后跳到评论页面，如果用户已登录，会直接跳转，但是如果用户还没有登录，先moda登录界面，登录完后，登录界面moda下去，再push评论界面，会造成一个延迟，用户体验不要，现在要求，登录界面moda下去后，直接显示评论界面（不要看到push动画）

解决：

当用户登录完后，先给新闻详情界面发一个通知，告诉它已登录，让它偷偷push评论界面出来且不要动画效果，然后再将登录界面moda下去

## Third party embed error

* [引入友盟分享，模拟器中运行报错Undefined symbols for architecture i386](http://bbs.umeng.com/thread-17411-1-1.html)

	因为QQ的sdk去除了i386架构的支持
	
* [Upload to iTunesConnect failing](http://stackoverflow.com/questions/37634627/upload-to-itunesconnect-failing)

		ERROR ITMS-90635: "Invalid Mach-O Format. The Mach-O in bundle "XXXX!.app/Frameworks/BRYXBanner.framework" isn’t consistent with the Mach-O in the main bundle. The main bundle Mach-O contains armv7(machine code) and arm64(machine code), while the nested bundle Mach-O contains armv7(bitcode) and arm64(bitcode). Verify that all of the targets for a platform have a consistent value for the ENABLE_BITCODE build setting." 
	
解决方法：
	
It was off in settings at both places but still didnt work..so i added this to pod file and it worked :
	
	post_install do |installer| 
	  installer.pods_project.targets.each do |target| 
	    target.build_configurations.each do |config| 
	      config.build_settings['ENABLE_BITCODE'] = 'NO' 
	    end 
	  end 
	end
	
[Errors after updating to Xcode 8: “No such module” and “target overrides the `EMBEDDED_CONTENT_CONTAINS_SWIFT`build setting”](http://stackoverflow.com/questions/39569743/errors-after-updating-to-xcode-8-no-such-module-and-target-overrides-the-em)

	I had met this problem today. I solved it by

	1. Go to Project/Targets -> [Project Name] -> Build Settings.
	2. search "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES"
	3. click the right of Debug, and selected 'Other', input "$(inherited)"
	4. do same with 'Release' and install your pod

	You can follow the image below.

![](https://i.stack.imgur.com/DF001.png)

## iOS crash 日志

### 常见错误标识

#### 低内存闪退

前面提到大多数crash日志都包含着执行线程的栈调用信息，但是低内存闪退日志除外，这里就先看看低内存闪退日志是什么样的。
我们使用Xcode 5和iOS 7的设备模拟一次低内存闪退，然后通过Organizer查看产生的crash日志，可以发现Process和Type都为Unknown：

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/6B7F9DD7-D9B6-48E0-81CC-AAC649BB8F00.png)

#### Watchdog超时

Apple的iOS Developer Library网站上，QA1693文档中描述了 `Watchdog` 机制，包括生效场景和表现。如果我们的应用程序对一些特定的UI事件（比如启动、挂起、恢复、结束）响应不及时，`Watchdog` 会把我们的应用程序干掉，并生成一份响应的crash报告。

这份crash报告的有趣之处在于异常代码：`0x8badf00d`，即 `ate bad food`。
如果说特定的UI事件比较抽象，那么用代码来直接描述的话，对应的就是（创建一个工程时Xcode自动生成的）UIApplicationDelegate的几个方法

#### Exception codes
上面“用户强制退出”的crash日志中的Exception Codes是 `0xdeadfa11`，再上面 `Watchdog` 超时”的crash日志中的Exception Codes是 `0x8badf00d`，这些都是特有的Exception codes。

根据官方文档描述，至少有以下几种特定异常代码：

* `0x8badf00d`错误码：`Watchdog超时`，意为 `ate bad food`。

* `0xdeadfa11`错误码：用户强制退出，意为`dead fall`。

* `0xbaaaaaad`错误码：用户按住Home键和音量键，获取当前内存状态，不代表崩溃。

* `0xbad22222`错误码：VoIP应用（因为太频繁？）被iOS干掉。

* `0xc00010ff`错误码：因为太烫了被干掉，意为`cool off`。

* `0xdead10cc`错误码：因为在后台时仍然占据系统资源（比如通讯录）被干掉，意为`dead lock`。

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/393F0C05-3B98-4B7A-9049-F631DE0CF7D6.png)

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/%40EQH%5BBG54A%29%7DFUHP%7DMM%5BSOA.jpg)

dwarfdump --uuid 美甲帮.app/美甲帮

dwarfdump --uuid 美甲帮.app.dSYM

[https://docs.fabric.io/apple/crashlytics/missing-dsyms.html](https://docs.fabric.io/apple/crashlytics/missing-dsyms.html)

--------

[Code Sign Error in macOS Sierra Xcode 8 : resource fork, Finder information, or similar detritus not allowed](http://stackoverflow.com/questions/39652867/code-sign-error-in-macos-sierra-xcode-8-resource-fork-finder-information-or)

### Swift

[Swift 3: Expression implicitly coerced from 'UIView?' to Any](http://stackoverflow.com/questions/40386836/swift-3-expression-implicitly-coerced-from-uiview-to-any)

![](http://jumpingfrog0-images.oss-cn-shenzhen.aliyuncs.com/string%3F_to_Any_warning.png)