//
//  NSDate+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "NSDate+GF.h"

@implementation NSDate (GF)

- (NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierISO8601];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

- (NSInteger)year {
    return [self components].year;
}

- (NSInteger)month {
    return [self components].month;
}

- (NSInteger)day {
    return [self components].day;
}

- (NSInteger)hour {
    return [self components].hour;
}

- (NSInteger)minute {
    return [self components].minute;
}

- (NSInteger)second {
    return [self components].second;
}

- (BOOL)sameYearTo:(NSDate *)date {
    return self.year == date.year;
}

- (BOOL)sameMonthTo:(NSDate *)date {
    return [self sameYearTo:date] && self.month == date.month;
}

- (BOOL)sameDayTo:(NSDate *)date {
    return [self sameMonthTo:date] && self.day == date.day;
}

@end
