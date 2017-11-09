//
//  UIScreen+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "UIScreen+GF.h"

@implementation UIScreen (GF)

+ (UIDeviceResolution)resolution {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    CGFloat pixelWidth = (CGRectGetWidth(mainScreen.bounds) * scale);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (scale == 2.0f) {
            if (pixelHeight == 960.0f) {
                return UIDeviceResolution_iPhoneRetina4;
            }
            else if (pixelHeight == 1136.0f) {
                return UIDeviceResolution_iPhoneRetina5;
            }
            else if (pixelHeight == 1334.0f) {
                return UIDeviceResolution_iPhoneRetina6;
            }
        }
        else if (scale == 1.0f) {
            if (pixelHeight == pixelHeight == 480.0f) {
                return UIDeviceResolution_iPhoneStandard;
            }
        }
        else if (scale == 3.0f) {
            if (pixelHeight == 2208.0f) {
                return UIDeviceResolution_iPhoneRetina6p;
            }
            else if (pixelHeight == 2436) {
                return UIDeviceResolution_iPhoneRetinaX;
            }
        }
    }
    else {
        if (scale == 2.0f && pixelHeight == 2048.0f) {
            return UIDeviceResolution_iPadRetina;
        }
        else if (scale == 1.0f && pixelHeight == 1024.0f) {
            return UIDeviceResolution_iPadStandard;
        }
    }
    
    return UIDeviceResolution_Unknown;
}

+ (CGSize)screenSize {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    CGFloat pixelWidth = (CGRectGetWidth(mainScreen.bounds) * scale);
    
    return CGSizeMake(pixelWidth, pixelHeight);
}

@end
