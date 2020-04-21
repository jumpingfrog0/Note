# iOS Code Snippets - Appcode

<!--
create time: 2020-04-21 17:44:00
Author: <黄东鸿>
-->

#### 1. lazy_getter

```
if (!_$VAR$$END$) {
    _$VAR$ = 
}
return _$VAR$;
```

#### 2. tp_button

```
@property (nonatomic, strong) UIButton *$END$Button;
```

#### 3. tp_image

```
@property (nonatomic, strong) UIImageView *$END$ImageView;
```

#### 4. tp_label

```
@property (nonatomic, strong) UILabel *$END$Label;
```

#### 5. tp_string

```
@property (nonatomic, copy) NSString *$END$;
```

#### 6. t_button

```
- (UIButton *)$VAR$$END$ {
    if (!_$VAR$) {
        _$VAR$ = [UIButton buttonWithType:UIButtonTypeCustom];
        _$VAR$.backgroundColor     = [UIColor whiteColor];
        _$VAR$.layer.masksToBounds = YES;
        _$VAR$.layer.cornerRadius  = $CONTEXT$;
        [_$VAR$ setTitle:@"" forState:UIControlStateNormal];
        [_$VAR$.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_$VAR$ setTitleColor:UIColorFromRGB(0x) forState:UIControlStateNormal];
        [_$VAR$ setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_$VAR$ addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _$VAR$;
}
```

#### 7. t_imageView

```
- (UIImageView *)$END$$VAR$ {
    if (!_$VAR$) {
        _$VAR$ = [[UIImageView alloc] init];
        _$VAR$.image = [UIImage imageNamed:@""];
        _$VAR$.contentMode = UIViewContentModeScaleAspectFill;
        _$VAR$.layer.masksToBounds = YES;
        _$VAR$.layer.cornerRadius = 28;
    }
    return _$VAR$;
}
```

#### 8. t_label

```
- (UILabel *)$VAR$$END$ {
    if (!_$VAR$) {
        _$VAR$ = [[UILabel alloc] init];
        _$VAR$.textAlignment = NSTextAlignmentLeft;
        _$VAR$.textColor = [UIColor whiteColor];
        _$VAR$.font = [UIFont systemFontOfSize:12];
    }
    return _$VAR$;
}
```

#### 9. t_table

```
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = 0.0;
        _tableView.estimatedSectionFooterHeight = 0.0;
        _tableView.estimatedSectionHeaderHeight = 0.0;
        _tableView.separatorColor = [MZDColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
```

#### 10. t_textfield

```
- (UITextField *)$VAR$ {
    if (!_$VAR$) {
        _$VAR$ =  [[UITextField alloc] init];
        _$VAR$.font = [UIFont systemFontOfSize:17];
        _$VAR$.textColor = UIColorFromRGB(0x);
    }
    return _$VAR$;
}
```

#### 11. tc_button

```
UIButton *$VAR$$END$Button = [UIButton buttonWithType:UIButtonTypeSystem];
[$VAR$Button setTitle:@"" forState:UIControlStateNormal];
[$VAR$Button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
[$VAR$Button setTitleColor:UIColorFromRGB(0x) forState:UIControlStateNormal];
[$VAR$Button addTarget:self action:@selector(handleWatchVideoAction:) forControlEvents:UIControlEventTouchUpInside];
```

#### 12. tc_imageView

```
UIImageView *$END$View = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
```

#### 13. tc_label

```
UILabel *$VAR$$END$Label = [[UILabel alloc] init];
$VAR$Label.textColor = UIColorFromRGB(0x);
$VAR$Label.font = [UIFont systemFontOfSize:20];
$VAR$Label.textAlignment = NSTextAlignmentCenter;
```

#### 14. t_singleton

```
+ (instancetype)sharedInstance {
    static $END$ *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
```

#### 15. t_setupNavBar

```
- (void)setupNavigationBar {
    self.navigationItem.title = @"$END$";
        @weakify(self);
    [self.navigationItem setupLeftBarButtonItem:[UIBarButtonItem plainBarButtonItemWithTitle:@"取消" handler:^(id sender) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }]];
}
```

#### 16. t_push

```
+ (void)pushInNavigationController:(UINavigationController *)navigationController {
    $TYPE$ *vc = [[$TYPE$ alloc] init];
    [navigationController pushViewController:vc animated:YES];
}
```

#### 17. t_load

```
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        $END$
    });
}
```

#### 18. t_initF

```
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        $END$
    }
    return self;
}
```

#### 20. t_init

```
- (instancetype)init {
    if (self = [super init]) {
        $END$
    }
    return self;
}
```

#### 21. t_delay

```
dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
dispatch_after(delayTime, dispatch_get_main_queue(), ^{
    $END$              
});
```

#### 22. t_dealloc

```
- (void)dealloc {
    NSLog(@"%@ -- dealloc", [self class]);
}
```

#### 23. t_controller_init

```
- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
```

#### 24. t_timer

```
- (void)addTimer {
    self.times = 7;
    self.$VAR$ = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    [self.$VAR$ invalidate];
    self.$VAR$ = nil;
}

- (void)countDown {
    if (self.times > 0) {
        
    } else {
        
    }
}
```

#### 25. t_ignore_selector

```
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    $EDN$
#pragma clang diagnostic pop
```

#### 26. tc_ontap

```
- (void)onTap:(UITapGestureRecognizer *)recognizer
{
    $END$
}
```

#### 27. tc_tap

```
UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
[$END$ addGestureRecognizer:recognizer];
```

#### 28. t_alert

```
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"$END$" message:@"" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
}]];
```