iOS Production
==============

[itunesconnect](https://itunesconnect.apple.com)

### App Icon

路径：[Documentation and API Reference] --> [Browse guides and sample code] --> User Experience --> Guides --> App Icons on iPhone, iPad and App Watch

![](http://os3yasu4i.bkt.clouddn.com/app_icon.png)


### iPhone 和 iPad 各个屏幕的尺寸

|      unit       | iPhone4 |     iPhone5     |     iPhone6      |     iPhone6+     |              iPad               | iPad Retina  |   iPad Pro   |
| :-------------: | :-----: | :-------------: | :--------------: | :--------------: | :-----------------------------: | :----------: | :----------: |
|  Display Size   |   in    |     3.5 in      |       4 in       |      4.7 in      |             5.5 in              |              |              |
|      ratio      |         |   3 : 2 (1.5)   |  16 : 9 (1.77)   |  16 : 9 (1.77)   |          16 : 9 (1.77)          | 4 : 3 (1.33) | 4 : 3 (1.33) |
|   Screen Size   |  point  |    320 x 480    |    320 x 568     |    375 x 667     |            414 x 736            |  768 x 1024  |  768 x 1024  |
| Rendered Pixels |  pixel  | 640 x 960 (@2x) | 640 x 1136 (@2x) | 750 x 1334 (@2x) |        1242 x 2208 (@2x)        |  768 x 1024  | 1536 x 2048  |
| Physical Pixels |  pixel  |    640 x 960    |    640 x 1136    |    750 x 1334    | 1080 x 1920 (downsampling/1.15) |  768 x 1024  | 1536 x 2048  |


* iPad Retina [4:3 or 1.33]: Displayed as-is to fit the 2048x1536 screen size.
* iPad Non-Retina [4:3 or 1.33]: Aspect fill will scale a 2048x1536 playable area by 0.5 to fit the 1024x768 screen size.
* iPhone 4S [3:2 or 1.5]: Aspect fill will scale a 2048x1366 playable area by 0.47 to fit the 960x640 screen size.
* iPhone 5 [16:9 or 1.77]: Aspect fill will scale a 2048x1152 playable area by 0.56 to fit the 1136x640 screen size.
* iPhone 6 [16:9 or 1.77]: Aspect fill will scale a 2048x1152 playable area by 0.65 to fit the 1334x750 screen size.
* iPhone 6 Plus [16:9 or 1.77]: Aspect fill will scale a 2048x1152 playable area by 0.93 to fit the 1920x1080 screen size.

### 上架时提供的预览图片尺寸（都是要@2x的）

[iTunes Connect Properties](https://developer.apple.com/library/ios/documentation/LanguagesUtilities/Conceptual/iTunesConnect_Guide/Appendices/Properties.html#//apple_ref/doc/writerid/itc_videopreview_screenshots)

| 屏幕大小    | 型号           | 图片尺寸      | 备注   |
| ------- | ------------ | --------- | ---- |
| 4.7 英寸  | iPhone6 Plus | 750x1134  |      |
| 5.5 英寸  | iPhone6      | 1242x2208 |      |
| 4 英寸    | iPhone5/5S   | 640x1136  |      |
| 3.5 英寸  | iPhone4/4S   | 640x960   |      |
| iPad		| iPad         | 1536x2048 |      |
| iPad Pro 	| iPad Pro		| 2048x2732 |		|


### 上架时提供的App图标尺寸

* 1024*1024

### 版权



### Enterprise distribution Icon Size
* Small Image Size: 57 x 57
* Large Image Size: 512 x 512
* see more: http://stackoverflow.com/questions/19151030/what-are-small-size-large-size-image-url-and-subtitle-in-ios-ad-hoc-distributio


### dSYM

	$ dwarfdump -u <PathToYourAppsDsym>



