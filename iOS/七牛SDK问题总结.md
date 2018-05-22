# 七牛SDK问题总结

<!--
create time: 2017-11-24 20:14:04
Author: <TODO: 请写上你的名字>

This file is created by Marboo<http://marboo.io> template file $MARBOO_HOME/.media/starts/default.md
本文件由 Marboo<http://marboo.io> 模板文件 $MARBOO_HOME/.media/starts/default.md 创建
-->

## PLPlayerKit 七牛视频播放SDK

[PLPlayerKit](https://github.com/pili-engineering/PLPlayerKit/) -Xcode 8打包的灰度包 v3.0.2

* 本地系统视频暂不支持，沙盒内支持播放 [#issue 293](https://github.com/pili-engineering/PLPlayerKit/issues/293)

## PLShortVideoKit 七牛短视频SDK

[PLShortVideoKit](https://github.com/pili-engineering/PLShortVideoKit) - Xcode8 打包的灰度包 （七牛Pod使用的是Xcode9打包的，在Xcode8不能编译通过）

* 依赖 Qiniu SDK，`pod "Qiniu", "~> 7.1"`
* 需要在 `Linked Frameworks and Libraries` 中手动引入 `libMuseProcessor.a` 和 `PLShortVideoKit.framework`