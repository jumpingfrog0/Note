iOS 性能优化相关
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