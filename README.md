# 支付流程交互图
![结构图](https://github.com/jhmobile/Android-zqpay-sample/blob/master/app/image/structure.png)

# 集成步骤
* 将ZQPayKit.framework和ZQPayKitResource.bundle拖到工程中
* `Linked Frameworks and Libraries`里添加以下项
```
libstdc++.6.0.9.tbd
AudioToolbox.framework
Security.framework
```
* CocoaPods依赖以下三方库
```
pod 'YTKNetwork', '2.0.4’
pod 'MBProgressHUD', '1.1.0’
pod 'SDWebImage', '4.2.3’
pod 'Masonry', '1.1.0’
pod 'YYModel', '1.0.4’
pod 'YYText', '1.0.7'
pod 'MJRefresh', '3.1.15.1’
pod 'IQKeyboardManager', '5.0.7’
pod 'ZXingObjC', '3.2.2'
```
* `Build Settings的Other Linker Flags`添加`-ObjC`

# API说明
### 初始化方法
`+ (void)initWithAppKey:(NSString *)anAppKey appSecret:(NSString *)anAppSecret;`

|参数名|说明|
|--|--|
|anAppKey|SDK提供方为第三方app生成的appKey|
|anAppSecret|SDK提供方为第三方app生成的appSecret|

`此方法在调用SDK页面之前必须调用，否则功能页面调用失败`

### 设置用户信息
`+ (void)setUid:(NSString *)uid token:(NSString *)token;`
|参数名|说明|
|--|--|
|uid|第三方app从SDK提供方后台服务中获取的用户id|
|token|第三方app从SDK提供方后台服务中获取的用户token|

`此方法在调用SDK页面之前必须调用，否则功能页面调用失败`

### 换肤
`+ (void)setButtonTitleColor:(UIColor *)buttonTitleColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor;`
|参数名|说明|
|--|--|
|buttonTitleColor|功能页面提交按钮文字颜色|
|buttonBackgroundColor|功能页面提交按钮背景色|

目前仅支持按钮样式，导航栏样式由第三方app自定义，按需调用

### 收银台
`+ (void)openCashierViewControllerWithOrderId:(NSString *)orderId orderAmount:(NSDecimalNumber *)orderAmount orderDate:(NSDate *)orderDate orderDesc:(NSString *)orderDesc resv:(NSString *)resv paymentCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|--|--|
|orderId|订单号|
|orderAmount|订单金额|
|orderDate|订单生成时间|
|orderDesc|订单描述|
|resv|订单生成时的保留域|
|callback|支付结果回调，error参数为空时表示支付成功，否则支付失败；错误码请参考ZQPayKitErrorCode|

### 银行卡列表
`+ (void)openBankListViewControllerWithCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|--|--|
|callback|回调，error参数为空表示打开页面成功，否则失败；错误码请参考ZQPayKitErrorCode|

### 支付密码管理
`+ (void)openPaymentPasswordManagerViewControllerWithCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|--|--|
|callback|回调，error参数为空表示打开页面成功，否则失败；错误码请参考ZQPayKitErrorCode|

### 错误码
```
typedef NS_ENUM(NSInteger, ZQPayKitErrorCode)
{
// 用户取消
ZQ_USER_CANCEL_ERROR   = 1001,
// 未设置appkey
ZQ_APPKEY_ERROR   = 1002,
// 用户信息错误
ZQ_USERINFO_ERROR   = 1003,
// 其他业务错误
ZQ_BUSINESS_ERROR   = 1010
};

```
