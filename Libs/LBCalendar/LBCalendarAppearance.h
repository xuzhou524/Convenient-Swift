//
//  LBCalendarAppearance.h
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBCalendarAppearance : NSObject

typedef NS_ENUM(NSInteger, LBCalendarWeekDayFormat) {
    LBCalendarWeekDayFormatSingle,
    LBCalendarWeekDayFormatShort,
    LBCalendarWeekDayFormatFull
};

@property (assign, nonatomic) BOOL isWeekMode;

// Weekday
@property (assign, nonatomic) LBCalendarWeekDayFormat weekDayFormat;
@property (strong, nonatomic) UIColor *weekDayTextColor;
@property (strong, nonatomic) UIFont *weekDayTextFont;

// Day
@property (strong, nonatomic) UIColor *dayRectangularColorSelected;
@property (strong, nonatomic) UIColor *dayRectangularColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayRectangularColorToday;
@property (strong, nonatomic) UIColor *dayRectangularColorTodayOtherMonth;

@property (strong, nonatomic) UIColor *dayDotColor;
@property (strong, nonatomic) UIColor *dayDotColorSelected;
@property (strong, nonatomic) UIColor *dayDotColorOtherMonth;
@property (strong, nonatomic) UIColor *dayDotColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayDotColorToday;
@property (strong, nonatomic) UIColor *dayDotColorTodayOtherMonth;

@property (strong, nonatomic) UIColor *dayStarColor;
@property (strong, nonatomic) UIColor *dayStarColorSelected;
@property (strong, nonatomic) UIColor *dayStarColorOtherMonth;
@property (strong, nonatomic) UIColor *dayStarColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayStarColorToday;
@property (strong, nonatomic) UIColor *dayStarColorTodayOtherMonth;

@property (strong, nonatomic) UIColor *dayTextColor;
@property (strong, nonatomic) UIColor *dayTextColorSelected;
@property (strong, nonatomic) UIColor *dayTextColorOtherMonth;
@property (strong, nonatomic) UIColor *dayTextColorSelectedOtherMonth;
@property (strong, nonatomic) UIColor *dayTextColorToday;
@property (strong, nonatomic) UIColor *dayTextColorTodayOtherMonth;

@property (strong, nonatomic) UIFont *dayTextFont;

@property (assign, nonatomic) CGFloat dayRectangularRatio;
@property (assign, nonatomic) CGFloat dayDotRatio;

- (NSCalendar *)calendar;

- (void)setDayDotColorForAll:(UIColor *)dotColor;
- (void)setDayStarColorForAll:(UIColor *)starColor;
- (void)setDayTextColorForAll:(UIColor *)textColor;

@end
