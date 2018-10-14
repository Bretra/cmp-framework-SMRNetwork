//
//  SMRNetAPIOption.m
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/14.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import "SMRNetAPIOption.h"
#import "SMRNetAPI.h"

@implementation SMRNetAPIOption

- (void)dealloc {
//    _successBlock = nil;
//    _faildBlock = nil;
//    _uploadProgress = nil;
//    _downloadProgress = nil;
    NSLog(@"释放对象:%@", self);
}

+ (instancetype)optionWithAPI:(SMRNetAPI *)api
                 successBlock:(SMRNetAPISuccessBlock)successBlock
                   faildBlock:(SMRNetAPIFaildBlock)faildBlock
               uploadProgress:(SMRNetAPIUploadProgressBlock)uploadProgress
             downloadProgress:(SMRNetAPIDownloadProgressBlock)downloadProgress {
    SMRNetAPIOption *option = [[SMRNetAPIOption alloc] init];
    option.api = api;
    option.successBlock = successBlock;
    option.faildBlock = faildBlock;
    option.uploadProgress = uploadProgress;
    option.downloadProgress = downloadProgress;
    return option;
}

@end
