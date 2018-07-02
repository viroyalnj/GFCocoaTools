//
//  UIView+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "UIView+GF.h"

@implementation UIView (GF)

- (UIImage *)snapshotImage {
    NSAssert(CGRectGetWidth(self.bounds) > 0 && CGRectGetHeight(self.bounds) > 0, @"size must be greater than zero");
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self layoutIfNeeded];
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end

CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMaxX(rect) / 2, CGRectGetMaxY(rect) / 2);
}

CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    rect.origin.x = center.x - size.width / 2;
    rect.origin.y = center.y - size.height / 2;
    
    return rect;
}

