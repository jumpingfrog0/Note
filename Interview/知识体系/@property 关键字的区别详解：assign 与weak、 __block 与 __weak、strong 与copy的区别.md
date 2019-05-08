@property 关键字的区别详解：assign 与weak、strong 与copy、__block 与 __weak 的区别
=========

> 原文链接：http://www.jianshu.com/p/3e0f12e5faaa

关于属性@property（）的关键字assign，weak，strong，copy区别，这里总结一下，供大家参考。修饰代理等对象使用weak，修饰NSString、block使用copy，但很少思考为什么？这篇文章将会给大家揭开这层面纱。

------

### 1. assign 与weak区别

* assign适用于基本数据类型，weak是适用于NSObject对象，并且是一个弱引用。
* assign其实也可以用来修饰对象。那么我们为什么不用它修饰对象呢？因为被assign修饰的对象（一般编译的时候会产生警告：Assigning retained object to unsafe property; object will be released after assignment）在释放之后，指针的地址还是存在的，也就是说指针并没有被置为nil，造成野指针。对象一般分配在堆上的某块内存，如果在后续的内存分配中，刚好分到了这块地址，程序就会崩溃掉。
* 那为什么可以用assign修饰基本数据类型？因为基础数据类型一般分配在栈上，栈的内存会由系统自己自动处理，不会造成野指针。
* weak修饰的对象在释放之后，指针地址会被置为nil。所以现在一般弱引用就是用weak。

weak使用场景：

* 在ARC下,在有可能出现循环引用的时候，往往要通过让其中一端使用weak来解决，比如: delegate代理属性，通常就会声明为weak。
* 自身已经对它进行一次强引用，没有必要再强引用一次时也会使用weak。比如：自定义 IBOutlet控件属性一般也使用weak，当然也可以使用strong。

### 2. strong 与copy的区别

* strong 与 copy 都会使引用计数加1，但strong是两个指针指向同一个内存地址，copy会在内存里拷贝一份对象，两个指针指向不同的内存地址

### 3. __block与__weak的区别

* __block是用来修饰一个变量，这个变量的值就可以在block中被修改
* 使用 __block修饰的变量在block代码块中会被retain（ARC下会retain，MRC下不会retain）
* 使用__weak修饰的变量在block代码块中不会被retain，同时，在ARC下，要避免block出现循环引用 __weak typedof(self)weakSelf = self;

### 4. block变量定义时为什么用copy？block是放在哪里的？

* block本身是像对象一样可以retain，和release。但是，block在创建的时候，它的内存是分配在栈(stack)上，可能被随时回收，而不是在堆(heap)上。他本身的作于域是在声明时的作用域，一旦在声明时的作用域外面调用block将导致程序崩溃。通过copy可以把block拷贝（copy）到堆，保证block可以在声明域外使用。
* 特别需要注意的地方就是在把block放到集合类当中去的时候，如果直接把生成的block放入到集合类中，是无法在其他地方使用block，必须要对block进行copy。
	
	```
	[array addObject:[[^{
	    NSLog(@"hello!");
	} copy] autorelease]];
	```
### 5. block 为什么不用strong？

* ~~block如果用到了self，就会retain self，如果是strong的话，就造成了循环引用~~

> 官方文档：You should specify copy as the property attribute, because a block needs to be copied to keep track of its captured state outside of the original scope. This isn’t something you need to worry about when using Automatic Reference Counting, as it will happen automatically, but it’s best practice for the property attribute to show the resultant behavior.

### strong 与 weak 的区别
* 当一个对象不再有strong类型的指针指向它的时候，它会被释放，即使还有weak型指针指向它。一旦最后一个strong型指针离去 ，这个对象将被释放，所有剩余的weak型指针都将被清除。