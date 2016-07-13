//
//  LBCalendarDayView.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCalendar.h"
#import "DateSelectView.h"

@interface LBCalendarDayView : UIView

@property (weak, nonatomic) LBCalendar *calendarManager;

@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isOtherMonth;

- (void)reloadData;
- (void)reloadAppearance;


@end
