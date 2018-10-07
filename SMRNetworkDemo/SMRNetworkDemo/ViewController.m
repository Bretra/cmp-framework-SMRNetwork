//
//  ViewController.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "SMRNetwork.h"
#import "SMRHomeBll.h"

@interface ViewController ()

@property (strong, nonatomic) SMRHomeBll *homeBll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"页面加载成功");
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"开始请求...");
    SMRNetAPI *homeInfoAPI = [self.homeBll getHomeInfoWithUserName:@"name"];
    [[SMRNetManager sharedManager] requestAPI:homeInfoAPI cacheBlock:^(SMRNetAPI *api, id response) {
        NSLog(@"得到缓存:%@", response);
    } successBlock:^(SMRNetAPI *api, id response) {
        NSLog(@"请求成功:%@", response);
    } faildBlock:^(SMRNetAPI *api, id response, NSError *error) {
        NSLog(@"请求失败:%@", response);
    }];
}

- (SMRHomeBll *)homeBll {
    if (!_homeBll) {
        _homeBll = [[SMRHomeBll alloc] init];
    }
    return _homeBll;
}

@end
