# iOS 笔记

<!--
create time: 2018-01-17 21:14:28
Author: 黄东鸿
-->


iOS 音频播放 - AVAudioSession

| 会话类型 | 说明 | 是否要求输入 | 是否要求输出	| 是否遵从静音键 |
|:------- |:-------:| -------:|:-------:| -------:|
| AVAudioSessionCategoryAmbient | 混音播放，可以与其他音频应用同时播放 | 否 | 是 | 是 |
| AVAudioSessionCategorySoloAmbient| 独占播放（会终止其他应用声音） | 否 | 是 | 是 |
| AVAudioSessionCategoryPlayback | 后台播放，独占（会终止其他应用声音） | 否 | 是 | 否 |
| AVAudioSessionCategoryRecord | 录音模式 | 是 | 否 | 否 |
| AVAudioSessionCategoryPlayAndRecord | 播放和录音，此时可以录音也可以播放 | 是 | 是 | 否 |
| AVAudioSessionCategoryAudioProcessing | 硬件解码音频，此时不能播放和录制 | 否 | 否 | 否 |
| AVAudioSessionCategoryMultiRoute | 多种输入输出，例如可以耳机、USB设备同时播放 | 是 | 是 | 否 |

#### 企业包下载地址

```
itms-services://?action=download-manifest&url=https://staticsci.xiaoenai.com/beta/ios/wake_beta2.plist
```