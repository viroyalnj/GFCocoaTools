//
//  YuCloud+GF.h
//  YuCloud
//
//  Created by 熊国锋 on 2016/11/19.
//  Copyright © 2016年 VIROYAL-ELEC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (GF)

- (NSString *)shortDayStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromDate:(NSDate *)date;

- (NSString *)shortDayTimeStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromTimeInterval:(NSTimeInterval)interval;

@end
