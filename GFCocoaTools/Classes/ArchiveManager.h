//
//  YuArchiveManager.h
//  YuCloud
//
//  Created by 熊国锋 on 2016/10/26.
//  Copyright © 2016年 VIROYAL-ELEC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArchiveManager : NSObject

+ (instancetype)manager;

- (void)unzipFile:(NSString *)path
      destination:(nullable NSString *)dest
      complection:(nullable void(^)(BOOL success, NSString *destination))complection;

@end

NS_ASSUME_NONNULL_END
