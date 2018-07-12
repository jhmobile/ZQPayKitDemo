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

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *token;

@end

@implementation ViewController

- (void)errorWithCode:(NSInteger)code {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"%ld", (long)code] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
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
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    
    [ZQPayKit initWithAppKey:@"jh28a4c4bc6734f58b" appSecret:@"63a10e15c19741599aacc686ecf7ffd5"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    Class c = NSClassFromString(@"LoginViewController");
    UIViewController *loginVC = [[c alloc] init];
    
    NSLog(@"%s SDK Version:%@  class:%@  loginVC:%@", __func__, [ZQPayKit version], c, loginVC);
    
//    NSLog(@"%s  %@", __func__, NSHomeDirectory());
//
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ZQPayKitResource" ofType:@"bundle"];
//    NSLog(@"%s  %@", __func__, bundlePath);
//    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//    NSLog(@"%s  %@", __func__, bundle);
//
//    NSString *path;
//    path = [bundle pathForResource:@"ServiceConfig" ofType:@"plist"];
//    NSLog(@"%s  ServiceConfig  %@", __func__, path);
//    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSLog(@"%s  %@", __func__, config);
//
//    path = [bundle pathForResource:@"Router-ymt" ofType:@"json"];
//    NSLog(@"%s  Router  %@", __func__, path);
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    config = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:NULL];
//    NSLog(@"%s  %@", __func__, config);
//
//    path = [bundle pathForResource:@"Platform-ymt" ofType:@"json"];
//    NSLog(@"%s  Platform  %@", __func__, path);
//    data = [[NSData alloc] initWithContentsOfFile:path];
//    config = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:NULL];
//    NSLog(@"%s  %@", __func__, config);
    
    
}

@end
