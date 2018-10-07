//
//  SMRNetCachePolicy.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/7.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetCachePolicy.h"

@implementation SMRNetCachePolicy

+ (instancetype)policyWithIdentifier:(NSString *)identifier cacheKey:(NSString *)cacheKey {
    SMRNetCachePolicy *policy = [[SMRNetCachePolicy alloc] init];
    policy.identifier = identifier;
    policy.cacheKey = cacheKey;
    return policy;
}

@end
