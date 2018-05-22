Harpjs
======

> The static web server with built-in preprocessing.

[Harp](http://harpjs.com/) serves Jade, Markdown, EJS, CoffeeScript, Sass, LESS and Stylus as HTML, CSS & JavaScript—no configuration necessary.

[Install Harp](http://harpjs.com/docs/environment/install)

### 安装Harp出错


```
$ npm ERR! Darwin 13.4.0
$ npm ERR! argv "node" "/usr/local/bin/npm" "install" "-g" "harp"
$ npm ERR! node v0.12.2
$ npm ERR! npm  v2.7.4
$ npm ERR! code ETIMEDOUT
$ npm ERR! errno ETIMEDOUT
$ npm ERR! syscall connect

$ npm ERR! network connect ETIMEDOUT
$ npm ERR! network This is most likely not a problem with npm itself
$ npm ERR! network and is related to network connectivity.
$ npm ERR! network In most cases you are behind a proxy or have bad network settings.
$ npm ERR! network
$ npm ERR! network If you are behind a proxy, please make sure that the
$ npm ERR! network 'proxy' config is set properly.  See: 'npm help config'

$ npm ERR! Please include the following file with any support request:
$ npm ERR!    /Users/paul/npm-debug.log
```

#### 解决办法

* 删除npmrc文件。
* 使用镜像（三种办法任意一种都能解决问题，建议使用第三种，将配置写死，下次用的时候配置还在）
	* 通过config命令

	```
	$ npm config set registry http://registry.cnpmjs.org
	$ npm info underscore 
	```
	
	如果上面配置正确这个命令会有字符串response）

	* 命令行指定

	```
	$ npm --registry http://registry.cnpmjs.org info underscore
	```

	* 编辑 `~/.npmrc` , 加入下面内容

	```
	registry = http://registry.cnpmjs.org
	```

### 生成静态网页

编译目录下的文件

	$ sudo harp compile _harp/ /Library/WebServer/Documents/

使用apache访问静态网页

	$ mac start apache
    $ sudo apachectl