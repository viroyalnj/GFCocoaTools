//
//  NSString+GF.h
//  YuCloud
//
//  Created by 熊国锋 on 2016/10/11.
//  Copyright © 2016年 VIROYAL-ELEC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GF)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set;

@end
