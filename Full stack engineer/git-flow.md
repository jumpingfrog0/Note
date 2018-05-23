# Git Flow

<!-- create time: 2015-08-18 17:38:29  -->

Git flow steps:
```shell
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Summary of changes)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop
```

## Table Of Contents

<!-- vim-markdown-toc GFM -->

* [Git Flow 相关文章](#git-flow-相关文章)
* [Git Help & Tutorial](#git-help--tutorial)
	* [Help](#help)
	* [Tutorials](#tutorials)
	* [Extension](#extension)
	* [SSH](#ssh)
	* [Configuration](#configuration)
	* [Push to new repo](#push-to-new-repo)
	* [分支操作](#分支操作)
	* [Commit 相关](#commit-相关)
	* [重写历史](#重写历史)
	* [Tag](#tag)
	* [从Git移除文件夹/文件](#从git移除文件夹文件)
	* [Fork 相关](#fork-相关)
	* [Log](#log)
	* [Git Problem](#git-problem)
	* [Other](#other)

<!-- vim-markdown-toc -->

## Git Flow 相关文章

[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/) -- git flow 经典文章

[git-flow 备忘清单](http://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html)

[gitflow](https://github.com/nvie/gitflow)

[gitflow install in windows](https://github.com/nvie/gitflow/wiki/Windows)

[gitflow getting started](http://yakiloo.com/getting-started-git-flow/)

[feature branch with single commit merged using fast-forward](https://github.com/nvie/gitflow/issues/292)

[Using git-flow to automate your git branching workflow](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/)


## Git Help & Tutorial

### Help

[GitHub Help](https://help.github.com/)

[Git Document -- git-scm](https://git-scm.com/book/tr/v2)

[gitignore collection](https://github.com/github/gitignore)

### Tutorials

[Git tutorials](https://www.atlassian.com/git/tutorials/undoing-changes)

[Git Community Book 中文版](http://gitbook.liuhui998.com/4_9.html)

[Git-简易指南](http://www.bootcss.com/p/git-guide/)

### Extension

[git-lfs](https://git-lfs.github.com/) -- Git Large File Storage(LFS): An open source Git extension for versioning large files.


### SSH

[GitHub -- Multiple SSH Keys settings for different github account](https://gist.github.com/jexchan/2351996)

[Bitbucket -- Configure multiple SSH identities for GitBash, Mac OSX, & Linux](https://confluence.atlassian.com/bitbucket/configure-multiple-ssh-identities-for-gitbash-mac-osx-linux-271943168.html)

[Generating a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

**生成SSH key**

	ssh-keygen -t rsa -C "jumpingfrog0@gmail.com"
	cat ~/.ssh/id_rsa.pub
	cat ~/.ssh/id_rsa.pub | pbcopy

**测试连接**

	## github
	ssh-add ~/.ssh/id_rsa_jumpingfrog0
	ssh -T git@github.com
	ssh-add -l
	
	## gitlab
	ssh -T git@gitlab.com
	
**.ssh/config**
	
	# https://gist.github.com/jexchan/2351996
	# Github - jumpingfrog0
	Host jumpingfrog0.github.com  # 前缀名可以任意设置
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa_jumpingfrog0
	
	# bitbucket - jumpingfrog0
	Host jumpingfrog0.bitbucket.org
	HostName bitbucket.org
	User git
	IdentityFile ~/.ssh/id_rsa_bitbucket_jumpingfrog0
	
	# gitlab - donghong.huang@enai.im
	host gitlab.xiaoenai.net
	hostname 106.75.96.131
	port 28290

### Configuration

**设置用户名和邮箱**

	git config user.name "username"
	git config user.email "example@gmail.com"
	
	git config --global user.name "username"
	git config --global user.email "example@gmail.com"
	
	## 参数
	-- list 列出当前配置
	-- global 设置全局配置
	-- local 设置当前仓库配置

**关联远程仓库**

	$ git remote add origin git@git.coding.net:jumpingfrog0/git-test.git

**重置远程仓库地址**

    $ git remote set-url origin https://sheldon517@bitbucket.org/517/ios-driver.git
	
### Push to new repo

	git remote add origin ssh://git@bitbucket.org/517/kankan-backend.git
	git push -u origin master

### 分支操作

**删除分支**

	# 删除远程分支
	$ git push origin :feature/2.0.1
	
	# 删除本地分支
	$ git branch -D <branchName>

**Checkout 远程分支**
    
    git chekcout -b <newBranch> origin/<newBranch>
    
**Rename branch**

	$ git branch -m <oldname> <newname>

	#If you want to rename the current branch, you can simply do:
	$ git branch -m <newname>
	
**让已经失效的远程 branch-name 在执行 git branch -a 的时候不再展示**

	git fetch -p
	
**把当前分支同步为远程分支的状态**

[master branch and 'origin/master' have diverged, how to 'undiverge' branches'?](http://stackoverflow.com/questions/2452226/master-branch-and-origin-master-have-diverged-how-to-undiverge-branches)

	git reset --hard origin/master
    
### Commit 相关

**重写commit的comment**

	git commit --amend
	
**scard all changes**

[git undo all uncommitted changes](http://stackoverflow.com/questions/14075581/git-undo-all-uncommitted-changes)

[undoing changes](https://www.atlassian.com/git/tutorials/undoing-changes)

    git reset
    git checkout .
    git clean -fdx
    git clean -f -f -dx
    
    git checkout -- file_path
    git checkout -- ./

**Discard unstaged files**

[discard unstaged files](http://stackoverflow.com/questions/52704/how-do-you-discard-unstaged-changes-in-git)

	git stash save --keep-index
	
- 从当前工作区中移除未追踪的文件

	git clean -f
	
- 从当前工作区中移除未追踪的文件和目录。
	git clean -df
	
- 从当前工作区中移除未追踪的文件，包括Git忽略的文件。
	git clean -xf	
	
**回滚最近一次commit**

	git reset --soft HEAD^
	git reset —hard HEAD
	
**删除所有commit**

	git update-ref -d HEAD
	git reset --hard
	
**Merge multiple commits**

[How can I merge two commits into one?](http://stackoverflow.com/questions/2563632/how-can-i-merge-two-commits-into-one)

	git rebase -i <sha1>

**解决冲突**

	# 这个是直接采用对方的文件
	$ git checkout --theirs -- path/to/conflicted-file.txt
	
	# 这个是采用我们的文件
	$ git checkout --ours -- path/to/conflicted-file.txt

### 重写历史

[Git 工具 - 重写历史](https://git-scm.com/book/zh/v1/Git-%E5%B7%A5%E5%85%B7-%E9%87%8D%E5%86%99%E5%8E%86%E5%8F%B2)

**git rebase**

	# rebase 所有commit
	git rebase --root -i
	
	# 基于某个commit开始进行rebase
	git rebase -i <sha1>

**fatal: refusing to merge unrelated histories**

[Git refusing to merge unrelated histories](http://stackoverflow.com/questions/37937984/git-refusing-to-merge-unrelated-histories)

	git pull origin master --allow-unrelated-histories
	
**Git change commit user**

[Change commit author at one specific commit](https://stackoverflow.com/questions/3042437/change-commit-author-at-one-specific-commit)

	git commit --amend --author="Author Name <email@address.com>"
	
For example, if your commit history is A-B-C-D-E-F with F as HEAD, and you want to change the author of C and D, then you would...

1. Specify git rebase -i B
2. change the lines for both C and D to edit
3. Once the rebase started, it would first pause at C
4. You would git commit --amend --author="Author Name <email@address.com>"
5. Then git rebase --continue
6. It would pause again at D
7. Then you would git commit --amend --author="Author Name <email@address.com>" again
8. git rebase --continue
9. The rebase would complete.

	
### Tag

**新建tag**

	git tag -a v1.0.0 -m "Relase version 1.0.0"
	
**把本地tag推送到远程**

	git push --tags
	
**删除tag**

- 删除远程tag

	git push origin :refs/tags/v1.0.0
	
- 删除本地tag
	
	git tag -d v1.0.0

**显示tag**

	git show v1.0.0
	git tag -l
	
### 从Git移除文件夹/文件
	 
[How to remove a directory in my GitHub repository?](http://stackoverflow.com/questions/6313126/how-to-remove-a-directory-in-my-github-repository)
	 
**Remove directory from git and local**
	 
	$ git rm -r one-of-the-directories
	$ git commit -m "Remove duplicated directory"
	$ git push origin <your-git-branch>
	
**Remove directory from git but NOT local**

	$ git rm -r --cached myFolder
	
### Fork 相关

**更新Fork的仓库的最新代码**

1. clone 自己的仓库到本地

```shell
$ git clone <YOU-FOR>
```

2. 添加upstream

```shell
# 添加一个叫upstream的remote
$ git remote add upstream git://github.com/ORIGINAL-DEV-USERNAME/REPO-YOU-FORKED-FROM.git
# 然后fetch
$ git fetch upstream
```
	
3. 从upstream中拉取最新的代码

```shell
# pull最新的代码到你的主分支中
$ git pull upstream master
```

### Log

**一行显示某个分支的所有commit**

	$ git log --pretty=oneline  master
	
**显示某个commit的详细log**

	$ git cat-file -p 9585191f37f7b0fb9444f35a9bf50de191beadc2
	
**显示当前分支的所有commit**

	$ git log --graph --pretty = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
	
**显示所有分支的所有commit**

	$ git log --graph --pretty = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all
	
**显示暂存区中哪些文件被修改了**

	$ git diff --name-only --cached
	
参数：

* `--diff-filter` ：选择某种操作的文件，Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R),changed (T), Unmerged (U), Unknown (X), Broken (B), * (All-or-none)。

* `--diff-filter=ad` : 则表示过滤除了添加和删除的文件。

### Git Problem

**error: There was a problem with the editor 'vi'**

	$ git config --global core.editor /usr/bin/vim

### Other

**习惯设置**

> push.default默认值在 Git 2.0 已从 'matching'变更为 'simple'。
> 若要不再显示本信息并保持传统习惯，进行如下设置：
> 
> git config --global push.default matching
> 
> 若要不再显示本信息并从现在开始采用新的使用习惯，设置：
>  git config --global push.default simple
>
> 当 push.default 设置为 'matching' 后，git 将推送和远程同名的所有本地分支。
>
> 从 Git 2.0 开始，Git 默认采用更为保守的 'simple' 模式，只推送当前
> 分支到远程关联的同名分支，即 'git push' 推送当前分支。
>
> 参见 'git help config' 并查找 'push.default' 以获取更多信息。
>（'simple' 模式由 Git 1.7.11 版本引入。如果您有时要使用老版本的 Git，
> 为保持兼容，请用 'current' 代替 'simple'）

**detached HEAD**

[How can I reconcile detached HEAD with master/origin?](http://stackoverflow.com/questions/5772192/how-can-i-reconcile-detached-head-with-master-origin)

	git symbolic-ref HEAD
	git rev-parse refs/heads/master
	git rev-parse HEAD

**HEAD^ vs HEAD~**

[What's the difference between HEAD^ and HEAD~ in Git?](http://stackoverflow.com/questions/2221658/whats-the-difference-between-head-and-head-in-git)

**Revert multiple git commit**

[Revert multiple git commits](http://stackoverflow.com/questions/1463340/revert-multiple-git-commits)
