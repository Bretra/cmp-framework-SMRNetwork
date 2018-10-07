//
//  SMRNetCache.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/7.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMRNetCachePolicy;
@interface SMRNetCache : NSObject

- (void)addCache:(id)content policy:(SMRNetCachePolicy *)policy;
- (id)cacheWithPolicy:(SMRNetCachePolicy *)policy;
- (void)clearCacheWihtPolicy:(SMRNetCachePolicy *)policy;
- (void)clearAllCaches;

@end
