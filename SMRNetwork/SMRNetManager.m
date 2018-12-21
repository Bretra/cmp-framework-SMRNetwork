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
#import "SMRNetError.h"
#import "SMRNetCache.h"
#import "SMRNetAPIOption.h"
#import "SMRNetAPIOptionQueue.h"
#import "SMRNetServiceErrorHandler.h"
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
    [config configManager:self.afnManger];
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
        // 设置header
        [self.config configReqeustHeaderWithManager:manager];
        // 设置超时时间
        manager.requestSerializer.timeoutInterval = api.timeoutInterval;
        // 创建task
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
            // 保存网络请求成功的结果
            [api fillResponse:responseObject error:nil];
            if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"error"]) {
                BOOL shouldCallBack = YES;
                // 截获服务器返回的业务性错误
                if ([self.serviceErrorHandler respondsToSelector:@selector(shouldResponseSerivceError:response:)]) {
                    shouldCallBack = [self.serviceErrorHandler shouldResponseSerivceError:[SMRNetError errorForNetSerivceDomain] response:responseObject];
                }
                // 失败的回调
                if (shouldCallBack && option.faildBlock) {
                    option.faildBlock(api, responseObject, [SMRNetError errorForNetSerivceDomain]);
                }
            } else {
                // 请求成功之后加入缓存
                if (api.cachePolicy) {
                    [strongSelf.netCache addCache:responseObject policy:api.cachePolicy];
                }
                // 请求成功的回调
                if (option.successBlock) {
                    option.successBlock(api, responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 保存网络请求失败的结果
            [api fillResponse:nil error:error];
            if (option.faildBlock) {
                option.faildBlock(api, nil, error);
            }
        }];
        // 保存task
        [api fillDataTask:task];
        // 发起一个请求
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
