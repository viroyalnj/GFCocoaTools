//
//  MBProgressHUD+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

#define PROGRESS_DELAY_HIDE     1.5

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (GF)

+ (MBProgressHUD *)showHudOn:(UIView *)view
                        mode:(MBProgressHUDMode)mode
                       image:(nullable UIImage *)image
                     message:(nullable NSString *)message
                   delayHide:(BOOL)delayHide;

+ (void)finishHudWithResult:(BOOL)success
                        hud:(MBProgressHUD *)hud
                  labelText:(nullable NSString *)labelText
                 completion:(nullable void (^)())completionBlock;
@end

NS_ASSUME_NONNULL_END
