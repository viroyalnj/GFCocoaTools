//
//  NSData+GF.m
//  Pods
//
//  Created by 熊国锋 on 2017/6/27.
//
//

#import "NSData+GF.h"
#import "NSString+GF.h"

@implementation NSData (GF)

- (NSString *)MD5 {
    NSString *string = [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [string MD5];
}

@end
