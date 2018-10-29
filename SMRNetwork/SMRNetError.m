//
//  SMRNetError.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/29.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetError.h"

SMRNetErrorDomain const SMRNetErrorDomainSerivceError = @"SMRNetErrorDomainSerivceError";

@implementation SMRNetError

#pragma mark - Errors

+ (SMRNetError *)errorForNetSerivceDomain {
    SMRNetError *error = [SMRNetError errorWithDomain:SMRNetErrorDomainSerivceError code:SMRServiceErrorCode userInfo:nil];
    return error;
}

@end
