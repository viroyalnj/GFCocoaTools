//
//  UITableViewCell+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "UITableViewCell+GF.h"

@implementation UITableViewCell (GF)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}


@end
