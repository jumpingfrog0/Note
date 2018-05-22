# 原生与RN双向调用

<!--
create time: 2017-12-28 22:19:34
Author: 黄东鸿
-->

[React-Native 与 iOS原生项目间通信](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E5%8E%9F%E7%94%9F%E7%BB%84%E4%BB%B6%E5%BC%80%E5%8F%91/React%20Native%20%E4%B8%8E%20iOS%20%E5%8E%9F%E7%94%9F%E5%BA%94%E7%94%A8%E9%97%B4%E9%80%9A%E4%BF%A1.md)

[React Native iOS原生模块开发实战|教程|心得](http://www.devio.org/2017/01/22/React-Native-iOS%E5%8E%9F%E7%94%9F%E6%A8%A1%E5%9D%97%E5%BC%80%E5%8F%91%E5%AE%9E%E6%88%98-%E6%95%99%E7%A8%8B-%E5%BF%83%E5%BE%97/)

----

[原生UI组件 -- React Native 官网](http://reactnative.cn/docs/0.37/native-component-ios.html#content)

[在原生和React Native间通信 -- React Native 官网](http://reactnative.cn/docs/0.37/communication-ios.html)

[原生模块](http://reactnative.cn/docs/0.37/native-modules-ios.html#content)

> 你可以随时更新属性，但是更新必须在主线程中进行，读取则可以在任何线程中进行。
> 更新属性时并不能做到只更新一部分属性。我们建议你自己封装一个函数来构造属性。