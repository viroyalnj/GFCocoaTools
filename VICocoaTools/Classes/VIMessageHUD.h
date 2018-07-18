//
//  VIMessageHUD.h
//  AFNetworking
//
//  Created by 熊国锋 on 2018/7/18.
//

#import <UIKit/UIKit.h>

typedef void (^VIMessageHUDCompletionBlock)(void);

@interface VIMessageHUD : UIView

+ (VIMessageHUD *)showHudOn:(UIView *)view
                      title:(nullable NSString *)title
                    message:(nullable NSString *)message
                  delayHide:(BOOL)delayHide
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock;

+ (void)finishHudWithResult:(BOOL)success
                        hud:(VIMessageHUD *)hud
                  labelText:(nullable NSString *)labelText
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock;

@end
