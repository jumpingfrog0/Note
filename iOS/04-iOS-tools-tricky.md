# 开发工具的坑

<!--
create time: 2020-04-21 13:20:00
Author: <黄东鸿>
-->

### 1. Reveal 连接不上

1. 运行代码查看终端是否有以下打印：

    ```
    Loading Reveal Server from /Applications/Reveal.app/Contents/SharedSupport/iOS-Libraries/RevealServer.framework/RevealServer...
    Reveal Server was loaded successfully.
    ```
2. Reveal 调试方法

    ```
    curl -s -D - http://localhost:51441/application -o /dev/null
    ```

3. 把 `localhost` 改为 `127.0.0.1`

    ```
    ##
    # Host Database
    #
    # localhost is used to configure the loopback interface
    # when the system is booting.  Do not change this entry.
    ##
    127.0.0.1	localhost
    255.255.255.255	broadcasthost
    ::1             localhost
    ```
参考：[记录一次Reveal连接不上的问题](https://juejin.im/post/5b18c015f265da6e363c924b)