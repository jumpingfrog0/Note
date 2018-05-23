# python

## python 技巧

一个模块被另一个程序第一次引入时，其主程序将运行。如果我们想在模块被引入时，模块中的某一程序块不执行，我们可以用__name__属性来使该程序块仅在该模块自身运行时执行。

	#!/usr/bin/python3
	# Filename: using_name.py
	
	if __name__ == '__main__':
	   print('程序自身在运行')
	else:
	   print('我来自另一模块')

运行输出如下：

	$ python3 using_name.py
	程序自身在运行
	
	$ python3
	>>> import using_name
	我来自另一模块
	>>>

### 字符串格式化

'!a' (使用 ascii()), '!s' (使用 str()) 和 '!r' (使用 repr()) 可以用于在格式化某个值之前对其进行转化:

	>>> import math
	>>> print('常量 PI 的值近似为： {}。'.format(math.pi))
	常量 PI 的值近似为： 3.141592653589793。
	>>> print('常量 PI 的值近似为： {!r}。'.format(math.pi))
	常量 PI 的值近似为： 3.141592653589793。

## python 工具

### 安装pip

```
$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
$ sudo python get-pip.py
```
	
### pip3 的使用

安装

	pip3 install [package]
	
卸载

	pip3 unstall [package]
	
指定版本安装

	pip3 install package==version
	
指定 git repo branch 安装

	pip3 install git+https://github.com/tangentlabs/django-oscar-paypal.git@issue/34/oscar-0.6
