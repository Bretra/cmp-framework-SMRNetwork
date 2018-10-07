//
//  SMRHomeBll.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRHomeBll.h"
#import "SMRHomeDal.h"

@interface SMRHomeBll ()

@property (strong ,nonatomic) SMRHomeDal *homeDal;

@end

@implementation SMRHomeBll

- (SMRNetAPI *)getHomeInfoWithUserName:(NSString *)userName {
    return [SMRHomeDal getHomeInfoWithUserName:userName];
}

- (SMRHomeDal *)homeDal {
    if (!_homeDal) {
        _homeDal = [[SMRHomeDal alloc] init];
    }
    return _homeDal;
}

@end
