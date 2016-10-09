//
//  LBCalendarMonthView.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBCalendar.h"

@interface LBCalendarMonthView : UIView

@property (weak, nonatomic) LBCalendar *calendarManager;

- (void)setBeginningOfMonth:(NSDate *)date;
- (void)reloadData;
- (void)reloadAppearance;

@end
