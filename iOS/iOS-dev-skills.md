# iOS开发技巧

### 场景1

有两个view，上下布局，view A 在上，view B 在下，当 view A 隐藏时，view B 向上移动。

解决办法：

```
要隐藏view A时，设置view A的高度为0即可，这样就不需要重新设置布局约束。
```

### 布局

	self.mas_topLayoutGuideBottom
	
#### Xcode9 storyboard update frame

	Cmd + option + =

### Block 语法

	@property(nonatomic, copy) void (^switchCoverBlock)(void);

### 引入高版本SDK

	/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/11.0 (15A5304f)

### 设置按钮不同状态背景色

### 设置按钮不同状态boderColor

### 按钮 system 和 custom 区别

### UITableView 奇淫技巧

	- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section

##### 设置分割线颜色

	[_tableView setSeparatorColor:[UIColor colorWithHex:@"bebebe"]];

##### 修改UITableView为空时样式

样式为 `UITableViewStylePlain` 的 UITableView 为空时，默认会有一些占位的行，想要阻止这个默认行为，展示空白，只需要设置 `footerView`:

	tableView.tableFooterView = [[UIView alloc] init];
	
##### UITableView 只在中间部分显示分割线，顶部和底部没有分割线

只需要设置 style 为 `UITableViewStylePlain`即可。
	
### NavigationBar 显示隐藏技巧

	- (void)viewWillAppear:(BOOL)animated
	{
	    [self.navigationController setNavigationBarHidden:YES animated:animated];
	    [super viewWillAppear:animated];
	}
	
	- (void)viewWillDisappear:(BOOL)animated {
	    [self.navigationController setNavigationBarHidden:NO animated:animated];
	    [super viewWillDisappear:animated];
	}
	
### 监听UITextField text changed

	UIControlEventEditingChanged
	
	self.codeField.text = nil;
	[textField sendActionsForControlEvents:UIControlEventEditingChanged]
	
### iOS 动画时间

push 动画时间：0.35 s

### iOS 橡皮筋效果公式

[Rubber-Banding formula](https://twitter.com/chpwn/status/285540192096497664)

	x = (1.0 - (1.0 / ((x * c / d) + 1.0))) * d
	
	where,
	x – distance from the edge
	c – constant (UIScrollView uses 0.55)
	d – dimension, either width or height

### UITextField 字数限制

```
[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

- (void)textFieldDidChange:(MZDTextField *)textField
{
    // 最多输入12位字符
    int kMaxLength = 12;
    NSString *toBeString = textField.text;
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制，有高亮选择的字符串，则暂不对文字进行统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
    }
    else{
        if (toBeString.length > kMaxLength) { // 表情之类的，中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}
```

### Disable ARC in specified file

1. Go to your project settings, under Build Phases > Compile Sources
2. Select the files you want ARC disabled and add `-fno-objc-arc` compiler flags. You can set flags for multiple files in one shot by selecting the files then hitting "Enter" key.


### iOS中 UIImagePickerController 中文界面问题

在使用UIImagePickerController的时候，选相片页面，拍照页面总是英文。要设置成中文的话，需要配置 `Info.plist` 文件。

 Target --> Info --> Localization native development region ： China
 
 
### NSDictionary set nil value

NSDictionary 设置 nil 值会导致奔溃，解决方法是：

```objective-c
static id ObjectOrNull(id object)
{
  return object ?: [NSNull null];
}
	
parameters:@{
  @"auth_token"         : ObjectOrNull(token),
  @"name"               : ObjectOrNull(drunk.name),
  @"date_started"       : ObjectOrNull(drunk.started_drinking),
  @"date_stopped"       : ObjectOrNull(drunk.stopped_drinking),
  @"prescribing_doctor" : ObjectOrNull(drunk.fat),
  @"pharmacy"           : ObjectOrNull(drunk.dumb),
}
```