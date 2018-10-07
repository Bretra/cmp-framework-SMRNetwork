//
//  SMRNetManager.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMRNetConfig;
@class SMRNetAPI;
@interface SMRNetManager : NSObject

+ (instancetype)sharedManager;
- (void)startWithConfig:(SMRNetConfig *)config;

- (void)requestAPI:(SMRNetAPI *)api
        cacheBlock:(void (^)(SMRNetAPI *api ,id response))cacheBlock
      successBlock:(void (^)(SMRNetAPI *api ,id response))successBlock
        faildBlock:(void (^)(SMRNetAPI *api ,id response, NSError *error))faildBlock;
- (void)requestSerialAPIs:(NSArray<SMRNetAPI *> *)apis
               cacheBlock:(void (^)(SMRNetAPI *api ,id response, BOOL finished, BOOL *stop))cacheBlock
             successBlock:(void (^)(SMRNetAPI *api ,id response, BOOL finished, BOOL *stop))successBlock
               faildBlock:(void (^)(SMRNetAPI *api ,id response, NSError *error, BOOL finished, BOOL *stop))faildBlock;

@end
