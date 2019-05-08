# FuckingErrors

<!--
create time: 2019-01-20 23:05:52
Author: <黄东鸿>
-->

### 安装 nginx rtmp 流媒体服务

```
$ brew tap denji/nginx
$ brew install nginx-full --with-rtmp-module --with-debug
```

> 注意：使用 `brew tap denji/nginx` 代替 `brew tap homebrew/nginx`, 因为会报下面的错误:
> homebrew/nginx was deprecated. This tap is now empty as all its formulae were migrated.

报错:

```
Error: Xcode alone is not sufficient on High Sierra.
Install the Command Line Tools:
  xcode-select --install
```

运行 `xcode-select --install` 安装必要的软件

### 安装 ffmpeg 和 ffplay

安装 ffmpeg 默认不会安装 ffplay，如果已经安装了 ffmpeg，需要先把 ffmpeg 卸载干净，再重新安装

```
$ brew uninstall ffmpeg
```

同时安装 ffmpeg 和 sdl2

```
$ brew install ffmpeg --with-sdl2
```