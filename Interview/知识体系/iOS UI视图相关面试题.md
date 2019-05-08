# iOS UI视图相关面试题

<!--
create time: 2019-03-17 12:22:48
Author: <黄东鸿>
-->

![](https://upload-images.jianshu.io/upload_images/5935677-fff14b37bd4a3d7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/552/format/webp)

## 图像渲染/UI绘制原理

### 1. UIView和CALayer是什么关系?

[27·iOS 面试题·UIView 和 CALayer 是啥关系?](https://ioscaff.com/articles/295)

* UIView 可以响应事件，CALayer 不可以

UIView 继承自UIResponder, 在 UIResponder 中定义了处理各种事件和事件传递的接口, 所以 UIView 具有响应事件的能力;
而 CALayer 直接继承 NSObject，不能响应用户事件。

* UIView 侧重于对显示内容的管理，CALayer 侧重于对显示内容的绘制, 负责绘制 UI

CALayer 是 QuartzCore 中的类，是一个比较底层的用来绘制内容的类。
UIView 是基于 CALayer 的高层封装, UIView 持有一个 CALayer 的属性，并且是该属性的代理，用来提供一些 CALayer 行的数据，例如动画和绘制。

 ```
 //绘制相关
 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;

 //动画相关
 - (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event;
 ```

UIView的所有特性来源于CALayer支持, 平时我们对 UIView 设置 frame、center、bounds 等位置信息，其实最终也是通过 CALayer 来控制。
比如 frame 属性主要是依赖：bounds、anchorPoint、transform、和 position，最终计算得出的。
UIView 只是把 对 CALayer 中这些属性的操作封装起来，使得我们可以很方便地设置控件的位置而已；但是例如圆角、阴影等属性， UIView 就没有进一步封装，所以我们还是需要去设置 Layer 的属性来实现功能。

我们这主要说一下 anchorPoint 和 position 如何影响 Frame 的：anchorPoint 锚点是相对于当前 Layer 的一个点，position 是 Layer 中 anchorPoint 锚点在 superLayer 中的点，即 position 是由 anchorPoint 来确认的。

这里有几个通用的公式：

```
position.x = frame.origin.x + anchorPoint.x * bounds.size.width；  
position.y = frame.origin.y + anchorPoint.y * bounds.size.height；

frame.origin.x = position.x - anchorPoint.x * bounds.size.width；  
frame.origin.y = position.y - anchorPoint.y * bounds.size.height；  
```

* UIView和CALayer是相互依赖的关系。UIView依赖CALayer提供的内容，CALayer依赖UIView提供的容器来显示绘制的内容。归根到底CALayer是这一切的基础，如果没有CALayer，UIView自身也不会存在，UIView是一个特殊的CALayer实现，添加了响应事件的能力。

[TODO: contents 属性，layer Tree, CALayer 默认隐式动画](https://blog.csdn.net/icetime17/article/details/48154021)
* 高级：UIView的layer树形在系统内部被系统维护着三份copy 
逻辑树：就是代码里可以操纵的，例如更改layer的属性（阴影，圆角等）就在这一份 
动画树：这是一个中间层，系统正是在这一层上更改属性，进行各种渲染操作 
显示树：这棵树的内容是当前正被显示在屏幕上的内容 
这三棵树的逻辑结构都是一样的，区别只有各自的属性

动画:UIView本身是由CoreAnimation来实现的.CALayer类来管理实际绘图.CALayer 内部维护着三分 layer tree,分别是 presentLayer Tree(显示树),modeLayer Tree(模型树), Render Tree (渲染树).iOS动画修改的的动画属性，实际上是修改presentLayer的属性值,而最终展示在界面上的是modelLayer.


[iOS 图像渲染原理](http://chuquan.me/2018/09/25/ios-graphics-render-principle/)

实际上，这里并不是两个层级关系，而是四个。每一个都扮演着不同的角色。除了 视图树 和 图层树，还有 呈现树 和 渲染树。

### 2. 为什么 iOS 要基于 UIView 和 CALayer 提供两个平行的层级关系呢？

其原因在于要做 职责分离，这样也能避免很多重复代码。在 iOS 和 Mac OS X 两个平台上，事件和用户交互有很多地方的不同，基于多点触控的用户界面和基于鼠标键盘的交互有着本质的区别，iOS 用 UIKit 和 UIView，而 Mac OS 用 AppKit 和 NSView 进行视图的绘制、布局和动。它们在功能上很相似，但是在实现上有着显著的区别。

