# node_env

### 安装nvm

[nvm](https://github.com/creationix/nvm) 是一个管理多版本 Node.js 的工具。

直接安装

	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
	
**推荐**使用 homebrew 安装

	brew install nvm
	
### 安装指定版本的node

	nvm install [nodeversion]
	
例如，需要安装 v6.9.1 版本的 Node.js，那可以通过以下命令完成。

	nvm install v6.9.1
	
使用 v6.9.1 版本的 Node.js

	nvm use v6.9.1

查看当前安装的 Node.js 版本列表

	nvm ls
	
删除指定版本的 Node.js

	nvm uninstall [nodeversion]
	
显示当前使用的 Node.js 版本

	nvm current