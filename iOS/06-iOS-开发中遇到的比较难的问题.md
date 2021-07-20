iOS 开发中的坑
===========

### ME 送礼超时问题

报错如下：

```
ErrorError Domain=NSURLErrorDomain Code=-1001 "请求超时。" UserInfo={_kCFStreamErrorCodeKey=-2102, NSUnderlyingError=0x283ee95f0 {Error Domain=kCFErrorDomainCFNetwork Code=-1001 "(null)" UserInfo={_kCFStreamErrorCodeKey=-2102, _kCFStreamErrorDomainKey=4}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <9A226EEC-2FA2-4DB5-912F-0E609D62D7DD>.<439>, _NSURLErrorRelatedURLSessionTaskErrorKey=(
    "LocalDataTask <9A226EEC-2FA2-4DB5-912F-0E609D62D7DD>.<439>"
), NSLocalizedDescription=请求超时。, NSErrorFailingURLStringKey=https://turnover.mejiaoyou.com/api/18/1009, NSErrorFailingURLKey=https://turnover.mejiaoyou.com/api/18/1009, _kCFStreamErrorDomainKey=4}
```