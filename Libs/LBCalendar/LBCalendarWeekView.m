//
//  LBCalendarWeekView.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBCalendarWeekView.h"

#import "LBCalendarDayView.h"

@interface LBCalendarWeekView (){
    NSArray *daysViews;
};

@end

@implementation LBCalendarWeekView

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
    
    for(int i = 0; i < 7; ++i){
        UIView *view = [LBCalendarDayView new];
        
        [views addObject:view];
        [self addSubview:view];
    }
    
    daysViews = views;
}

- (void)layoutSubviews
{
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
    
    [super layoutSubviews];
}

- (void)setBeginningOfWeek:(NSDate *)date
{
    NSDate *currentDate = date;
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    for(LBCalendarDayView *view in daysViews){
        if(!self.calendarManager.calendarAppearance.isWeekMode){
            NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
            NSInteger monthIndex = comps.month;
            
            [view setIsOtherMonth:monthIndex != self.currentMonthIndex];
        }
        else{
            [view setIsOtherMonth:NO];
        }
        
        [view setDate:currentDate];
        
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 1;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(LBCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    for(LBCalendarDayView *view in daysViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadData
{
    for(LBCalendarDayView *view in daysViews){
        [view reloadData];
    }
}

- (void)reloadAppearance
{
    for(LBCalendarDayView *view in daysViews){
        [view reloadAppearance];
    }
}

@end
