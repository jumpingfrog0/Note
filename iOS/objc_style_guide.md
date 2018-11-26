# iOS编码规范文档

<--
作者：黄东鸿
创建于：2018/06/20
-->

苹果和谷歌的官方编码风格文档:

* [Apple Coding Guidelines for Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)
* [Google Objective-C Style Guide](http://google.github.io/styleguide/objcguide.html)

## Table Of Contents 

<!-- vim-markdown-toc GitLab -->

* [一般性原则](#一般性原则)
	* [1. 为读者优化，而不是作者](#1-为读者优化而不是作者)
	* [2. 一致性](#2-一致性)
	* [3. 与 Apple SDK 保持一致](#3-与-apple-sdk-保持一致)
* [Example](#example)
* [编码风格](#编码风格)
	* [语言](#语言)
	* [排版格式](#排版格式)
		* [方法长度/行宽限制](#方法长度行宽限制)
		* [Tab vs 空格](#tab-vs-空格)
		* [代码组织结构](#代码组织结构)
		* [属性声明](#属性声明)
		* [方法声明和定义](#方法声明和定义)
		* [条件语句](#条件语句)
			* [Case 语句](#case-语句)
	* [Block](#block)
* [命名规范](#命名规范)
	* [命名规则](#命名规则)
	* [类命名](#类命名)
	* [协议命名](#协议命名)
	* [Category 命名](#category-命名)
	* [头文件(Headers)命名](#头文件headers命名)
	* [方法](#方法)
		* [方法命名](#方法命名)
		* [方法调用](#方法调用)
	* [函数命名](#函数命名)
	* [属性和变量](#属性和变量)
		* [属性和变量命名](#属性和变量命名)
	* [枚举](#枚举)
	* [常量](#常量)
	* [宏定义](#宏定义)
	* [通知命名](#通知命名)
	* [布尔值](#布尔值)
* [注释规范](#注释规范)
	* [文件注释](#文件注释)
	* [声明部分的注释](#声明部分的注释)
	* [实现部分的注释](#实现部分的注释)
* [日志打印规范](#日志打印规范)
	* [输出规范](#输出规范)
* [资源管理规范](#资源管理规范)
	* [图片资源](#图片资源)
	* [图片命名](#图片命名)
	* [其他资源](#其他资源)
* [工程目录](#工程目录)

<!-- vim-markdown-toc -->

## 一般性原则

### 1. 为读者优化，而不是作者

代码是写来看的，阅读代码花费的时间比写代码更多，不要为了炫技而使用复杂难懂的语法或算法，代码应该保持清晰和简洁，并且，清晰比简洁更重要!

### 2. 一致性

保持代码风格的始终如一，参与同一个代码库的所有开发人员必须遵守统一的编码风格。

### 3. 与 Apple SDK 保持一致

苹果在使用 Objective-C 的过程中肯定解决了关于如何使用它的争论，当你不知道如何使用的时候，与 Apple SDK 保持风格一致便是正确的。

## Example

一个好的例子胜过千言万语，让我们感受一下编码风格、留白以及命名等。

```objective-c
// Foo.h

#import <Foundation/Foundation.h>

@class Bar;

/**
 * A sample class demonstrating good Objective-C style. All interfaces,
 * categories, and protocols (read: all non-trivial top-level declarations
 * in a header) MUST be commented. Comments must also be adjacent to the
 * object they're documenting.
 */
@interface Foo : NSObject

/** The retained Bar. */
@property(nonatomic) Bar *bar;

/** The current drawing attributes. */
@property(nonatomic, copy) NSDictionary<NSString *, NSNumber *> *attributes;

/**
 * Convenience creation method.
 * See -initWithBar: for details about @c bar.
 *
 * @param bar The string for fooing.
 * @return An instance of Foo.
 */
+ (instancetype)fooWithBar:(Bar *)bar;

/**
 * Designated initializer.
 *
 * @param bar A string that represents a thing that does a thing.
 */
- (instancetype)initWithBar:(Bar *)bar;

/**
 * Does some work with @c blah.
 *
 * @param blah
 * @return YES if the work was completed; NO otherwise.
 */
- (BOOL)doWorkWithBlah:(NSString *)blah;

@end
```

```objective-c
// Foo.m

#import "Shared/Util/Foo.h"

@implementation Foo {
	/** The string used for displaying "hi". */
	NSString *_string;
}

+ (instancetype)fooWithBar:(Bar *)bar {
	return [[self alloc] initWithBar:bar];
}

- (instancetype)init {
	// Classes with a custom designated initializer should always override
	// the superclass's designated initializer.
	return [self initWithBar:nil];
}

- (instancetype)initWithBar:(Bar *)bar {
	self = [super init];
	if (self) {
		_bar = [bar copy];
		_string = [[NSString alloc] initWithFormat:@"hi %d", 3];
		_attributes = @{
			@"color" : [UIColor blueColor],
			@"hidden" : @NO
		};
	}
	return self;
}

- (BOOL)doWorkWithBlah:(NSString *)blah {
	// Work should be done here.
	return NO;
}

@end
```

## 编码风格

### 语言

应该使用美式英语，而不是英式英语。

```
// GOOD:
UIColor *myColor = [UIColor whiteColor];
```

```
// BAD:
UIColor *myColour = [UIColor whiteColor];
```

### 排版格式

以下规定了方法长度、行宽限制、如何使用空格和留白等规范。

#### 方法长度/行宽限制

* 一个方法（函数）的长度不要超过**50行**，过长的方法应该拆分为多个方法。
* 一行代码不要超过**100个字符**，过长的一行代码将会导致可读性变差。

	在 `Xcode -> Preferences -> Text Editing -> Editing -> Page guide at column:` 中设置最大行长为**100**。

#### Tab vs 空格

使用**4个空格**来缩进。

	在 `Xcode > Preferences > Text Editing -> Indentation` 设置Tab和自动缩进为4个空格。

#### 代码组织结构

使用 `#pragma mark -` 进行分组

```
#pragma mark - Life Cycle 

- (instancetype)init {}
- (void)dealloc {}
- (void)loadView {}
- (void)viewDidLoad {}
- (void)viewWillAppear:(BOOL)animated {}
- (void)viewDidAppear:(BOOL)animated {}
- (void)viewWillDisappear:(BOOL)animated {}
- (void)viewDidDisappear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}

#pragma mark - Getter & Setter

- (void)setCustomProperty:(id)value {}
- (id)customProperty {}

#pragma mark - Logic

- (void)publicMethod {}
- (void)privateMethod {}

#pragma mark - Protocol
#pragma mark - DataSource 
#pragma mark - Delegate

#pragma mark - UI & Layout

// Layout
- (void)viewWillLayoutSubviews
- (void)viewDidLayoutSubviews

- (void)layoutSubviews {}
- (void)customLayoutMethod {}

// Lazy load UI
- (UIImageView *)imageView {}
- (UIButton *)loginButton {}
```

结构层次较复杂时，按照模块创建 category 来分离 viewController 的代码 (参见项目中的实现), 如：

JFViewController               (只实现针对 module1, module2, module3 的管理逻辑)

JFViewController+Module1       (实现当前模块逻辑, UI)

JFViewController+Module2

JFViewController+Module3

#### 属性声明

* 属性声明左括号紧贴`@property`，按照如下顺序进行：原子性，内存管理，访问器，并且 `*` 紧贴属性名

```
// GOOD:

@property(nonatomic, strong) NSString *myProperty;
```

```
// BAD:

@property(strong, nonatomic) NSString *myProperty;		// AVOID
@property (nonatomic, strong) NSString *myProperty;		// AVOID
@property(nonatomic, strong) NSString* myProperty;		// AVOID
@property(nonatomic, strong) NSString * myProperty;		// AVOID
```


#### 方法声明和定义
	
* 必须在 `-` 或 `+` 和返回值之间使用一个空格，参数列表中只有参数之间才可以有空格
* 左大括号 `{` 总是在方法声明的同一行，并且前面有一个空格

```objective-c
// GOOD:

- (void)doSomethingWithString:(NSString *)theString {
	...
}
```

```
// BAD:

- (void)doSomethingWithString:(NSString *)theString
{
	...
}

- (void)doSomethingWithString:(NSString *)theString{
	...
}
```

如果一行有很多个参数，最好把每个参数单独拆成一行，并将冒号对齐。

```objective-c
// GOOD:

- (void)doSomethingWithFoo:(GTMFoo *)theFoo
				  rect:(NSRect)theRect
			  interval:(float)theInterval {
	...
}
```

如果第一个参数比第二个或其他参数短时，下一行至少要有4个空格的缩进，并保持冒号对齐。

```objective-c
// GOOD:

- (void)short:(GTMFoo *)theFoo
          longKeyword:(NSRect)theRect
    evenLongerKeyword:(float)theInterval
                error:(NSError **)theError {
	...
}
```

#### 条件语句

条件语句（`if`/`else`/`switch`/`for`/`while`)必须跟随着大括号，即使只有一行代码，并且左大括号 `{` 与条件语句在同一行中，且前面有一个空格。

```
// GOOD:

- (void)doSomethingMethod {
	...
}

if (i > 0) {
	// do something
} else {
	// ...
}

for (int i = 0; i < 5; ++i) {
	...
}

while (test) {
	...
};
```

```
// BAD:

if (hasSillyName)
	LaughOutLoud();               // AVOID.

for (int i = 0; i < 10; i++)
	BlowTheHorn();                // AVOID.

if (hasBaz) foo();	// AVOID
else bar();        	// AVOID.

uf (hasBaz) {
	foo();
} else bar();      	// AVOID.
```

##### Case 语句

* 当一个 case 语句包含多行代码时，必须加上大括号。
* 当需要 `fall-through` 到下一个case语句时，必须加上注释；除非在下一个case前没有执行任何有意义的代码

```
switch (condition) {
	case 1:
		...
		break;
	case 2: {
		// Multi-line example using braces
		...
		break;
	} 
	case 3:
		j++;
		// Falls through.
	case 4: {
		// code executed for values 3 and 4
		int k;
		...
		break;
	}
  	case 4:
  	case 5:
  	case 6: break;
}
```

### Block

* block 不能写在一行内，要分行显示
* `^` 和 `(` 之间，`^` 和 `{` 之间都没有空格，参数列表的右括号 `)` 和 `{` 之间有一个空格
* block 内的代码采用 **4个空格** 的缩进
* 避免以冒号对齐的方式来调用方法
* 如果block过于庞大，应该单独声明成一个变量来使用

```Objective-C
// GOOD

// blocks are easily readable
[UIView animateWithDuration:1.0 animations:^{
  	// something
} completion:^(BOOL finished) {
  	// something
}];
```

```Ojbective-C
// BAD

// colon-aligning makes the block indentation hard to read
[UIView animateWithDuration:1.0
                 animations:^{
                     // something
                 }
                 completion:^(BOOL finished) {
                     // something
                 }];
```

```Objective-C
// GOOD

// 庞大的block应该单独定义成变量使用
void (^largeBlock)(void) = ^{
    // ...
};
[_operationQueue addOperationWithBlock:largeBlock];
```

## 命名规范

### 命名规则

* 驼峰命名

### 类命名

类名以大写字母的开头，使用**名词**，同时加上必要的前缀（公司名/框架名/项目名）

规则：前缀 + 模块 + 描述 + 类型，如：`JFMallHomeViewController`, `JFMallSceneView`

### 协议命名

协议名以大写字母开头，清晰地表示协议的功能或执行的行为，同时加上必要的后缀(Protocol/Delegate/DataSource/ing/...)

规则：前缀 + 协议描述 + 后缀，如：`UITableViewDelegate`, `NSCopying`, `JFAccountProtocol`

### Category 命名

**分类必须添加前缀**，包括文件名和方法名，目的是最大限度地避免与系统或第三方类库中的方法重名而引发难以追踪的Bug。

* category 文件命名规则：类名 + 大写前缀 + 功能

	文件名，比如：`NSString+JFJSON.h`, `NSString+JFURL.h`, `NSString+JFEncrypt.h`

	分类名，左括号`(`前要有一个空格 ，比如：`@interface NSString (JFEncrypt)`, `@interface NSString (JFURL)`, `@interface NSString (JFEncrypt)`

* category 方法命名规则：小写前缀 + 方法名

	比如：`jf_urlEncode`, `- (NSURL *)jf_URLByAppendingQueryString:(NSString *)queryString;`

```
// GOOD:

/** A category that adds parsing functionality to NSString. */
@interface NSString (GTMNSStringParsingAdditions)
- (NSString *)gtm_parsedString;
@end
```


### 头文件(Headers)命名

与`类命名`类似，应该清晰的暗示它的功能和包含的内容，如：`JFDebugging`，`JFDefines`

### 方法

#### 方法命名

Objective-C的方法名通常较长，为了让程序有更好的可读性，按照苹果的说法“好的方法名应当可以以一个短句的形式朗读出来”

* 以小写字母开头，后续每个单词首字母大写，且不包含任何标点符号，有三个例外：
	- 通用的大写字母缩写开头的，比如：`PDF`, `TIFF`, `URL`
	- 私有方法可以用下划线`_`开头
	- 分类（category）中的方法可以使用`前缀+下划线`，如：`jf_setBackgroundImage:`
* 如果方法表示让对象执行一个动作，以**动词**开头，注意不要使用 `do`, `does` 这种多余的关键字
* 如果方法返回一个对象或值，使用**名词**，注意不要添加 `get` 或者其他动词前缀

```
// GOOD:

- (void)showPageWithOptions:(NSDictionary *)options;
+ (NSURL *)URLWithString:(NSString *)string;

// 返回对象或值
- (NSSize)cellSize;
- (Sandwich *)sandwich;

// 私有方法
- (void)_handlePrivateAction;

// category 方法
- (void)jf_setCustomProperty;
```

```
// BAD:

- (void)doSomething;

// 返回对象或值
- (NSSize)getCellSize;
- (NSSize)calcCellSize;
- (Sandwich *)makeSandwich;
```

#### 方法调用

1. 一行代码方法嵌套不要超过2层。

```
// GOOD:

[alert show];
[[UIView alloc] init];


NSString *imageName = [NSString stringWithFormat:@"forum-loading-0%1ld", i];
[images addObject:[UIImage imageNamed:imageName]];

id<JFLocalConfigurationProtocol> service = [[JFLocalConfigurationManager sharedManager] globalService];
[service fetchBoolForConfig:@"key"];
```

```
// BAD:

[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"forum-loading-0%1ld", i]]];

[[[JFLocalConfigurationManager sharedManager] globalService] fetchBoolForConfig:@"key"];
```

2. 方法调用很长时，如果有返回值，把返回值提前声明。

```
// GOOD:

int a;
a = [b callVeryVeryVeryLongMethodAndThenReturnTheValue];
```

```
// BAD:
int a = [b callVeryVeryVeryLongMethodAndThenReturnTheValue];
```

3. 点语法只在访问属性时使用，不能用在方法调用上。

```
// GOOD:

@property(nonatomic, getter=isGlorious) BOOL glorious;
- (BOOL)isGlorious;

BOOL isGood = object.glorious;      // GOOD.
BOOL isGood = [object isGlorious];  // GOOD.
```

```
// BAD:

BOOL isGood = object.isGlorious;    // AVOID.
```

```
// GOOD:

NSArray<Frog *> *frogs = [NSArray<Frog *> arrayWithObject:frog];
NSEnumerator *enumerator = [frogs reverseObjectEnumerator];  // GOOD.
```

```
// BAD:

NSEnumerator *enumerator = frogs.reverseObjectEnumerator;    // AVOID.
```


### 函数命名

函数的命名与方法有些不同，主要是：

* 函数名称前带有缩写前缀，表示方法所在的框架
* 前缀后的单词首字母大写

```objective-c
// GOOD:

extern NSTimeZone *JFGetDefaultTimeZone();
extern NSString *JFGetURLScheme(NSURL *URL);
```

其他规则：

1. 函数没有返回值，以**动词**开头，表示执行的操作

	```	
	// GOOD:

	FOUNDATION_EXTERN void NSDeallocateObject(id object);

	static void JFAddTableEntry(NSString *tableEntry);
	```
2. 函数有返回值，返回值是基本类型（int/float/double/bool/CGRect等)，则**省略动词**

	```
	// GOOD:

	unsigned int NSEventMaskFromType(NSEventType type)
	float NSHeight(NSRect aRect)
	```

3. 函数有返回值，返回值是指针类型，需要在函数名中使用 `Get`

	```
	// GOOD:

	extern NSString *JFGetURLScheme(NSURL *URL);
	```
4. 函数有返回值，返回值是BOOL，需要在函数名中使用 `Is`

	```
	// GOOD:

	BOOL NSDecimalIsNotANumber(const NSDecimal *dcm)
	```

### 属性和变量

#### 属性和变量命名

* 属性和变量命名首字母小写，后续单词首字母大写，尽量是 **名词或形容词**。
* 实例变量以下划线 `_` 开头，作用域是文件或全局的变量要有前缀 `g`，比如：`myLocalVariable`, `_myInstanceVariable`, `gMyGlobalVariable`。
* 声明 `BOOL` 类型的属性，推荐使用**形容词**，`getter` 添加 `is` 前缀

```
// GOOD:

@property(nonatomic, strong) NSString *myProperty;

@property(nonatomic, assign, getter=isGlorious) BOOL glorious;
```

```
// BAD:

@property(nonatomic, assign) BOOL glorious;				// AVOID
@property(nonatomic, assign) BOOL glory;				// AVOID
```

### 枚举

不要使用 `enum`，推荐使用 `NS_ENUM`，并且添加前缀，使用驼峰命名法则，命名应准确表达枚举表示的意义，枚举中各个值都应以定义的枚举类型开头，其后跟随各个枚举值对应的状态、选项或状态码等。

```
// GOOD: 

typedef NS_ENUM(NSInteger, UICollectionViewScrollDirection) {
    UICollectionViewScrollDirectionVertical,
    UICollectionViewScrollDirectionHorizontal
};
```

也可以显示的赋值

```
// GOOD:

typedef NS_ENUM(NSInteger, JFServiceError) {
  JFServiceErrorQueryResultMissing = -3000,
  JFServiceErrorWaitTimedOut       = -3001,
};
```

```
// BAD:

enum GlobalConstants {
  kMaxPinSize = 5,
  kMaxPinCount = 500,
};
```

对于需要以按位或操作来组合的枚举(多个选项可同时使用)都应使用 `NS_OPTIONS` 来定义

```
// GOOD:

typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
    UIViewAutoresizingNone                 = 0,
    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
    UIViewAutoresizingFlexibleWidth        = 1 << 1,
    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
    UIViewAutoresizingFlexibleHeight       = 1 << 4,
    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
};
```

> 编码技巧：
> 在处理枚举类型的 switch 语句中不要实现 default 分支。这样加入新的枚举值之后，编译器就会发出警告提示，switch 还有未处理的枚举值，这样可以提前发现bug。

### 常量

常量推荐使用 `static` `const` 关键字来声明，并添加前缀 `k`，不推荐使用宏定义 `#define`

1. 指针类型 或 CGRect/CGSize/CGPoint 类型的常量，`const` 应该置于类型之后

```
// GOOD:

static NSString *const kDBFileName = @"manifest.sqlite";
```

```
// BAD:

const NSString *kDBFileName = @"manifest.sqlite";
static NSString *kDBFileName = @"manifest.sqlite";
static const NSString *kDBFileName = @"manifest.sqlite";
static NSString const *kDBFileName = @"manifest.sqlite";

#define kDBFileName = @"manifest.sqlite";
```

2. 基本数据类型的常量，`const` 应该置于类型之前

```
// GOOD:

static const int kFileCount = 100; 
```

```
// BAD:

static int const kFileCount = 100; 
```

3. 对外公开的(public)的常量必须使用 `extern` 或 `FOUNDATION_EXTERN` 关键字导出，将细节隐藏在 `.m` 中，不要在直接在 `.h` 中直接声明，并且紧跟 `k` 后面加上框架前缀

```objective-c
// GOOD:

// .h
extern NSString *const kJFUserKey;
FOUNDATION_EXTERN const int kJFFileCount; 

// .m
NSString *const kJFUserKey = @"kJFUserKey";
const int kJFFileCount = 100; 
```

### 宏定义

**不要使用宏定义**

### 通知命名

通知的命名要尽可能地表示出发生的事件/动作。

命名规则: 前缀 + [ 关联的类名 | 涉及的业务模块 ] + [ Did | Will | Should ] + 动作 + Notification

```
// GOOD:

NSApplicationDidBecomeActiveNotification
NSWindowDidMiniaturizeNotification
NSTextViewDidChangeSelectionNotification
NSColorPanelColorDidChangeNotification

JFAccountDidLoginSuccessNotification
JFUserDidChangeFollowStateNotification
```

通知的写法和常量一样，在 .m 中定义，在 .h 中暴露出去，并且推荐使用 `NSNotificationName` 定义类型。

`NSNotificationName` ，其实也就是 `NSString *`，在Foundation的定义如下：`typedef NSString *NSNotificationName NS_EXTENSIBLE_STRING_ENUM;`

```objective-c
// GOOD:

// .h
FOUNDATION_EXTERN NSString *const JFAccountDidLoginSuccessNotification; 			// good
FOUNDATION_EXTERN NSNotificationName const JFAccountDidLoginSuccessNotification; 	// better

// .m
NSString *const JFAccountDidLoginSuccessNotification = @"JFAccountDidLoginSuccessNotification"; 			// good
NSNotificationName const JFAccountDidLoginSuccessNotification = @"JFAccountDidLoginSuccessNotification";	// better
```

### 布尔值

1. 不要直接把整形值转化成`BOOL`值

	常见的错误包括将数组的大小、指针值及位运算的结果直接转换成BOOL，因为可能产生一个NO的值，这取决于整型结果的最后一个字节。当转换整形至BOOL时，使用三目操作符来返回YES或者NO。

	对于BOOL合理使用逻辑运算符(&&,||和!)的，以及返回值可以安全地转换成BOOL的，不需要使用三目操作符。

	```
	// BAD:

	- (BOOL)isBold {
	  	return [self fontTraits] & NSFontBoldTrait;  // AVOID.
	}
	- (BOOL)isValid {
	  	return [self stringValue];  // AVOID.
	}
	```

	```
	// GOOD:

	- (BOOL)isBold {
	  	return ([self fontTraits] & NSFontBoldTrait) ? YES : NO;
	}
	- (BOOL)isValid {
	  	return [self stringValue] != nil;
	}
	- (BOOL)isEnabled {
	  	return [self isValid] && [self isBold];
	}
	```

2. 不要拿 `BOOL` 变量与 `YES` 直接比较。不仅影响可读性，而且结果可能与你想的不一样。

```
// BAD:

BOOL great = [foo isGreat];
if (great == YES) {  // AVOID.
  	// ...be great!
}
```

```
// GOOD:

BOOL great = [foo isGreat];
if (great) {         // GOOD.
  	// ...be great!
}
```

3. `BOOL` 变量与 `NO` 作比较时，使用 `!` 更简洁

```
// GOOD:

if (!isAwesome) {
}
```

```
// BAD: 

if (isAwesome == NO) {
}
```

## 注释规范

> 注释的目的是为了方便阅读和理解代码，除非有必要，否则不要添加任何无意义的注释。
>
> 注释应该解释这段特殊代码**为什么**要这样做
>
> 尽管注释很重要，但最好的代码应该自成文档

按照规范进行注释，方便使用 apple doc 生成文档

快捷键
* Xcode: `Cmd + Option + /`
* AppCode：`/** + Enter`

### 文件注释

每个文件必须包含文件注释，顺序如下：

* 文件内容的简要描述
* 作者
* 创建时间
* 版权信息声明
* 必要的话，加上许可证声明（如 MIT，Apache 2.0，BSD 等开源许可证声明）

```
//
//  JFAppDelegate.m
//  iLoving
//
//  Created by Donghong on 6/21/2018.
//  Copyright (c) 2018 JF. All rights reserved.
//
```


### 声明部分的注释

声明部分统一使用 `Doxygen-style` 风格的注释，便于出成 api 文档

每个方法的注释必须解释方法作用，参数，返回值，线程或队列假设以及任何副作用。

```
// GOOD:

/**
 * A delegate for NSApplication to handle notifications about app
 * launch and shutdown. Owned by the main app controller.
 */
 @interface MyAppDelegate : NSObject {
 /**
* The background task in progress, if any. This is initialized
* to the value UIBackgroundTaskInvalid.
*/
UIBackgroundTaskIdentifier _backgroundTaskID;
}

/** The factory that creates and manages fetchers for the app. */
@property(nonatomic) GTMSessionFetcherService *fetcherService;

@end
```

### 实现部分的注释

* 实现部分的注释统一使用 `//`，不要使用 `/** */`
* 在行末添加注释时，至少有2个空格，并且有多行连续的注释时，需要对齐，这是为了保证可读性
* 注释中涉及引用方法或变量，需要用 ` `` ` 括起来

```
// GOOD:

// Set the property to nil before invoking the completion handler to
// avoid the risk of reentrancy leading to the callback being
// invoked again.
CompletionHandler handler = self.completionHandler;
self.completionHandler = nil;
handler();
```

```
// GOOD:

[self doSomethingWithALongName];  // Two spaces before the comment.
[self doSomethingShort];          // More spacing to align the comment.
```

```
// GOOD:

// Sometimes `count` will be less than zero.

```

```
// GOOD:

// Remember to call `initWithString:`
```


## 日志打印规范

日志级别，级别从高到低:

* OFF	: 用于关闭日志。
* FATAL	: 最高级别错误，反映系统遇到了非常严重的错误事件，导致应用无法正常使用，在客户端中一般不需要使用这个级别的错误。
* ERROR	: 高级别错误，表明遇到了一些错误，可能会导致功能无法正常使用。
* WARN	: 低级别异常日志，反映系统在业务处理时触发了异常流程，存在潜在的有害状况，但应用仍能正常使用，下一次业务可能可以正常执行。WARN级别问题需要开发人员给予足够关注，往往表示有参数校验问题或者程序逻辑缺陷。
* INFO	: 关键信息日志，主要用于记录系统运行状态等关键信息，从粗粒度上描述了应用运行过程。
* DEBUG	: 开发调试日志，记录各类详细信息，起到调试的作用，包括参数信息，调试细节信息，返回值信息等等。线上环境默认关闭这一级别的日志。
* TRACE	: 低级别调试日志，比 DEBUG 级别的粒度更细。只有在"追踪"代码流程时才使用，比如在跟踪复杂逻辑或算法的每一步执行结果，需要知道何时进入某一个函数，"if-else"进入哪个条件分支等情况，才使用这一级别的日志。 

### 输出规范

	时间 [日志级别] => [模块名::函数名]: 日志信息

示例：

```
2018/06/21 13:37:25:733 [INFO] => [TCP::-[JFTCPClient init]]: 初始化 tcp client <JFTCPClient: 0x1744a2880>
2018/06/21 13:37:25:733 [INFO] => [TCP::-[JFTCPClient init]]: 调用 X Auth verify
2018/06/21 13:37:25:734 [INFO] => [TCP::-[JFTCPClient init]]: 创建 tcp-queue <OS_dispatch_queue: com.xiaoenai.tcp-queue[0x174376a40]>
2018/06/21 13:37:25:734 [INFO] => [TCP::-[JFTCPClient init]]: 创建 tcp synchronizer <_JFTCPSynchronizer: 0x175e6fa00>
2018/06/21 13:37:25:734 [INFO] => [TCP::-[JFTCPClient init]]: 创建 tcp gateway <_JFTCPGateway: 0x170012320>
2018/06/21 13:37:25:735 [INFO] => [TCP::-[JFTCPClient init]]: 创建 X client callback <_JFTCPClientCallback: 0x170620840>
2018/06/21 13:37:25:735 [INFO] => [TCP::-[JFTCPClient init]]: 创建 tcp api service <_JFTCPAPIService: 0x17064fff0>
2018/06/21 13:37:25:735 [INFO] => [TCP::-[JFTCPClient init]]: 创建 tcp semaphore <OS_dispatch_semaphore: 0x170684510>
2018/06/21 13:37:25:736 [INFO] => [TCP::-[JFTCPClient init]]: 创建 tcp init callback <_JFTCPClientInitCallback: 0x174014bb0>
2018/06/21 13:37:25:736 [INFO] => [TCP::-[JFTCPClient init]]: 调用 X client xinitialize

2018/06/21 13:37:26:318 [DEBUG] => [TCP::-[_JFTCPSynchronizer sync]_block_invoke_3]: 服务器参数: {
	local = 26,
	real = 26
}, 本地参数 recvSeq：0
```

## 资源管理规范

### 图片资源

图片资源统一放在 `Images.xcassets` 中，按照不同模块放置在不同的Group中，一个模块可以有多个子模块，层级结构不超过2级。

一些可复用的公共图片放置在 `Common` 的 Group 下，比如导航栏的箭头、关闭按钮等的icon。

```
├── Chat
│   ├── Couple
│   └── Single
├── Common
│   ├── Input
│   └── NavBar
├── Home
│   ├── Feed
│   └── Topic
└── Profile
    ├── Setting
    └── User
```

### 图片命名

命名规则：模块 + 子模块 + 用途 + 状态(方向/颜色/类型等)

类型缩写：

* 图标：icon
* 按钮：btn
* 背景：bg

示例：

```
common_navbar_arrow_left.png
common_navbar_close_black.png
home_feed_camera_selected.png
home_feed_camera_default.png
home_feed_welcome_bg.png
profile_setting_delete_btn.png
```

### 其他资源

视频，配置文件等其他资源放在 `Supporting Files/Resources` 下，目录结构如下：

```
.
├── Audios
├── Config
└── Videos
```

命名规则：模块(全局资源使用 global）+ 资源描述 + 资源类型 +  后缀名 

示例：

```
home_introduction_video.mp4
chat_notify_alarm_audio.mp3
global_theme_config.plist
```

## 工程目录

工程目录与项目文件夹目录保持一致。

Example：

```
── wake
│   ├── 3rd-party
│   │   ├── GTM
│   │   ├── JSONKit
│   │   └── ...
│   ├── Assets.xcassets
│   ├── BusinessModule
│   │   ├── Home
│   │   ├── JFAccount
│   │   ├── JFHybridKit
│   │   ├── JFLocalConfiguration
│   │   ├── Me
│   │   ├── PublishVideo
│   │   ├── Search
│   │   └── Setting
│   ├── Controllers
│   ├── HTTPClient
│   ├── Models
│   ├── Resource
│   └── Utilities
│       ├── JFCache
│       ├── Additions
│       ├── Configuration
│       ├── InternalProtocol
│       ├── JUDSDK
│       ├── JFComponent
│       ├── JFDBClient
│       ├── JFDownloader
│       ├── JFImageCache
│       ├── JFNetwork
│       ├── JFShortVideoPlayer
│       ├── JFUploader
│       ├── JFXCrypto
│       ├── JFXEAUtil
│       ├── Permission
│       ├── Refresh
│       ├── Share
│       └── Statistics
└── xcconfig
```

// TODO:
