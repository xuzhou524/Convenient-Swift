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

class WeatherModel: BaseModel {
    var date : String?
    var isForeign : String?
    var life : Weather_lifeModel?
    var pm25 : Weather_pm25Model?
    var realtime : Weather_realtimeModel?
    var weather : NSMutableArray = [weather_weatherModel()]
    

    
   
   class func like(cityname: String, success: (WeatherModel) -> Void, failure: (NSError?) -> Void) {
        let urlString = "http://op.juhe.cn/onebox/weather/query"
        let prames = [
            "cityname" : cityname,
            "key" : "af34bbdd7948b379a0d218fc2c59c8ba"
        ]
        requestModel(.POST, String(format: urlString), parameters: prames, success: success, failure: failure)
    }
}

class Weather_lifeModel: BaseModel {
    var date : String?
    var info : life_infoModel!

}

class life_infoModel: BaseModel {
    var chuanyi : NSMutableArray?
    var ganmao : NSMutableArray?
    var kongtiao : NSMutableArray?
    var wuran : NSMutableArray?
    var xiche : NSMutableArray?
    var yundong : NSMutableArray?
    var ziwaixian : NSMutableArray?
}

class Weather_pm25Model: BaseModel {
    var cityName : String?
    var dateTime : String?
    var key : String?
    var pm25 : pm25_pam25Model?
    var show_desc : String?
}

class pm25_pam25Model: BaseModel {
    var curPm : String?
    var des : String?
    var level : String?
    var pm10 : String?
    var pm25 : String?
    var quality : String?
}

class Weather_realtimeModel: BaseModel {
    var city_code : String?
    var city_name : String?
    var dataUptime : String?
    var date : String?
    var moon : String?
    var time : String?
    
    var weather : realtime_weatherModel?
    var week : String?
    var wind : realtime_windModel?
}

class realtime_weatherModel: BaseModel {
    var humidity : String?
    var img : String?
    var info : String?
    var temperature : String?
}

class realtime_windModel: BaseModel {
    var direct : String?
    var offset : String?
    var power : String?
    var windspeed : String?
}


class weather_weatherModel: BaseModel {
    var date : String?
    var info : weather_infoModel?
    var nongli : String?
    var week : String?
}
class weather_infoModel: BaseModel {
    var day : NSMutableArray?
    var night : NSMutableArray?
}

func requestModel< T: BaseModel >(method: Alamofire.Method, _ URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, success: (T) -> Void, failure: (NSError?) -> Void) {
    Alamofire.request(.POST, URLString , parameters: parameters, encoding: .URL).responseJSON{ (response) -> Void in
        print(response)
        if response.result.error == nil {
            if let dict = response.result.value as? NSDictionary {
                if let dicts = dict["result"] as? NSDictionary {
                    if let dictss = dicts["data"] as? NSDictionary {
                        if let model = T(dictionary: dictss as [NSObject : AnyObject]) {
                            success(model)
                            return
                        }
                    }
                }
            }
        }else{
            failure(response.result.error)
        }
    }
}


