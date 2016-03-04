//
//  WeatherModel.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/4.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import jastor


class WeatherModel: Jastor{
    var date : NSString?
    var isForeign : NSString?
    var life : Weather_lifeModel?
    var pm25 : Weather_pm25Model?
    var realtime : Weather_realtimeModel?
    var weather : NSMutableArray?
    
    override init!(dictionary: [NSObject : AnyObject]!) {
        super.init(dictionary: dictionary)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}


class Weather_lifeModel: Jastor {
    var date : NSString?
    var info : life_infoModel?
}


class life_infoModel: Jastor {
    var chuanyi : NSMutableArray?
    var ganmao : NSMutableArray?
    var kongtiao : NSMutableArray?
    var wuran : NSMutableArray?
    var xiche : NSMutableArray?
    var yundong : NSMutableArray?
    var ziwaixian : NSMutableArray?
}


class Weather_pm25Model: Jastor {
    var cityName : NSString?
    var dateTime : NSString?
    var key : NSString?
    var pm25 : pm25_pam25Model?
    var show_desc : NSString?
}


class pm25_pam25Model: Jastor {
    var curPm : NSString?
    var des : NSString?
    var level : NSString?
    var pm10 : NSString?
    var pm25 : NSString?
    var quality : NSString?
}



class Weather_realtimeModel: Jastor {
    var city_code : NSString?
    var city_name : NSString?
    var dataUptime : NSString?
    var date : NSString?
    var moon : NSString?
    var time : NSString?
    
    var weather : realtime_weatherModel?
    var week : NSString?
    var wind : realtime_windModel?
}

class realtime_weatherModel: Jastor {
    var humidity : NSString?
    var img : NSString?
    var info : NSString?
    var temperature : NSString?
}

class realtime_windModel: Jastor {
    var direct : NSString?
    var offset : NSString?
    var power : NSString?
    var windspeed : NSString?
}


class weather_weatherModel: Jastor {
    var date : NSString?
    var info : weather_infoModel?
    var nongli : NSString?
    var week : NSString?
}
class weather_infoModel: Jastor {
    var day : NSMutableArray?
    var night : NSMutableArray?
}











