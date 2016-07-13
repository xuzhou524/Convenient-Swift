//
//  LBCalendar.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBCalendar.h"
#define NUMBER_PAGES_LOADED 5 

@interface LBCalendar(){
    LBCalendarAppearance *calendarAppearance;
    BOOL cacheLastWeekMode;
}

@end

@implementation LBCalendar

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self->_currentDate = [NSDate date];
    calendarAppearance = [LBCalendarAppearance new];
    
    return self;
}

- (void)setContentView:(LBCalendarContentView *)contentView
{
    [self->_contentView setDelegate:nil];
    [self->_contentView setCalendarManager:nil];
    
    self->_contentView = contentView;
    [self->_contentView setDelegate:self];
    [self->_contentView setCalendarManager:self];
    
    [self.contentView setCurrentDate:self.currentDate];
    [self.contentView reloadAppearance];
}

- (void)reloadData
{
    // Position to the middle page
    CGFloat pageWidth = CGRectGetWidth(self.contentView.frame);
    self.contentView.contentOffset = CGPointMake(pageWidth * ((NUMBER_PAGES_LOADED / 2)), self.contentView.contentOffset.y);
    
    [self.contentView reloadData];
    
}

- (void)reloadAppearance
{
    [self.contentView reloadAppearance];
    
    if(cacheLastWeekMode != self.calendarAppearance.isWeekMode){
        cacheLastWeekMode = self.calendarAppearance.isWeekMode;
        [self setCurrentDate:self.currentDate]; // Reload all data
    }
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    self->_currentDate = currentDate;
    
    [self.contentView setCurrentDate:currentDate];
    
    [self reloadData]; // For be on the good page and update all DayView
    
}

- (LBCalendarAppearance *)calendarAppearance
{
    return calendarAppearance;
}

#pragma mark - UIScrollView delegate

// Use for scroll with scrollRectToVisible or setContentOffset
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)updatePage
{
    CGFloat pageWidth = CGRectGetWidth(self.contentView.frame);
    CGFloat fractionalPage = self.contentView.contentOffset.x / pageWidth;
    
    int currentPage = roundf(fractionalPage);
    if (currentPage == (NUMBER_PAGES_LOADED / 2)){
        self.contentView.scrollEnabled = YES;
        return;
    }
    
    NSCalendar *calendar = calendarAppearance.calendar;
    NSDateComponents *dayComponent = [NSDateComponents new];
    
    if(!self.calendarAppearance.isWeekMode){
        dayComponent.month = currentPage - (NUMBER_PAGES_LOADED / 2);
    }
    else{
        dayComponent.day = 7 * (currentPage - (NUMBER_PAGES_LOADED / 2));
    }
    
    NSDate *currentDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
    
    [self setCurrentDate:currentDate];
    
    self.contentView.scrollEnabled = YES;
}

- (void)loadNextMonth
{
    if(self.calendarAppearance.isWeekMode){
        NSLog(@"LBCalendar loadNextMonth ignored");
        return;
    }
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = frame.size.width * ((NUMBER_PAGES_LOADED / 2) + 1);
    frame.origin.y = 0;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

- (void)loadPreviousMonth
{
    if(self.calendarAppearance.isWeekMode){
        NSLog(@"LBCalendar loadPreviousMonth ignored");
        return;
    }
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = frame.size.width * ((NUMBER_PAGES_LOADED / 2) - 1);
    frame.origin.y = 0;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

@end
