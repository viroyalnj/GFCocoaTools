//
//  UIView+VI.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VI)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat height;

- (UIImage *)snapshotImage;

@end

extern CGPoint CGRectGetCenter(CGRect rect);
extern CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size);
