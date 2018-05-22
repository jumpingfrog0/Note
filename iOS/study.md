# Study

[socket.io-ios](http://socket.io/blog/socket-io-on-ios/)

debug 技巧
	
	po xxx
	
[使用UIPageViewController实现照片墙/轮播](http://www.jianshu.com/p/da654ea1e937)
[autoScrollBanner](https://github.com/iunion/autoScrollBanner) 循环滚动banner

# blog & Website
NSHipster
Objc.io
唐巧的技术博客

避免滥用单例
单例应该只用来保存全局的状态，并且不能和任何作用域绑定。如果这些状态的作用域比一个完整的应用程序的生命周期要短，那么这个状态就不应该使用单例来管理。用一个单例来管理用户绑定的状态，是代码的坏味道，你应该认真的重新评估你的对象图的设计。

在面向对象编程中我们想要最小化可变状态的作用域。但是单例却因为使可变的状态可以被程序中的任何地方访问，而站在了对立面。下一次你想使用单例时，我希望你能够好好考虑一下使用依赖注入作为替代方案。