//
//  DateSelectView.m
//  Calendar module
//
//  Created by king on 1510-29-302.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "DateSelectView.h"

@implementation DateSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
 
    _datePicker = [[UIDatePicker alloc]init];
    _datePicker.frame = CGRectMake(0, 44, frame.size.width, frame.size.height-88);
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker setDate:[NSDate date]];
    [self addSubview:_datePicker];
    
    UILabel *datePickerTitle = [[UILabel alloc]init];
    datePickerTitle.frame = CGRectMake(0, 0, frame.size.width, 44);
    datePickerTitle.text = @"选择日期";
    datePickerTitle.backgroundColor = [UIColor grayColor];
    datePickerTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:datePickerTitle];
    
    UIButton * cancelBt = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBt.frame = CGRectMake(0, frame.size.height-44, frame.size.width/2, 44);
    [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
    cancelBt.backgroundColor = [UIColor whiteColor];
    cancelBt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelBt addTarget:self action:@selector(cancelBtTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBt];
    
    UIButton * selectedBt = [UIButton buttonWithType:UIButtonTypeSystem];
    selectedBt.frame = CGRectMake(frame.size.width/2, frame.size.height-44, frame.size.width/2, 44);
    [selectedBt setTitle:@"确定" forState:UIControlStateNormal];
    selectedBt.backgroundColor = [UIColor whiteColor];
    selectedBt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [selectedBt addTarget:self action:@selector(OKBtTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectedBt];
    
    
    
    return self;
}

- (void)cancelBtTap{

    [UIView animateWithDuration:.6 animations:^{

        self.frame = CGRectMake(0, [self superview].frame.size.height, [self superview].frame.size.width, 270);
        [self.delegate changAlpha:1.];
    } completion:^(BOOL finished) {
        
     /////////////////
        
    }];
    
    [_datePicker setDate:[NSDate date]];

}

- (void)OKBtTap{
    
    [self.delegate didTouchDatePickeOKBt:_datePicker.date];
   
    
}



@end
