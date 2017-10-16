//
//  NSString+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
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
    NSString *string = self;
    NSInteger len = [string length];
    while (len > 0) {
        unichar uchar = [string characterAtIndex:len - 1];
        if ([set characterIsMember:uchar]) {
            if (len > 1) {
                string = [string substringToIndex:len - 2];
                len = [string length];
            }
            else {
                string = @"";
                break;
            }
        }
        else {
            break;
        }
    }
    
    return string;
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
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, data.length, r);
    
    NSMutableString *output = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", r[i]];
    }
    
    return output;
}

- (NSString *)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (BOOL)isValidMobileNumber {
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    if (self.length < 3) {
        return NO;
    }
    
    if ([self isValidMobileNumber]) {
        return YES;
    }
    
    NSString *phoneRegex = @"^[0-9]*$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

@end
