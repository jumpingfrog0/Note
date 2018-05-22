# Xcode调试技巧

### 设置断点触发条件

断点可以设置条件，只有当条件满足时，才会进入断点，并且可以设置进入断点时执行某些操作，比如打印log，执行lldb命令等。

这种应用场景主要是在循环遍历时，想要断点跟踪就只能通过这种方式了，除非添加NSLog打印，但是这种需要手动添加代码，在调试时才想到要添加一些打印语句，这时候又得重新运行，这太慢了，所以懂得设置断点触发条件将会大大提高效率。

操作如下：

断点触发条件（打印log）
![](http://os3yasu4i.bkt.clouddn.com/QQ20170714-202920.png)

断点触发条件（执行lldb命令）
![](http://os3yasu4i.bkt.clouddn.com/QQ20170714-203055.png)

### Symbolic Breakpoint

![](http://os3yasu4i.bkt.clouddn.com/130935401201770.jpg?imageView2/0/w/400/h/400/q/75|imageslim)

`Symbolic Breakpoint` 可以设置系统方法处的断点，比如，在 Symbolic 一栏输入 `viewDidLoad`，在程序中所有的 `viewDidLoad` 方法被调用时都会触发断点。

当然，我们也可以仅仅为特定的某个类的方法添加断点。在 Symbol 一栏输入 `[ClassName viewDidLoad]` (Objective-C) 或 `ClassName.viewDidLoad` (Swift) 即可。

![](http://os3yasu4i.bkt.clouddn.com/130939231357903.jpg?imageView2/0/w/400/h/400/q/75|imageslim)

对于 `unrecognized selector sent to instance 0xaxxxx` 这种错误，使用 `Symbolic Breakpoint` 就可以快速定位了。

	-[NSObject doesNotRecognizeSelector:]
	
### Zombie 对象


### 证书配置文件目录

	~/Library/MobileDevice/Provisioning Profiles
	
### 非ARC

	-fno-objc-arc