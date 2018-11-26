iOS 面试题及解答2
=========

## UITableView的优化技巧

[UITableView优化技巧](http://longxdragon.github.io/2015/05/26/UITableView%E4%BC%98%E5%8C%96%E6%8A%80%E5%B7%A7/)

[UITableView的优化](http://www.jianshu.com/p/93085c0de4c9)

UITableView的优化主要从三个方面入手：

* 提前计算并缓存好高度（布局），因为heightForRowAtIndexPath:是调用最频繁的方法；
* 使用CoreText异步绘制Cell，遇到复杂界面，遇到性能瓶颈时，可能就是突破口；
* 滑动时按需加载，如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载，这个在快速滚动和大量图片展示的时候很管用！（SDWebImage已经实现异步加载，配合这条性能杠杠的）。

除了上面最主要的三个方面外，还有很多几乎大伙都很熟知的优化点：

* 正确使用reuseIdentifier来重用Cells
* 尽量使所有的view opaque，包括Cell自身
* 尽量少用或不用透明\阴影、圆角等图层属性，尽量采用其他替代方案
* 如果Cell内现实的内容来自web，使用异步加载，缓存请求结果
* 减少View的层级
* 在heightForRowAtIndexPath:中尽量不使用cellForRowAtIndexPath:，如果你需要用到它，只用一次然后缓存结果
* 尽量少用addView给Cell动态添加View，可以初始化时就添加，然后通过hide来控制是否显示

## iOS 性能优化

[iOS 程序性能优化](http://www.samirchen.com/ios-performance-optimization/)

[Designing for iOS: Graphics &amp; Performance](https://robots.thoughtbot.com/designing-for-ios-graphics-performance)

[如何加强 iOS 里的列表滚动时的顺畅感？](https://www.zhihu.com/question/20382396)

[iOS 保持界面流畅的技巧](http://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/)

### 初级技巧

#### 1. 避免臃肿的Xib文件

当你加载一个 XIB 时，它的所有内容都会被加载，如果这个 XIB 里面有个 View 你不会马上就用到，你其实就是在浪费宝贵的内存。所以，，一般情况下，一个Xib只包含一个view。
而加载 StoryBoard 时并不会把所有的 ViewController 都加载，只会按需加载。

#### 2. 不要阻塞主线程

把I/O操作、网络读取数据等耗时操作放到其他线程中处理

#### 3. 启用 GZIP 数据压缩

### 中级技巧

#### 1. View 的复用机制

当你的程序中需要展示很多的 View 的时候，这就意味着需要更多的 CPU 处理时间和内存空间，这个情况对程序性能的影响在你使用 UIScrollView 来装载和呈现界面时会变得尤为显著。

处理这种情况的一种方案就是向 UITableView 和 UICollectionView 学习，不要一次性把所有的 subviews 都创建出来，而是在你需要他们的时候创建，并且用复用机制去复用他们。这样减少了内存分配的开销，节省了内存空间。

#### 2. View 的懒加载机制

「懒加载机制」就是把创建对象的时机延后到不得不需要它们的时候。这个机制常常用在对一个类的属性的初始化上。

存在这样一种场景：你点击一个按钮的时候，你需要显示一个 View，这时候你有两种实现方案：

* 在当前界面第一次加载的时候就创建出这个 View，只是把它隐藏起来，当你需要它的时候，只用显示它就行了。
* 使用「懒加载机制」，在你需要这个 View 的时候才创建它，并展示它。

这两种方案都各有利弊。采用方案一，你在不需要这个 View 的时候显然白白地占用了更多的内存，但是当你点击按钮展示它的时候，你的程序能响应地相对较快，因为你只需要改变它的 hidden 属性。采用方案二，那么你得到的效果相反，你更准确的使用了内存，但是如果对这个 View 的初始化和创建比较耗时，那么响应性相对就没那么好了。

所以当你考虑使用何种方案时，你需要根据现实的情况来参考，去权衡到底哪个因素才是影响性能的瓶颈，然后再做出选择。

#### 3. 缓存

在开发我们的程序时，一个很重要的经验法则就是：`对那些更新频度低，访问频度高的内容做缓存`。

有哪些东西使我们可以缓存的呢？比如下面这些：

服务器的响应信息（response）。
图片。
计算值。比如：UITableView 的 row heights。

NSURLConnection 可以根据 HTTP 头部的设置来决定把资源内容缓存在磁盘或者内存，你甚至可以设置让它只加载缓存里的内容：

```objective-c
+ (NSMutableURLRequest *)imageRequestWithURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
 
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad; // this will make sure the request always returns the cached image
    request.HTTPShouldHandleCookies = NO;
    request.HTTPShouldUsePipelining = YES;
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
 
    return request;
}
```

关于 HTTP 缓存的更多内容可以关注 NSURLCache。关于缓存其他非 HTTP 请求的内容，可以关注 NSCache。对于图片缓存，可以关注一个第三方库 SDWebImage。

#### 关于图形绘制

当我们为一个 UIButton 设置背景图片时，对于这个背景图片的处理，我们有很多种方案，你可以使用全尺寸图片直接设置，还可以用 resizable images，或者使用 CALayer、CoreGraphics 甚至 OpenGL 来绘制。

当然，不同的方案的编码复杂度不一样，性能也不一样。关于图形绘制的不同方案的性能问题，可以看看：[Designing for iOS: Graphics Performance](https://robots.thoughtbot.com/designing-for-ios-graphics-performance)

简而言之，使用 pre-rendered 的图片会更快，因为这样就不需要在程序中去创建一个图像，并在上面绘制各种形状了（Offscreen Rendering，离屏渲染）。但是缺点是你必须把这些图片资源打包到代码包，从而需要增加程序包的体积。这就是为什么 resizable images 是一个很棒的选择：不需要全尺寸图，让 iOS 为你绘制图片中那些可以拉伸的部分，从而减小了图片体积；并且你不需要为不同大小的控件准备不同尺寸的图片。比如两个按钮的大小不一样，但是他们的背景图样式是一样的，你只需要准备一个对应样式的 resizable image，然后在设置这两个按钮的背景图的时候分别做拉伸就可以了。

但是一味的使用使用预置的图片也会有一些缺点，比如你做一些简单的动画的时候各个帧都用图片叠加，这样就可能要使用大量图片。

总之，你需要去在图形绘制的性能和应用程序包的大小上做权衡，找到最合适的性能优化方案。

#### 处理 Memory Warnings

关于内存警告，苹果的官方文档是这样说的：

> If your app receives this warning, it must free up as much memory as possible. The best way to do this is to remove strong references to caches, image objects, and other data objects that can be recreated later.

我们可以通过这些方式来获得内存警告：

在 AppDelegate 中实现 `- [AppDelegate applicationDidReceiveMemoryWarning:]` 代理方法。
在 UIViewController 中重载 `didReceiveMemoryWarning` 方法。
监听 `UIApplicationDidReceiveMemoryWarningNotification` 通知。
当通过这些方式监听到内存警告时，你需要马上释放掉不需要的内存从而避免程序被系统杀掉。

比如，在一个 UIViewController 中，你可以清除那些当前不显示的 View，同时可以清除这些 View 对应的内存中的数据，而有图片缓存机制的话也可以在这时候释放掉不显示在屏幕上的图片资源。

但是需要注意的是，你这时清除的数据，必须是可以在重新获取到的，否则可能因为必要数据为空，造成程序出错。在开发的时候，可以使用 iOS Simulator 的 `Simulate memory warning` 的功能来测试你处理内存警告的代码。

### 高级技巧

#### imageNamed 和 imageWithContentsOfFile

在 iOS 应用中加载图片通常有 `- [UIImage imageNamed:]` 和 `-[UIImage imageWithContentsOfFile:]` 两种方式。它们的不同在于前者会对图片进行缓存，而后者只是简单的从文件加载文件。

```objective-c
UIImage *img = [UIImage imageNamed:@"myImage"]; // caching
// or
UIImage *img = [UIImage imageWithContentsOfFile:@"myImage"]; // no caching
```
在整个程序运行的过程中，当你需要加载一张较大的图片，并且只会使用它一次，那么你就没必要缓存这个图片，这时你可以使用 -[UIImage imageWithContentsOfFile:]，这样系统也不会浪费内存来做缓存了。当然，如果你会多次使用到一张图时，用 - [UIImage imageNamed:] 就会高效很多，因为这样就不用每次都从硬盘上加载图片了。

## 谈谈你对Runtime的理解

[玉令天下博客的Objective-C Runtime](http://yulingtianxia.com/blog/2014/11/05/objective-c-runtime/)

[顾鹏博客的Objective-C Runtime](http://tech.glowing.com/cn/objective-c-runtime/) 或者 [http://ju.outofmemory.cn/entry/108810](http://ju.outofmemory.cn/entry/108810)

[Sam_Lau 简书博客的Objective-C特性：Runtime](http://www.jianshu.com/p/25a319aee33d)

`Runtime` 是 Objective-C 的动态运行时库，正是有了`Runtime`，Objective-C 才有了面向对象的特性（Objective-C是基于C语言的扩展）和灵活的动态特性。我们常说，Objective-C 是一门动态语言，是因为它的代码运行不总是在编译期决定的，而是有一部分工作推迟到了运行时才动态执行的，Objective-C可以在运行时动态地创建类和对象、进行消息传递和转发。

`Runtime` 中有一个重要的概念叫做**“消息”**，消息的执行会使用到一些编译器为实现动态特性而创建的数据结构和函数，Objc 中的类、方法和协议等在 runtime 中都由一些数据结构来定义。

了解 `Runtime`，就要先了解它的核心 -- `消息传递和转发机制`。

在 Objective-C 中，调用一个对象的某个方法 `[receiver message]`，其实是在给这个对象发送一条消息，它会被编译器转化为：

	objc_msgSend(receiver, selector)
	
如果消息的接收者能够找到对应的selector，那么就相当于直接执行了接收者这个对象的特定方法；否则，消息要么被转发，或是临时想接收者添加这个selector对应的实现内容，要么就干脆玩完奔溃掉。

所以可以看出 `[receiver message]` 这不是简简单单的方法调用，这只是在编译阶段确定了要想接收者发送 `message` 这条消息，而 `receiver` 将要如何响应这条消息，就要看运行时发生的情况来决定了。

利用 runtime，我们可以做很多比较酷的事情，比如：

* 热更新，JSPatch直接调用 `objc_msgForward`来实现其核心功能的，做到了让JS调用/替换任意OC方法，让iOS APP具备热更新的能力。
* 给Category添加属性
* 黑魔法：使用 Method Swizzling 替换 系统方法的实现 

### Runtime术语

每个对象都有一个 `isa` 指针，指向它的类对象，其实是一个指向 `objc_class` 结构体的指针

```objective-c
struct objc_class {
    Class isa  OBJC_ISA_AVAILABILITY;

#if !__OBJC2__
    Class super_class                                        OBJC2_UNAVAILABLE;
    const char *name                                         OBJC2_UNAVAILABLE;
    long version                                             OBJC2_UNAVAILABLE;
    long info                                                OBJC2_UNAVAILABLE;
    long instance_size                                       OBJC2_UNAVAILABLE;
    struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
    struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
#endif

} OBJC2_UNAVAILABLE;
```

可以看到运行时一个类还关联了它的超类指针，类名，成员变量，方法，缓存，还有附属的协议。

* `isa` 指向类对象的元类（Meta Class）
* `super_class`表示实例对象对应的父类
* `name`表示类名
* `ivars`表示多个成员变量
* `methodLists`表示方法列表
* `cache`用来缓存经常访问的方法
* `protocols`表示类遵循哪些协议

objc_class中也有一个isa对象，这是因为一个 ObjC 类本身同时也是一个对象，为了处理类和对象的关系，runtime 库创建了一种叫做元类 (Meta Class) 的东西，类对象所属类型就叫做元类，它用来表述类对象本身所具备的元数据。

每个类仅有一个类对象，而每个类对象仅有一个与之相关的元类。当你发出一个类似[NSObject alloc]的消息时，你事实上是把这个消息发给了一个类对象 (Class Object) ，这个类对象必须是一个元类的实例，而这个元类同时也是一个根元类 (root meta class) 的实例。**所有的元类最终都指向根元类为其超类。所有的元类的方法列表都有能够响应消息的类方法。**所以当 [NSObject alloc] 这条消息发给类对象的时候，objc_msgSend()会去它的元类里面去查找能够响应消息的方法，如果找到了，然后对这个类对象执行方法调用。

![](https://upload-images.jianshu.io/upload_images/2361648-4916caf2b141a8cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/850/format/webp)

上图实线是 super_class 指针，虚线是isa指针。 有趣的是**根元类的超类是NSObject，而isa指向了自己，而NSObject的超类为nil，也就是它没有超类**。


`Cache`为方法调用的性能进行优化，通俗地讲，每当实例对象接收到一个消息时，它不会直接在isa指向的类的方法列表中遍历查找能够响应消息的方法，因为这样效率太低了，而是优先在`Cache`中查找。Runtime 系统会把被调用的方法存到`Cache`中（理论上讲一个方法如果被调用，那么它有可能今后还会被调用），下次查找的时候效率更高。

### 消息传递和转发机制

#### objc_msgSend函数

前面已经对`objc_msgSend`进行了一点介绍，看起来像是`objc_msgSend`返回了数据，其实`objc_msgSend`从不返回数据而是你的方法被调用后返回了数据。

下面详细叙述下消息发送步骤：

1. 检测这个 selector 是不是要忽略的。比如 Mac OS X 开发，有了垃圾回收就不理会 retain, release 这些函数了。
2. 检测这个 target 是不是 nil 对象。ObjC 的特性是允许对一个 nil 对象执行任何一个方法不会 Crash，因为会被忽略掉。
3. 如果上面两个都过了，那就开始查找这个类的 IMP，先从 cache 里面找，完了找得到就跳到对应的函数去执行。
4. 如果 cache 找不到就找一下方法分发表。
5. 如果分发表找不到就到超类的分发表去找，一直找，直到找到NSObject类为止。
6. 如果还找不到就要开始进入动态方法解析了，后面会提到。

![](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Art/messaging1.gif)

#### 消息转发

![](http://yulingtianxia.com/resources/QQ20141113-1@2x.png)

\_objc\_msgForward消息转发做了如下几件事：

1.调用resolveInstanceMethod:方法，允许用户在此时为该Class动态添加实现。如果有实现了，则调用并返回。如果仍没实现，继续下面的动作。

2.调用`forwardingTargetForSelector:`方法，尝试找到一个能响应该消息的对象。如果获取到，则直接转发给它。如果返回了nil，继续下面的动作。

3.调用`methodSignatureForSelector:`方法，尝试获得一个方法签名。如果获取不到，则直接调用doesNotRecognizeSelector抛出异常。

4.调用`forwardInvocation:`方法，将地3步获取到的方法签名包装成Invocation传入，如何处理就在这里面了。

上面这4个方法均是模板方法，开发者可以override，由runtime来调用。最常见的实现消息转发，就是重写方法3和4，吞掉一个消息或者代理给其他对象都是没问题的。


## 谈谈你对Runloop的理解

[深入理解RunLoop](http://blog.ibireme.com/2015/05/18/runloop/)

[CFRunLoop -- 微博@我就叫Sunny怎么了 的笔记](https://github.com/ming1016/study/wiki/CFRunLoop)

`Runloop`，顾名思义，运行循环，就是一个一直运行着的事件循环，Runloop 和线程是紧密相连的，是线程的基础架构，让线程能随时处理事件但并不退出，让线程在没有处理消息时休眠以避免资源占用、在有消息到来时立刻被唤醒。

通常的代码逻辑是这样的：

```
function loop() {
    initialize();
    do {
        var message = get_next_message();
        process_message(message);
    } while (message != quit);
}
```

### RunLoop 与线程的关系

线程和 RunLoop 之间是一一对应的，一个线程中只有一个 Runloop。线程刚创建时并没有 RunLoop，如果你不主动获取，那它一直都不会有。**RunLoop 的创建是发生在第一次获取时**，RunLoop 的销毁是发生在线程结束时。你只能在一个线程的内部获取其 RunLoop（主线程除外）。

苹果不允许直接创建 RunLoop，它只提供了两个自动获取的函数：CFRunLoopGetMain() 和 CFRunLoopGetCurrent()。 这两个函数内部的逻辑大概是下面这样:

```
/// 全局的Dictionary，key 是 pthread_t， value 是 CFRunLoopRef
static CFMutableDictionaryRef loopsDic;
/// 访问 loopsDic 时的锁
static CFSpinLock_t loopsLock;
 
/// 获取一个 pthread 对应的 RunLoop。
CFRunLoopRef _CFRunLoopGet(pthread_t thread) {
    OSSpinLockLock(&loopsLock);
    
    if (!loopsDic) {
        // 第一次进入时，初始化全局Dic，并先为主线程创建一个 RunLoop。
        loopsDic = CFDictionaryCreateMutable();
        CFRunLoopRef mainLoop = _CFRunLoopCreate();
        CFDictionarySetValue(loopsDic, pthread_main_thread_np(), mainLoop);
    }
    
    /// 直接从 Dictionary 里获取。
    CFRunLoopRef loop = CFDictionaryGetValue(loopsDic, thread));
    
    if (!loop) {
        /// 取不到时，创建一个
        loop = _CFRunLoopCreate();
        CFDictionarySetValue(loopsDic, thread, loop);
        /// 注册一个回调，当线程销毁时，顺便也销毁其对应的 RunLoop。
        _CFSetTSD(..., thread, loop, __CFFinalizeRunLoop);
    }
    
    OSSpinLockUnLock(&loopsLock);
    return loop;
}
 
CFRunLoopRef CFRunLoopGetMain() {
    return _CFRunLoopGet(pthread_main_thread_np());
}
 
CFRunLoopRef CFRunLoopGetCurrent() {
    return _CFRunLoopGet(pthread_self());
}
```

### RunLoop 对外的接口

在 CoreFoundation 里面关于 RunLoop 有5个类:

CFRunLoopRef
CFRunLoopModeRef
CFRunLoopSourceRef
CFRunLoopTimerRef
CFRunLoopObserverRef

他们的关系如下:

![](http://blog.ibireme.com/wp-content/uploads/2015/05/RunLoop_0.png)

一个 RunLoop 包含若干个 Mode，每个 Mode 又包含若干个 Source/Timer/Observer。**每次调用 RunLoop 的主函数时，只能指定其中一个 Mode**，这个Mode被称作 CurrentMode。**如果需要切换 Mode，只能退出 Loop，再重新指定一个 Mode 进入。这样做主要是为了分隔开不同组的 Source/Timer/Observer，让其互不影响**。

* `CFRunLoopSourceRef` 是事件产生的地方。Source有两个版本：Source0 和 Source1。
	* Source0 只包含了一个回调（函数指针），它并不能主动触发事件。使用时，你需要先调用 CFRunLoopSourceSignal(source)，将这个 Source 标记为待处理，然后手动调用 CFRunLoopWakeUp(runloop) 来唤醒 RunLoop，让其处理这个事件。
	* Source1 包含了一个 mach_port 和一个回调（函数指针），被用于通过内核和其他线程相互发送消息。这种 Source 能主动唤醒 RunLoop 的线程，其原理在下面会讲到。

* `CFRunLoopTimerRef` 是基于时间的触发器，它和 NSTimer 是toll-free bridged 的，可以混用。其包含一个时间长度和一个回调（函数指针）。当其加入到 RunLoop 时，RunLoop会注册对应的时间点，当时间点到时，RunLoop会被唤醒以执行那个回调。

* `CFRunLoopObserverRef` 是观察者，每个 Observer 都包含了一个回调（函数指针），当 RunLoop 的状态发生变化时，观察者就能通过回调接受到这个变化。可以观测的时间点有以下几个：

```
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    kCFRunLoopEntry         = (1UL << 0), // 即将进入Loop
    kCFRunLoopBeforeTimers  = (1UL << 1), // 即将处理 Timer
    kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
    kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
    kCFRunLoopAfterWaiting  = (1UL << 6), // 刚从休眠中唤醒
    kCFRunLoopExit          = (1UL << 7), // 即将退出Loop
};
```

上面的 Source/Timer/Observer 被统称为 mode item，一个 item 可以被同时加入多个 mode。但一个 item 被重复加入同一个 mode 时是不会有效果的。**如果一个 mode 中一个 item 都没有，则 RunLoop 会直接退出，不进入循环**。

### RunLoop 的 Mode

系统默认注册了5个Mode:

1. kCFRunLoopDefaultMode: App的默认 Mode，通常主线程是在这个 Mode 下运行的。
2. UITrackingRunLoopMode: 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响。
3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用。
4. GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到。
5. kCFRunLoopCommonModes: 这是一个占位的 Mode，没有实际作用。

苹果公开提供的 Mode 只有两个: `kCFRunLoopDefaultMode (NSDefaultRunLoopMode)` 和 `UITrackingRunLoopMode`，你可以用这两个 Mode Name 来操作其对应的 Mode。

**RunLoop只能运行在一种mode下，如果要换mode当前的loop也需要停下重启成新的。**

CFRunLoopMode 和 CFRunLoop 的结构大致如下：

```
struct __CFRunLoopMode {
    CFStringRef _name;            // Mode Name, 例如 @"kCFRunLoopDefaultMode"
    CFMutableSetRef _sources0;    // Set
    CFMutableSetRef _sources1;    // Set
    CFMutableArrayRef _observers; // Array
    CFMutableArrayRef _timers;    // Array
    ...
};
 
struct __CFRunLoop {
    CFMutableSetRef _commonModes;     // Set
    CFMutableSetRef _commonModeItems; // Set<Source/Observer/Timer>
    CFRunLoopModeRef _currentMode;    // Current Runloop Mode
    CFMutableSetRef _modes;           // Set
    ...
};
```

这里有个概念叫 "CommonModes"：一个 Mode 可以将自己标记为"Common"属性（通过将其 ModeName 添加到 RunLoop 的 "commonModes" 中）。**每当 RunLoop 的内容发生变化时，RunLoop 都会自动将 _commonModeItems 里的 Source/Observer/Timer 同步到具有 "Common" 标记的所有Mode里**。

应用场景举例：主线程的 RunLoop 里有两个预置的 Mode：kCFRunLoopDefaultMode 和 UITrackingRunLoopMode。这两个 Mode 都已经被标记为"Common"属性。DefaultMode 是 App 平时所处的状态，TrackingRunLoopMode 是追踪 ScrollView 滑动时的状态。当你创建一个 Timer 并加到 DefaultMode 时，Timer 会得到重复回调，但此时滑动一个TableView时，RunLoop 会将 mode 切换为 TrackingRunLoopMode，这时 Timer 就不会被回调，并且也不会影响到滑动操作。

有时你需要一个 Timer，在两个 Mode 中都能得到回调，一种办法就是将这个 Timer 分别加入这两个 Mode。还有一种方式，就是将 Timer 加入到顶层的 RunLoop 的 "commonModeItems" 中。"commonModeItems" 被 RunLoop 自动更新到所有具有"Common"属性的 Mode 里去。

### RunLoop 的内部逻辑

RunLoop 内部的逻辑大致如下:

![](http://blog.ibireme.com/wp-content/uploads/2015/05/RunLoop_1.png)

其内部伪代码整理如下:

```
{
    /// 1. 通知Observers，即将进入RunLoop
    /// 此处有Observer会创建AutoreleasePool: _objc_autoreleasePoolPush();
    __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopEntry);
    do {
 
        /// 2. 通知 Observers: 即将触发 Timer 回调。
        __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeTimers);
        /// 3. 通知 Observers: 即将触发 Source (非基于port的,Source0) 回调。
        __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeSources);
        __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__(block);
 
        /// 4. 触发 Source0 (非基于port的) 回调。
        __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__(source0);
        __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__(block);
 
        /// 6. 通知Observers，即将进入休眠
        /// 此处有Observer释放并新建AutoreleasePool: _objc_autoreleasePoolPop(); _objc_autoreleasePoolPush();
        __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeWaiting);
 
        /// 7. sleep to wait msg.
        mach_msg() -> mach_msg_trap();
        
 
        /// 8. 通知Observers，线程被唤醒
        __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopAfterWaiting);
 
        /// 9. 如果是被Timer唤醒的，回调Timer
        __CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__(timer);
 
        /// 9. 如果是被dispatch唤醒的，执行所有调用 dispatch_async 等方法放入main queue 的 block
        __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(dispatched_block);
 
        /// 9. 如果如果Runloop是被 Source1 (基于port的) 的事件唤醒了，处理这个事件
        __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__(source1);
 
 
    } while (...);
 
    /// 10. 通知Observers，即将退出RunLoop
    /// 此处有Observer释放AutoreleasePool: _objc_autoreleasePoolPop();
    __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopExit);
}
```

### AutoreleasePool

App启动后，苹果在主线程 RunLoop 里注册了两个 Observer，其回调都是 _wrapRunLoopWithAutoreleasePoolHandler()。

第一个 Observer 监视的事件是 Entry(即将进入Loop)，其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池。其 order 是-2147483647，优先级最高，保证创建释放池发生在其他所有回调之前。

第二个 Observer 监视了两个事件：

* BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；
* Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。

这个 Observer 的 order 是 2147483647，优先级最低，保证其释放池子发生在其他所有回调之后。

在主线程执行的代码，通常是写在诸如事件回调、Timer回调内的。这些回调会被 RunLoop 创建好的 AutoreleasePool 环绕着，所以不会出现内存泄漏，开发者也不必显示创建 Pool 了。

### Cocoa会涉及到Run Loops的

* 系统级：GCD，mach kernel，block，pthread
* 应用层：NSTimer，UIEvent，Autorelease，NSObject(NSDelayedPerforming)，NSObject(NSThreadPerformAddition)，CADisplayLink，CATransition，CAAnimation，dispatch_get_main_queue()（GCD中dispatch到main queue的block会被dispatch到main RunLoop执行），NSPort，NSURLConnection，AFNetworking(这个第三方网络请求框架使用在开启新线程中添加自己的run loop监听事件)
