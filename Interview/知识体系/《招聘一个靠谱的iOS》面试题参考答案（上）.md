[《招聘一个靠谱的 iOS》](http://blog.sunnyxx.com/2015/07/04/ios-interview/)—参考答案（上）


说明：面试题来源是[微博@我就叫Sunny怎么了](http://weibo.com/u/1364395395)的这篇博文：[《招聘一个靠谱的 iOS》](http://blog.sunnyxx.com/2015/07/04/ios-interview/)，其中共55题，除第一题为纠错题外，其他54道均为简答题。


出题者简介： 孙源（sunnyxx），目前就职于百度，负责百度知道 iOS 客户端的开发工作，对技术喜欢刨根问底和总结最佳实践，热爱分享和开源，维护一个叫 forkingdog 的开源小组。

答案为[微博@iOS程序犭袁](http://weibo.com/luohanchenyilong/)整理，未经出题者校对，如有纰漏，请向[微博@iOS程序犭袁](http://weibo.com/luohanchenyilong/)指正。

本人 [jumpingfrog0](https://github.com/jumpingfrog0) 对这份面试题进行简单分类，方便自己观看。

原文链接：[原文链接](https://github.com/ChenYilong/iOSInterviewQuestions/blob/master/01%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88/%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88%EF%BC%88%E4%B8%8A%EF%BC%89.md)

----------

# 索引
##### 代码规范
1. [风格纠错题](#风格纠错题) 
 	1. [优化部分](#风格纠错题-优化部分) 
  	2. [硬伤部分](#风格纠错题-硬伤部分)
  	
##### 一个区分度很大的面试题
1. [什么情况使用 weak 关键字，相比 assign 有什么不同？](#一个区分度很大的面试题-1) 
2. [怎么用 copy 关键字？](#一个区分度很大的面试题-2) 
3. [这个写法会出什么问题： @property (copy) NSMutableArray *array;](#一个区分度很大的面试题-3) 
4. [ 如何让自己的类用 copy 修饰符？如何重写带 copy 关键字的 setter？](#一个区分度很大的面试题-4)
5. [@property 的本质是什么？ivar、getter、setter 是如何生成并添加到这个类中的](#一个区分度很大的面试题-5) 
6.  [@protocol 和 category 中如何使用 @property](#一个区分度很大的面试题-6) 
7.  [runtime 如何实现 weak 属性](#一个区分度很大的面试题-7)

##### Checklist
1. [※][@property中有哪些属性关键字？/ @property 后面可以有哪些修饰符？](#Checklist-1) 
2. [※][weak属性需要在dealloc中置nil么？](#Checklist-2)
3. [※※][@synthesize和@dynamic分别有什么作用？](#Checklist-3) 
4. [※※※][ARC下，不显式指定任何属性关键字时，默认的关键字都有哪些？](#Checklist-4) 
5. [※※※][用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？](#Checklist-5) 
	1. [对非集合类对象的copy操作](#Checklist-5-1) 
 	2. [集合类对象的copy与mutableCopy](#Checklist-5-2) 
6. [※※※][@synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？](#Checklist-6) 
7. [※※※※※][在有了自动合成属性实例变量之后，@synthesize还有哪些使用场景？](#Checklist-7)
</br>
</br>

8. [※※][objc中向一个nil对象发送消息将会发生什么？](#Checklist-8) 
9. [※※※][objc中向一个对象发送消息[obj foo]和objc_msgSend()函数之间有什么关系？](#Checklist-9) 
10. [※※※][什么时候会报unrecognized selector的异常？](#Checklist-10) 
11. [※※※※][一个objc对象如何进行内存布局？（考虑有父类的情况）](#Checklist-11) 
12. [※※※※][一个objc对象的isa的指针指向什么？有什么作用？](#Checklist-12)
13. [※※※※][下面的代码输出什么？](#Checklist-13)

 ```Objective-C
	@implementation Son : Father
	- (id)init
	{
	    self = [super init];
	    if (self) {
	        NSLog(@"%@", NSStringFromClass([self class]));
	        NSLog(@"%@", NSStringFromClass([super class]));
	    }
	    return self;
	}
	@end
 ```

14. [※※※※][runtime如何通过selector找到对应的IMP地址？（分别考虑类方法和实例方法）](#Checklist-14)
15. [※※※※][使用runtime Associate方法关联的对象，需要在主对象dealloc的时候释放么？](#Checklist-15)
16. [※※※※※][objc中的类方法和实例方法有什么本质区别和联系？](#Checklist-16)
17. [※※※※※][_objc_msgForward函数是做什么的，直接调用它将会发生什么？](#Checklist-17)
18. [※※※※※][runtime如何实现weak变量的自动置nil？](#Checklist-18)
19. [※※※※※][能否向编译后得到的类中增加实例变量？能否向运行时创建的类中添加实例变量？为什么？](#Checklist-19)

## 风格纠错题
### 1. <span id="风格纠错题">风格纠错题</span>
![enter image description here](http://i.imgur.com/O7Zev94.png)
修改完的代码：

修改方法有很多种，现给出一种做示例：

 ```Objective-C
// .h文件
// http://weibo.com/luohanchenyilong/
// https://github.com/ChenYilong
// 修改完的代码，这是第一种修改方法，后面会给出第二种修改方法

typedef NS_ENUM(NSInteger, CYLSex) {
    CYLSexMan,
    CYLSexWoman
};

@interface CYLUser : NSObject<NSCopying>

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) NSUInteger age;
@property (nonatomic, readonly, assign) CYLSex sex;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;
+ (instancetype)userWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;

@end
 ```

下面对具体修改的地方，分两部分做下介绍：***硬伤部分***和***优化部分***
。因为***硬伤部分***没什么技术含量，为了节省大家时间，放在后面讲，大神请直接看***优化部分***。


#### <span id="风格纠错题-优化部分">优化部分</span>

1. enum 建议使用 `NS_ENUM` 和 `NS_OPTIONS` 宏来定义枚举类型，参见官方的 [Adopting Modern Objective-C](https://developer.apple.com/library/ios/releasenotes/ObjectiveC/ModernizationObjC/AdoptingModernObjective-C/AdoptingModernObjective-C.html) 一文：

    ```objective-c
//定义一个枚举
	typedef NS_ENUM(NSInteger, CYLSex) {
	    CYLSexMan,
	    CYLSexWoman
	};
```
 （仅仅让性别包含男和女可能并不严谨，最严谨的做法可以参考 [这里](https://github.com/ChenYilong/iOSInterviewQuestions/issues/9) 。）

2. age 属性的类型：应避免使用基本类型，建议使用 Foundation 数据类型，对应关系如下：
 
 ```Objective-C
	int -> NSInteger
	unsigned -> NSUInteger
	float -> CGFloat
	动画时间 -> NSTimeInterval
```
同时考虑到 age 的特点，应使用 NSUInteger ，而非 int 。
这样做的是基于64-bit 适配考虑，详情可参考出题者的博文[《64-bit Tips》](http://blog.sunnyxx.com/2014/12/20/64-bit-tips/)。

3. 如果工程项目非常庞大，需要拆分成不同的模块，可以在类、typedef宏命名的时候使用前缀。
4. doLogIn方法不应写在该类中： <p><del>虽然`LogIn`的命名不太清晰，但笔者猜测是login的意思， （勘误：Login是名词，LogIn 是动词，都表示登陆的意思。见： [ ***Log in vs. login*** ](http://grammarist.com/spelling/log-in-login/)）</del></p>登录操作属于业务逻辑，观察类名 UserModel ，以及属性的命名方式，该类应该是一个 Model 而不是一个“ MVVM 模式下的 ViewModel ”：

 > 无论是 MVC 模式还是 MVVM 模式，业务逻辑都不应当写在 Model 里：MVC 应在 C，MVVM 应在 VM。

 （如果抛开命名规范，假设该类真的是 MVVM 模式里的 ViewModel ，那么 UserModel 这个类可能对应的是用户注册页面，如果有特殊的业务需求，比如： `-logIn` 对应的应当是注册并登录的一个 Button ，出现 `-logIn` 方法也可能是合理的。）

5. doLogIn 方法命名不规范：添加了多余的动词前缀。
请牢记：

  > 如果方法表示让对象执行一个动作，使用动词打头来命名，注意不要使用 `do`，`does` 这种多余的关键字，动词本身的暗示就足够了。

 应为 `-logIn` （注意： `Login` 是名词， `LogIn`  是动词，都表示登陆。  见[ ***Log in vs. login*** ](http://grammarist.com/spelling/log-in-login/)）

6. `-(id)initUserModelWithUserName: (NSString*)name withAge:(int)age;`方法中不要用 `with` 来连接两个参数: `withAge:` 应当换为`age:`，`age:` 已经足以清晰说明参数的作用，也不建议用 `andAge:` ：通常情况下，即使有类似 `withA:withB:` 的命名需求，也通常是使用`withA:andB:` 这种命名，用来表示方法执行了两个相对独立的操作（*从设计上来说，这时候也可以拆分成两个独立的方法*），它不应该用作阐明有多个参数，比如下面的：

  ```objective-c
//错误，不要使用"and"来连接参数
- (int)runModalForDirectory:(NSString *)path andFile:(NSString *)name andTypes:(NSArray *)fileTypes;
//错误，不要使用"and"来阐明有多个参数
- (instancetype)initWithName:(CGFloat)width andAge:(CGFloat)height;
//正确，使用"and"来表示两个相对独立的操作
- (BOOL)openFile:(NSString *)fullPath withApplication:(NSString *)appName andDeactivate:(BOOL)flag;
```

7. 由于字符串值可能会改变，所以要把相关属性的“内存管理语义”声明为 copy 。(原因在下文有详细论述：***用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？***)
8. “性别”(sex）属性的：该类中只给出了一种“初始化方法” (initializer)用于设置“姓名”(Name)和“年龄”(Age)的初始值，那如何对“性别”(Sex）初始化？

 Objective-C 有 designated 和 secondary 初始化方法的观念。 designated 初始化方法是提供所有的参数，secondary 初始化方法是一个或多个，并且提供一个或者更多的默认参数来调用 designated 初始化方法的初始化方法。举例说明：
 
 ```Objective-C

    // .m文件
    // http://weibo.com/luohanchenyilong/
    // https://github.com/ChenYilong
    //

    @implementation CYLUser

    - (instancetype)initWithName:(NSString *)name
                             age:(NSUInteger)age
                             sex:(CYLSex)sex {
        if(self = [super init]) {
            _name = [name copy];
            _age = age;
            _sex = sex;
        }
        return self;
    }

    - (instancetype)initWithName:(NSString *)name
                             age:(NSUInteger)age {
        return [self initWithName:name age:age sex:nil];
    }

    @end
```

 上面的代码中initWithName:age:sex: 就是 designated 初始化方法，另外的是 secondary 初始化方法。因为仅仅是调用类实现的 designated 初始化方法。

  因为出题者没有给出 `.m` 文件，所以有两种猜测：1：本来打算只设计一个 designated 初始化方法，但漏掉了“性别”(sex）属性。那么最终的修改代码就是上文给出的第一种修改方法。2：不打算初始时初始化“性别”(sex）属性，打算后期再修改，如果是这种情况，那么应该把“性别”(sex）属性设为 readwrite 属性，最终给出的修改代码应该是：
 
 ```Objective-C
	// .h文件
	// http://weibo.com/luohanchenyilong/
	// https://github.com/ChenYilong
	// 第二种修改方法（基于第一种修改方法的基础上）

	typedef NS_ENUM(NSInteger, CYLSex) {
	    CYLSexMan,
	    CYLSexWoman
	};

	@interface CYLUser : NSObject<NSCopying>

	@property (nonatomic, readonly, copy) NSString *name;
	@property (nonatomic, readonly, assign) NSUInteger age;
	@property (nonatomic, readwrite, assign) CYLSex sex;

	- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;
	- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age;
	+ (instancetype)userWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;

	@end
```


  `.h` 中暴露 designated 初始化方法，是为了方便子类化 （想了解更多，请戳--》 [***《禅与 Objective-C 编程艺术 （Zen and the Art of the Objective-C Craftsmanship 中文翻译）》***](http://is.gd/OQ49zk)。）

  * 按照接口设计的惯例，如果设计了“初始化方法” (initializer)，也应当搭配一个快捷构造方法。而快捷构造方法的返回值，建议为 instancetype，为保持一致性，init 方法和快捷构造方法的返回类型最好都用 instancetype。
  * 如果基于第一种修改方法：既然该类中已经有一个“初始化方法” (initializer)，用于设置“姓名”(Name)、“年龄”(Age)和“性别”(Sex）的初始值:
那么在设计对应 `@property` 时就应该尽量使用不可变的对象：其三个属性都应该设为“只读”。用初始化方法设置好属性值之后，就不能再改变了。在本例中，仍需声明属性的“内存管理语义”。于是可以把属性的定义改成这样


 ```Objective-C
        @property (nonatomic, readonly, copy) NSString *name;
        @property (nonatomic, readonly, assign) NSUInteger age;
        @property (nonatomic, readonly, assign) CYLSex sex;
 ```

      由于是只读属性，所以编译器不会为其创建对应的“设置方法”，即便如此，我们还是要写上这些属性的语义，以此表明初始化方法在设置这些属性值时所用的方式。要是不写明语义的话，该类的调用者就不知道初始化方法里会拷贝这些属性，他们有可能会在调用初始化方法之前自行拷贝属性值。这种操作多余而且低效。
9. `initUserModelWithUserName` 如果改为 `initWithName` 会更加简洁，而且足够清晰。
10. `UserModel` 如果改为 `User` 会更加简洁，而且足够清晰。
11. `UserSex`如果改为`Sex` 会更加简洁，而且足够清晰。
12. 第二个 `@property` 中 assign 和 nonatomic 调换位置。
 推荐按照下面的格式来定义属性

 ```Objective-C
@property (nonatomic, readwrite, copy) NSString *name;
 ```
 
 属性的参数应该按照下面的顺序排列： 原子性，读写 和 内存管理。 这样做你的属性更容易修改正确，并且更好阅读。这在[《禅与Objective-C编程艺术 >》](https://github.com/oa414/objc-zen-book-cn#属性定义)里有介绍。而且习惯上修改某个属性的修饰符时，一般从属性名从右向左搜索需要修动的修饰符。最可能从最右边开始修改这些属性的修饰符，根据经验这些修饰符被修改的可能性从高到底应为：内存管理 > 读写权限 >原子操作。


#### <span id="风格纠错题-硬伤部分">硬伤部分</span>

1. 在-和(void)之间应该有一个空格
2. enum 中驼峰命名法和下划线命名法混用错误：枚举类型的命名规则和函数的命名规则相同：命名时使用驼峰命名法，勿使用下划线命名法。
3. enum 左括号前加一个空格，或者将左括号换到下一行
4. enum 右括号后加一个空格
5. `UserModel :NSObject` 应为`UserModel : NSObject`，也就是`:`右侧少了一个空格。
6.  `@interface` 与 `@property` 属性声明中间应当间隔一行。
7. 两个方法定义之间不需要换行，有时为了区分方法的功能也可间隔一行，但示例代码中间隔了两行。
8. `-(id)initUserModelWithUserName: (NSString*)name withAge:(int)age;`方法中方法名与参数之间多了空格。而且 `-` 与 `(id)` 之间少了空格。
9. `-(id)initUserModelWithUserName: (NSString*)name withAge:(int)age;`方法中方法名与参数之间多了空格：`(NSString*)name` 前多了空格。
10. `-(id)initUserModelWithUserName: (NSString*)name withAge:(int)age;` 方法中 `(NSString*)name`,应为 `(NSString *)name`，少了空格。 
11. <p><del>doLogIn方法中的 `LogIn` 命名不清晰：笔者猜测是login的意思，应该是粗心手误造成的。
 （勘误： `Login` 是名词， `LogIn`  是动词，都表示登陆的意思。见： [ ***Log in vs. login*** ](http://grammarist.com/spelling/log-in-login/)）</del></p>


