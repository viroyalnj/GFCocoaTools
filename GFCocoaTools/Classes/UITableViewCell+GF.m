//
//  UITableViewCell+GF.m
//  YuCloud
//
//  Created by guofengld on 2016/12/8.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "UITableViewCell+GF.h"

@implementation UITableViewCell (GF)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}


@end
