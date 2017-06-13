//
//  UIImage.h
//  YuCloud
//
//  Created by guofengld on 16/2/3.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GF)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
          byRoundingCorners:(UIRectCorner)corners
                cornerRadii:(CGSize)cornerRadii;

- (UIImage *)convertToGrayscale;

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;

- (UIImage *)imageResized:(CGFloat)resolution;

- (UIImage *)imageRotated:(UIImageOrientation)orientation;

- (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius
                             scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
