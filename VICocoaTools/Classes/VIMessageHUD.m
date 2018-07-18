//
//  VIMessageHUD.m
//  AFNetworking
//
//  Created by 熊国锋 on 2018/7/18.
//

#import "VIMessageHUD.h"

@implementation VIMessageHUD

+ (VIMessageHUD *)showHudOn:(UIView *)view
                      title:(nullable NSString *)title
                    message:(nullable NSString *)message
                  delayHide:(BOOL)delayHide
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock {
    return nil;
}

+ (void)finishHudWithResult:(BOOL)success
                        hud:(VIMessageHUD *)hud
                  labelText:(nullable NSString *)labelText
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock {
    
}

@end
