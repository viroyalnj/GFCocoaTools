//
//  UIView+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GF)

- (UIImage *)snapshotImage;

@end

extern CGPoint CGRectGetCenter(CGRect rect);
extern CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size);
