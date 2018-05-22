Shell
====

#### 文件头部

	#!/bin/bash

#### getopts

`$OPTARG : ` 若短选项后有参数，则 `$OPTARG` 指向该参数

`$OPTIND : ` 扫描选项时，标识下一个选项的索引；扫描结束后，标识第一个非选项参数索引

`$OPTERR : ` 出现不可识别的选项时，`$OPTERR` 将打印错误信息。将`$OPTERR`设为0，可不打印错误信息。

#### 判断字符串是否为空

	STRING=''

	if [ -z "$STRING" ]; then 
	    echo "STRING is empty" 
	fi
	
	if [ -n "$STRING" ]; then 
	    echo "STRING is not empty" 
	fi
	
#### 安装jq

	$ curl -s 'https://api.github.com/users/lambda' | jq -r '.name'