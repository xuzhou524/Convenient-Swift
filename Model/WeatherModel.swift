//
//  WeatherModel.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/4.
//  Copyright © 2016年 xuzhou. All rights reserved.
//
import UIKit
import jastor
import ObjectMapper

class WeatherModel: BaseJsonModel{
    var date : String?
    var isForeign : String?
    var life : Weather_lifeModel?
    var pm25 : Weather_pm25Model?
    var realtime : Weather_realtimeModel?
    var weather : [weather_weatherModel]?
    
    override func mapping(map: Map) {
        date <- map["date"]
        isForeign <- map["isForeign"]
        life <- map["life"]
        pm25 <- map["pm25"]
        realtime <- map["realtime"]
        weather <- map["weather"]
    }
}


class Weather_lifeModel: BaseJsonModel {
    var date : String?
    var info : life_infoModel!
    
    override func mapping(map: Map) {
        date <- map["date"]
        info <- map["info"]
    }
}


class life_infoModel: BaseJsonModel {
    var chuanyi : NSMutableArray?
    var ganmao : NSMutableArray?
    var kongtiao : NSMutableArray?
    var wuran : NSMutableArray?
    var xiche : NSMutableArray?
    var yundong : NSMutableArray?
    var ziwaixian : NSMutableArray?
    
    override func mapping(map: Map) {
        chuanyi <- map["chuanyi"]
        ganmao <- map["ganmao"]
        kongtiao <- map["kongtiao"]
        wuran <- map["pm25"]
        xiche <- map["xiche"]
        yundong <- map["yundong"]
        ziwaixian <- map["ziwaixian"]
    }
}


class Weather_pm25Model: BaseJsonModel {
    var cityName : String?
    var dateTime : String?
    var key : String?
    var pm25 : pm25_pam25Model?
    var show_desc : String?
    
    override func mapping(map: Map) {
        cityName <- map["cityName"]
        dateTime <- map["dateTime"]
        key <- map["key"]
        pm25 <- map["pm25"]
        show_desc <- map["show_desc"]
    }
}


class pm25_pam25Model: BaseJsonModel {
    var curPm : String?
    var des : String?
    var level : String?
    var pm10 : String?
    var pm25 : String?
    var quality : String?
    override func mapping(map: Map) {
        curPm <- map["curPm"]
        des <- map["des"]
        level <- map["level"]
        pm25 <- map["pm25"]
        pm10 <- map["pm10"]
        quality <- map["quality"]
    }
}



class Weather_realtimeModel: BaseJsonModel {
    var city_code : String?
    var city_name : String?
    var dataUptime : String?
    var date : String?
    var moon : String?
    var time : String?
    
    var weather : realtime_weatherModel?
    var week : String?
    var wind : realtime_windModel?
    
    override func mapping(map: Map) {
        city_code <- map["city_code"]
        city_name <- map["city_name"]
        dataUptime <- map["dataUptime"]
        date <- map["date"]
        moon <- map["moon"]
        weather <- map["weather"]
        time <- map["time"]
        week <- map["week"]
        wind <- map["wind"]
    }
}

class realtime_weatherModel: BaseJsonModel {
    var humidity : String?
    var img : String?
    var info : String?
    var temperature : String?
    
    override func mapping(map: Map) {
        humidity <- map["humidity"]
        img <- map["img"]
        info <- map["info"]
        temperature <- map["temperature"]
    }
}

class realtime_windModel: BaseJsonModel {
    var direct : String?
    var offset : String?
    var power : String?
    var windspeed : String?
    
    override func mapping(map: Map) {
        direct <- map["direct"]
        offset <- map["offset"]
        power <- map["power"]
        windspeed <- map["windspeed"]
    }
}


class weather_weatherModel: BaseJsonModel {
    var date : String?
    var info : weather_infoModel?
    var nongli : String?
    var week : String?
    
    override func mapping(map: Map) {
        date <- map["date"]
        info <- map["info"]
        nongli <- map["nongli"]
        week <- map["week"]
    }
}
class weather_infoModel: BaseJsonModel {
    var day : NSMutableArray?
    var night : NSMutableArray?
    
    override func mapping(map: Map) {
        day <- map["day"]
        night <- map["night"]
    }
}









