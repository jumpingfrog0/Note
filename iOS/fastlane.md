# fastlane

<!--
create time: 2017-11-07 15:58:58
Author: <TODO: 请写上你的名字>

This file is created by Marboo<http://marboo.io> template file $MARBOO_HOME/.media/starts/default.md
本文件由 Marboo<http://marboo.io> 模板文件 $MARBOO_HOME/.media/starts/default.md 创建
-->

## 打包

	$ fastlane ios mzd_inhouse ci_proj:wake-ios
	
## 上线

1. 修改 `MatchFile` 的 `readonly` 为 `false`
2. `$ fastlane match appstore`
3. 配置 xcconfig release 项
4. 手动打包

## 证书配置

[https://codesigning.guide](https://codesigning.guide)

