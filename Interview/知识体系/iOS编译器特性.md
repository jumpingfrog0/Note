# iOS 编译器特性

<!--
create time: 2018-12-07 15:32:58
Author: <黄东鸿>
-->

### 1. @property 的本质是什么？ivar、getter、setter 是如何生成并添加到这个类中的

**@property 的本质是什么？**

> @property = ivar + getter + setter;

下面解释下：

> “属性” (property)有两大概念：ivar（实例变量）、存取方法（access method ＝ getter + setter）。

“属性” (property)作为 Objective-C 的一项特性，主要的作用就在于封装对象中的数据。 Objective-C 对象通常会把其所需要的数据保存为各种实例变量。实例变量一般通过“存取方法”(access method)来访问。其中，“获取方法” (getter)用于读取变量值，而“设置方法” (setter)用于写入变量值。这个概念已经定型，并且经由“属性”这一特性而成为 `Objective-C 2.0` 的一部分。

而在正规的 Objective-C 编码风格中，存取方法有着严格的命名规范。
正因为有了这种严格的命名规范，所以 Objective-C 这门语言才能根据名称自动创建出存取方法。其实也可以把属性当做一种关键字，其表示:

> 编译器会自动写出一套存取方法，用以访问给定类型中具有给定名称的变量。
所以你也可以这么说：

> @property = getter + setter;

例如下面这个类：

 ```Objective-C
@interface Person : NSObject
@property NSString *firstName;
@property NSString *lastName;
@end
 ```

上述代码写出来的类与下面这种写法等效：

 ```Objective-C
@interface Person : NSObject
- (NSString *)firstName;
- (void)setFirstName:(NSString *)firstName;
- (NSString *)lastName;
- (void)setLastName:(NSString *)lastName;
@end
 ```

property在runtime中是`objc_property_t`定义如下:

```objective-c
typedef struct objc_property *objc_property_t;
```

而`objc_property`是一个结构体，包括name和attributes，定义如下：

```objective-c
struct property_t {
    const char *name;
    const char *attributes;
};
```

而attributes本质是`objc_property_attribute_t`，定义了property的一些属性，定义如下：

```objective-c
/// Defines a property attribute
typedef struct {
    const char *name;           /**< The name of the attribute */
    const char *value;          /**< The value of the attribute (usually empty) */
} objc_property_attribute_t;
```

而attributes的具体内容是什么呢？其实，包括：类型，原子性，内存语义和对应的实例变量。

例如：我们定义一个string的property`@property (nonatomic, copy) NSString *string;`，通过 `property_getAttributes(property)`获取到attributes并打印出来之后的结果为`T@"NSString",C,N,V_string`

其中T就代表类型，可参阅[Type Encodings](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1)，C就代表Copy，N代表nonatomic，V就代表对于的实例变量。


**ivar、getter、setter 是如何生成并添加到这个类中的?**

> “自动合成”( autosynthesis)

完成属性定义后，编译器会自动编写访问这些属性所需的方法，此过程叫做“自动合成”(autosynthesis)。需要强调的是，这个过程由编译
器在编译期执行，所以编辑器里看不到这些“合成方法”(synthesized method)的源代码。除了生成方法代码 getter、setter 之外，编译器还要自动向类中添加适当类型的实例变量，并且在属性名前面加下划线，以此作为实例变量的名字。在前例中，会生成两个实例变量，其名称分别为
 `_firstName` 与 `_lastName`。也可以在类的实现代码里通过
 `@synthesize` 语法来指定实例变量的名字.

 ```Objective-C
@implementation Person
@synthesize firstName = _myFirstName;
@synthesize lastName = _myLastName;
@end
 ```

我为了搞清属性是怎么实现的,曾经反编译过相关的代码,他大致生成了五个东西

 1. `OBJC_IVAR_$类名$属性名称` ：该属性的“偏移量” (offset)，这个偏移量是“硬编码” (hardcode)，表示该变量距离存放对象的内存区域的起始地址有多远。
 2. setter 与 getter 方法对应的实现函数
 2. `ivar_list` ：成员变量列表
 2. `method_list` ：方法列表
 2. `prop_list` ：属性列表


也就是说我们每次在增加一个属性,系统都会在 `ivar_list` 中添加一个成员变量的描述,在 `method_list` 中增加 setter 与 getter 方法的描述,在属性列表中增加一个属性的描述,然后计算该属性在对象中的偏移量,然后给出 setter 与 getter 方法对应的实现,在 setter 方法中从偏移量的位置开始赋值,在 getter 方法中从偏移量开始取值,为了能够读取正确字节数,系统对象偏移量的指针类型进行了类型强转.

### 2. @protocol 和 category 中如何使用 @property

 1. 在 protocol 中使用 property 只会生成 setter 和 getter 方法声明,我们使用属性的目的,是希望遵守我协议的对象能实现该属性
 2. category 使用 @property 也是只会生成 setter 和 getter 方法的声明,如果我们真的需要给 category 增加属性的实现,需要借助于运行时的两个函数：

  * `objc_setAssociatedObject`
  * `objc_getAssociatedObject`

### 3. @property 后面可以有哪些修饰符？

属性可以拥有的特质分为四类:
 
 1. 原子性--- `nonatomic` 特质

    在默认情况下，由编译器合成的方法会通过锁定机制确保其原子性(atomicity)。如果属性具备 nonatomic 特质，则不使用自旋锁。请注意，尽管没有名为“atomic”的特质(如果某属性不具备 nonatomic 特质，那它就是“原子的” ( atomic) )，但是仍然可以在属性特质中写明这一点，编译器不会报错。若是自己定义存取方法，那么就应该遵从与属性特质相符的原子性。

 2. 读/写权限---`readwrite(读写)`、`readonly (只读)`
 3. 内存管理语义---`assign`、`strong`、 `weak`、`unsafe_unretained`、`copy`
 4. 方法名---`getter=<name>` 、`setter=<name>`
   
 	`getter=<name>`的样式：

 	```Objective-C
        @property (nonatomic, getter=isOn) BOOL on;
 	```
 	<p><del>（ `setter=<name>`这种不常用，也不推荐使用。故不在这里给出写法。）
</del></p>

 	`setter=<name>`一般用在特殊的情境下，比如：

	在数据反序列化、转模型的过程中，服务器返回的字段如果以 `init` 开头，所以你需要定义一个 `init` 开头的属性，但默认生成的 `setter` 与 `getter` 方法也会以 `init` 开头，而编译器会把所有以 `init` 开头的方法当成初始化方法，而初始化方法只能返回 self 类型，因此编译器会报错。

	这时你就可以使用下面的方式来避免编译器报错：

 	```Objective-C
	@property(nonatomic, strong, getter=p_initBy, setter=setP_initBy:)NSString *initBy;
 	```

	另外也可以用关键字进行特殊说明，来避免编译器报错：

 	```Objective-C
	@property(nonatomic, readwrite, copy, null_resettable) NSString *initBy;
- (NSString *)initBy __attribute__((objc_method_family(none)));
 	```
5. 不常用的：`nonnull`,`null_resettable`,`nullable`

注意：很多人会认为如果属性具备 nonatomic 特质，则不使用“同步锁”。其实在属性设置方法中使用的是自旋锁，自旋锁相关代码如下：

 ```Objective-C
static inline void reallySetProperty(id self, SEL _cmd, id newValue, ptrdiff_t offset, bool atomic, bool copy, bool mutableCopy)
{
    if (offset == 0) {
        object_setClass(self, newValue);
        return;
    }

    id oldValue;
    id *slot = (id*) ((char*)self + offset);

    if (copy) {
        newValue = [newValue copyWithZone:nil];
    } else if (mutableCopy) {
        newValue = [newValue mutableCopyWithZone:nil];
    } else {
        if (*slot == newValue) return;
        newValue = objc_retain(newValue);
    }

    if (!atomic) {
        oldValue = *slot;
        *slot = newValue;
    } else {
        spinlock_t& slotlock = PropertyLocks[slot];
        slotlock.lock();
        oldValue = *slot;
        *slot = newValue;        
        slotlock.unlock();
    }

    objc_release(oldValue);
}

void objc_setProperty(id self, SEL _cmd, ptrdiff_t offset, id newValue, BOOL atomic, signed char shouldCopy) 
{
    bool copy = (shouldCopy && shouldCopy != MUTABLE_COPY);
    bool mutableCopy = (shouldCopy == MUTABLE_COPY);
    reallySetProperty(self, _cmd, newValue, offset, atomic, copy, mutableCopy);
}
 ```

### 4. @synthesize和@dynamic分别有什么作用？

 1. @property有两个对应的词，一个是 @synthesize，一个是 @dynamic。如果 @synthesize和 @dynamic都没写，那么默认的就是`@syntheszie var = _var;`
 2. @synthesize 的语义是如果你没有手动实现 setter 方法和 getter 方法，那么编译器会自动为你加上这两个方法。
 3. @dynamic 告诉编译器：属性的 setter 与 getter 方法由用户自己实现，不自动生成。（当然对于 readonly 的属性只需提供 getter 即可）。假如一个属性被声明为 @dynamic var，然后你没有提供 @setter方法和 @getter 方法，编译的时候没问题，但是当程序运行到 `instance.var = someVar`，由于缺 setter 方法会导致程序崩溃；或者当运行到 `someVar = var` 时，由于缺 getter 方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。

### 5. @synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为`_foo`的实例变量，那么还会自动合成新变量么？

在回答之前先说明下一个概念：

> 实例变量 = 成员变量 ＝ ivar

这些说法，笔者下文中，可能都会用到，指的是一个东西。

正如
[Apple官方文档 ***You Can Customize Synthesized Instance Variable Names***](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/EncapsulatingData/EncapsulatingData.html#//apple_ref/doc/uid/TP40011210-CH5-SW6) 所说：
![enter image description here](http://i.imgur.com/D6d0zGJ.png)

如果使用了属性的话，那么编译器就会自动编写访问属性所需的方法，此过程叫做“自动合成”( auto synthesis)。需要强调的是，这个过程由编译器在编译期执行，所以编辑器里看不到这些“合成方法” (synthesized method)的源代码。除了生成方法代码之外，编译器还要自动向类中添加适当类型的实例变量，并且在属性名前面加下划线，以此作为实例变量的名字。
 
```Objective-C
@interface CYLPerson : NSObject 
@property NSString *firstName; 
@property NSString *lastName; 
@end
```

在上例中，会生成两个实例变量，其名称分别为
 `_firstName` 与 `_lastName`。也可以在类的实现代码里通过 `@synthesize` 语法来指定实例变量的名字:
 
```Objective-C
@implementation CYLPerson 
@synthesize firstName = _myFirstName; 
@synthesize lastName = _myLastName; 
@end 
```

上述语法会将生成的实例变量命名为 `_myFirstName` 与 `_myLastName` ，而不再使用默认的名字。一般情况下无须修改默认的实例变量名，但是如果你不喜欢以下划线来命名实例变量，那么可以用这个办法将其改为自己想要的名字。笔者还是推荐使用默认的命名方案，因为如果所有人都坚持这套方案，那么写出来的代码大家都能看得懂。

总结下 @synthesize 合成实例变量的规则，有以下几点：

 1. 如果指定了成员变量的名称,会生成一个指定的名称的成员变量,
 2. 如果这个成员已经存在了就不再生成了.
 3. 如果是 `@synthesize foo;` 还会生成一个名称为foo的成员变量，也就是说：

 > 如果没有指定成员变量的名称会自动生成一个属性同名的成员变量,

 4. 如果是 `@synthesize foo = _foo;` 就不会生成成员变量了.

假如 property 名为 foo，存在一个名为 `_foo` 的实例变量，那么还会自动合成新变量么？
不会。如下图：

![enter image description here](http://i.imgur.com/t28ge4W.png)


### 7. <span id="Checklist-7">在有了自动合成属性实例变量之后，@synthesize还有哪些使用场景？</span>

回答这个问题前，我们要搞清楚一个问题，什么情况下不会autosynthesis（自动合成）？

 1. 同时重写了 setter 和 getter 时
 2. 重写了只读属性的 getter 时
 2. 使用了 @dynamic 时
 2. 在 @protocol 中定义的所有属性
 2. 在 category 中定义的所有属性
 2. 重载的属性 
 
当你在子类中重载了父类中的属性，你必须 使用 `@synthesize` 来手动合成ivar。

除了后三条，对其他几个我们可以总结出一个规律：当你想手动管理 @property 的所有内容时，你就会尝试通过实现 @property 的所有“存取方法”（the accessor methods）或者使用 `@dynamic` 来达到这个目的，这时编译器就会认为你打算手动管理 @property，于是编译器就禁用了 autosynthesis（自动合成）。

因为有了 autosynthesis（自动合成），大部分开发者已经习惯不去手动定义ivar，而是依赖于 autosynthesis（自动合成），但是一旦你需要使用ivar，而 autosynthesis（自动合成）又失效了，如果不去手动定义ivar，那么你就得借助 `@synthesize` 来手动合成 ivar。

其实，`@synthesize` 语法还有一个应用场景，但是不太建议大家使用：

可以在类的实现代码里通过 `@synthesize` 语法来指定实例变量的名字:
 
```Objective-C
@implementation CYLPerson 
@synthesize firstName = _myFirstName; 
@synthesize lastName = _myLastName; 
@end 
```

上述语法会将生成的实例变量命名为 `_myFirstName` 与 `_myLastName`，而不再使用默认的名字。一般情况下无须修改默认的实例变量名，但是如果你不喜欢以下划线来命名实例变量，那么可以用这个办法将其改为自己想要的名字。笔者还是推荐使用默认的命名方案，因为如果所有人都坚持这套方案，那么写出来的代码大家都能看得懂。

举例说明：应用场景：

 ```Objective-C
//
// .m文件
// http://weibo.com/luohanchenyilong/ (微博@iOS程序犭袁)
// https://github.com/ChenYilong
// 打开第14行和第17行中任意一行，就可编译成功

@import Foundation;

@interface CYLObject : NSObject
@property (nonatomic, copy) NSString *title;
@end

@implementation CYLObject {
    //    NSString *_title;
}

//@synthesize title = _title;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"微博@iOS程序犭袁";
    }
    return self;
}

- (NSString *)title {
    return _title;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
}

@end
 ```

结果编译器报错：
![enter image description here](http://i.imgur.com/fAEGHIo.png)

当你同时重写了 setter 和 getter 时，系统就不会生成 ivar（实例变量/成员变量）。这时候有两种选择：

 1. 要么如第14行：手动创建 ivar
 2. 要么如第17行：使用`@synthesize foo = _foo;` ，关联 @property 与 ivar。

更多信息，请戳 => [ ***When should I use @synthesize explicitly?*** ](http://stackoverflow.com/a/19821816/3395008)

