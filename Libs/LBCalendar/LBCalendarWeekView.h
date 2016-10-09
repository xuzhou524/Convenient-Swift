//
//  LBCalendarWeekView.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBCalendar.h"

@interface LBCalendarWeekView : UIView

@property (weak, nonatomic) LBCalendar *calendarManager;

@property (assign, nonatomic) NSUInteger currentMonthIndex;

- (void)setBeginningOfWeek:(NSDate *)date;
- (void)reloadData;
- (void)reloadAppearance;

@end
