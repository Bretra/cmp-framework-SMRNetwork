//
//  SMRNetAPI.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetAPI.h"
#import "SMRNetCache.h"

SMRReqeustMethod const SMRReqeustMethodGet      = @"GET";
SMRReqeustMethod const SMRReqeustMethodPost     = @"POST";
SMRReqeustMethod const SMRReqeustMethodPut      = @"PUT";
SMRReqeustMethod const SMRReqeustMethodDelete   = @"DELTE";

@interface SMRNetAPI ()

@end

@implementation SMRNetAPI
@synthesize dataTask = _dataTask;
@synthesize response = _response;
@synthesize error = _error;

- (void)dealloc {
    NSLog(@"释放对象:%@", self);
}

+ (instancetype)apiWithIdentifier:(NSString *)identifier method:(SMRReqeustMethod)method url:(NSString *)url params:(NSDictionary *)params useCache:(BOOL)useCache {
    SMRNetAPI *api = [[SMRNetAPI alloc] init];
    api.identifier = identifier;
    api.method = method;
    api.url = url;
    api.params = params;
    api.timeoutInterval = 30;
    api.cachePolicy = useCache?[SMRNetCachePolicy policyWithIdentifier:identifier cacheKey:url]:nil;
    return api;
}

- (void)fillDataTask:(NSURLSessionTask *)dataTask {
    _dataTask = dataTask;
}
- (void)fillResponse:(id)response error:(NSError *)error {
    _response = response;
    _error = error;
}

@end
