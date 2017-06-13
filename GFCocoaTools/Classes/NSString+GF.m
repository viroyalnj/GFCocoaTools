//
//  NSString+GF.m
//  YuCloud
//
//  Created by guofengld on 2016/10/11.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "NSString+GF.h"

@implementation NSString (GF)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set {
    NSString *string = self;
    while ([string length] > 0) {
        unichar uchar = [string characterAtIndex:0];
        if ([set characterIsMember:uchar]) {
            string = [string substringFromIndex:1];
        }
        else {
            break;
        }
    }
    
    return string;
}

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set {
    return self;
}

@end
