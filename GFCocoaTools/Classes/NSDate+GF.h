//
//  NSDate+GF.h
//  Dreamedu
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GF)

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;

- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;

- (BOOL)sameYearTo:(NSDate *)date;
- (BOOL)sameMonthTo:(NSDate *)date;
- (BOOL)sameDayTo:(NSDate *)date;

@end
