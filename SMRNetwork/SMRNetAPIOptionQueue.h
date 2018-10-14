//
//  SMRNetAPIOptionQueue.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/14.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMRNetAPIOption;
@interface SMRNetAPIOptionQueue : NSObject

- (void)enqueue:(SMRNetAPIOption *)option;
- (SMRNetAPIOption *)dequeue;

@end
