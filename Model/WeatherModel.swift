//
//  WeatherModel.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/4.
//  Copyright © 2016年 xuzhou. All rights reserved.
//
import UIKit
import jastor
import Alamofire
import ObjectMapper


class WeatherModel: NSObject, Mappable{
    var life : Weather_lifeModel?
    var pm25 : Weather_pm25Model?
    var realtime : Weather_realtimeModel?
    var weather : [weather_weatherModel]?
    var xxweihao : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return WeatherModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        life <- map["life"]
        pm25 <- map["pm25"]
        realtime <- map["realtime"]
        weather <- map["weather"]
        xxweihao <- map["xxweihao"]

    }

    class func like(_ cityname: String, success: @escaping (WeatherModel) -> Void, failure: @escaping (NSError?) -> Void) {
        let urlString = "https://op.juhe.cn/onebox/weather/query"
        let prames = [
            "cityname" : cityname,
            "key" : "af34bbdd7948b379a0d218fc2c59c8ba"
        ]
        //注释一下下
//        Alamofire.request(urlString, method:.post, parameters: prames).responseJSON{ (response) -> Void in
//            if response.result.error == nil {
//                if let dict = response.result.value as? NSDictionary {
//                    if let dicts = dict["result"] as? NSDictionary {
//                        if let dictss = dicts["data"] as? NSDictionary {
//                            if let model = WeatherModel(dictionary: dictss as! [AnyHashable: Any]) {
//                                success(model)
//                                return
//                            }
//                        }
//                    }
//                }
//            }else{
//                failure(response.result.error as! NSError)
//            }
//        }
    
//        requestModel(String(format: urlString), parameters: prames as [String : AnyObject], success: success as! (BaseModel) -> Void, failure: failure)
    }
    
}

class Weather_lifeModel: NSObject, Mappable {
    var date : String?
    var info : life_infoModel?
    
    class func newInstance(map: Map) -> Mappable?{
        return Weather_lifeModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        date <- map["date"]
        info <- map["info"]

    }

}

class life_infoModel: NSObject, Mappable {
    var chuanyi : NSMutableArray?
    var ganmao : NSMutableArray?
    var kongtiao : NSMutableArray?
    var wuran : NSMutableArray?
    var xiche : NSMutableArray?
    var yundong : NSMutableArray?
    var ziwaixian : NSMutableArray?
    
    class func newInstance(map: Map) -> Mappable?{
        return life_infoModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        chuanyi <- map["chuanyi"]
        ganmao <- map["ganmao"]
        
        kongtiao <- map["kongtiao"]
        wuran <- map["wuran"]
        ziwaixian <- map["ziwaixian"]
        xiche <- map["xiche"]
        yundong <- map["yundong"]

    }
}

class Weather_pm25Model: NSObject, Mappable {
    var cityName : String?
    var dateTime : String?
    var key : String?
    var pm25 : pm25_pam25Model?
    var show_desc : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return Weather_pm25Model()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        cityName <- map["cityName"]
        dateTime <- map["dateTime"]
        
        key <- map["key"]
        pm25 <- map["pm25"]
        show_desc <- map["show_desc"]

    }
    
}

class pm25_pam25Model: NSObject, Mappable {
    var curPm : String?
    var des : String?
    var level : String?
    var pm10 : String?
    var pm25 : String?
    var quality : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return pm25_pam25Model()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        curPm <- map["curPm"]
        des <- map["des"]
        
        level <- map["level"]
        pm25 <- map["pm25"]
        pm10 <- map["pm10"]
        quality <- map["quality"]

    }
}

class Weather_realtimeModel: NSObject, Mappable {
    var city_code : String?
    var city_name : String?
    var dataUptime : String?
    var date : String?
    var moon : String?
    var time : String?
    
    var weather : realtime_weatherModel?
    var week : String?
    var wind : realtime_windModel?
    
    class func newInstance(map: Map) -> Mappable?{
        return Weather_realtimeModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        city_code <- map["city_code"]
        city_name <- map["city_name"]
        
        dataUptime <- map["dataUptime"]
        date <- map["date"]
        moon <- map["moon"]
        time <- map["time"]
        
        weather <- map["weather"]
        week <- map["week"]
        wind <- map["wind"]


    }
}

class realtime_weatherModel: NSObject, Mappable {
    var humidity : String?
    var img : String?
    var info : String?
    var temperature : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return realtime_weatherModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        humidity <- map["humidity"]
        img <- map["img"]
        
        info <- map["info"]
        temperature <- map["temperature"]

    }
}

class realtime_windModel: NSObject, Mappable {
    var direct : String?
    var offset : String?
    var power : String?
    var windspeed : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return realtime_windModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        direct <- map["direct"]
        offset <- map["offset"]
        
        power <- map["power"]
        windspeed <- map["windspeed"]

    }
}


class weather_weatherModel: NSObject, Mappable {
    var date : String?
    var info : weather_infoModel?
    var nongli : String?
    var week : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return weather_weatherModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        date <- map["date"]
        info <- map["info"]
        
        nongli <- map["nongli"]
        week <- map["week"]

    }
}

class weather_infoModel: NSObject, Mappable {
    var day : [String]?
    var night : [String]?
    class func newInstance(map: Map) -> Mappable?{
        return weather_infoModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map){
        day <- map["day"]
        night <- map["night"]

    }
}

//func requestModel< T: BaseModel >(_ uRLString: String, parameters: [String: AnyObject]? = nil, success: @escaping (T) -> Void, failure: @escaping (NSError?) -> Void) {
//
//    //注释一下下
////    Alamofire.request(uRLString, method:.post, parameters: parameters).responseJSON{ (response) -> Void in
////        if response.result.error == nil {
////            if let dict = response.result.value as? NSDictionary {
////                if let dicts = dict["result"] as? NSDictionary {
////                    if let dictss = dicts["data"] as? NSDictionary {
////                        if let model = T(dictionary: dictss as! [AnyHashable: Any]) {
////                            success(model)
////                            return
////                        }
////                    }
////                }
////            }
////        }else{
////            failure(response.result.error as! NSError)
////        }
////    }
//}


