//
//  BaseModel.m
//  Convenient-Swift
//
//  Created by gozap on 16/3/11.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
//Make all model properties optional (avoid if possible)
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(instancetype)initWithDictionary:(NSDictionary*)dict {
    return (self = [[super init] initWithDictionary:dict error:nil]);
}

@end
