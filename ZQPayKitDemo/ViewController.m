//
//  ViewController.m
//  ZQPayKitDemo
//
//  Created by mshqiu on 2018/7/3.
//  Copyright © 2018年 jinhui. All rights reserved.
//

#import "ViewController.h"
#import <ZQPayKit/ZQPayKit.h>

/*
 集成文档请参考工程目录下的README.md
 */

@interface ViewController ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation ViewController

- (void)errorWithCode:(NSInteger)code {
    NSDictionary *messages = @{
                               @"1001": @"用户取消",
                               @"1002": @"未设置appKey",
                               @"1003": @"用户信息错误",
                               @"1010": @"未知业务错误"
                               };
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:messages[[NSString stringWithFormat:@"%ld", (long)code]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
}
#pragma mark - event response
- (IBAction)pay:(id)sender {
    self.orderId = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970]*1000)];
    [ZQPayKit openCashierViewControllerWithInstuId:@"13651246987" instuName:@"中航国旅" orderId:self.orderId orderAmount:[NSDecimalNumber decimalNumberWithString:@"50012.53"] orderDate:[NSDate date] orderDesc:@"欧洲十天九晚双飞豪华套餐" resv:@"保留域" paymentCallback:^(NSError *error) {
        if (error) {
            // 支付出错
            [self errorWithCode:error.code];
        } else {
            // error为空表示支付成功
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:[NSString stringWithFormat:@"订单编号：%@", self.orderId] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:NO completion:nil];
        }
    }];
}

- (IBAction)pwdManage:(id)sender {
    [ZQPayKit openModifyPasswordViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (IBAction)resetPwd:(id)sender {
    [ZQPayKit openResetPasswordViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (IBAction)bankList:(id)sender {
    [ZQPayKit openBankListViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    
    // 初始化，此方法必须在调用功能页面之前调用
    [ZQPayKit initWithAppKey:@"appKey" appSecret:@"appSecret"];
    
    // 设置用户信息，此方法必须在调用功能页面之前调用
    [ZQPayKit setUid:@"uid" token:@"token"];
    
    // 设置按钮颜色
    [ZQPayKit setButtonTitleColor:[UIColor whiteColor] buttonBackgroundColor:[UIColor magentaColor]];
}

@end
