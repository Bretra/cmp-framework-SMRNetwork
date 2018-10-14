//
//  SMRNetAPIOptionQueue.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/14.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetAPIOptionQueue.h"

@interface SMRNetAPIOptionQueue ()

@property (strong, nonatomic) NSMutableArray *queueArray;

@end

@implementation SMRNetAPIOptionQueue

- (void)enqueue:(SMRNetAPIOption *)api {
    if (!api) {
        return;
    }
    [self.queueArray addObject:api];
}
- (SMRNetAPIOption *)dequeue {
    SMRNetAPIOption *option = self.queueArray.firstObject;
    if (option) {
        [self.queueArray removeObject:option];
    }
    return option;
}

#pragma mark - Getters

- (NSMutableArray *)queueArray {
    if (!_queueArray) {
        _queueArray = [NSMutableArray array];
    }
    return _queueArray;
}

@end
