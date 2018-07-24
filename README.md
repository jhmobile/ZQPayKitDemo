# 支付SDK集成文档

## 当前最新版本：v0.1.0

## SDK包含的业务功能

1. 绑定银行卡(未提供调起API，在首次支付等环节由SDK调起))
2. 收银台支付（提供调起和回调API）
3. 银行卡管理（提供调起API）
4. 修改支付密码、忘记支付密码（提供调起API）

## 非原生页面如何使用SDK

使用非原生技术的App内页面（如H5、React Native、Weex等）如需调起SDK，需在App内部通过原生与非原生通信的API，封装SDK接口后供非原生页面调用即可。
如果需要回调，可以在非原生页面约定好回调接口，由原生模块收到SDK回调后调用非原生页面的约定接口即可实现回调。

## SDK交互流程图
![交互流程](/image.png)

## 集成步骤
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

## API说明
### 初始化方法
`+ (void)initWithAppKey:(NSString *)anAppKey appSecret:(NSString *)anAppSecret;`

|参数名|说明|
|:-:|:-:|
|anAppKey|SDK提供方为第三方app生成的appKey|
|anAppSecret|SDK提供方为第三方app生成的appSecret|

`此方法在调用SDK页面之前必须调用，否则功能页面调用失败`

### 设置用户信息
`+ (void)setUid:(NSString *)uid token:(NSString *)token;`

|参数名|说明|
|:-:|:-:|
|uid|第三方app从SDK提供方后台服务中获取的用户id|
|token|第三方app从SDK提供方后台服务中获取的用户token|

`此方法在调用SDK页面之前必须调用，否则功能页面调用失败`

### 换肤
`+ (void)setButtonTitleColor:(UIColor *)buttonTitleColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor;`

|参数名|说明|
|:-:|:-:|
|buttonTitleColor|功能页面提交按钮文字颜色|
|buttonBackgroundColor|功能页面提交按钮背景色|

目前仅支持按钮样式，导航栏样式由第三方app自定义，按需调用

### 收银台
`+ (void)openCashierViewControllerWithInstuId:(NSString *)instuId instuName:(NSString *)instuName orderId:(NSString *)orderId orderAmount:(NSDecimalNumber *)orderAmount orderDate:(NSDate *)orderDate orderDesc:(NSString *)orderDesc resv:(NSString *)resv paymentCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|:-:|:-:|
|instuId|商户号|
|instuName|商户名称|
|orderId|订单号|
|orderAmount|订单金额|
|orderDate|订单生成时间|
|orderDesc|订单描述|
|resv|订单生成时的保留域|
|callback|支付结果回调，error参数为空时表示支付成功，否则支付失败；错误码请参考ZQPayKitErrorCode|

### 银行卡列表
`+ (void)openBankListViewControllerWithCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|:-:|:-:|
|callback|回调，error参数为空表示打开页面成功，否则失败；错误码请参考ZQPayKitErrorCode|

### 修改支付密码
`+ (void)openModifyPasswordViewControllerWithCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|:-:|:-:|
|callback|回调，error参数为空表示打开页面成功，否则失败；错误码请参考ZQPayKitErrorCode|

### 重置支付密码
`+ (void)openResetPasswordViewControllerWithCallback:(void (^)(NSError *error))callback;`

|参数名|说明|
|:-:|:-:|
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

## 备注

#### 测试环境万能验证码

|页面|验证码|
|:-:|:-:|
|实名绑卡|123456(华创111111)|
|添加银行卡|123456(华创111111)|
|身份验证（重新绑卡找回支付密码）|7310|
