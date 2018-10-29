//
//  SMRNetServiceErrorHandler.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/29.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetServiceErrorHandler.h"

@implementation SMRNetServiceErrorHandler

- (BOOL)shouldResponseSerivceError:(SMRNetError *)error response:(id)response {
    return YES;
}

@end
