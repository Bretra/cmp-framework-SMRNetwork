//
//  SMRNetCachePolicy.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/7.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMRNetCachePolicy : NSObject

@property (copy  , nonatomic) NSString *identifier; ///< identifier标识一个cache
@property (copy  , nonatomic) NSString *cacheKey;   ///< cacheKey相匹配时才取出cache

+ (instancetype)policyWithIdentifier:(NSString *)identifier cacheKey:(NSString *)cacheKey;

@end
