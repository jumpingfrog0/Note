# swift.md

<!-- create time: 2015-08-03 16:18:57  -->

<!-- This file is created from $MARBOO_HOME/.media/starts/default.md
本文件由 $MARBOO_HOME/.media/starts/default.md 复制而来 -->

### 官方文档

[Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)

[Swift Documentation](https://swift.org/)

[The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)

[Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html)

[The Swift Standard Library](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)

[API Design Guidelines](https://swift.org/documentation/api-design-guidelines)

### Copyright Statement

	//
	//  Copyright (c) 2014-2016 Jumpingfrog0 LLC
	//
	//  Permission is hereby granted, free of charge, to any person obtaining a copy
	//  of this software and associated documentation files (the "Software"), to deal
	//  in the Software without restriction, including without limitation the rights
	//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	//  copies of the Software, and to permit persons to whom the Software is
	//  furnished to do so, subject to the following conditions:
	//
	//  The above copyright notice and this permission notice shall be included in
	//  all copies or substantial portions of the Software.
	//
	//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	//  THE SOFTWARE.

### Swift 学习网址

[Swift 学习指引](http://www.swiftguide.cn/)

[Swift 翻译](https://numbbbbb.gitbooks.io/-the-swift-programming-language-/content/)

[Swiftist](http://swiftist.org/)

[hacking with swift](https://www.hackingwithswift.com/)

### 构造器
构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给本身提供的其它构造器。类则不同，它可以继承自其它类，这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。

对于值类型，你可以使用self.init在自定义的构造器中引用其它的属于相同值类型的构造器。并且你只能在构造器内部调用self.init。

注意，如果你为某个值类型定义了一个定制的构造器，你将无法访问到默认构造器（如果是结构体，则无法访问逐一对象构造器）。这个限制可以防止你在为值类型定义了一个更复杂的，完成了重要准备构造器之后，别人还是错误的使用了那个自动生成的构造器。

> 注意：
假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例，我们建议你将自己定制的构造器写到扩展（extension）中，而不是跟值类型定义混在一起。


### Swift programming style

[swift style guide](https://github.com/raywenderlich/swift-style-guide)

[RayWenderlich 官方 Swift 风格指南](http://codebuild.me/2015/09/14/raywenderlich-swift-style-guide/)

[API Design Guidelines](https://swift.org/documentation/api-design-guidelines/#follow-case-conventions)

[swift style guide 2](https://github.com/github/swift-style-guide)

[How We Tamed Swift Syntax: the Open Source Style Guide](https://www.netguru.co/blog/swift-style-guide-open-source)

-------

[The as! Operator](https://developer.apple.com/swift/blog/?id=23)

[Using Swift String enums in Objective-C](https://medium.com/@oscarcortes/using-swift-string-enums-in-objective-c-f6683da5b92e)
[How to make a Swift String enum available in Objective-C?](http://stackoverflow.com/questions/30480338/how-to-make-a-swift-string-enum-available-in-objective-c)

##### static & class

[Static properties in Swift](http://stackoverflow.com/questions/26567480/static-properties-in-swift)

[Static vs class functions/variables in Swift classes?](http://stackoverflow.com/questions/29636633/static-vs-class-functions-variables-in-swift-classes)

[STATIC 和 CLASS](http://swifter.tips/static-class/)


---------------------
[Nullability and Objective-C](https://developer.apple.com/swift/blog/?id=25)

[object-x-of-class-y-does-not-implement-methodsignatureforselector-in-swift](http://stackoverflow.com/questions/24415662/object-x-of-class-y-does-not-implement-methodsignatureforselector-in-swift)

##### ifdef in swift language / debug config
[#ifdef in swift language](http://stackoverflow.com/questions/24003291/ifdef-replacement-in-swift-language)

	Other swift flags:
	-D DEBUG
	-D RELEASE
	

[https://github.com/swisspol/XLFacility/issues/11#issuecomment-74774034](https://github.com/swisspol/XLFacility/issues/11#issuecomment-74774034)

[http://qiita.com/qmihara/items/a6b88b74fe64e1e05ca4](http://qiita.com/qmihara/items/a6b88b74fe64e1e05ca4)

##### GlobalConstants
[http://stackoverflow.com/questions/26252233/global-constants-file-in-swift](http://stackoverflow.com/questions/26252233/global-constants-file-in-swift)

[Macros in Swift?](http://stackoverflow.com/questions/24114288/macros-in-swift)

##### protocol

[How to define optional methods in Swift protocol?](http://stackoverflow.com/questions/24032754/how-to-define-optional-methods-in-swift-protocol)

> Only classes, protocols, methods and properties can use @objc

In Swift 2.0 it's possible to add default implementations of a protocol. This creates a new way of optional methods in protocols.

	protocol MyProtocol {
	    func doSomethingNonOptionalMethod()
	    func doSomethingOptionalMethod()
	}

	extension MyProtocol {
	    func doSomethingOptionalMethod(){ 
	        // leaving this empty 
	    }
	}

> It's not a really nice way in creating optional protocol methods, but gives you the possibility to use structs in in protocol callbacks.

### New features

[What's new in Swift 2](https://www.hackingwithswift.com/swift2)

[What's new in Swift 2.2](https://www.hackingwithswift.com/swift2-2)

[What's new in Swift 3.0](https://www.hackingwithswift.com/swift3)

### Swift 2.0 feature

[stringByAppendingPathComponent is unavailable](https://forums.developer.apple.com/thread/13580)

[HACKING WITH SWIFT](https://www.hackingwithswift.com/)

[What's new in iOS 9](https://www.hackingwithswift.com/ios9)

[The guard keyword in Swift 2: early returns made easy](https://www.hackingwithswift.com/new-syntax-swift-2-guard)

[Swift 2.0: Why Guard is Better than If](http://natashatherobot.com/swift-guard-better-than-if/)

[Error handling in Swift 2: try, catch, do and throw](https://www.hackingwithswift.com/new-syntax-swift-2-error-handling-try-catch)

### Swift syntax
[String length in Swift 1.2 and Swift 2.0](http://stackoverflow.com/questions/29575140/string-length-in-swift-1-2-and-swift-2-0)

[sort](http://useyourloaf.com/blog/sorting-an-array-of-dictionaries.html)

[The defer keyword in Swift 2: try/finally done right](https://www.hackingwithswift.com/new-syntax-swift-2-defer)

### runtime

[Swift & the Objective-C Runtime](http://nshipster.cn/swift-objc-runtime/)

[Equatable NSObject With Swift 2](http://mgrebenets.github.io/swift/2015/06/21/equatable-nsobject-with-swift-2)

### Bool

[Checking the value of an Optional Bool](http://stackoverflow.com/questions/25523305/checking-the-value-of-an-optional-bool)

---------

Swift3 syntax changes

[shouldAutorotate() function in Xcode 8 beta 4](http://stackoverflow.com/questions/38721302/shouldautorotate-function-in-xcode-8-beta-4)

### 逃逸闭包

[swift3.0中@escaping 和 @noescape 的含义](http://www.jianshu.com/p/73bd0633ab00)

[Updating closures to Swift 3 - @escaping](http://stackoverflow.com/questions/39063499/updating-closures-to-swift-3-escaping)

### Compile slow


### swift [self class]

[http://stackoverflow.com/questions/24403718/swift-equivalent-objective-c-runtime-class](http://stackoverflow.com/questions/24403718/swift-equivalent-objective-c-runtime-class)
