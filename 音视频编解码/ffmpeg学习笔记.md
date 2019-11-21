# ffmpeg学习笔记

<!--
create time: 2019-11-19 21:20:48
Author: <TODO: 请写上你的名字>

This file is created by Marboo<http://marboo.io> template file $MARBOO_HOME/.media/starts/default.md
本文件由 Marboo<http://marboo.io> 模板文件 $MARBOO_HOME/.media/starts/default.md 创建
-->

#### 名词解释

Demux: 解复用（解封装），音视频是经过RTP封装的，接收到RTP数据流后，首先要去掉RTP协议的头和分隔符等，得到裸流（纯音视频数据）
Mux: 封装（转换成MP4等视频格式）

#### 保留网络视频到本地

![](./images/ffmpeg入门学习/保存网络视频到本地基本流程.png)