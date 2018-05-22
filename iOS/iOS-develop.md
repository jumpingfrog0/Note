# iOS develop

## Have read

### Runtime

[翻译：Method Swizzling](http://esoftmobile.com/2014/02/19/method-swizzling/)

### Status Bar 的那些坑】

[stackoverflow -- The unbalanced calls to begin/end appearance transitions](http://stackoverflow.com/questions/9088465/unbalanced-calls-to-begin-end-appearance-transitions-for-detailviewcontroller)

[stackoverflow -- hidesBarsOnSwipe set on UINavigationController](http://stackoverflow.com/questions/25870382/how-to-prevent-status-bar-from-overlapping-content-with-hidesbarsonswipe-set-on)

[stackoverflow -- preferredStatusBarStyle isn't called](http://stackoverflow.com/questions/19022210/preferredstatusbarstyle-isnt-called)

[iOS 使用Method Swizzling隐藏Status Bar](http://www.bkjia.com/IOSjc/889635.html)

-----

## Unread

### dynamic TableViewCell height

[Using Auto Layout in UITableView for dynamic cell layouts & variable row heights](http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights)

[Dynamic Table View Cell Height and Auto Layout](http://www.raywenderlich.com/73602/dynamic-table-view-cell-height-auto-layout)

[How to present UIAlertController when not in a view controller?](http://stackoverflow.com/questions/26554894/how-to-present-uialertcontroller-when-not-in-a-view-controller)

[How to use UITableViewHeaderFooterView?](http://stackoverflow.com/questions/12900446/how-to-use-uitableviewheaderfooterview)

### NSTimer 内存泄露问题

自定义NStimer

[http://blog.callmewhy.com/2015/07/06/weak-timer-in-ios/](http://blog.callmewhy.com/2015/07/06/weak-timer-in-ios/)

选择 GCD 还是 NSTimer ？

[http://www.jianshu.com/p/0c050af6c5ee](http://www.jianshu.com/p/0c050af6c5ee)

[UIApplication sharedApplication - keyWindow is nil?](http://stackoverflow.com/questions/3359501/uiapplication-sharedapplication-keywindow-is-nil)

-----

##### Notification

[custom notification sound](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/IPhoneOSClientImp.html)

[Apple Push Notification Service](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ApplePushService.html#//apple_ref/doc/uid/TP40008194-CH100-SW1)

[How to handle launchOptions: [NSObject: AnyObject]? in Swift?](http://stackoverflow.com/questions/26641127/how-to-handle-launchoptions-nsobject-anyobject-in-swift)

payload example:

	{"aps":{"alert":"example", "sound":"default", "badge": 1, "category":"identifier"}}
------

[ios system sound file download url](https://sites.google.com/site/iphonesounds/iPhoneOriginalSystemSounds_WAV.zip?attredirects=0)

[NSTimer stops firing in Background after some time](http://stackoverflow.com/questions/25658064/nstimer-stops-firing-in-background-after-some-time)

[AnyObject' is not convertible to 'Self'](http://stackoverflow.com/questions/27109268/how-can-i-create-instances-of-managed-object-subclasses-in-a-nsmanagedobject-swi)

['AnyObject?' is not a subtype of CustomClass](http://stackoverflow.com/questions/24609153/anyobject-is-not-a-subtype-of-customclass)

#### Enterprise Distributing App

[Apple Developer Document: Distributing Enterprise Apps](https://developer.apple.com/videos/wwdc/2014/?id=705)

[Apple Developer Document: Guidelines for installing custom enterprise apps on iOS](https://support.apple.com/en-us/HT204460)

[Let’s take a look at in-house iOS apps, part 2 of 2: Managing the apps](http://www.brianmadden.com/blogs/jackmadden/archive/2012/08/10/let-s-take-a-look-at-in-house-ios-apps-part-2-of-2-managing-the-apps.aspx)

[Singleton pattern and proper use of Alamofire's URLRequestConvertible](http://stackoverflow.com/questions/31286632/singleton-pattern-and-proper-use-of-alamofires-urlrequestconvertible)

[Proper usage of the Alamofire's URLRequestConvertible](http://stackoverflow.com/questions/28333241/proper-usage-of-the-alamofires-urlrequestconvertible)

#### UITableView not pinned to top layout guide
> refer to : [https://github.com/xmartlabs/XLForm/issues/483](https://github.com/xmartlabs/XLForm/issues/483)

	override func viewDidLayoutSubviews()
	{
	    super.viewDidLayoutSubviews()
	    tableView.contentInset.top = topLayoutGuide.length
	}

#### Swift 与 Objective-C相互调用

[Swift 与 Objective-C相互调用](http://www.bubuko.com/infodetail-846370.html)



#### google maps
[NSThread gtm_performBlock Error](http://stackoverflow.com/questions/18940147/nsthread-gtm-performblock-error)

#### keyboard size
[keyboard size given by NSNotificationCenter](http://stackoverflow.com/questions/11298688/keyboard-size-given-by-nsnotificationcenter)


#### About Internationalization and Localization
[About Internationalization and Localization](https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i-CH1-SW1)

[How to do I18N/Localization in-app?](http://stackoverflow.com/questions/8185416/ios-how-to-do-i18n-localization-in-app)

[iOS Supported Language Codes (ISO-639)](http://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html)

[the babble-blog: App Localization](http://www.ibabbleon.com/copywriter-translator/2013/05/ios-language-codes-how-do-you-name-your-lproj-folder/)

[Working with Localization in iOS 8 and Xcode 6](http://www.appcoda.com/localization-tutorial-ios8/)

[Localizing with Plurals and Genders](http://objectivetoast.com/2014/04/21/localizing-with-plurals-and-genders/)

[IOS APP 国际化 程序内切换语言实现 不重新启动系统（支持项目中stroyboard 、xib 混用。完美解决方案）](http://www.cnblogs.com/tangbinblog/p/3972318.html)

[IOS APP 国际化（实现不跟随系统语言，不用重启应用,代码切换stroyboard ,xib ,图片，其他资源）](http://www.cnblogs.com/tangbinblog/p/3898046.html)

[ iOS国际化](http://blog.csdn.net/VictorMoKai/article/details/48894873)


#### NavigationBar的各种坑
[UIScrollView offset in UINavigationController](http://stackoverflow.com/questions/18967859/ios7-uiscrollview-offset-in-uinavigationcontroller)

[Appearance and Behavior](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/TransitionGuide/AppearanceCustomization.html)

[Fixing the iOS 7 Navigation Bar Overlap Problem](http://blog.motioninmotion.tv/fixing-the-ios-7-navigation-bar-overlap-problem/)

[将NavigationBar设置透明](http://blog.csdn.net/chaoyuan899/article/details/11590867)

[iOS 动态修改导航栏颜色 UINavigationBar -- 类淘宝](http://www.cnblogs.com/someonelikeyou/p/5124403.html)

[动态修改UINavigationBar的背景色](http://www.cocoachina.com/ios/20150409/11505.html)

[动态修改UINavigationBar的背景色](http://tech.glowing.com/cn/change-uinavigationbar-backgroundcolor-dynamically/)

#### SeparatorInset
[Remove SeparatorInset on iOS 8 UITableView for XCode 6 iPhone Simulator](http://stackoverflow.com/questions/25762723/remove-separatorinset-on-ios-8-uitableview-for-xcode-6-iphone-simulator)

[iOS7 tableview separatorInset cell分割线左对齐](http://www.skyfox.org/ios7-tableview-separatorinset-ajust.html)

#### debug
[Xcode 6 Advanced Debugging](http://encyclopediaofdaniel.com/blog/xcode-6-advanced-debugging/)

[what the fuck bug about fabric](http://stackoverflow.com/questions/31992079/xcode-7-beta-debugger-not-showing-values-of-variable-at-breakpoint-for-swift-cod)

[without debugger, may be Crashlytics](https://twittercommunity.com/t/xcode-7-debugger/50792)

[without debugger, may be GoogleMaps???](https://code.google.com/p/gmaps-api-issues/issues/detail?id=8524)

#### NSNotification

[remove observer](http://stackoverflow.com/questions/21418726/ios-remove-observer-from-notification-can-i-call-this-once-for-all-observers-a)

#### layoutSubviews

[谈谈UIView的几个layout方法-layoutSubviews、layoutIfNeeded、setNeedsLayout...](http://www.jianshu.com/p/eb2c4bb4e3f1)

[关于 UIView 的 layoutSubviews 方法](http://bachiscoding.com/blog/2014/12/15/when-will-layoutsubviews-be-invoked/)

[When is layoutSubviews called?](http://stackoverflow.com/questions/728372/when-is-layoutsubviews-called)

#### dispatch_async
[dispatch_get_global_queue vs dispatch_get_main_queue](http://stackoverflow.com/questions/12693197/dispatch-get-global-queue-vs-dispatch-get-main-queue)

	The dispatch_get_global_queue gets you a background queue upon which you can dispatch background tasks that are run asynchronously (i.e. won't block your user interface). And if you end up submitting multiple blocks to the global queues, these jobs can operate concurrently. If you have multiple blocks of code that you want to submit to a background queue that you must have run sequentially in the background (not often needed), you could create your own serial background queue and dispatch to that, but if concurrent background operations are acceptable, then availing yourself of dispatch_get_global_queue is convenient/efficient.

	Be aware, though, that you're not allowed to perform user interface updates in the background queue, so the dispatch_async to the dispatch_get_main_queue lets that background queue dispatch the user interface updates back to the main queue, once the main queue is available.

	This is a very common programming pattern: Submit something to run in the background and when it needs to perform user updates, dispatch the update back to the main queue.

	For more information, refer to the
	Concurrency Programming Gui1

<https://developer.apple.com/library/ios/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1>.

[Xcode wont start, stuck on 'Verifying “Xcode”…'](http://stackoverflow.com/questions/25996484/xcode-wont-start-stuck-on-verifying-xcode)

	xattr -d com.apple.quarantine Xcode.app

<br>
----------------------------------

### Integration Thirk-party

##### Fabric
[How do I fix linker errors when adding Fabric?](http://support.crashlytics.com/knowledgebase/articles/617277)

### Revoke certificates

[关于revoke certificate和备份的这点事](http://joeyio.com/2013/06/12/revoke-certificate/)
​	
	Important: Members of the Standard iOS Developer Program can be assured that replacing either your developer or distribution certificate will not affect any existing apps that you've published in the iOS App Store, nor will it affect your ability to update those apps.

	Notes before beginning:

	Replacing your distribution certificate won't affect your developer certificate or development profiles.

	Similarly, replacing your developer certificate won't affect your distribution certificate or distribution profiles.

	Replace only your development certificate if you are troubleshooting an issue running your app on device through Xcode.

	Replace only your distribution certificate if you are troubleshooting an issue creating, submitting or installing a distribution build.

	After replacing your certificate(s) you are required to update and reinstall any provisioning profiles that were bound to the old certificate.

[OS Code Signing Troubleshooting](https://developer.apple.com/legacy/library/technotes/tn2250/_index.html#//apple_ref/doc/uid/DTS40009933-CH1-TNTAG24)

[How do I delete/revoke my certificates and start over fresh?](https://developer.apple.com/legacy/library/technotes/tn2250/_index.html#//apple_ref/doc/uid/DTS40009933-CH1-TNTAG6)

[Why not use development provisioning instead of ad hoc?](http://stackoverflow.com/questions/2625773/why-not-use-development-provisioning-instead-of-ad-hoc)

	There's one situation in which you need an Ad Hoc profile, and that's when you want to test Push Notifications.

	If you test Push Notifications on a Development Provisioning Profile, your push notifications need to be sent using the Development Push Notification Certificate for your SSL connections to Apple's sandbox APNS server.
	
	If you want to test Push Notifications using your Production Push Notification Certificate and the live APNS servers, you'll have to deploy your app to a device using a Distribution Certificate and Ad Hoc Provisioning Profile (which includes doing the Entitlement.plist retardedness which you can ordinarily skip if you were only using Developer Provisioning Profiles).
	
	Also note that when you deploy using an Ad Hoc profile, your device token will be different from the one you use when you're using the development profile. Also this the recommended way to test APN because there's no back end changes that need to be made between the Ad Hoc build and the final live deployment on the AppStore.

### Unit Test

[Xcode6下iOS单元测试——XCTest和GHUnit框架简介和比较](http://blog.csdn.net/abc649395594/article/details/47823547)

[iOS开发中的单元测试（一）](http://www.infoq.com/cn/articles/ios-unit-test-1)

[XCTest​Case /
XCTest​Expectation /
measure​Block()](http://nshipster.com/xctestcase/)

### iPhone resolution

[iPhone 6 Screens Demystified](http://www.paintcodeapp.com/news/iphone-6-screens-demystified)

[iOS开发- 游戏屏幕适配(SpriteKit)](http://demo.netfoucs.com/hitwhylz/article/details/42082225)

### UIStackView & UICollectionView

[UIStackView小窥](http://www.devtalking.com/articles/uistackview/)
[iOS 9: UIStackView入门](http://www.cocoachina.com/ios/20150623/12233.html)

[UIStackView](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIStackView_Class_Reference/)

[自定义UICollectionViewLayout 瀑布流](http://www.saitjr.com/ios/ios-custom-uicollectionviewlayout.html)

[Creating Custom Layouts](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html)

[How to Add a Decoration View to a UICollectionView](https://markpospesel.wordpress.com/2012/12/11/decorationviews/)


### ios hardware communication

[Guest post: Building an iOS app for external devices](http://muniwireless.com/2014/01/07/building-ios-app-external-devices/)

### UIView Border outside black line
[cornerRadius with border : Some glitch at border](http://stackoverflow.com/questions/25551053/cornerradius-with-border-some-glitch-at-border)

[Set the CALayer 'borderWidth' and 'cornerRadius' in iOS, can not fully covers background](http://stackoverflow.com/questions/31602251/set-the-calayer-borderwidth-and-cornerradius-in-ios-can-not-fully-covers-ba)

### 自动化打包

[自己用Python写的iOS项目自动打包脚本](http://www.cocoachina.com/ios/20160307/15501.html)

[xcode-shell](https://github.com/webfrogs/xcode_shell)

[iOS自动打包并发布脚本](http://liumh.com/2015/11/25/ios-auto-archive-ipa/)

[详解Shell脚本实现iOS自动化编译打包提交](http://zackzheng.info/2015/12/27/2015-12-27-an-automated-script-for-building-archiving-submission-sending-emails/)

[唐巧的技术博客_专访《iOS测试指南》作者羋峮](http://blog.devtang.com/blog/2014/06/01/interview-on-miqun/)

[豆瓣自动化测试开源工具ynm3k](https://github.com/douban/ynm3k)

### OAuth refresh token

[Mechanism to Retry Requests ](https://github.com/Alamofire/Alamofire/issues/1097)

[Alamofire : How to handle errors globally](http://stackoverflow.com/questions/28733256/alamofire-how-to-handle-errors-globally)

### Size Class

[iOS8 AutoLayout与Size Class 自悟](http://www.hmttommy.com/2014/12/05/AutoLayout/)

[[iOS] 初探 iOS8 中的 Size Class](http://blog.csdn.net/pleasecallmewhy/article/details/39295327)

### Animation

[Creating Custom UIViewController Transitions](https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions)

### GCD

[浅谈GCD](http://allanhost.com/blog/2015/04/08/%E6%B5%85%E8%B0%88GCD.html)

[debug 和 release 的区别](http://blog.csdn.net/mad1989/article/details/40658033)

[截获导航控制器系统返回按钮的点击pop及右滑pop事件](http://www.jianshu.com/p/6376149a2c4c)

[swift桥接头文件 import <xx/xx.h> file not found的问题](http://www.jianshu.com/p/d61f915d9530)

[通知机制导读](http://zeroheroblog.com/ios/notifications-in-ios-part-1-broadcasting-events-via-nsnotificationcenter)

[iOS 学习资料整理](https://segmentfault.com/a/1190000002473595)

[Launch Image not showing up in iOS application (using Images.xcassets)](http://stackoverflow.com/questions/27723547/launch-image-not-showing-up-in-ios-application-using-images-xcassets)

### Landscape

[iOS Orientations: Landscape orientation for only one View Controller](http://swiftiostutorials.com/ios-orientations-landscape-orientation-one-view-controller/)

### Ipv6

[IPv6-only 你准备好了吗](http://www.jianshu.com/p/86ff36f84089)

[检查iOS App是否支持IPv6-only Network](http://www.liuhaihua.cn/archives/368022.html)

[Supporting IPv6 DNS64/NAT64 Networks](https://developer.apple.com/library/mac/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/UnderstandingandPreparingfortheIPv6Transition/UnderstandingandPreparingfortheIPv6Transition.html#//apple_ref/doc/uid/TP40010220-CH213-SW1)

[iOS-用手机网络测试Ipv6](http://www.jianshu.com/p/6c7a155fc372/comments/2663653)

### Cocoapods

[CocoaPods的ruby问题 Error fetching http://ruby.taobao.org/](http://www.cnblogs.com/fengmin/p/5144247.html)

### Xcode problem summary

[Why is Swift compile time so slow?](http://stackoverflow.com/questions/25537614/why-is-swift-compile-time-so-slow)

[Shaving off 50% waiting time from the iOS Edit-Build-Test cycle](https://labs.spotify.com/2013/11/04/shaving-off-time-from-the-ios-edit-build-test-cycle/)

### 获取设备的型号（具体到iphone5还是iphone6)

	#import "sys/utsname.h"
	struct utsname systemInfo;
	uname(&systemInfo);
	
	NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
	NSLog(@"%@", deviceString);
	
### iOS 代码划分

* life cycle
* UITableViewDelegate
* CustomDelegate
* event response
* private methods
* getters and setters

### 日期格式
http://www.cnblogs.com/jhxk/articles/1618194.html
{0:yyyy-MM-dd HH:mm:ss.fff}:使用24小时制格式化日期

{0:yyyy-MM-dd hh:mm:ss.fff}:使用12小时制格式化日期

以下同理,从左至右分别为-年-月-日 时:分:秒.毫秒
{0:yyyy-MM-dd HH:mm:ss zzz}
{0:yyyy-MM-dd HH:mm:ss.ff zzz}
{0:yyyy-MM-dd HH:mm:ss.fff zzz}
{0:yyyy-MM-dd HH:mm:ss.ffff zzz}

以下测试代码
//---假设时间为-2009-03-17 16:50:49.92
object objValue2 = Business.Services.ExecuteScalar(sqliteconnstring, "Select LastUpdate From CmItemClass2 order by LastUpdate desc limit 0,1");
string lastUpdate2 = objValue2 == null ? string.Empty : string.Format("{0:yyyy-MM-dd HH:mm:ss.fff}", objValue2); //--输出2009-03-17 16:50:49.920
string lastUpdate3 = objValue2 == null ? string.Empty : string.Format("{0:yyyy-MM-dd hh:mm:ss.fff}", objValue2); //--输出2009-03-17 04:50:49.920

//--------------------
y 将指定 DateTime 对象的年份部分显示为位数最多为两位的数字。忽略年的前两位数字。如果年份是一位数字 (1-9)，则它显示为一位数字。
yy 将指定 DateTime 对象的年份部分显示为位数最多为两位的数字。忽略年的前两位数字。如果年份是一位数字 (1-9)，则将其格式化为带有前导 0 (01-09)。
yyyy 显示指定 DateTime 对象的年份部分（包括世纪）。如果年份长度小于四位，则按需要在前面追加零以使显示的年份长度达到四位。

z 仅以整小时数为单位显示系统当前时区的时区偏移量。偏移量总显示为带有前导或尾随符号（零显示为“+0”），指示早于格林威治时间 (+) 或迟于格林威治时间 (-) 的小时数。值的范围是 –12 到 +13。如果偏移量为一位数 (0-9)，则将其显示为带合适前导符号的一位数。该时区的设置指定为 +X 或 –X，其中 X 是相对 GMT 以小时为单位的偏移量。所显示的偏移量受夏时制的影响。
zz 仅以整小时数为单位显示系统当前时区的时区偏移量。偏移量总显示为带有前导或尾随符号（零显示为“+00”），指示早于格林威治时间 (+) 或迟于格林威治时间 (-) 的小时数。值范围为 –12 到 +13。如果偏移量为单个数字 (0-9)，则将其格式化为前面带有 0 (01-09) 并带有适当的前导符号。该时区的设置指定为 +X 或 –X，其中 X 是相对 GMT 以小时为单位的偏移量。所显示的偏移量受夏时制的影响。
zzz, zzz（外加任意数量的附加“z”字符）以小时和分钟为单位显示系统当前时区的时区偏移量。偏移量总是显示为带有前导或尾随符号（零显示为“+00:00”），指示早于格林威治时间 (+) 或迟于格林威治时间 (-) 的小时和分钟数。值范围为 –12 到 +13。如果偏移量为单个数字 (0-9)，则将其格式化为前面带有 0 (01-09) 并带有适当的前导符号。该时区的设置指定为 +X 或 –X，其中 X 是相对 GMT 以小时为单位的偏移量。所显示的偏移量受夏时制的影响。

: 时间分隔符。
/ 日期分隔符。
" 带引号的字符串。显示转义符 (/) 之后两个引号之间的任何字符串的文本值。
' 带引号的字符串。显示两个“'”字符之间的任何字符串的文本值。
%c 其中 c 是标准格式字符，显示与格式字符关联的标准格式模式。
\c 其中 c 是任意字符，转义符将下一个字符显示为文本。在此上下文中，转义符不能用于创建转义序列（如“\n”表示换行）。
任何其他字符 其他字符作为文本直接写入输出字符串。

向 DateTime.ToString 传递自定义模式时，模式必须至少为两个字符长。如果只传递“d”，则公共语言运行库将其解释为标准格式说明符，这是因为所有单个格式说明符都被解释为标准格式说明符。如果传递单个“h”，则引发异常，原因是不存在标准的“h”格式说明符。若要只使用单个自定义格式进行格式化，请在说明符的前面或后面添加一个空格。例如，格式字符串“h”被解释为自定义格式字符串。

下表显示使用任意值 DateTime.Now（该值显示当前时间）的示例。示例中给出了不同的区域性和时区设置，以阐释更改区域性的影响。可以通过下列方法更改当前区域性：更改 Microsoft Windows 的“日期/时间”控制面板中的值，传递您自己的 DateTimeFormatInfo 对象，或将 CultureInfo 对象设置传递给不同的区域性。此表是说明自定义日期和时间说明符如何影响格式化的快速指南。请参阅该表下面阐释这些说明符的代码示例部分。

格式说明符 当前区域性 时区 输出
d, M en-US GMT 12, 4
d, M es-MX GMT 12, 4
d MMMM en-US GMT 12 April
d MMMM es-MX GMT 12 Abril
dddd MMMM yy gg en-US GMT Thursday April 01 A.D.
dddd MMMM yy gg es-MX GMT Jueves Abril 01 DC
h , m: s en-US GMT 6 , 13: 12
hh,mm:ss en-US GMT 06,13:12
HH-mm-ss-tt en-US GMT 06-13-12-AM
hh:mm, G\MT z  en-US GMT 05:13 GMT +0
hh:mm, G\MT z  en-US GMT +10:00 05:13 GMT +10
hh:mm, G\MT zzz en-US GMT 05:13 GMT +00:00


### iOS后台运行

[Background Modes Tutorial: Getting Started](https://www.raywenderlich.com/92428/background-modes-ios-swift-tutorial)

[iOS后台模式开发指南](https://github.com/hehonghui/iOS-tech-frontier/blob/master/issue-3/iOS%E5%90%8E%E5%8F%B0%E6%A8%A1%E5%BC%8F%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97.md)

### Unowned vs weak

[Shall we always use [unowned self] inside closure in Swift](http://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift)

[Why specify [unowned self] in blocks where you depend on self being there?](http://stackoverflow.com/questions/32936264/why-specify-unowned-self-in-blocks-where-you-depend-on-self-being-there)

### App Store 下载链接

[https://itunes.apple.com/us/app/a-gai-hua-shi-jie/id1131947172](https://itunes.apple.com/us/app/a-gai-hua-shi-jie/id1131947172)

### UIView init

[Why UIView calls both init and initWithFrame?](http://stackoverflow.com/questions/19423182/why-uiview-calls-both-init-and-initwithframe)

### iOS 强制横屏总结

[iOS强制横屏总结](http://www.jianshu.com/p/5c773628caa6)

### Xcode 调试问题

[Xcode error “Could not find Developer Disk Image”](http://stackoverflow.com/questions/30736932/xcode-error-could-not-find-developer-disk-image)

### Top window

[In iOS, how do I create a button that is always on top of all other view controllers?](http://stackoverflow.com/questions/34777558/in-ios-how-do-i-create-a-button-that-is-always-on-top-of-all-other-view-control)

### Xcode 8 多余Log

[http://www.jianshu.com/p/80ab798553d8](http://www.jianshu.com/p/80ab798553d8)

	设置OS_ACTIVITY_MODE ~> disable