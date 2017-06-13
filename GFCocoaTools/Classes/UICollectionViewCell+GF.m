//
//  UICollectionViewCell+GF.m
//  YuCloud
//
//  Created by 熊国锋 on 2016/12/8.
//  Copyright © 2016年 VIROYAL-ELEC. All rights reserved.
//

#import "UICollectionViewCell+GF.h"

@implementation UICollectionViewCell (GF)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

@end
