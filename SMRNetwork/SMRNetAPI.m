//
//  SMRNetAPI.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/6.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetAPI.h"
#import "SMRNetCachePolicy.h"

SMRReqeustMethod const SMRReqeustMethodGet      = @"GET";
SMRReqeustMethod const SMRReqeustMethodPost     = @"POST";
SMRReqeustMethod const SMRReqeustMethodPut      = @"PUT";
SMRReqeustMethod const SMRReqeustMethodDelete   = @"DELTE";

@interface SMRNetAPI ()

@end

@implementation SMRNetAPI
@synthesize sessionTast = _sessionTast;
@synthesize response = _response;
@synthesize error = _error;

+ (instancetype)apiWithIdentifier:(NSString *)identifier method:(SMRReqeustMethod)method url:(NSString *)url params:(NSDictionary *)params {
    SMRNetAPI *api = [[SMRNetAPI alloc] init];
    api.identifier = identifier;
    api.method = method;
    api.url = url;
    api.params = params;
    api.cachePolicy = [SMRNetCachePolicy policyWithIdentifier:identifier cacheKey:url];
    return api;
}

- (void)fillSessionTask:(NSURLSessionTask *)sessionTask {
    
}
- (void)fillResponse:(id)response error:(NSError *)error {
    
}

@end
