//
//  UIButton+GF.m
//  Pods
//
//  Created by 熊国锋 on 2017/7/8.
//
//

#import "UIButton+GF.h"
#import "UIImage+GF.h"

@implementation UIButton (GF)

+ (instancetype)buttonWithTitleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor cornerRadii:(CGSize)cornerRadii {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    CGSize imgSize = CGSizeMake(cornerRadii.width * 2, cornerRadii.height * 2);
    UIImage *btnImage = [[UIImage imageWithColor:backgroundColor
                                            size:imgSize
                               byRoundingCorners:UIRectCornerAllCorners
                                     cornerRadii:cornerRadii] stretchableImageWithLeftCapWidth:cornerRadii.width topCapHeight:cornerRadii.height];
    
    [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    return btn;
}

@end
