# fuck_error

<!--
create time: 2018-11-15 13:41:30
Author: 黄东鸿
-->

#### UnhandledPromiseRejectionWarning: Error: `fsevents` unavailable (this watcher can only be used on Darwin)

	npm r -g watchman
	brew install watchman

#### 真机调试遇到：Cannot find entry file index.ios.js [index.android.js] in any of the roots 

```
// 设置电脑IP
[[RCTBundleURLProvider sharedSettings] setJsLocation:@”192.168.17.22”];
jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@”index.ios” fallbackResource:nil];
```

#### React-Native Error: Connection to http://localhost:8081/debugger-proxy?role=client timed out

这是因为使用了离线bundle，同时开启了远程调试 `remote debugger`