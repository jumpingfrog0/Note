# iOS获取设备唯一标识的方法对比

<!--
create time: 2018-04-20 12:44:24
Author: <黄东鸿>
-->

> 参考链接：https://www.jianshu.com/p/c5eca7cd56c2
>
> 作者：hiigirl
>
> 來源：简书

8种iOS获取设备唯一标识的方法。

### 1. UDID

`UDID（Unique Device Identifier）`，iOS 设备的唯一识别码，是一个40位十六进制序列（越狱的设备通过某些工具可以改变设备的 UDID），移动网络可以利用 UDID 来识别移动设备。

许多开发者把 UDID 跟用户的真实姓名、密码、住址、其它数据关联起来，网络窥探者会从多个应用收集这些数据，然后顺藤摸瓜得到这个人的许多隐私数据，同时大部分应用确实在频繁传输 UDID 和私人信息。 为了避免集体诉讼，苹果最终决定在 iOS 5 的时候，将这一惯例废除。

**现在应用试图获取 UDID 已被禁止且不允许上架。**

### 2. MAC 地址

`MAC（Medium / Media Access Control）`地址，用来表示互联网上每一个站点的标示符，是一个六个字节（48位）的十六进制序列。前三个字节是由 IEEE 的注册管理机构 RA 负责给不同厂家分配的"*编制上唯一的标示符（Organizationally Unique Identifier)*"，后三个字节由各厂家自行指派给生产的适配器接口，称为扩展标示符。

MAC 地址在网络上用来区分设备的唯一性，接入网络的设备都有一个MAC地址，他们肯定都是唯一的。一部 iPhone 上可能有多个 MAC 地址，包括 WIFI 的、SIM 的等，但是 iTouch 和 iPad 上就有一个 WIFI 的，因此只需获取 WIFI 的 MAC 地址就好了。一般会采取 MD5（MAC 地址 + bundleID）获取唯一标识。

**但是 MAC 地址和 UDID 一样，存在隐私问题， iOS 7 之后，所有设备请求 MAC 地址会返回一个固定值，这个方法也不攻自破了。**

### 3. OpenUDID

UDID 被弃用后，广大开发者需要寻找一个可以替代的 UDID，并且不受苹果控制的方案，由此，OpenUDID 成为了当时使用最广泛的开源 UDID 代替方案。OpenUDID 利用一个非常巧妙的方法在不同程序间存储标示符：在粘贴板中用了一个特殊的名称来存储标示符，通过这种方法，其他应用程序也可以获取。

**苹果在 iOS 7 之后对粘贴板做了限制，导致同一个设备上的应用间，无法再共享一个 OpenUDID。**

### 4. UUID + 自己存储

`UUID（Universally Unique IDentifier）`，通用唯一标示符，是一个32位的十六进制序列，使用小横线来连接：8-4-4-4-12，通过 `NSUUID`（iOS 6 之后） 或者 `CFUUID`（iOS 2 之后）来获取，但是每次获取的值都不一样，需要自己存储。

```objective-c
[NSUUID UUID].UUIDString
```

```objective-c
CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault)))
```

### 5. 推送 token + bundleID

推送 token 保证设备唯一，但是必须有网络情况下才能工作，该方法不依赖于设备本身，但依赖于 apple push，而 apple push 有时候会抽风的。

### 6. IDFA

`IDFA-identifierForIdentifier（广告标示符）`，**在同一个设备上的所有 APP 都会取到相同的值**，是苹果专门给各广告提供商用来追踪用户而设定的。虽然 iPhone 默认是允许追踪的，而且一般用户都不知道有这么个设置，但是用户可以在 **设置 - 隐私 - 广告追踪 里重置此 ID 的值，或者限制此 ID 的使用，所以有可能会取不到值**。

### 7. IDFV

`IDFV-identifierForVendor（Vendor 标示符）`，通过以下代码来获取：

```objective-c
[UIDevice currentDevice].identifierForVendor.UUIDString 
```

是通过 bundleID 的反转的前两部分进行匹配，如果相同是同一个 Vendor ，例如对于 com.mayan.app_1 和 com.mayan.app_2 这两个 bundleID 来说，就属于同一个 Vendor ，共享同一个 IDFV。和 IDFA 不同的是，IDFV 的值一定能取到的，所以非常适合于作为内部用户行为分析的主 ID 来识别用户。

**但是用户删除了该 APP ，则 IDFV 值会被重置，再次安装此 APP ，IDFV 的值和之前的不同。**


### 8. IDFV + keychain

通过以上几种储存唯一标识的方法的分析，总结一下各有优劣。很多方法被苹果禁止或者漏洞太多，越来越不被开发者使用，**现在苹果主推 IDFA 和 IDFV 这两种方法，** 分别对外和对内，但是 IDFV 在 APP 重新安装时会更改，所以我的方法是**通过第一次生成的 IDFV 存储到 keychain 中，以后每次获取标识符都从 keychain 中获取。**




