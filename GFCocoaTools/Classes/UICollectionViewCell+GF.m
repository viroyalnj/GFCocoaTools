//
//  UICollectionViewCell+GF.m
//  YuCloud
//
//  Created by guofengld on 2016/12/8.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "UICollectionViewCell+GF.h"

@implementation UICollectionViewCell (GF)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

@end
