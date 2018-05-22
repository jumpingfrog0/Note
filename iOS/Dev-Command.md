# Dev-Command

<!--
create time: 2017-01-19 18:45:03
Author: <TODO: 黄东鸿>

This file is created by Marboo<http://marboo.io> template file $MARBOO_HOME/.media/starts/default.md
本文件由 Marboo<http://marboo.io> 模板文件 $MARBOO_HOME/.media/starts/default.md 创建
-->

#### Realm 文件路径

[How to find my realm file?](http://stackoverflow.com/questions/28465706/how-to-find-my-realm-file/28465803#28465803)

Swift

	po Realm.Configuration.defaultConfiguration.fileURL
	
Objective-C

	[RLMRealmConfiguration defaultConfiguration].fileURL

Or if you have an RLMRealm instance at hand, you can use:

	po myRealm.configuration.fileURL