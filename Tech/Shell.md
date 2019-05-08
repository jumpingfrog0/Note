Shell
====

### Style

![Shell 风格指南](https://zh-google-styleguide.readthedocs.io/en/latest/google-shell-styleguide/contents/)

* 文件头部: `#!/bin/bash`
* 调用: `$ bash <sript_name>`

##### 错误打印

> Tip:
> 所有的错误信息都应该被导向STDERR。

推荐使用类似如下函数，将错误信息和其他状态信息一起打印出来。

```
err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
    echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: \033[31m $1 \033[0m"
}

if ! do_something; then
    err "Unable to do_something"
    exit "${E_DID_NOTHING}"
fi
```

##### 源文件命名

> 小写，如果需要的话使用下划线分隔单词。

示例：`make_template.sh`

##### 函数名

> 使用小写字母，并用下划线分隔单词。使用双冒号 :: 分隔库。函数名之后必须有圆括号。关键词 function 是可选的，但必须在一个项目中保持一致。

```
# Single function
my_func() {
  ...
}

# Part of a package
mypackage::my_func() {
  ...
}
```

#### getopts

`$OPTARG : ` 若短选项后有参数，则 `$OPTARG` 指向该参数

`$OPTIND : ` 扫描选项时，标识下一个选项的索引；扫描结束后，标识第一个非选项参数索引

`$OPTERR : ` 出现不可识别的选项时，`$OPTERR` 将打印错误信息。将`$OPTERR`设为0，可不打印错误信息。

### 字符串

判断字符串长度是否为0

```
STRING=''
if [ -z "$STRING" ]; then 
	echo "STRING is empty" 
fi

if [ -n "$STRING" ]; then 
	echo "STRING is not empty" 
fi
```

### expr

> expr 最安全的使用方式：`if [[ $(expr 3 '+' 2) != 5 ]] `

expr 表达式返回的是"返回值"，不是"结果", 只要加法成功，返回值就是0

expr 表达式计算完后如何获得结果？—— 用 `$(expr  … )` 或反引号 

```
` expr  …`
```

因为 expr 在if语句里，不能用 `[ ]`，因为这里把它当作command, 

如果要进行结果判定，需要加 `$()`, 就必须用`[ ]`了,因为把它当作表达式了。

#### 模式匹配

expr 也有模式匹配功能。可以使用 expr 通过指定 `冒号选项` 计算字符串中字符数。

```
$ VALUE=account.doc
$ expr $VALUE : ‘.*’
$ 8
```
在expr中可以使用字符串匹配操作，这里使用模式抽取.doc文件附属名:

`
$ expr $VALUE : '/(.*/).doc'
accounts
`

	
#### 安装jq

	$ curl -s 'https://api.github.com/users/lambda' | jq -r '.name'

#### 重定向输入文件

```
cat > ${path}<<EOF
content...
EOF
```

### 输出颜色

shell 脚本中 `echo` 显示内容带颜色，需要使用参数 `-e`

格式如下：

```
echo -e "\033[41;36m something here \033[0m"
```

其中41的位置代表底色(背景色）， 36的位置是代表字的颜色

字颜色：30—–37

```
echo -e "\033[30m 黑色字 \033[0m" 
echo -e "\033[31m 红色字 \033[0m" 
echo -e "\033[32m 绿色字 \033[0m" 
echo -e "\033[33m 黄色字 \033[0m" 
echo -e "\033[34m 蓝色字 \033[0m" 
echo -e "\033[35m 紫色字 \033[0m" 
echo -e "\033[36m 天蓝字 \033[0m" 
echo -e "\033[37m 白色字 \033[0m"
```

字背景颜色范围：40—–47

```
echo -e "\033[40;37m 黑底白字 \033[0m" 
echo -e "\033[41;37m 红底白字 \033[0m" 
echo -e "\033[42;37m 绿底白字 \033[0m" 
echo -e "\033[43;37m 黄底白字 \033[0m" 
echo -e "\033[44;37m 蓝底白字 \033[0m" 
echo -e "\033[45;37m 紫底白字 \033[0m" 
echo -e "\033[46;37m 天蓝底白字 \033[0m" 
echo -e "\033[47;37m 白底白字 \033[0m"
```

末尾控制选项说明：

```
\33[0m 关闭所有属性 
\33[1m 设置高亮度 
\33[4m 下划线 
\33[5m 闪烁 
\33[7m 反显 
\33[8m 消隐 
\33[30m — \33[37m 设置前景色 
\33[40m — \33[47m 设置背景色 
\33[nA 光标上移n行 
\33[nB 光标下移n行 
\33[nC 光标右移n行 
\33[nD 光标左移n行 
\33[y;xH设置光标位置 
\33[2J 清屏 
\33[K 清除从光标到行尾的内容 
\33[s 保存光标位置 
\33[u 恢复光标位置 
\33[?25l 隐藏光标 
\33[?25h 显示光标
```