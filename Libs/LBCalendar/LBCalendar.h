//
//  LBCalendar.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBCalendarDataSource.h"
#import "LBCalendarAppearance.h"
#import "LBCalendarContentView.h"


@interface LBCalendar : NSObject<UIScrollViewDelegate>

@property (weak, nonatomic) LBCalendarContentView *contentView;

@property (weak, nonatomic) id<LBCalendarDataSource> dataSource;

@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSDate *currentDateSelected;

- (LBCalendarAppearance *)calendarAppearance;

- (void)reloadData;
- (void)reloadAppearance;

- (void)loadPreviousMonth;
- (void)loadNextMonth;

@end

