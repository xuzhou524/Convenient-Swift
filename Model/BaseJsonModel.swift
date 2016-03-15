//
//  BaseJsonModel.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/7.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import ObjectMapper


class BaseJsonModel:NSObject, NSCoding, Mappable {
    required init?(_ map: Map) {
        
    }
    required init?(coder aDecoder: NSCoder){
        super.init()
    }
    func encodeWithCoder(aCoder: NSCoder){
        
    }
    func mapping(map: Map) {
        
    }
}