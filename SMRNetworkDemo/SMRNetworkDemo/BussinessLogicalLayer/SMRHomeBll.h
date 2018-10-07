//
//  SMRHomeBll.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMRNetAPI;
@interface SMRHomeBll : NSObject

- (SMRNetAPI *)getHomeInfoWithUserName:(NSString *)userName;

@end
