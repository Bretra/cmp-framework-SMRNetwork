//
//  SMRNetServiceErrorHandler.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/29.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMRNetError;
@interface SMRNetServiceErrorHandler : NSObject

- (BOOL)shouldResponseSerivceError:(SMRNetError *)error response:(id)response;

@end
