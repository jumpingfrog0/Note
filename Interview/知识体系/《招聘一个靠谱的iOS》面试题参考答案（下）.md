
[《招聘一个靠谱的 iOS》](http://blog.sunnyxx.com/2015/07/04/ios-interview/)—参考答案（下）


说明：面试题来源是[微博@我就叫Sunny怎么了](http://weibo.com/u/1364395395)的这篇博文：[《招聘一个靠谱的 iOS》](http://blog.sunnyxx.com/2015/07/04/ios-interview/)，其中共55题，除第一题为纠错题外，其他54道均为简答题。

出题者简介： 孙源（sunnyxx），目前就职于百度，负责百度知道 iOS 客户端的开发工作，对技术喜欢刨根问底和总结最佳实践，热爱分享和开源，维护一个叫 forkingdog 的开源小组。

答案为[微博@iOS程序犭袁](http://weibo.com/luohanchenyilong/)整理，未经出题者校对，如有纰漏，请向[微博@iOS程序犭袁](http://weibo.com/luohanchenyilong/)指正。

----------

# 索引

##### Checklist
1. [※※※][runloop和线程有什么关系？](#Checklist-1)
2. [※※※][runloop的mode作用是什么？](#Checklist-2)
3. [※※※※][以+ scheduledTimerWithTimeInterval...的方式触发的timer，在滑动页面上的列表时，timer会暂定回调，为什么？如何解决？](#Checklist-3)
4. [※※※※※][猜想runloop内部是如何实现的？](#Checklist-4)
</br>
</br>
5. [※][objc使用什么机制管理对象内存？](#Checklist-5)
6. [※※※※][ARC通过什么方式帮助开发者管理内存？](#Checklist-6)
7. [※※※※][不手动指定autoreleasepool的前提下，一个autorealese对象在什么时刻释放？（比如在一个vc的viewDidLoad中创建）](#Checklist-7)
8. [※※※※][BAD_ACCESS在什么情况下出现？](#Checklist-8)
9. [※※※※※][苹果是如何实现autoreleasepool的？](#Checklist-9)
</br>
</br>
10. [※※][使用block时什么情况会发生引用循环，如何解决？](#Checklist-10)
11. [※※][在block内如何修改block外部变量？](#Checklist-11)
12. [※※※][使用系统的某些block api（如UIView的block版本写动画时），是否也考虑引用循环问题？](#Checklist-12)
</br>
</br>
13. [※※][GCD的队列（dispatch_queue_t）分哪两种类型？](#Checklist-13)
14. [※※※※][如何用GCD同步若干个异步调用？（如根据若干个url异步加载多张图片，然后在都下载完成后合成一张整图）](#Checklist-14)
15. [※※※※][dispatch_barrier_async的作用是什么？](#Checklist-15)
16. [※※※※※][苹果为什么要废弃dispatch_get_current_queue？](#Checklist-16)
17. [※※※※※][以下代码运行结果如何？](#Checklist-17)

 ```Objective-C
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}
 ```
 
18. [※※][addObserver:forKeyPath:options:context:各个参数的作用分别是什么，observer中需要实现哪个方法才能获得KVO回调？](#Checklist-18)
19. [※※※][如何手动触发一个value的KVO](#Checklist-19)
20. [※※※][若一个类有实例变量NSString *_foo，调用setValue:forKey:时，可以以foo还是_foo作为key？](#Checklist-20)
21. [※※※※][KVC的keyPath中的集合运算符如何使用？](#Checklist-21)
22. [※※※※][KVC和KVO的keyPath一定是属性么？](#Checklist-22)
23. [※※※※※][如何关闭默认的KVO的默认实现，并进入自定义的KVO实现？](#Checklist-23)
24. [※※※※※][apple用什么方式实现对一个对象的KVO？](#Checklist-24)
</br>
</br>
25. [※※][IBOutlet连出来的视图属性为什么可以被设置成weak?](#Checklist-25)
26. [※※※※※][IB中User Defined Runtime Attributes如何使用？](#Checklist-26)
</br>
</br>
27. [※※※][如何调试BAD_ACCESS错误](#Checklist-27)
28. [※※※][lldb（gdb）常用的调试命令？](#Checklist-28)
