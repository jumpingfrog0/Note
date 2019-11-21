Shell
====

### Style

[Shell 风格指南](https://zh-google-styleguide.readthedocs.io/en/latest/google-shell-styleguide/contents/)

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

##### if/for/while

```
if [[ ${#line} -eq 0 ]]; then
		echo "blank line"
	else
		echo "xxx"
	fi
```

```
for(( k=0;k<${#dir_array[@]};k++)) 
do
  xxx
done

for line in $(cat ${config_file})
	do
		echo ${line}
		if [[ ${#line} -eq 0 ]]; then
			echo "blank line"
		else
			dir_array[${dir_line_count}]=${line}
		fi
		dir_line_count=$[ ${dir_line_count} + 1 ]
	done
```

### getopts

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

#### 取文件名和目录名的一些方法

[Linux shell 之 提取文件名和目录名的一些方法](https://blog.csdn.net/ljianhui/article/details/43128465)

##### 1. ${var##*/} 

该命令的作用是去掉变量var从左边算起的最后一个'/'字符及其左边的内容，返回从左边算起的最后一个'/'（不含该字符）的右边的内容。

```
$ var=/dir1/dir2/file.txt
$ echo ${var##*/}
file.txt
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

## sed

### 1. sed介绍

执行文本替换的正确程序应该是 sed----流编辑器。

sed 的设计就是用来批处理而不是交互的方式编辑文件。当要做好几个变化的时候，不管是对一个还是对数个文件，比较简单的方式就是将这些变更部分写到一个编辑的脚本里，再将此脚本应用到所有必须修改的文件，sed 的存在目的就在这里。

sed可删除(delete)、改变(change)、添加(append)、插入(insert)、合、交换文件中的资料行,或读入其它的资料到文件中,也可替换(substuite)它们其中的字串、或转换(tranfer)其中的字母等等。例如将文件中的连续空白行删成一行、"local"字串替换成"remote"、"t"字母转换成"T"、将第10行资料与第11资料合等。

总合上述所言,当sed由标准输入读入一行资料并放入pattern space时,sed依照sed script 的编辑指令逐一对pattern space内的资料执行编辑,之後,再由pattern space内的结果送到标准输出,接着再将下一行资料读入.如此重执行上述动作,直至读完所有资料行为止。

小结,记住:
* (1)sed总是以行对输入进行处理
* (2)sed处理的不是原文件而是原文件的拷贝

主要参数：

* -e：执行命令行中的指令，例如：sed -e 'command' file(s)
* -f：执行一个 sed 脚本文件中的指令，例如： sed -f scriptfile file(s)
* -i：与-e的区别在于：当使用-e 时，sed 执行指令并不会修改原输入文件的内容，只会显示在 bash 中，而使用-i 选项时，sed 执行的指令会直接修改原输入文件。
* -n：读取下一行到 pattern space。

#### sed 命令

##### N 命令

把下一行的内容纳入当前缓冲区做匹配。

N是将后面一行填补到当前的模式空间一并处理，这样就包含了换行符，从而可以对换行符进行替换操作。

##### label

label的作用类似C语言中的goto，先定义一个标签，然后在其他地方可以goto到标签代码的地方重新执行；

```

# sed -e '1,${
# 	/instanceF/d; 
# 	/MELaunchTimeCostReport/d
# 		}' ${target_file}

# sed -n '1,${
# 	:label;
# 	N;
# 	$!b label;
# 	/^\+ \(.*\)me_.*\}/p
# 	}' ${target_file}

# sed -n '1,${
# 	:label;
#  	N;
#  	$!b label;
# 	/^\+ \(.*\)\w+\n\{\n\t\w+./p;
# 	/^\- \(.*\)me_.*/p;
# 	}' ${target_file}

# sed -i '/^- \(.*\)/{
#             :tag1;
#             N;
#             /{$/!b tag1;
#             a\ '"$injected_content"'
#         }' ${file}
```

删除文件行首的空白字符 http://www.jb51.net/article/57972.htm

for line in $(cat $cfg_injected_content | sed 's/^[ \t]*//g')

## awk

* `$0` : 当前记录（这个变量中存放着整个行的内容）
* `$1~$n` : 当前记录的第n个字段，字段间由FS分隔
* `FS` : 输入字段分隔符 默认是空格或Tab
* `NF` : 当前记录中的字段个数，就是有多少列
* `NR` : 已经读出的记录数，就是行号，从1开始，如果有多个文件话，这个值也是不断累加中。
* `FNR` : 当前记录数，与NR不同的是，这个值会是各个文件自己的行号
* `RS` : 输入的记录分隔符， 默认为换行符
* `OFS` : 输出字段分隔符， 默认也是空格
* `ORS` : 输出的记录分隔符，默认为换行符
* `FILENAME` : 当前输入文件的名字

去掉  @2x, @3x 后缀

```
image_name=$(echo "${image_name}" | awk '{sub(/@(2|3)x/, ""); print}')
```

去重第一列重复的行：

```
# 去重
    cat ${output} | awk '!a[$1]++{print}' > tmp && mv tmp ${output}
```

对齐

```
awk '{
    printf "%-50s%-50s\n", $1, $2
}' ${output} > tmp && mv tmp ${output}
```

awk 结果赋值给shell数组

```
# 这种写法会忽略空行
array=( $(awk -F ' ' '{ print $NF }' log filename) )
```

```
array=()
awk -F ' ' '{ print $NF }' log filename | while IFS= read -r line; do
    array+=( "$line" )
done
echo ${#array[@]}
echo ${array[1]}
echo ${array[17]}
```

## 正则表达式

* `^` 表示一行的开头。如：`/^#/` 以#开头的匹配。
* `$` 表示一行的结尾。如：`/}$/` 以}结尾的匹配。
* `\<` 表示词首。 如：`\<abc` 表示以 abc 为首的詞。
* `\>` 表示词尾。 如：`abc\>` 表示以 abc 結尾的詞。
* `.` 表示任何单个字符。
* `*` 表示某个字符出现了0次或多次。
* `[ ]` 字符集合。 如：`[abc]` 表示匹配a或b或c，还有 `[a-zA-Z]` 表示匹配所有的26个字符。如果其中有`^`表示反，如 `[^a]` 表示非a的字符

