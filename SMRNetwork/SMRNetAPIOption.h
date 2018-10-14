//
//  SMRNetAPIOption.h
//  SMRNetworkDemo
//
//  Created by 丁治文 on 2018/10/14.
//  Copyright © 2018年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMRNetAPI;
typedef void(^SMRNetAPISuccessBlock)(SMRNetAPI *api, id response);
typedef void(^SMRNetAPIFaildBlock)(SMRNetAPI *api, id response, NSError *error);
typedef void(^SMRNetAPIUploadProgressBlock)(SMRNetAPI *api, NSProgress *uploadProgress);
typedef void(^SMRNetAPIDownloadProgressBlock)(SMRNetAPI *api, NSProgress *downloadProgress);

@interface SMRNetAPIOption : NSObject

@property (strong, nonatomic) SMRNetAPI *api;
@property (copy  , nonatomic) SMRNetAPISuccessBlock successBlock;
@property (copy  , nonatomic) SMRNetAPIFaildBlock faildBlock;
@property (copy  , nonatomic) SMRNetAPIUploadProgressBlock uploadProgress;
@property (copy  , nonatomic) SMRNetAPIDownloadProgressBlock downloadProgress;

+ (instancetype)optionWithAPI:(SMRNetAPI *)api
                 successBlock:(SMRNetAPISuccessBlock)successBlock
                   faildBlock:(SMRNetAPIFaildBlock)faildBlock
               uploadProgress:(SMRNetAPIUploadProgressBlock)uploadProgress
             downloadProgress:(SMRNetAPIDownloadProgressBlock)downloadProgress;

@end
