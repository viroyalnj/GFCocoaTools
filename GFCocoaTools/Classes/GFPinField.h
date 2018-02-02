//
//  GFPinField.h
//  Pods
//
//  Created by 熊国锋 on 2017/3/14.
//
//

#import <UIKit/UIKit.h>
#import "UIView+Shake.h"

@import Masonry;

@class GFPinField;

@protocol GFPinFieldDelegate <NSObject>

- (void)pinTextDidChange:(GFPinField *)pinField;

@end

@interface GFPinField : UIView < UIKeyInput >

- (instancetype)initWithFrame:(CGRect)frame digitCount:(NSInteger)digitCount;

@property (nonatomic, weak) id<GFPinFieldDelegate>  delegate;

@property (nonatomic, readonly)         NSInteger       digitCount;
@property (nonatomic, copy)             NSString        *text;
@property (nonatomic,getter=isEnabled)  BOOL            enabled;
@property (nonatomic, copy)             UIColor         *textColor;

@end
