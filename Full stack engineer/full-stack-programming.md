Full Stack Programming
===========

## Shell

[Linux Shell脚本教程：30分钟玩转Shell脚本编程](http://c.biancheng.net/cpp/shell/)

[Shell 教程](http://www.runoob.com/linux/linux-shell.html)

## 脚本

### 批量删除新浪微博

	// 作者：无涯
	// 链接：https://www.zhihu.com/question/19808336/answer/70656422
	// 来源：知乎
	// 著作权归作者所有，转载请联系作者获得授权。
	// 你先到自己微博主页加载完你的微博 调出控制台粘进去敲回车就行
	
	var fEvent = function(element,event){
	  var evt = document.createEvent( 'HTMLEvents' );
	  evt.initEvent(event, true, true);  
	  return !element.dispatchEvent(evt);
	}
	var del = function (){
		var dropDown = document.getElementsByClassName("screen_box")[0];
		fEvent(dropDown.children[0],"click");
		var delBox = document.getElementsByClassName("layer_menu_list");
		var ul = delBox[1].children;
		var a = ul[0].children[0].children[0];
		fEvent(a,"click")
		var ok = document.getElementsByClassName("screen_box")[0].children[2].children[0].children[2].children[0];
		fEvent(ok,"click");
	}
	
	setInterval(function(){
		del();
	},1000);
	
	
### 正则表达式

[path to regexp](https://github.com/pillarjs/path-to-regexp)