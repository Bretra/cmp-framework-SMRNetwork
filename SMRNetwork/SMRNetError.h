//
//  SMRNetError.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/29.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * SMRNetErrorDomain NS_STRING_ENUM;
extern SMRNetErrorDomain const SMRNetSerivceErrorDomain;

typedef NS_ENUM(NSInteger, SMRErrorCode) {
    SMRServiceErrorCode     = 1001,///< 数据服务器错误,API正常响应
};

@interface SMRNetError : NSError

+ (SMRNetError *)errorForNetSerivceDomain;

@end
