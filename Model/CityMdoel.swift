//
//  CityMdoel.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import ObjectMapper

class CityMdoel: NSObject, Mappable {
    var status :String?
    var data :[CityDataMdoel]?
    
    class func newInstance(map: Map) -> Mappable?{
        return CityMdoel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        status <- map["status"]
        data <- map["data"]
    }
}

class CityDataMdoel: NSObject, Mappable {
    var city_level_id: String?
    var cityid: String?
    var country: String?
    var name: String?
    var prov: String?
    
    class func newInstance(map: Map) -> Mappable?{
        return CityDataMdoel()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map){
        city_level_id <- map["city_level_id"]
        cityid <- map["cityid"]
        country <- map["country"]
        name <- map["name"]
        prov <- map["prov"]
    }
}
