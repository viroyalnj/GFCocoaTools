//
//  NSString+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "NSString+GF.h"
#import <CommonCrypto/CommonDigest.h>

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


- (NSString *)phoneNumberStyledString {
    NSMutableString *str = [NSMutableString stringWithString:self];
    if ([str length] == 11) {
        [str insertString:@"-" atIndex:7];
        [str insertString:@"-" atIndex:3];
        
        [str insertString:@"+86 " atIndex:0];
    }
    
    return str.copy;
}

- (NSString *)MD5 {
    if ([self length] == 0) {
        return nil;
    }
    
    const char *str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *MD5 = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [MD5 uppercaseString];
}

@end
