//
//  NSString+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (GF)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)phoneNumberStyledString;

- (NSString *)MD5;

- (NSString *)sha1;

- (BOOL)isValidPhoneNumber;

- (BOOL)isValidMobileNumber;

@end
