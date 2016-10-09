//
//  LBRectangularView.m
//  Calendar module
//
//  Created by king on 1511-4-308.
//  Copyright © 2015年 luqinbin. All rights reserved.
//

#import "LBRectangularView.h"

@implementation LBRectangularView

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor whiteColor];
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    CGContextSetFillColorWithColor(ctx, [self.backgroundColor CGColor]);
    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    
    CGContextFillPath(ctx);
}

- (void)setColor:(UIColor *)color
{
    self->_color = color;
    
    [self setNeedsDisplay];
}

@end

