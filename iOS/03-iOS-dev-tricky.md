iOS 开发中的坑
===========

## Xcode9 swift 项目 console 没有 Log 原因

可能是按了快捷键 `Cmd + Shift + y` 导致的
可能是按了快捷键 `Cmd + Shift + }` 导致的

## Xcode 配置

### 证书选择

有时候，release 的 provisioning profile 选择后，signing certicate 不会变化（或不正确），如图：

![](http://os3yasu4i.bkt.clouddn.com/release_signing_certicate_abnormal.png)

这是 Xcode 8的一个bug，只要先勾选 `Automatically manage signing`，然后取消，再重新设置 provisioning profile 就可以恢复正常了。

### Xcode 9 Jump To Definition

**Solution 1:**

* Go to Xcode menu
* Click on Preferences
* Select Navigation Tab from Top
* Select Command-click on Code
* Change to "Jumps to Definition"

![](https://i.stack.imgur.com/3Nuws.png)

**Solution 2:** Use

**Ctrl + ⌘ + Left click**

## Coding

### 读取 Bundle 文件失败

**Go to : Target -> "Build Phases" -> "copy bundle Resources" Then add that particular file here. If that file is already added , delete it and add it again. clean the project and RUN. It works. :)**

	NSString *path = [[NSBundle mainBundle] pathForResource:@"publish_video_tutorial" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];


### UIScrollView 的坑

#### UIScrollView 清空视图的坑：

```
for (UIView *subview in self.scrollView.subviews) {
	[subview removeFromSuperview];
}
```

```
for (UIView *subview in self.scrollView.subviews) {
    if ([subview isKindOfClass:[UIImageView class]]) {
        [subview removeFromSuperview];
    }
}
```

> 注意：上面的代码会把 UIScrollView 的滚动条也一并删除掉，因为 scroll view 的滚动条是用 UIImageView 生成的。
> 
> 解决办法是：使用tag标记对 UIImageView 进行标记，查找到对应tag的subview时才删除。

#### UIScorllView 不能滚动

* 检查 `contentSize` 是否大于父视图
* 检查 `contentSize` 在哪个地方设置：使用了 AutoLayout 的情况下，`- setContentSize:` 不能放在 `viewDidLoad` 或 `viewDidLayoutSubviews` 或 `updateViewConstraints` 中，必须放在 `viewDidAppear` 中。

### 解决多行文字时某行不足以容纳足够多的字符而导致text的右边空白间隙过大的问题

[https://stackoverflow.com/questions/3476646/uilabel-text-margin]([https://stackoverflow.com/questions/3476646/uilabel-text-margin)

```objective-c
NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
style.alignment = NSTextAlignmentJustified;
style.firstLineHeadIndent = 10.0f;
style.headIndent = 10.0f;
style.tailIndent = -10.0f;   

NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:title attributes:@{ NSParagraphStyleAttributeName : style}];  

UILabel * label = [[UILabel alloc] initWithFrame:someFrame];
label.numberOfLines = 0;
label.attributedText = attrText;
```

![](http://os3yasu4i.bkt.clouddn.com/033859E7-73D3-40A2-BBA4-32B7E7630CB5.png?imageView2/0/w/400/h/400/q/75|imageslim)
	
### 文件管理使用NSURL 的坑

**应该使用 `[NSURL fileURLWithPath:filePath];` 而不是 `[NSURL URLWithString:filePath];`**

`+URLWithString:` produces an `NSURL` that represents the string as given. So the string might be `@"http://www.google.com"` and the URL represents `http://www.google.com`.

`+fileURLWithPath:` takes a path, not a URL, and produces an `NSURL` that represents the path using a `file://` URL. So if you give it `/foo/bar/baz` the URL would represent `file:///foo/bar/baz`.

### NavigationBar 的坑

#### 隐藏 NavigationBar 下方的横线

方案一：

	// 对导航栏下面那条线做处理
	self.navigationBar.clipsToBounds = alpha == 0.0;
	
当我们对导航栏的透明度设为 0 时，就会隐藏细线，否则不隐藏，这样当切换到其他界面时，细线就又会出来了，现在导航栏的透明就比较完美了。

方案二：

	navigationBar.setBackgroundImage(UIImage(), for: .default)
	navigationBar.shadowImage = UIImage()
	
#### NavigationBar translucent 的坑

`translucent` 为 true 时，导航栏有毛玻璃穿透效果，因为 view 的container的高度会自动向上扩展到整个屏幕，`translucent` 为 false 时，view 的container的高度会减小44pt。
如果设置 `translucent` 为 false ，使用手势左滑或左滑到一半取消时（特别是自定义的push和pop的转场动画时）会出现整体视图往下偏移的奇葩现象，如图：

![](http://os3yasu4i.bkt.clouddn.com/navigationbar_translucent_tricky.PNG?imageView2/0/w/400/h/400/q/75|imageslim)

解决方法：

```objective-c
self.extendedLayoutIncludesOpaqueBars = YES;
```

上面的代码意思是：view 的 container 向四周扩展，并且包含不透明的bar的区域，也就是导航栏的区域

#### 透明/不透明

iOS 8.2 以后，可以通过 `[setBackgroundImage:forBarMetrics]` 将 navigationBar 设置为透明:

```
[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
```

然而，使用其他颜色设置背景图片时，会导致 navigationBar 变成完全不透明的，此时 `translucent` 会变为 `NO`

```
UIImage *image = [[self class] bl_imageWithColor:[UIColor blueColor] size:CGSizeMake(1, 1)];
[self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
```

#### 自定义 UIBarButtonItem 的坑

##### 自定义 UIBarButtonItem 的 disable 的颜色 和 字体

正确代码：

```objective-c
// 必须使用系统方法创建UIBarButtonItem，不能使用customView的方式
self.publishButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(handlePublishAction)];
self.publishButton.enabled = NO;

// 必须同时设置 normal 和 disabled 两种状态
[self.publishButton setTitleTextAttributes:@{
                                             NSFontAttributeName : [UIFont systemFontOfSize: 16],
                                             NSForegroundColorAttributeName : [MZDColor darkBarButtonItemColor]
                                             } forState:UIControlStateNormal];
[self.publishButton setTitleTextAttributes:@{
                                             NSFontAttributeName : [UIFont systemFontOfSize: 16],
                                             NSForegroundColorAttributeName : [MZDColor buttonRedColor]
                                             } forState:UIControlStateDisabled];
[self.navigationItem setRightBarButtonItem:self.publishButton];
```

错误代码：

```objective-c
// 这句是“小恩爱”中使用customView 自定义 UIBarButtonItem的代码
// 使用这种方法时，setTitleTextAttributes 方法不起作用
self.publishButton = [UIBarButtonItem doneBarButtonItemWithTitle:@"发布" handler:^(id sender) {
    @strongify(self);
    [self handlePublishAction];
}];

self.publishButton.enabled = NO;
[self.publishButton setTitleTextAttributes:@{
                                             NSFontAttributeName : [UIFont systemFontOfSize: 16],
                                             NSForegroundColorAttributeName : [MZDColor darkBarButtonItemColor]
                                             } forState:UIControlStateNormal];
[self.publishButton setTitleTextAttributes:@{
                                             NSFontAttributeName : [UIFont systemFontOfSize: 16],
                                             NSForegroundColorAttributeName : [MZDColor buttonRedColor]
                                             } forState:UIControlStateDisabled];
[self.navigationItem setRightBarButtonItem:self.publishButton];
```


#### 使用 AutoLayout 布局 适配 NavigationBar 细节处理

> 1.edgesForExtendedLayout是一个类型为UIExtendedEdge的属性，指定边缘要延伸的方向。默认是UIRectEdgeAll，四周边缘均延伸，从iOS7开始
如果即使视图中上有navigationBar，下有tabBar，那么视图仍会延伸覆盖到四周的区域。

> 2.假设在有navigation bar和tabbar的情况下：
该属性设置为UIRectEdgeBottom;那么就会self.view.frame是从navigationBar下面开始计算一直到屏幕底部；
该属性设置为UIRectEdgeTop;那么就会self.view.frame是从navigationBar上面计算面开始计算一直到屏幕tabBar上部；
该属性设置为UIRectEdgeNone;那么就会self.view.frame是从navigationBar下面开始计算一直到屏幕tabBar上部；

> 3.iOS7以上系统，self.navigationController.navigationBar.translucent默认为YES，self.view.frame.origin.y从0开始（屏幕最上部）。此时若是添加代码self.edgesForExtendedLayout = UIRectEdgeNone（iOS7.0以后方法）;self.view.frame.origin.y会下移64像素至navBar下方开始。

当 NavigationBar 的 translucent 为 YES时，计算是从最顶部0的位置开始的。使用 Masonry 自动布局时，为了使 view 不被 NavigationBar 遮挡住，需要使用 hard code 的方式加上 64 的距离，而这种方式对于有代码洁癖的程序员来说是绝对不能容忍的。有两种方式可以避免hard code。

1) 解决方案一：`self.edgesForExtendedLayout = UIRectEdgeNone;` 

这样就能使view的计算从导航栏的底部开始计算。
但是会引起另外一个问题，会导致 NavigationBar 的颜色变深，如下：

![正常的白色半透明的NavigationBar](http://os3yasu4i.bkt.clouddn.com/translucent-white-navigation-bar.png)

![异常的白色半透明的NavigationBar](http://os3yasu4i.bkt.clouddn.com/abnormal-white-navigation-bar.png)

设置 `translucent` 为 NO，可以避免该问题，但是就失去了导航栏半透明的特性。

> [Navigation bar stop being translucent when self.edgesForExtendedLayout = UIRectEdgeNone](https://stackoverflow.com/questions/19239606/navigation-bar-stop-being-translucent-when-self-edgesforextendedlayout-uirecte)
>
> Translucent means that the content under the bar can be seen through the translucency. By turning off the extended edges, the translucency is still there, simply you cannot see it because there's not content below.

2）解决方案二： `mas_topLayoutGuideBottom`

	 make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20.0f);
	 
`mas_topLayoutGuideBottom` 表示的就是 `UILayoutSupport` 中的 `bottomLayoutGuide` 是苹果为了约束自动布局透明或不透明导航栏变化时视图控制器的内容的垂直范围。也可以简单理解为 `mas_topLayoutGuideBottom`就是导航栏的底部。


UIScrollView 需要添加以下代码避免ScrollView顶到 NavigationBar 上边：

	self.automaticallyAdjustsScrollViewInsets = YES;

### UITextField 切换 security 时，字体变化的问题

[UITextField secureTextEntry toggle set incorrect font](https://stackoverflow.com/questions/35293379/uitextfield-securetextentry-toggle-set-incorrect-font)

![](http://os3yasu4i.bkt.clouddn.com/23154249035029m0.png)
![](http://os3yasu4i.bkt.clouddn.com/23154301089109m.png)

	textField.resignFirstResponder()
	textField.secureTextEntry = !self.textField.secureTextEntry
	textField.becomeFirstResponder()
	
	textfieldPassword.font = nil
	textfieldPassword.font = UIFont.systemFontOfSize(14.0)
	
### `secureTextEntry` 为YES时，首次编辑时会默认清空文本

	- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string
	{	
	    if (textField.secureTextEntry) { // `secureTextEntry` 为YES时，首次编辑时会默认清空文本
	        NSString *updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
	        textField.text          = updatedString;
	        [textField
	            sendActionsForControlEvents:UIControlEventEditingChanged]; // 手动触发事件，不然无法显示或隐藏清空按钮
	        return NO;
	    }
	    return YES;
	}

### 判断生日是否存在

	@property (nonatomic, assign) NSInteger birth;
	
判断生日是否存在，应该判断 `birth != 0`，而不是 `birth > 0`，因为 1970年1月1号 及之前的日期 时间戳为负数。

### NSJSONSerialization 解析时的坑

> 非标准JSON字符串会解析为nil

	NSString *s = @"access_token=w27ouz1s6s17lGU732NGo07DeBNk4X&apns_token=60501d8f1fc91152bbbf2e68ce9c2c8b4c6b889387e73f1b3a37db16dfb5d5ac&irv=2489783183&is_com=1&lang=zh_CN&sig=5b6cb9eb1ceafd290feb3b1338d9e72a&ts=1508826841&xea_app_ver=6.1.9&xea_channel=appstore&xea_net=wifi&xea_os=ios";
    NSData *d = [s dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    // 正确写法
	// NSString *j = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
	
	// 错误写法
    NSString *j = [NSJSONSerialization JSONObjectWithData:d options:0 error:&err];
    NSLog(@"%@",j);  // nil

### UISearchBar 的坑

自定义 UISearchBar 样式，代码如下：

```objective-c
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 15 - 60, 30);
        [_searchBar mzd_setBackgroundColor:[UIColor whiteColor]];
        _searchBar.barTintColor = [UIColor clearColor];
        _searchBar.backgroundColor = [MZDColor backgroundGrayColor];
        _searchBar.backgroundImage = [[UIImage alloc] init];
        [_searchBar mzd_setCornerRadius:15.0f];
        _searchBar.placeholder = @"搜索挖客用户昵称";
        _searchBar.delegate    = self;
        [_searchBar setTintColor:[MZDColor darkBarButtonItemColor]];
    }
    return _searchBar;
}
	
- (void)mzd_setBackgroundColor:(UIColor *)color {
    UIImage *searchBarBg = [self GetImageWithColor:color height:self.frame.size.height];
    [self setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
}
	
- (void)mzd_setCornerRadius:(CGFloat)radius {
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        searchField.layer.cornerRadius = radius;
        searchField.layer.masksToBounds = YES;
    }
}
	
- (void)mzd_setCancelButtonTitle:(NSString *)title {
    if ([UIDevice uponVersion:9.0]) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}
```

设置 UISearchBar 在 NavigationBar 上

```objective-c
- (void)animateSearchBar {
    if ([UIDevice uponVersion:11.0]) {
        MZDSearchBarContainerView *titleView = [[MZDSearchBarContainerView alloc] initWithCustomSearchBar:self.searchBar];
        titleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        self.navigationItem.titleView = titleView;
    } else {
        self.navigationItem.titleView = self.searchBar;
    }
}
```

UISearchBar 不为第一响应者的情况下显示取消按钮

```objective-c
self.searchBar.showsCancelButton = YES;
// UISearchBar 失去焦点时 enabled 属性为NO，需要手动设为YES
UIButton *cancelButton = [self.searchBar value	ForKey:@"cancelButton"];
cancelButton.enabled = YES;
[self hideBackBarButtonItem];
```


取消按钮的颜色

```objective-c
if ([UIDevice uponVersion:9.0]) {
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[MZDColor cancelBarButtonItemColor]];
}else {
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[MZDColor cancelBarButtonItemColor]];
}
```

设置字体大小

```objective-c
// 设置字体大小
[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{
    NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:20],
}];
```

移除动画

```
searchBar.becomeFirstResponder()
searchBar.removeLayerAnimationsRecursively()

extension UIView {
  func removeLayerAnimationsRecursively() {
    layer.removeAllAnimations()
    subviews.forEach { $0.removeLayerAnimationsRecursively() }
  }
}
```

icon和placeholder居左显示

```objective-c
- (void)setLeftPlaceholder {
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}
```

### UIAlertController 的坑

使用 UIAlertController 弹出 ActionSheet，添加一个 UIAlertAction，在 **iOS 8** 中 style 不能为 
`UIAlertActionStyleCancel`，否则会闪退！！！
解决方法：使用 `UIAlertActionStyleDestructive`

### UINavigationController返回手势失效问题

从iOS7开始，系统为UINavigationController提供了一个interactivePopGestureRecognizer用于右滑返回(pop),但是，如果自定了back button或者隐藏了navigationBar，该手势就失效了。

[UINavigationController返回手势失效问题](http://chisj.github.io/blog/2015/05/27/uinavigationcontrollerfan-hui-shou-shi-shi-xiao-wen-ti/)

### 获取相册 

PHFetchOptions *options = [[PHFetchOptions alloc] init];
options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];

导致闪退


	https://developer.apple.com/documentation/photos/phfetchoptions#//apple_ref/doc/uid/TP40014396
	
	
### 文件管理的坑

`stringByAppendingPathComponent` 会将 `file:///` 格式化为 `file:/`

`[[NSFileManager defaultManager] fileExistsAtPath:path]` 必须是 `file:///` 开头

`[UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];` 存文件的 path 不能带 `file:///` 头部。 

### 在一个ViewController上面盖另一个透明的ViewController

在一个 ViewController 上面盖另一个透明的 ViewController ，有2种实现方式：present 和 自定义转场。

1. Present 方式

	Present 一个 backgroundColor 为 clearColor 的 controller 即可，但是背景会变成黑色，解决方法是在 present 之前设置 `modalPresentationStyle` 和 `definesPresentationContext`。
	
	```
	UIViewController *presentedVC = [[UIViewController alloc] init];
	presentedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	presentedVC.definesPresentationContext = YES;
	```
	
	> 注意：是 Presented View Controller，而不是 Presenting View Controller，一定要在 present 出来之前设置上述2个属性，**在 viewDidLoad 中设置无效**。
	>
	> [Display clearColor UIViewController over UIViewController](https://stackoverflow.com/questions/11236367/display-clearcolor-uiviewcontroller-over-uiviewcontroller)

2. 自定义转场
	
	自定义转场时，除了设置 `modalPresentationStyle` 和 `definesPresentationContext` 之外，还需要设置 `backgroundColor` 为 `[UIColor clearColor]`，同样必须在 present 或 push 出来之前设置，**在 viewDidLoad 中设置无效**。
 

### CABasicAnimation 的坑

必须设置 `removedOnCompletion` 为 `NO`，否则执行完动画后会恢复原状。这时可能会出现各种奇怪的现象，比如闪一下（view被移除之前恢复原状，然后再被移除）。

> 注意：如果 转场动画(Transition) 中设置了 `removedOnCompletion` 为 `NO`，必须在动画执行完毕后手动移除animation，否则会导致内存泄漏。

## React-Native

["__nw_connection_get_connected_socket_block_invoke Connection has no connected handler" in logs](https://github.com/facebook/react-native/issues/10027)

打开 React-Native 页面，在控制台持续打印 `TCP Conn 0x1c036b880 Failed : error 0:61 [61]` 的错误信息，使用如下方法禁止打印。

1. Open Xcode.
2. Open Product menu.
3. Select Edit Scheme...
4. Add the following under Environment Variables:
5. Name: OS_ACTIVITY_MODE
6. Value: disable
7. Run your app again

## WKWebView 相关

如果服务端的Https证书是不合法的证书（比如自建的证书），那https请求在TLS握手过程的身份认证（证书校验）就会不通过导致请求失败。

解决办法是：使用服务端传过来的证书进行身份验证，而不是去权威机构验证证书。

```
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
    }
}
```

## TableView 相关

### iOS 11 中 UITableView Header Height

[iOS 11 Floating TableView Header](https://stackoverflow.com/questions/46246924/ios-11-floating-tableview-header)

在 iOS 11 中，如果同时设置了 `tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section` 和 `tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section`，需要如下设置：

	self.tableView.estimatedRowHeight = 0;
	self.tableView.estimatedSectionHeaderHeight = 0;
	self.tableView.estimatedSectionFooterHeight = 0;
	
### UITableView 的分割线没有显示

原因：自定义 UITableViewCell 重写了 layoutSubviews，但是没有调用 super 方法。

### reloadData 不会立即刷新

调用 `reloadData` 后，发现 `tableView:numberOfRowsInSection:`, `tableView:cellForRowAtIndexPath:` 等几个代理方法不会立即调用，而是在 `reloadData` 后面的代码会先执行。

比如：

```
- (void)reloadLikeMeData
{
    if (self.likeViewModel.needReloadData) {
        [self.tableView reloadData];
        self.likeViewModel.needReloadData = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *likeStateID = @"likeState_cell";
    FYLikeStateCell *likeStateCell = [tableView dequeueReusableCellWithIdentifier:likeStateID];
    if (likeStateCell == nil) {
        likeStateCell = [[FYLikeStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:likeStateID];
        likeStateCell.unreadCount = self.likeViewModel.unreadCount;
        likeStateCell.likeMeUsers = self.likeViewModel.likeMeUsers;
    } else {
        // 这里不会执行
        if (self.likeViewModel.needReloadData) { // 为了不频繁刷新界面
            likeStateCell.unreadCount = self.likeViewModel.unreadCount;
            likeStateCell.likeMeUsers = self.likeViewModel.likeMeUsers;
        }
    }
    return likeStateCell;
}
```

上面的代码 `self.likeViewModel.needReloadData = NO;` 会比 `tableView:cellForRowAtIndexPath:` 先执行，导致 `else` 的代码不会执行。

原因是：`reloadData` 是在下一个 runloop 才执行刷新界面的，所以，而当前方法中的函数是在runloop中串行排队执行的。只有当前方法不再占用runloop，[tableview reloaddata]才可以在下一个runloop中执行。

有2中方法可以解决。

方法1: `layoutIfNeeded` 会强制重绘并等待完成

```
[self.tableView reloadData];  
[self.tableView layoutIfNeeded];
//刷新完成  

self.likeViewModel.needReloadData = NO;
```

方法2: `reloadData` 会在主队列执行，而 `dispatch_get_main_queue` 会等待机会，直到主队列空闲才执行。

```
[self.collectionView reloadData];
dispatch_async(dispatch_get_main_queue(), ^{
    // 刷新完成
    self.likeViewModel.needReloadData = NO;
});
```