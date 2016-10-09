//
//  DateSelectView.h
//  Calendar module
//
//  Created by king on 1510-29-302.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeBGScrollviewAlphaDelegate <NSObject>

- (void)changAlpha: (float )BGAlpha;
- (void)didTouchDatePickeOKBt:(NSDate *)date1;


@end

@interface DateSelectView : UIView
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, strong) id<ChangeBGScrollviewAlphaDelegate> delegate;
- (void)cancelBtTap;

@end
