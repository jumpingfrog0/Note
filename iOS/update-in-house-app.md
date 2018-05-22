# Update In-House App

<!-- create time: 2015-08-12 19:53:38  -->

<!-- This file is created from $MARBOO_HOME/.media/starts/default.md
本文件由 $MARBOO_HOME/.media/starts/default.md 复制而来 -->

iOS 应用分2种:

一种是提交到 `App Store` 审核的应用;

另一种是`Enterprise`应用 即`In-House` 模式的，这种应用一般在企业内部使用，可以分发给任意的手机，只要通过一个URL即可下载安装，不用上传到`App Stroe`审核。

Xcode 6之前在导出`Enterprise`的ipa时，会自动生成两个文件：ipa和plist。
Xcode 6开始就只有ipa文件了，所以要手动生成plist文件。

> 注意：plist 文件的名称必须和ipa文件一致

证书安装的步骤就不细述了，百度和google上很多。

plist 文件内容如下：

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
		<key>items</key>
		<array>
			<dict>
				<key>assets</key>
				<array>
					<dict>
						<key>kind</key>
						<string>software-package</string>
						<key>url</key>
						<string>THE URL FOR YOUR IPA: ex: https://s3-us-west-2.amazonaws.com/driver-app-download/517Driver.ipa</string>
					</dict>
					<dict>
						<key>kind</key>
						<string>full-size-image</string>
						<key>needs-shine</key>
						<true/>
						<key>url</key>
						<string>THE URL FOR INSTALLATION @2x ICON: ex: http://go.com/Icon@2x.png</string>
					</dict>
					<dict>
						<key>kind</key>
						<string>display-image</string>
						<key>needs-shine</key>
						<true/>
						<key>url</key>
						<string>THE URL FOR INSTALLATION ICON: ex: http://go.com/Icon.png</string>
					</dict>
				</array>
				<key>metadata</key>
				<dict>
					<key>bundle-identifier</key>
					<string>YOUR BUNDLE ID (Take it from your Xcode Project)</string>
					<key>bundle-version</key>
					<string>1.2.3 Your app version</string>
					<key>kind</key>
					<string>software</string>
					<key>title</key>
					<string>The Title To Present To The User installing the app</string>
				</dict>
			</dict>
		</array>
	</dict>
	</plist>

将plist和ipa文件上传到服务器，然后建立一个网页，html内容如下：

	<a href="itms-services://?action=download-manifest&amp;url=https://s3-us-west-2.amazonaws.com/driver-app-download/517Driver.plist">Download Driver App</a>
	
> 注意：url 必须是https，否则ipa无法安装。



see more :

[http://stackoverflow.com/questions/13154619/update-in-house-apps-ios-enterprise-developer-program](http://stackoverflow.com/questions/13154619/update-in-house-apps-ios-enterprise-developer-program)

[http://blog.csdn.net/pang040328/article/details/40924737](http://blog.csdn.net/pang040328/article/details/40924737)

[http://blog.csdn.net/keshuiyun/article/details/45915261](http://blog.csdn.net/keshuiyun/article/details/45915261)

[Xcode 6 Save for Enterprise Deployment does not create plist for ipa anymore](http://stackoverflow.com/questions/25910387/xcode-6-save-for-enterprise-deployment-does-not-create-plist-for-ipa-anymore)

