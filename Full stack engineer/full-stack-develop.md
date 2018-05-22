Full Stack Develop
=======

------------------------------------------------------

### some configuration or error fixing

#### git ssh

[How to install a public key on your Bitbucket Cloud account](https://confluence.atlassian.com/bitbucket/how-to-install-a-public-key-on-your-bitbucket-cloud-account-276628835.html)

[Generating an SSH key](https://help.github.com/articles/generating-an-ssh-key/)

#### npm

[getting-started-guide](https://docs.npmjs.com/getting-started/what-is-npm)

[Fixing npm permissions](https://docs.npmjs.com/getting-started/fixing-npm-permissions)

[Error: EACCES, open '/Users/Profile/.npm/_locks/browser-sync-ed941186c435fb34.lock' ](https://github.com/npm/npm/issues/7407)

	Looks like you need sudo to run installs to /usr/local on your machine:

	`npm ERR! Please try running this command again as root/Administrator.`
	Give that a shot and see if it helps with the problem.
	
##### 修改npm的registry为淘宝的镜像

	npm config set registry https://registry.npm.taobao.org
	npm config set disturl https://npm.taobao.org/dist
	
[node.js 教程](http://www.runoob.com/nodejs/nodejs-web-module.html)

[json-server](https://www.npmjs.com/package/json-server)

https://github.com/localmed/api-mock

https://github.com/apiaryio/api-blueprint

https://apiblueprint.org/

blueprint是一个API documentation的规范和工具

## Java

Problem: No Java runtime present, requesting install.

Solution: manually download and install the official Java package for OS X, which is in [Java for OS X 2015-001](https://support.apple.com/kb/DL1572?locale=zh_CN)

