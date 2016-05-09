//
//  CityMdoel.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import ObjectMapper

class CityMdoel: BaseJsonModel {
    var data :[CityDataMdoel]?
    
    override func mapping(map: Map) {
        data <- map["data"]
    }
}

class CityDataMdoel: BaseJsonModel {
    var city_level_id: String?
    var cityid: String?
    var country: String?
    var name: String?
    var prov: String?

    override func mapping(map: Map) {
        city_level_id <- map["city_level_id"]
        cityid <- map["cityid"]
        country <- map["country"]
        name <- map["name"]
        prov <- map["prov"]
    }
}
