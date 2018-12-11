iOS 基础面试题
=========

### 1. 简述ViewController的生命周期

* initWithCoder
* loadView 
* viewDidLoad 
* viewWillAppear
* viewWillLayoutSubviews
* viewDidLayoutSubviews
* viewDidAppear 
* viewWillDisappear 
* viewDidDisappear
* dealloc(deinit)

#### 2. Cocoa 有哪些消息传递机制？

[消息传递机制](https://objccn.io/issue-7-4/)

* KVO
* NotificationCenter
* Delegate
* Block
* Target-Action

### 3. 通知中心、代理和block的区别

* 通知中心：主要特征是一对多，它在程序内部提供了一种消息广播的机制，我们需要在通知中心注册我们想要监听的消息，当项目中有地方发出这个消息的时候，通知中心会根据内部的一个消息转发表，来将消息转发给监听了这个消息的对象，通知中心可以通知多个对象。
* 代理：主要特征一对一，只能在代理者跟被代理者之间通信。代理更注重信息传输的过程：比如发起一个网络请求，可能想要知道此时请求是否已经开始、是否收到了数据、数据是否已经接受完成或数据接收失败等过程
* block和delegate一样，一般都是“一对一”之间的通信，相比代理，block有以下特点
	* 写法更简练，不需要写protocol、函数等
    * block注重传输的结果：比如对于一个事件，只想知道成功或者失败，并不需要知道进行了多少或者额外的一些信息
	* block需要注意防止循环引用

### 4. 使用 atomic 是“线程安全”的吗？

automic表明该属性使用了同步锁，是“原子性的”，但这并不能保证“线程安全” ( thread safety)，若要实现“线程安全”的操作，还需采用更为深层的锁定机制才行。例如，一个线程在连续多次读取某属性值的过程中有别的线程在同时改写该值，那么即便将属性声明为 atomic，也还是会读到不同的属性值。

因此，开发iOS程序时一般都会使用 nonatomic 属性。但是在开发 Mac OS X 程序时，使用 atomic 属性通常都不会有性能瓶颈。

也即:

> 在属性所指的对象遭到摧毁时，属性值也会清空(nil out)。


### 5. 简述iOS的沙盒机制

* iOS系统下每个应用都有自己对应的沙盒，每个沙盒之间都是相互独立的，互不能访问（没有越狱的情况下）。正因为这样的沙盒机制让iOS的系统变得更安全。
* Documents：保存应用运行时生成的需要持久化的数据，一般用来存储用户产生的内容，比如用户信息、游戏进度存档等。
	* 通过 iTunes、iCloud 备份时, 会备份该目录下的数据。
	* 此目录下保存相对重要的数据。
* Library：可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份。
* Library/Caches：一般存储的是缓存文件，例如图片、音乐、视频等。
	* 此目录下的数据不会自动删除，需要程序员手动清除。
	* iTunes、iCloud 备份时不会备份此目录下的数据。
	* 主要用于保存应用在运行时生成的需要长期使用、体积较大、不需要备份的非重要数据。
* Library/Preferences：专门用来保存应用程序的配置信息，最好不要存储任何和用户相关的数据。
	* iTunes、iCloud备份时，会备份该目录下的数据。
	* 不应该直接在这里创建文件，而是需要通过NSUserDefault来访问应用程序的偏好设置。
* tmp：临时文件目录，保存应用运行时产生的一些临时数据。
	* 在程序退出（或重新运行），系统磁盘空间不够，手机重启的时候，会自动清空该目录的数据，无需程序员手动清除。
	* iTunes、iCloud备份时，不会备份该目录


### 6. iOS有哪些数据存储方式？

* Plist：只能保存最基本的数据类型，比如NSArray、NSDictionary。
	* 一般保存在`Document`文件夹。
	* 通过 `writeToFile` 将数据写入文件中，通过类似 `dictionaryWithContentsOfFile` 的方法读取数据。
* Preference（偏好设置）：保存应用程序的偏好设置。
	* 会将所有的数据都保存到 `Library/Preferences`的文件夹下的同一个plist文件中。
	* 需要通过 NSUserDefault 来存取偏好设置。
* `NSKeydeArchiver(归档)`：可以保存自定义的类对象
	* 保存在`Document`文件夹，文件后缀名可以任意命名，通过归档方法保存的数据在文件中打开是编码，更安全。
	* 必须使被归档的类遵守`NSCoding`协议并且实现 `encodeWithCoder:` 和 `initWithCoder:` 这两个协议方法。
	* 通过 `archiveRootObject: toFile:`将自定义的对象保存到文件中，通过 `unarchiveObjectWithFile:` 读取数据。
* Sqlite
* CoreData
* Realm

### 7. imageNamed 和 imageWithContentsOfFile 的区别

* 前者会对图片进行缓存，而后者只是简单的从硬盘加载文件。
* 在整个程序运行的过程中，当你需要加载一张较大的图片，并且只会使用它一次，那么你就没必要缓存这个图片，这时你可以使用 `-[UIImage imageWithContentsOfFile:]`，这样系统也不会浪费内存来做缓存了。当然，如果你会多次使用到一张图时（比如UITableViewCell），用 `- [UIImage imageNamed:]` 就会高效很多，因为这样就不用每次都从硬盘上加载图片了。

## Swift

### Swift与OC的区别

1. Swift 中有引用类型和值类型，OC中只有引用类型，Swift的结构体是值类型
2. Swift 的Array，Dictionary是结构体而不是类
3. 苹果官网对swift优点的描述：

Safe.（安全）
The most obvious way to write code should also behave in a safe manner. Undefined behavior is the enemy of safety, and developer mistakes should be caught before software is in production. Opting for safety sometimes means Swift will feel strict, but we believe that clarity saves time in the long run.

Fast. （快）
Swift is intended as a replacement for C-based languages (C, C++, and Objective-C). As such, Swift must be comparable to those languages in performance for most tasks. Performance must also be predictable and consistent, not just fast in short bursts that require clean-up later. There are lots of languages with novel features — being fast is rare.

Expressive.（表达能力）
Swift benefits from decades of advancement in computer science to offer syntax that is a joy to use, with modern features developers expect. But Swift is never done. We will monitor language advancements and embrace what works, continually evolving to make Swift even better.

