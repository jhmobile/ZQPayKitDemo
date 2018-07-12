//
//  ViewController.m
//  ZQPayKitDemo
//
//  Created by mshqiu on 2018/7/3.
//  Copyright © 2018年 jinhui. All rights reserved.
//

#import "ViewController.h"
#import <ZQPayKit/ZQPayKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;

@end

@implementation ViewController

- (void)errorWithCode:(NSInteger)code {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"%ld", (long)code] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
}

#pragma mark - event response
- (IBAction)pay:(id)sender {
    [ZQPayKit openCashierViewControllerWithOrderId:nil orderAmount:nil orderDate:nil orderDesc:nil resv:nil paymentCallback:^(NSError *error) {
        if (error) {
            [self errorWithCode:error.code];
        }
    }];
}

- (IBAction)pwdManage:(id)sender {
    [ZQPayKit openPaymentPasswordManagerViewControllerWithCallback:^(NSError *error) {
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

- (IBAction)login:(id)sender {
    [ZQPayKit performSelector:NSSelectorFromString(@"test")];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    
    [ZQPayKit initWithAppKey:@"jh28a4c4bc6734f58b" appSecret:@"63a10e15c19741599aacc686ecf7ffd5"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([ZQPayKit respondsToSelector:NSSelectorFromString(@"uid")]) {
        NSString *uid = [ZQPayKit performSelector:NSSelectorFromString(@"uid")];
        self.uidLabel.text = [NSString stringWithFormat:@"%@", uid];
    }
    if ([ZQPayKit respondsToSelector:NSSelectorFromString(@"token")]) {
        NSString *token = [ZQPayKit performSelector:NSSelectorFromString(@"token")];
        self.tokenLabel.text = [NSString stringWithFormat:@"%@", token];
    }
}

@end
