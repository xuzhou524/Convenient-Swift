//
//  LBCalendarMonthWeekDaysView.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBCalendar.h"

@interface LBCalendarMonthWeekDaysView : UIView

@property (weak, nonatomic) LBCalendar *calendarManager;

+ (void)beforeReloadAppearance;
- (void)reloadAppearance;

@end
