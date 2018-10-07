//
//  SMRNetCache.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/7.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetCache.h"
#import "SMRNetCachePolicy.h"

NSString * const kCacheForSMRNet = @"kCacheForSMRNet";

@interface SMRNetCache ()

@end

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
