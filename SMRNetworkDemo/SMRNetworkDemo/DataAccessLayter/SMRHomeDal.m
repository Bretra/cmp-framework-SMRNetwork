//
//  SMRHomeDal.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRHomeDal.h"
#import "SMRNetAPI.h"

@implementation SMRHomeDal

+ (SMRNetAPI *)getHomeInfoWithUserName:(NSString *)userName {
    NSString *url = [NSString stringWithFormat:@"http://api.apiopen.top/singlePoetry"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SMRNetAPI *api = [SMRNetAPI apiWithIdentifier:@"getHomeInfoWithUserName"
                                           method:SMRReqeustMethodGet
                                              url:url
                                           params:params];
    return api;
}

@end
