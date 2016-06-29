//
//  LBCalendarContentView.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBCalendar;

@interface LBCalendarContentView : UIScrollView
@property (weak, nonatomic) LBCalendar *calendarManager;

@property (strong, nonatomic) NSDate *currentDate;

- (void)loadPreviousMonth;
- (void)loadNextMonth;

- (void)reloadData;
- (void)reloadAppearance;

@end

