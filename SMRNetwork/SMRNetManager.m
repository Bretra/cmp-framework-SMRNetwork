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
#import "SMRNetAPIOption.h"
#import "SMRNetAPIOptionQueue.h"
#import "AFHTTPSessionManager+SMRNet.h"

@interface SMRNetManager ()

@property (strong, nonatomic) SMRNetConfig *config;
@property (strong, nonatomic) SMRNetCache *netCache;
@property (strong, nonatomic) SMRNetAPIOptionQueue *netAPIQueue;
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
    
    SMRNetAPIOption *option = [SMRNetAPIOption optionWithAPI:api
                                                successBlock:successBlock
                                                  faildBlock:faildBlock
                                              uploadProgress:nil
                                            downloadProgress:nil];
//    [self.netAPIQueue enqueue:option];
    [self queryOption:option manager:self.afnManger];
}
- (void)requestSerialAPIs:(NSArray<SMRNetAPI *> *)apis
               cacheBlock:(void (^)(SMRNetAPI *api ,id response, BOOL finished, BOOL *stop))cacheBlock
             successBlock:(void (^)(SMRNetAPI *api ,id response, BOOL finished, BOOL *stop))successBlock
               faildBlock:(void (^)(SMRNetAPI *api ,id response, NSError *error, BOOL finished, BOOL *stop))faildBlock {
    
}

#pragma mark - Query

- (void)queryOption:(SMRNetAPIOption *)option manager:(AFHTTPSessionManager *)manager {
    SMRNetAPI *api = option.api;
    __weak typeof(self) weakSelf = self;
    // request
    if ([manager respondsToSelector:@selector(dataTaskWithHTTPMethod:URLString:parameters:uploadProgress:downloadProgress:success:failure:)]) {
        NSURLSessionTask *task = [manager dataTaskWithHTTPMethod:api.method URLString:api.url parameters:api.params uploadProgress:^(NSProgress *uploadProgress) {
            if (option.uploadProgress) {
                option.uploadProgress(api, uploadProgress);
            }
        } downloadProgress:^(NSProgress *downloadProgress) {
            if (option.downloadProgress) {
                option.downloadProgress(api, downloadProgress);
            }
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [api fillResponse:responseObject error:nil];
            if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"error"]) {
                if (option.faildBlock) {
                    option.faildBlock(api, responseObject, [SMRNetErrors errorForNetSerivceDomain]);
                }
            } else {
                if (api.cachePolicy) {
                    [strongSelf.netCache addCache:responseObject policy:api.cachePolicy];
                }
                if (option.successBlock) {
                    option.successBlock(api, responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [api fillResponse:nil error:error];
            if (option.faildBlock) {
                option.faildBlock(api, nil, error);
            }
        }];
        [api fillDataTask:task];
        [task resume];
    } else {
        NSAssert(NO, @"AFNetwork版本可能与SMRNetwork不匹配,请更新SMRNetwork!");
    }
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

- (SMRNetAPIOptionQueue *)netAPIQueue {
    if (!_netAPIQueue) {
        _netAPIQueue = [[SMRNetAPIOptionQueue alloc] init];
    }
    return _netAPIQueue;
}

- (AFHTTPSessionManager *)afnManger {
    if (!_afnManger) {
        _afnManger = [AFHTTPSessionManager manager];
    }
    return _afnManger;
}

@end
