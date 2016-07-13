//
//  LBCalendarAppearance.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBCalendarAppearance.h"

@implementation LBCalendarAppearance

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self setDefaultValues];
    
    return self;
}

- (void)setDefaultValues
{
    self.isWeekMode = NO;
    
    self.weekDayFormat = LBCalendarWeekDayFormatShort;
    
    self.dayRectangularRatio = 2;
    self.dayDotRatio = 1. / 8.;
    
    self.weekDayTextFont = [UIFont systemFontOfSize:11];
    self.dayTextFont = [UIFont systemFontOfSize:18];
    
    self.weekDayTextColor = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:0];
    
    [self setDayDotColorForAll:[UIColor redColor]];//[UIColor colorWithRed:43./256. green:88./256. blue:134./256. alpha:1.]];
    [self setDayStarColorForAll:[UIColor orangeColor]];
    [self setDayTextColorForAll:[UIColor blackColor]];
    
    self.dayTextColorOtherMonth = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:1.];
    
    self.dayRectangularColorSelected = [UIColor redColor];
    self.dayTextColorSelected = [UIColor whiteColor];
    self.dayDotColorSelected = [UIColor whiteColor];
    self.dayStarColorSelected = [UIColor whiteColor];
    
    self.dayRectangularColorSelectedOtherMonth = self.dayRectangularColorSelected;
    self.dayTextColorSelectedOtherMonth = self.dayTextColorSelected;
    self.dayDotColorSelectedOtherMonth = self.dayDotColorSelected;
    self.dayStarColorSelectedOtherMonth = self.dayStarColorSelected;
    
    self.dayRectangularColorToday = [UIColor colorWithRed:0x33/256. green:0xB3/256. blue:0xEC/256. alpha:.5];
    self.dayTextColorToday = [UIColor whiteColor];
    self.dayDotColorToday = [UIColor whiteColor];
    self.dayStarColorToday = [UIColor whiteColor];
    
    self.dayRectangularColorTodayOtherMonth = self.dayRectangularColorToday;
    self.dayTextColorTodayOtherMonth = self.dayTextColorToday;
    self.dayDotColorTodayOtherMonth = self.dayDotColorToday;
    self.dayStarColorTodayOtherMonth = self.dayStarColorToday;
}

- (NSCalendar *)calendar
{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        //calendar.timeZone = [NSTimeZone localTimeZone];
        calendar.timeZone =[NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    });
    
    return calendar;
}

- (void)setDayDotColorForAll:(UIColor *)dotColor
{
    self.dayDotColor = dotColor;
    self.dayDotColorSelected = dotColor;
    
    self.dayDotColorOtherMonth = dotColor;
    self.dayDotColorSelectedOtherMonth = dotColor;
    
    self.dayDotColorToday = dotColor;
    self.dayDotColorTodayOtherMonth = dotColor;
}

- (void)setDayStarColorForAll:(UIColor *)starColor
{
    self.dayStarColor = starColor;
    self.dayStarColorSelected = starColor;
    
    self.dayStarColorOtherMonth = starColor;
    self.dayStarColorSelectedOtherMonth = starColor;
    
    self.dayStarColorToday = starColor;
    self.dayStarColorTodayOtherMonth = starColor;
}

- (void)setDayTextColorForAll:(UIColor *)textColor
{
    self.dayTextColor = textColor;
    self.dayTextColorSelected = textColor;
    
    self.dayTextColorOtherMonth = textColor;
    self.dayTextColorSelectedOtherMonth = textColor;
    
    self.dayTextColorToday = textColor;
    self.dayTextColorTodayOtherMonth = textColor;
}

@end