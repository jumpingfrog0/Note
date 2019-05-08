编码习惯
=================

#### 手势监听Selector

```
UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
[_rightItemView addGestureRecognizer:tap];

- (void)onTap:(UITapGestureRecognizer *)recognizer
{
}
```
	
	
链接：

[What is the best way to create constants in Objective-C](https://stackoverflow.com/questions/17228334/what-is-the-best-way-to-create-constants-in-objective-c)

