Theme
=====

## 原生终端（Terminal）和 Vim 配色

Terminal的流行的两种配色主题：[Solarized](https://github.com/altercation/solarized) 和 [tomorrow-theme](https://github.com/chriskempson/tomorrow-theme)

##### 安装方法：

在github上下载，打开后缀名为`.terminal`的文件，然后在`Preference`上选择对应的主题即可。

同时，这两种主题还支持 `Vim` 和其他编辑器，最好`terminal` 和 `vim` 都是用同一种主题

`Vim`还有比较好的一种配色主题：[monokai](https://github.com/sickill/vim-monokai)

##### Vim 配色

	$ cd solarized
	$ cd vim-colors-solarized/colors
	$ mkdir -p ~/.vim/colors
	$ cp solarized.vim ~/.vim/colors/
	
	$ vi ~/.vimrc
	syntax enable
	set background=dark
	colorscheme solarized
	
虽然在 `terminal` 上配置了主题，但是 `ls` 命令不会高亮，如果不挑剔的话可以进行简单的配置，在 `.bash_profile` 输出 `CLICOLOR=1` 即可。

	$ vi ~/.bash_profile
	export CLICOLOR=1


refer to:

[在 Mac OS X 终端里使用 Solarized 配色方案](http://www.vpsee.com/2013/09/use-the-solarized-color-theme-on-mac-os-x-terminal/)


#### Black screen

[black-screen](https://github.com/shockone/black-screen)

## Sublime Text3 使用技巧

* 安装Package Control

	[Package Controll installation](https://packagecontrol.io/installation#st3)

	
		import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
		
* [如何优雅地使用Sublime Text3](http://www.jianshu.com/p/3cb5c6f2421c)
* install plugins: type in `package control` with `install package` and then search keyword.



## Sublime Text3 插件

* Javascript Completions : JS 智能提示
* SublimeREPL : 这可能是对程序员很有用的插件。SublimeREPL 允许你在 Sublime Text 中运行各种语言（NodeJS ， Python，Ruby， Scala 和 Haskell 等等）

## App Code 

* Material Theme UI
	* Colors & Fonts: Material Default
* Material Theme UI EAP


## 字体

[powerline](https://github.com/powerline/fonts)

安装好字体后，在 Perference 修改字体即可。

## ZSH 主题

```vim
# vim ~/.zshrc

ZSH_THEME="pygmalion"
```

输出当前主题

```shell
$ echo $ZSH_THEME
```

设置 Colors Presets:

Perference --> Profiles --> Colors --> Colors Presets --> `Solarized Dark`

设置透明度

Perference --> Profiles --> Windows --> Transparency