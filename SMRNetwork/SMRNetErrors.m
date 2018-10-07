//
//  SMRNetErrors.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/7.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetErrors.h"

SMRNetErrorDomain const SMRNetErrorDomainSerivceError = @"SMRNetErrorDomainSerivceError";

@implementation SMRNetErrors

#pragma mark - Errors

+ (NSError *)errorForNetSerivceDomain {
    NSError *error = [NSError errorWithDomain:SMRNetErrorDomainSerivceError code:SMRServiceErrorCode userInfo:nil];
    return error;
}

@end
