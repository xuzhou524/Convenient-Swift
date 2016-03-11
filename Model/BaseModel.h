//
//  BaseModel.h
//  Convenient-Swift
//
//  Created by gozap on 16/3/11.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface BaseModel : JSONModel

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
