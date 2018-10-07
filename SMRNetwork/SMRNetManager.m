//
//  SMRNetManager.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetManager.h"
#import "SMRNetConfig.h"
#import "SMRNetAPI.h"
#import "SMRNetErrors.h"
#import "SMRNetCache.h"
#import <AFNetworking/AFNetworking.h>

@interface SMRNetManager ()

@property (strong, nonatomic) SMRNetConfig *config;
@property (strong, nonatomic) SMRNetCache *netCache;
@property (strong, nonatomic) AFHTTPSessionManager *afnManger;

@end

@implementation SMRNetManager

+ (instancetype)sharedManager {
    static SMRNetManager *_sharedNetManager = nil;
    static dispatch_once_t _sharedNetManagerOnceToken;
    dispatch_once(&_sharedNetManagerOnceToken, ^{
        _sharedNetManager = [[SMRNetManager alloc] init];
    });
    return _sharedNetManager;
}

- (void)startWithConfig:(SMRNetConfig *)config {
    _config = config;
    [self configManager:self.afnManger config:config];
}

#pragma mark - Private - AFN
- (void)configManager:(AFHTTPSessionManager *)manager config:(SMRNetConfig *)config {
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
}

- (void)configReqeustHeaderWithManager:(AFHTTPSessionManager *)manager config:(SMRNetConfig *)config {
    
}

#pragma mark - Public

- (void)requestAPI:(SMRNetAPI *)api
        cacheBlock:(void (^)(SMRNetAPI *api ,id response))cacheBlock
      successBlock:(void (^)(SMRNetAPI *api ,id response))successBlock
        faildBlock:(void (^)(SMRNetAPI *api ,id response, NSError *error))faildBlock {
    // cache
    if (cacheBlock) {
        id response = [self.netCache cacheWithPolicy:api.cachePolicy];
        cacheBlock(api, response);
    }
    
    __weak typeof(self) weakSelf = self;
    // request
    if ([api.method isEqualToString:SMRReqeustMethodGet]) {
        NSURLSessionTask *task = [self.afnManger GET:api.url parameters:api.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [api fillResponse:responseObject error:nil];
            if (!responseObject[@"error"]) {
                if (api.cachePolicy) {
                    [strongSelf.netCache addCache:responseObject policy:api.cachePolicy];
                }
                if (successBlock) {
                    successBlock(api, responseObject);
                }
            } else {
                if (faildBlock) {
                    faildBlock(api, responseObject, [SMRNetErrors errorForNetSerivceDomain]);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [api fillResponse:nil error:error];
            if (faildBlock) {
                faildBlock(api, nil, error);
            }
        }];
        [api fillSessionTask:task];
    }
}
- (void)requestSerialAPIs:(NSArray<SMRNetAPI *> *)apis
               cacheBlock:(void (^)(SMRNetAPI *api ,id response, BOOL finished, BOOL *stop))cacheBlock
             successBlock:(void (^)(SMRNetAPI *api ,id response, BOOL finished, BOOL *stop))successBlock
               faildBlock:(void (^)(SMRNetAPI *api ,id response, NSError *error, BOOL finished, BOOL *stop))faildBlock {
    
}

#pragma mark - Getters

- (SMRNetConfig *)config {
    if (!_config) {
        _config = [[SMRNetConfig alloc] init];
        [self startWithConfig:_config];
    }
    return _config;
}

- (SMRNetCache *)netCache {
    if (!_netCache) {
        _netCache = [[SMRNetCache alloc] init];
    }
    return _netCache;
}

- (AFHTTPSessionManager *)afnManger {
    if (!_afnManger) {
        _afnManger = [AFHTTPSessionManager manager];
    }
    return _afnManger;
}

@end
