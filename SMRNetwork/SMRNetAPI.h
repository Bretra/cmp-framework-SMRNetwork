//
//  SMRNetAPI.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * SMRReqeustMethod NS_STRING_ENUM;
extern SMRReqeustMethod const SMRReqeustMethodGet;
extern SMRReqeustMethod const SMRReqeustMethodPost;
extern SMRReqeustMethod const SMRReqeustMethodPut;
extern SMRReqeustMethod const SMRReqeustMethodDelete;

@class SMRNetCachePolicy;
@interface SMRNetAPI : NSObject

@property (copy  , nonatomic) NSString *identifier;
@property (copy  , nonatomic) SMRReqeustMethod method;          ///< 请求方式,默认为requestMethodGet
@property (copy  , nonatomic) NSString *url;
@property (strong, nonatomic) NSDictionary *params;
@property (strong, nonatomic) SMRNetCachePolicy *cachePolicy;   ///< 缓存策略,默认nil

@property (strong, nonatomic, readonly) NSURLSessionTask *sessionTast;  /// API创建的任务,API发起后才能获取到值
@property (strong, nonatomic, readonly) id response;                    ///< API请求成功后的返回结果
@property (strong, nonatomic, readonly) NSError *error;                 ///< API请求失败后的错误

+ (instancetype)apiWithIdentifier:(NSString *)identifier
                           method:(SMRReqeustMethod)method
                              url:(NSString *)url
                           params:(NSDictionary *)params;

- (void)fillSessionTask:(NSURLSessionTask *)sessionTask;
- (void)fillResponse:(id)response error:(NSError *)error;

@end
