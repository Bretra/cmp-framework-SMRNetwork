//
//  SMRNetConfig.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;
@interface SMRNetConfig : NSObject

- (void)configManager:(AFHTTPSessionManager *)manager;
- (void)configReqeustHeaderWithManager:(AFHTTPSessionManager *)manager;

@end
