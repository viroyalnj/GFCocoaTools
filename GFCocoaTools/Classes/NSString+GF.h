//
//  NSString+GF.h
//  YuCloud
//
//  Created by guofengld on 2016/10/11.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GF)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set;

@end
