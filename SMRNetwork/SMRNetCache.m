//
//  SMRNetCache.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/7.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetCache.h"

@implementation SMRNetCachePolicy

+ (instancetype)policyWithIdentifier:(NSString *)identifier cacheKey:(NSString *)cacheKey {
    SMRNetCachePolicy *policy = [[SMRNetCachePolicy alloc] init];
    policy.identifier = identifier;
    policy.cacheKey = cacheKey;
    return policy;
}

@end

@interface SMRNetCache ()

@end

NSString * const kCacheForSMRNet = @"kCacheForSMRNet";

@implementation SMRNetCache

- (void)addCache:(id)content policy:(SMRNetCachePolicy *)policy {
    if (!policy.identifier || !policy.cacheKey || !content) {
        return;
    }
    NSMutableDictionary *cacheDict = [[[NSUserDefaults standardUserDefaults] objectForKey:kCacheForSMRNet] mutableCopy];
    if (!cacheDict) {
        cacheDict = [NSMutableDictionary dictionary];
    }
    cacheDict[policy.identifier] = @{policy.cacheKey:content};
    [[NSUserDefaults standardUserDefaults] setObject:cacheDict forKey:kCacheForSMRNet];
}
- (id)cacheWithPolicy:(SMRNetCachePolicy *)policy {
    if (!policy.identifier || !policy.cacheKey) {
        return nil;
    }
    NSDictionary *cacheDict = [[NSUserDefaults standardUserDefaults] objectForKey:kCacheForSMRNet];
    NSDictionary *dict = cacheDict[policy.identifier];
    id cache = dict[policy.cacheKey];
    return cache;
}
- (void)clearCacheWihtPolicy:(SMRNetCachePolicy *)policy {
    if (!policy.identifier || !policy.cacheKey) {
        return;
    }
    NSMutableDictionary *cacheDict = [[[NSUserDefaults standardUserDefaults] objectForKey:kCacheForSMRNet] mutableCopy];
    [cacheDict removeObjectForKey:policy.identifier];
    [[NSUserDefaults standardUserDefaults] setObject:cacheDict forKey:kCacheForSMRNet];
}
- (void)clearAllCaches {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCacheForSMRNet];
}

@end
