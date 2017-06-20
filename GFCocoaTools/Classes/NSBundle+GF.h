//
//  NSBundle+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GF)

+ (UIImage *)bundleImageNamed:(NSString *)name;

@end

@interface NSBundle (GF)

+ (instancetype)photoBrowserBundle;

- (NSString *)photoBrowserStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end

#define GFLocalizedString(key, comment) \
    [[NSBundle photoBrowserBundle] photoBrowserStringForKey:(key) value:(key) table:@"Localizable"]
