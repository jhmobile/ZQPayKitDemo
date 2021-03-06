//
//  ZQPayKit.h
//  ZQPayKit
//
//  Created by minshun on 2018/7/10.
//  Copyright © 2018年 gzlex. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ZQPayKit.
FOUNDATION_EXPORT double ZQPayKitVersionNumber;

//! Project version string for ZQPayKit.
FOUNDATION_EXPORT const unsigned char ZQPayKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZQPayKit/PublicHeader.h>

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


@interface ZQPayKit : NSObject

// 读取当前SDK版本号
+ (NSString *)version;
// 配置发布环境
+ (void)setProduction:(BOOL)isProduction;
// 网络调试开关
+ (void)setDebugMode:(BOOL)debug;
// 初始化，需要appkey、appsecret
+ (void)initWithAppKey:(NSString *)anAppKey appSecret:(NSString *)anAppSecret;
// 设置用户信息
+ (void)setUid:(NSString *)uid token:(NSString *)token;
// 设置按钮文字颜色、按钮背景色
+ (void)setButtonTitleColor:(UIColor *)buttonTitleColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor;
// 是否支持余额支付
+ (void)setSupportBalancePay:(BOOL)support;
// 打开收银台页面，携带参数以及支付结果回调，参数包括：instuId商户号、instuName商户名称、orderId订单号、orderAmount订单金额、orderDate订单日期、orderDesc订单描述、resv保留域
+ (void)openCashierViewControllerWithInstuId:(NSString *)instuId instuName:(NSString *)instuName orderId:(NSString *)orderId orderAmount:(NSDecimalNumber *)orderAmount orderDate:(NSDate *)orderDate orderDesc:(NSString *)orderDesc resv:(NSString *)resv paymentCallback:(void (^)(NSError *error))callback;
// 打开我的银行卡列表
+ (void)openBankListViewControllerWithCallback:(void (^)(NSError *error))callback;
// 获取余额
+ (void)getBalanceWithCallback:(void (^)(NSDecimalNumber *balance, NSError *error))callback;
// 打开余额页面
+ (void)openBalanceViewControllerWithCallback:(void (^)(NSError *error))callback;
// 打开修改支付密码页
+ (void)openModifyPasswordViewControllerWithCallback:(void (^)(NSError *error))callback;
// 打开重置支付密码页
+ (void)openResetPasswordViewControllerWithCallback:(void (^)(NSError *error))callback;

@end

