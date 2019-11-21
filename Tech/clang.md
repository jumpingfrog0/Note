# clang

<!--
create time: 2019-02-02 00:12:48
Author: <黄东鸿>
-->

### 编译

```
$ clang -g -O2 -o filename filename.c -I . -L . -l libname
```

* `-g` : 输出文件中的调试信息
* `-O` : 对输出文件做指令优化，默认是-O1
* `-o` : 输出文件
* `-I` : 指定头文件
* `-L` : 指定库文件位置
* `-l` : 指定使用哪个库
* `-c` : 生成编译的中间文件(.o文件)
* `.` : 当前目录

编译过程

* 预编译
* 编译
* 链接，动态链接/静态链接

生成静态库

`libtool -static -o libmylib.a add.o`

#### 编译 .c 文件

```
$ clang -g -o filename filename.c -l libname
$ clang -g -o ffmpeg_test ffmpeg_test.c -lavutil
```
pkg-config

```
clang -g -o list ffmpeg_list.c `pkg-config --libs libavformat libavutil`
```

### 调试器原理

* 编译输出带调试信息的程序
* 调试信息包含：指令地址、对应源代码及行号
* 指令完成后，回调

### lldb

使用lldb调试:

```
$ lldb testlib
```

* `b` : breakpoint, 设置断点
* `r` : run, 运行程序
* `n` : next, 单步执行到下一个语句
* `s` : step, 跳入函数
* `finish` : 跳出函数
* `p` : print, 打印内容
* `break list` : 查看所有断点
* `l` : list, 查看当前断点下的代码
* `c` : continue, 继续执行下去到达下一个断点
* `quit` : 退出调试

使用lldb调试后会生成一个 `testlib.dSYM`, 在 `testlib.dSYM/Contents/Resources/DWARF`目录下有一个 testlib 文件，这是一个为调试器所使用的带有调试信息的文件

```
$ dwarfdump testlib
```