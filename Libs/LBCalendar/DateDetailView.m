//
//  DateDetailView.m
//  Calendar module
//
//  Created by king on 1511-3-307.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "DateDetailView.h"
#import "DateMessageView.h"

@implementation DateDetailView{
    UISegmentedControl *segmentControl;
    UILabel *dayLabel1;
    UILabel *dayLabel2;
    UILabel *dayLabel3;
    UIButton *segmentBtLeft;
    UIButton *segmentBtRight;
    DateMessageView *messageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"dd"];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    
    UIView *viewTop = [[UIView alloc]init];
    viewTop.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    viewTop.backgroundColor= [UIColor colorWithRed:255/255. green:211/255. blue:186/255. alpha:1];
    
    dayLabel1 = [[UILabel alloc]init];
    dayLabel1.frame = CGRectMake(0, 0, self.frame.size.width/6., 60);
    dayLabel1.text = [dateFormatter1 stringFromDate:[NSDate date]];
    dayLabel1.font = [UIFont systemFontOfSize:35];
    dayLabel1.textColor = [UIColor colorWithRed:40/255. green:101/255. blue:221/255. alpha:1];
    dayLabel1.textAlignment = NSTextAlignmentCenter;
    [viewTop addSubview:dayLabel1];
    
    dayLabel2 = [[UILabel alloc]init];
    dayLabel2.frame = CGRectMake(dayLabel1.frame.size.width, 2, self.frame.size.width/6.*2.5, 30);
    dayLabel2.text = [dateFormatter2 stringFromDate:[NSDate date]];
    dayLabel2.font = [UIFont systemFontOfSize:18];
    dayLabel2.textColor = [UIColor grayColor];
    [viewTop addSubview:dayLabel2];
    
    dayLabel3 = [[UILabel alloc]init];
    dayLabel3.frame = CGRectMake(dayLabel1.frame.size.width, 28, self.frame.size.width/6.*2.5, 30);
    dayLabel3.text = [self getChineseCalendarWithDate:[NSDate date]];
    dayLabel3.font = [UIFont systemFontOfSize:18];
    dayLabel3.textColor = [UIColor grayColor];
    [viewTop addSubview:dayLabel3];
    
    UIButton *scheduleAddBt = [UIButton buttonWithType:UIButtonTypeSystem];
    scheduleAddBt.frame = CGRectMake(self.frame.size.width/6.*5-20, 0, self.frame.size.width/6., 60);
    [scheduleAddBt setTitle:@"添加日程" forState:UIControlStateNormal];
    [viewTop addSubview:scheduleAddBt];
    
    [self addSubview:viewTop];
    
    segmentBtLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    segmentBtLeft.frame = CGRectMake(0, 60, self.frame.size.width/2, 44);
    [segmentBtLeft setTitle:@"我的日程" forState:UIControlStateNormal];
    segmentBtLeft.titleLabel.textAlignment = NSTextAlignmentCenter;
    [segmentBtLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [segmentBtLeft setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [segmentBtLeft setBackgroundImage:[UIImage imageNamed:@"segmentBtbg.png"] forState:UIControlStateSelected];
    segmentBtLeft.backgroundColor = [UIColor colorWithRed:215/255. green:215/255. blue:215/255. alpha:1];
    [segmentBtLeft addTarget:self action:@selector(segmentBtLeftAction) forControlEvents:UIControlEventTouchUpInside];
    segmentBtLeft.selected = YES;
    [self addSubview:segmentBtLeft];
    
    segmentBtRight = [UIButton buttonWithType:UIButtonTypeCustom];
    segmentBtRight.frame = CGRectMake(self.frame.size.width/2, 60, self.frame.size.width/2, 44);
    [segmentBtRight setTitle:@"@我的" forState:UIControlStateNormal];
    segmentBtRight.titleLabel.textAlignment = NSTextAlignmentCenter;
    [segmentBtRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [segmentBtRight setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [segmentBtRight setBackgroundImage:[UIImage imageNamed:@"segmentBtbg.png"] forState:UIControlStateSelected];
    segmentBtRight.backgroundColor = [UIColor colorWithRed:215/255. green:215/255. blue:215/255. alpha:1];
   
    [segmentBtRight addTarget:self action:@selector(segmentBtRightAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:segmentBtRight];
    
    //messageView = [[DateMessageView alloc]initWithFrame:CGRectMake(0, 104, self.frame.size.width, self.frame.size.height-104)];

    //[self addSubview:messageView];
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDay:) name:@"DaySelected" object:nil];
    
    return self;
}

-(void)segmentBtLeftAction{
    
    segmentBtRight.selected = NO;
    segmentBtLeft.selected = YES;
    
}

-(void)segmentBtRightAction{
    
    segmentBtLeft.selected = NO;
    segmentBtRight.selected = YES;
    
}

- (NSString*)getChineseCalendarWithDate:(NSDate *)date{

    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSArray *weekDays=[NSArray arrayWithObjects:
                          @" ",@"星期日",@"星期一",@"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @" ",nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSInteger unitFlags =  NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@%@",m_str,d_str];
    
    NSInteger weekDayFlag = [localeCalendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSString *weekDay_str = weekDays[weekDayFlag];
    
    NSString *dayLabel3_str = [NSString stringWithFormat:@"%@ %@",chineseCal_str,weekDay_str];

    return dayLabel3_str;
}

- (void)reloadDay:(NSNotification *)notification{
    
    NSDate *date = [notification object];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"dd"];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    
    dayLabel1.text = [dateFormatter1 stringFromDate:date];
    dayLabel2.text = [dateFormatter2 stringFromDate:date];
    dayLabel3.text = [self getChineseCalendarWithDate:date];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

@end
