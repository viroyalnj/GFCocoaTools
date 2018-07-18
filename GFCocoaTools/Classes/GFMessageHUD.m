//
//  GFMessageHUD.m
//  AFNetworking
//
//  Created by 熊国锋 on 2018/7/18.
//

#import "GFMessageHUD.h"

@implementation GFMessageHUD

+ (GFMessageHUD *)showHudOn:(UIView *)view
                      title:(nullable NSString *)title
                    message:(nullable NSString *)message
                  delayHide:(BOOL)delayHide
                 completion:(nullable GFMessageHUDCompletionBlock)completionBlock {
    return nil;
}

+ (void)finishHudWithResult:(BOOL)success
                        hud:(GFMessageHUD *)hud
                  labelText:(nullable NSString *)labelText
                 completion:(nullable GFMessageHUDCompletionBlock)completionBlock {
    
}

@end
