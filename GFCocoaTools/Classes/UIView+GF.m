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
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self layoutIfNeeded];
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
