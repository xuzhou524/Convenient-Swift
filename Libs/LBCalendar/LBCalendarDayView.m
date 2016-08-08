//
//  LBCalendarDayView.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBCalendarDayView.h"
#import "LBRectangularView.h"
#import "LBStarView.h"

@interface LBCalendarDayView (){
    LBRectangularView *rectangularView;
    UILabel *textLabel;
    UILabel *dateLabel;
    LBRectangularView *dotView;
    LBStarView * starView;
    
    BOOL isSelected;
    
    int cacheIsToday;
    NSString *cacheCurrentDateText;
}
@end

static NSString *kLBCalendarDaySelected = @"kLBCalendarDaySelected";

@implementation LBCalendarDayView

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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)commonInit
{
    isSelected = NO;
    self.isOtherMonth = NO;
    
    {
        rectangularView = [LBRectangularView new];
        [self addSubview:rectangularView];
    }
    
    {
        textLabel = [UILabel new];
        [self addSubview:textLabel];
        
        dateLabel = [UILabel new];
        [self addSubview:dateLabel];
    }
    
    {
        dotView = [LBRectangularView new];
        [self addSubview:dotView];
        dotView.hidden = YES;
    }
    {
        starView = [LBStarView new];
        [self addSubview:starView];
        starView.hidden =YES;
    }
    
    {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouch)];
        
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
    }
    
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDaySelected:) name:kLBCalendarDaySelected object:nil];
    }
}

- (void)layoutSubviews
{
    [self configureConstraintsForSubviews];
    
    
}


- (void)configureConstraintsForSubviews
{
    textLabel.frame = CGRectMake(0, -5, self.frame.size.width, self.frame.size.height);
    dateLabel.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height);
    
    CGFloat sizeRectangular = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat sizeDot = sizeRectangular;
    
    sizeRectangular = sizeRectangular * self.calendarManager.calendarAppearance.dayRectangularRatio;
    sizeDot = sizeDot * self.calendarManager.calendarAppearance.dayDotRatio;
    
    sizeRectangular = roundf(sizeRectangular);
    sizeDot = roundf(sizeDot);
    
    rectangularView.frame = CGRectMake(0, 0, sizeRectangular, sizeRectangular);
    rectangularView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    rectangularView.layer.cornerRadius = 6.0;
    
    dotView.frame = CGRectMake(0, 0, sizeDot, sizeDot);
    dotView.center = CGPointMake(self.frame.size.width / 2.+12, (self.frame.size.height / 2.) + sizeDot * 1.8);
    dotView.layer.cornerRadius = sizeDot / 2.;
    
    starView.frame = CGRectMake(0, 0, sizeDot*3, sizeDot*3);
    starView.center = CGPointMake(self.frame.size.width / 2., (self.frame.size.height / 2.) + sizeDot * 1.8);
    
}

- (void)setDate:(NSDate *)date
{

    self->_date = date;
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSDateComponents *comps = [calendar components: NSCalendarUnitDay fromDate:date];
    
    textLabel.text = [NSString stringWithFormat:@"%ld",comps.day];
    dateLabel.text = [self chineseCalendarOfDate:date];
    
    cacheIsToday = -1;
    cacheCurrentDateText = nil;
}

- (void)didTouch
{
    [self setSelected:YES animated:YES];
    [self.calendarManager setCurrentDateSelected:self.date];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLBCalendarDaySelected object:self.date];
    
    [self.calendarManager.dataSource calendarDidDateSelected:self.calendarManager date:self.date];
    
    if(!self.isOtherMonth){
        return;
    }
    
    NSInteger currentMonthIndex = [self monthIndexForDate:self.date];
    NSInteger calendarMonthIndex = [self monthIndexForDate:self.calendarManager.currentDate];
    
    currentMonthIndex = currentMonthIndex % 12;
    
    if(currentMonthIndex == (calendarMonthIndex + 1) % 12){
        [self.calendarManager loadNextMonth];
    }
    else if(currentMonthIndex == (calendarMonthIndex + 12 - 1) % 12){
        [self.calendarManager loadPreviousMonth];
    }
    
}

- (void)didDaySelected:(NSNotification *)notification
{
    NSDate *dateSelected = [notification object];
    
    if([self isSameDate:dateSelected]){
        if(!isSelected){
            [self setSelected:YES animated:YES];
        }
    }
    else if(isSelected){
        [self setSelected:NO animated:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(isSelected == selected){
        animated = NO;
    }
    
    isSelected = selected;
    
    rectangularView.transform = CGAffineTransformIdentity;
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGFloat opacity = 1.;
    
    if(selected){
        if(!self.isOtherMonth){
            rectangularView.color = [self.calendarManager.calendarAppearance dayRectangularColorSelected];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelected];
            dateLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelected];
            dotView.color = [self.calendarManager.calendarAppearance dayDotColorSelected];
            starView.color = [self.calendarManager.calendarAppearance dayStarColorSelected];
        }
        else{
            rectangularView.color = [self.calendarManager.calendarAppearance dayRectangularColorSelectedOtherMonth];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelectedOtherMonth];
            dateLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelectedOtherMonth];
            dotView.color = [self.calendarManager.calendarAppearance dayDotColorSelectedOtherMonth];
            starView.color  = [self.calendarManager.calendarAppearance dayStarColorSelectedOtherMonth];
        }
        
        rectangularView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        tr = CGAffineTransformIdentity;
    }
    else if([self isToday]){
        if(!self.isOtherMonth){
            rectangularView.color = [self.calendarManager.calendarAppearance dayRectangularColorToday];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorToday];
            dateLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorToday];
            dotView.color = [self.calendarManager.calendarAppearance dayDotColorToday];
            starView.color  = [self.calendarManager.calendarAppearance dayStarColorToday];
        }
        else{
            rectangularView.color = [self.calendarManager.calendarAppearance dayRectangularColorTodayOtherMonth];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorTodayOtherMonth];
            dateLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorTodayOtherMonth];
            dotView.color = [self.calendarManager.calendarAppearance dayDotColorTodayOtherMonth];
            starView.color = [self.calendarManager.calendarAppearance dayStarColorTodayOtherMonth];
        }
    }
    else{
        if(!self.isOtherMonth){
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColor];
            dateLabel.textColor = [self.calendarManager.calendarAppearance dayTextColor];
            dotView.color = [self.calendarManager.calendarAppearance dayDotColor];
            starView.color = [self.calendarManager.calendarAppearance dayStarColor];
        }
        else{
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorOtherMonth];
            dateLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorOtherMonth];
            dotView.color = [self.calendarManager.calendarAppearance dayDotColorOtherMonth];
            starView.color = [self.calendarManager.calendarAppearance dayStarColorOtherMonth];
        }
        
        opacity = 0.;
    }
    
    if(animated){
        [UIView animateWithDuration:.3 animations:^{
            rectangularView.layer.opacity = opacity;
            rectangularView.transform = tr;
        }];
    }
    else{
        rectangularView.layer.opacity = opacity;
        rectangularView.transform = tr;
    }
}

- (void)setIsOtherMonth:(BOOL)isOtherMonth
{
    self->_isOtherMonth = isOtherMonth;
    [self setSelected:isSelected animated:NO];
}

- (void)reloadData
{
    dotView.hidden = ![self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:self.date];
    starView.hidden = ![self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:self.date];
    
    BOOL selected = [self isSameDate:[self.calendarManager currentDateSelected]];
    [self setSelected:selected animated:NO];
}

- (BOOL)isToday
{
    if(cacheIsToday == 0){
        return NO;
    }
    else if(cacheIsToday == 1){
        return YES;
    }
    else{
        if([self isSameDate:[NSDate date]]){
            cacheIsToday = 1;
            return YES;
        }
        else{
            cacheIsToday = 0;
            return NO;
        }
    }
}

- (BOOL)isSameDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    }
    
    if(!cacheCurrentDateText){
        cacheCurrentDateText = [dateFormatter stringFromDate:self.date];
    }
    
    NSString *dateText2 = [dateFormatter stringFromDate:date];
    
    if ([cacheCurrentDateText isEqualToString:dateText2]) {
        return YES;
    }
    
    return NO;
}

- (NSInteger)monthIndexForDate:(NSDate *)date
{
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:date];
    return comps.month;
}

- (void)reloadAppearance
{
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = self.calendarManager.calendarAppearance.dayTextFont;
    
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = self.calendarManager.calendarAppearance.dateTextFont;
    
    [self configureConstraintsForSubviews];
    [self setSelected:isSelected animated:NO];
}


// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    NSString * _day;
    //农历日期名
    NSArray *ChineseDays =  [NSArray arrayWithObjects:@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    //农历月份名
    NSArray *ChineseMonths =  [NSArray arrayWithObjects:@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月",nil];
    NSArray * ChineseFestival = @[@"除夕",@"春节",@"中秋",@"五一",@"国庆",@"儿童",@"圣诞",@"七夕",@"端午"];
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSCalendar *normalDate = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *Datecomponents = [normalDate components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    if (components.day ==1 ) {
        _day =ChineseMonths[components.month -1];
    } else {
        _day =ChineseDays[components.day -1];
    }
    
    //农历节日
    if (components.day ==1 && components.month ==1) {
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[1]]; //春节
    } if(components.month ==8 && components.day ==15){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[2]];//中秋
    }else if(components.month ==7 && components.day ==7){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[7]];//七夕
    }else if(components.month ==5 && components.day ==5){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[8]];//端午
    }
    
    //阳历节日
    if (Datecomponents.month ==6 && Datecomponents.day ==1) {       //儿童节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[5]];
    }else if(Datecomponents.month ==10 && Datecomponents.day ==1){  //国庆节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[4]];
    }else if(Datecomponents.month ==5 && Datecomponents.day ==1){   //劳动节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[3]];
    }else if(Datecomponents.month ==12 && Datecomponents.day ==25){ //圣诞节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[6]];
    }
    
    NSTimeInterval timeInterval_day = 60 *60 * 24;
    
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
    components = [chineseCalendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nextDay_date];
    
    if ( 1 == components.month && 1 == components.day ) {
        return@"除夕";
    }
    return _day;
}
@end
