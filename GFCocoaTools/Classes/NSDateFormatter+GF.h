//
//  YuCloud+GF.h
//  YuCloud
//
//  Created by guofengld on 2016/11/19.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (GF)

- (NSString *)shortDayStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromDate:(NSDate *)date;

- (NSString *)shortDayTimeStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromTimeInterval:(NSTimeInterval)interval;

@end
