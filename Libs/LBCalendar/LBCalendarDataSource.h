//
//  LBCalendarDataSource.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LBCalendar;

@protocol LBCalendarDataSource <NSObject>

- (BOOL)calendarHaveEvent:(LBCalendar *)calendar date:(NSDate *)date;
- (void)calendarDidDateSelected:(LBCalendar *)calendar date:(NSDate *)date;

@end
