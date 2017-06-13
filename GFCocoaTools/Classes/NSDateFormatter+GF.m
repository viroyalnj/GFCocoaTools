//
//  YuCloud+GF.m
//  YuCloud
//
//  Created by guofengld on 2016/11/19.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "NSDateFormatter+GF.h"

@implementation NSDateFormatter (GF)

- (NSString *)shortDayStringFromDate:(NSDate *)date {
    self.dateFormat = @"y-M-d";
    return [self stringFromDate:date];
}

- (NSString *)shortTimeStringFromDate:(NSDate *)date {
    self.dateFormat = @"aa h:mm";
    return [self stringFromDate:date];
}

- (NSString *)shortDayTimeStringFromDate:(NSDate *)date {
    self.dateFormat = @"y-M-d aa h:mm";
    return [self stringFromDate:date];
}

- (NSString *)shortTimeStringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger min = (NSInteger)interval / 60 % 60;
    NSInteger hour = (NSInteger)interval / (60 * 60);
    
    if (hour == 0) {
        return [NSString stringWithFormat:@"%ld分钟", (long)min];
    }
    else if (min == 0) {
        return [NSString stringWithFormat:@"%ld小时", (long)hour];
    }
    else {
        return [NSString stringWithFormat:@"%ld小时%ld分钟", (long)hour, (long)min];
    }
}

@end
