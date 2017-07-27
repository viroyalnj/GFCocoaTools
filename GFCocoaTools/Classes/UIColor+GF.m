//
//  UIColor+GF.m
//  Pods
//
//  Created by 熊国锋 on 2017/7/27.
//
//

#import "UIColor+GF.h"

@implementation UIColor (GF)

- (UIColor *)colorWithMinimumSaturation:(CGFloat)saturation {
    if (!self)
        return nil;
    
    CGFloat h, s, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    
    if (s < saturation)
        return [UIColor colorWithHue:h saturation:saturation brightness:b alpha:a];
    
    return self;
}

@end
