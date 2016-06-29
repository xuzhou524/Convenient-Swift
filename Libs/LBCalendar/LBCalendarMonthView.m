//
//  LBCalendarMonthView.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBCalendarMonthView.h"

#import "LBCalendarMonthWeekDaysView.h"
#import "LBCalendarWeekView.h"

#define WEEKS_TO_DISPLAY 6

@interface LBCalendarMonthView (){
    LBCalendarMonthWeekDaysView *weekdaysView;
    NSArray *weeksViews;
    
    NSUInteger currentMonthIndex;
    
    BOOL cacheLastWeekMode; // Avoid some operations
};

@end

@implementation LBCalendarMonthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    NSMutableArray *views = [NSMutableArray new];
    
    for(int i = 0; i < WEEKS_TO_DISPLAY; ++i){
        UIView *view = [LBCalendarWeekView new];
        
        [views addObject:view];
        [self addSubview:view];
    }
    
    weeksViews = views;
    
    cacheLastWeekMode = self.calendarManager.calendarAppearance.isWeekMode;
}

- (void)layoutSubviews
{
    [self configureConstraintsForSubviews];
    
    [super layoutSubviews];
}

- (void)configureConstraintsForSubviews
{
    CGFloat weeksToDisplay;
    
    if(cacheLastWeekMode){
        weeksToDisplay = 1.;
    }
    else{
        weeksToDisplay = (CGFloat)(WEEKS_TO_DISPLAY);
    }
    
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height / weeksToDisplay;
    
    for(int i = 0; i < self.subviews.count; ++i){
        UIView *view = self.subviews[i];
        
        view.frame = CGRectMake(0, y, width, height);
        y = CGRectGetMaxY(view.frame);
        
        if(cacheLastWeekMode && i == weeksToDisplay - 1){
            height = 0.;
        }
    }
}

- (void)setBeginningOfMonth:(NSDate *)date
{
    NSDate *currentDate = date;
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    {
        NSDateComponents *comps = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        
        currentMonthIndex = comps.month;
        
        // Hack
        if(comps.day > 7){
            currentMonthIndex = (currentMonthIndex % 12) + 1;
        }
    }
    
    for(LBCalendarWeekView *view in weeksViews){
        view.currentMonthIndex = currentMonthIndex;
        [view setBeginningOfWeek:currentDate];
        
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 7;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
        
        // Doesn't need to do other weeks
        if(self.calendarManager.calendarAppearance.isWeekMode){
            break;
        }
    }
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(LBCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    
    [weekdaysView setCalendarManager:calendarManager];
    for(LBCalendarWeekView *view in weeksViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadData
{
    for(LBCalendarWeekView *view in weeksViews){
        [view reloadData];
        
        // Doesn't need to do other weeks
        if(self.calendarManager.calendarAppearance.isWeekMode){
            break;
        }
    }
}

- (void)reloadAppearance
{
    if(cacheLastWeekMode != self.calendarManager.calendarAppearance.isWeekMode){
        cacheLastWeekMode = self.calendarManager.calendarAppearance.isWeekMode;
        [self configureConstraintsForSubviews];
    }
    
    [LBCalendarMonthWeekDaysView beforeReloadAppearance];
    [weekdaysView reloadAppearance];
    
    for(LBCalendarWeekView *view in weeksViews){
        [view reloadAppearance];
    }
}

@end
