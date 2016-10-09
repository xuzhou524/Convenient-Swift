//
//  UUColor.h
//  UUChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define chartMargin         10
#define xLabelMargin        15
#define yLabelMargin        15
#define UULabelHeight       0    //这是下面label的高度
#define UUWHeight       20    //这是下面label的高度
#define UUYLabelwidth       0    //左边刻度的标记的宽度
#define UUTagLabelwidth     80

//范围
struct Range {
    CGFloat max;
    CGFloat min;
};
typedef struct Range CGRange;
CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange
CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0,0};

@interface UUColor : UIColor
+(UIColor *)randomColor;
+(UIColor *)randomColorDeep;
+(UIColor *)randomColorlight;
+(UIColor *)red;
+(UIColor *)green;
+(UIColor *)brown;
+(UIColor *)brownOne;
+(UIColor *)yellow;
@end
