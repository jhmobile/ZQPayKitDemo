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

@implementation ViewController {
    NSArray *_data;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"证联支付SDK";
    self.navigationController.navigationBar.translucent = NO;
    
    // 配置发布环境为测试
    [ZQPayKit setProduction:NO];
    
    // 初始化，此方法必须在调用功能页面之前调用
    [ZQPayKit initWithAppKey:@"jh28a4c4bc6734f58b" appSecret:@"63a10e15c19741599aacc686ecf7ffd5"];
    
    // 设置用户信息，此方法必须在调用功能页面之前调用
//    [ZQPayKit setUid:@"uid" token:@"token"];
    
    // 设置按钮颜色
    [ZQPayKit setButtonTitleColor:[UIColor whiteColor] buttonBackgroundColor:[UIColor magentaColor]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _data = @[@{
                  @"text": @"我的银行卡",
                  @"action": @"bankList"
                  }, @{
                  @"text": @"修改支付密码",
                  @"action": @"pwdManage"
                  }, @{
                  @"text": @"忘记支付密码",
                  @"action": @"resetPwd"
                  }, @{
                  @"text": @"订单支付",
                  @"action": @"pay"
                  }, @{
                  @"text": @"获取余额",
                  @"action": @"getBalance"
                  }, @{
                  @"text": @"余额首页",
                  @"action": @"balanceHome"
                  }, @{
                  @"text": @"登录",
                  @"action": @"login"
                  }];
}

#pragma mark - data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = _data[indexPath.row][@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSelector:NSSelectorFromString(_data[indexPath.row][@"action"])];
}

#pragma mark - event response
- (void)login {
    [ZQPayKit performSelector:NSSelectorFromString(@"test")];
}

- (void)pay {
    self.orderId = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970]*1000)];
    [ZQPayKit openCashierViewControllerWithInstuId:@"B00000627" instuName:@"中航国旅" orderId:self.orderId orderAmount:[NSDecimalNumber decimalNumberWithString:@"50012.53"] orderDate:[NSDate date] orderDesc:@"欧洲十天九晚双飞豪华套餐" resv:@"保留域" paymentCallback:^(NSError *error) {
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

- (void)pwdManage {
    [ZQPayKit openModifyPasswordViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (void)resetPwd {
    [ZQPayKit openResetPasswordViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (void)bankList {
    [ZQPayKit openBankListViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (void)getBalance {
    [ZQPayKit getBalanceWithCallback:^(NSDecimalNumber *balance, NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"账户余额 %@元", balance] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:NO completion:nil];
        }
    }];
}

- (void)balanceHome {
    [ZQPayKit openBalanceViewControllerWithCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

@end
