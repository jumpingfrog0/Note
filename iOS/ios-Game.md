ios-Game
=========

[iOS开发- 游戏屏幕适配(SpriteKit)](http://demo.netfoucs.com/hitwhylz/article/details/42082225)
	
	• iPad Retina [4:3 or 1.33]: Displayed as-is to fit the 2048x1536 screen size.
	• iPad Non-Retina [4:3 or 1.33]: Aspect fill will scale a 2048x1536 playable area by 0.5 to fit the 1024x768 screen size.
	• iPhone 4S [3:2 or 1.5]: Aspect fill will scale a 2048x1366 playable area by 0.47 to fit the 960x640 screen size.
	• iPhone 5 [16:9 or 1.77]: Aspect fill will scale a 2048x1152 playable area by 0.56 to fit the 1136x640 screen size.
	• iPhone 6 [16:9 or 1.77]: Aspect fill will scale a 2048x1152 playable area by 0.64 to fit the 1334x750 screen size.
	• iPhone 6 Plus [16:9 or 1.77]: Aspect fill will scale a 2048x1152 playable area by 0.93 to fit the 1920x1080 screen size.
	
[Sprite Kit教程：制作一个通用程序 1](http://beyondvincent.com/2013/10/27/2013-10-19-118-sprite-kit-tutorial-making-a-universal-app-part-1/)

[cocos2dx3.2 ——屏幕适配](http://blog.csdn.net/chinahaerbin/article/details/39586281)

关于Texture的使用：苹果官方文档--Working with Sprites

[SpriteKit快速入门](http://www.kingyeung.com/blog/2014/05/25/spritekitkuai-su-ru-men/)

[Sprite Kit 物理引擎初体验（一](http://www.cocoachina.com/ios/20140526/8552.html)

[raywenderlich](https://www.raywenderlich.com/category/sprite-kit)

[stackoverflow - button node](http://stackoverflow.com/questions/20010331/correct-way-to-create-button-in-sprite-kit)

[SpriteKitScrollingNode](https://github.com/JenDobson/SpriteKitScrollingNode)

--------

## Scene Kit

![Working with Cameras](https://koenig-media.raywenderlich.com/uploads/2016/03/CameraNode.jpg)

There are a couple of key points in the previous diagram:

* The camera’s direction of view is always along the negative z-axis of the node that contains the camera.

* The **field of view** is the limiting angle of the viewable area of your camera. A tight angle provides a narrow view, while a wide angle provides a wide view.

* The **viewing frustum** determines the visible depth of your camera. Anything outside this area – that is, too close or too far from the camera – will be clipped and won’t appear on the screen.


A Scene Kit camera is represented by `SCNCamera`, whose `xPov` and `yPov` properties let you adjust the field of view, while `zNear` and `zFar` let you adjust the viewing frustum.


---------

## 矩阵变换数学基础

[Opengl 矩阵变换](http://blog.csdn.net/lyx2007825/article/details/8792475)

[3D变换：模型，视图，投影与Viewport](http://blog.csdn.net/kesalin/article/details/7168967)

[矩阵的空间变换、仿射变换](http://blog.sina.com.cn/s/blog_7149fc900101brf6.html)

[仿射变换](http://blog.csdn.net/carson2005/article/details/7540936)

仿射变换有五种：`平移变换`、`缩放变换`、`旋转变换`、`翻转变换`、`错切变换`

[齐次坐标](http://baike.baidu.com/link?url=JELQ2MrDeMIoiMnGf29qrDc6WXFZuw6zLt3gDurrOzNsvtXgL36U0945gEiSwqX65iOTjT9foQC8_emPjpBRhv3nOErZmH8PyfIZqy0C6EYKj_Xh8gTKnVB5rHb2MYn4)

[齐次坐标](http://blog.csdn.net/janestar/article/details/44244849)(推荐）

[齐次坐标](http://www.songho.ca/math/homogeneous/homogeneous.html)（原文）

[深入探索透视投影变换](http://blog.csdn.net/popy007/article/details/1797121)

[旋转坐标转换的矩阵推导](http://www.cnblogs.com/yuzhongwusan/p/4121815.html)

[三维旋转矩阵推导](http://blog.csdn.net/ningyaliuhebei/article/details/7481679)

[错切变换](http://blog.sina.com.cn/s/blog_6163bdeb0102du6p.html)

平移变换、旋转变换、缩放变换（见上:3D变换：模型，视图，投影与Viewport）

[欧拉角](http://blog.csdn.net/mysniper11/article/details/8766574)

	Yaw（偏航）：欧拉角向量的y轴，顺时针(向左）为正方向
	Pitch（俯仰）：欧拉角向量的x轴, 逆时针（向下）为正方向
	Roll（翻滚）： 欧拉角向量的z轴，顺时针为正方向

---------

##### 在球体中心玩z轴负方向看，贴图上下翻转了

* 垂直翻转球体内表面的贴图

[SceneKit, flip direction of SCNMaterial](http://stackoverflow.com/questions/33284781/scenekit-flip-direction-of-scnmaterial)

code 1：

	material.diffuse.contentsTransform = SCNMatrix4MakeScale(1,-1,1);
	material.diffuse.wrapT = SCNWrapModeRepeat; //or translate contentsTransform by (0,1,0);
	
code 2：

	var transform = SCNMatrix4MakeRotation(Float(M_PI), 0.0, 0.0, 1.0)
	transform = SCNMatrix4Translate(transform, 1.0, 1.0, 0.0)
	material.diffuse.contentsTransform = transform
        
* 将球先绕z轴旋转180度，再绕y轴旋转180度

	var transform = SCNMatrix4MakeRotation(Float(M_PI), 0.0, 0.0, 1.0)
	transform = SCNMatrix4Rotate(transform, Float(M_PI), 0, 1, 0)
	node.transform = transform