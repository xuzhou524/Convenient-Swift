//
//  LBStarView.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBStarView.h"

@implementation LBStarView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor whiteColor];
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [self.backgroundColor CGColor]);
    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    
    CGPoint centerPoint=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGFloat radius=5.0;
    
    CGPoint p1=CGPointMake(centerPoint.x, centerPoint.y-radius);
    CGContextMoveToPoint(ctx, p1.x, p1.y);
    
    CGFloat angle=4*M_PI/5.0;
    for (int i=1; i<=5; i++) {
        CGFloat x=centerPoint.x-sinf(i*angle)*radius;
        CGFloat y=centerPoint.y-cosf(i*angle)*radius;
        CGContextAddLineToPoint(ctx, x, y);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)setColor:(UIColor *)color
{
    self->_color = color;
    
    [self setNeedsDisplay];
}


@end

