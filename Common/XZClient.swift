//
//  XZClient.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/9.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
let KplacemarkName = "me.XZ.placemarkName"
let KweatherTefurbishTime = "me.XZ.weatherTefurbishTime"


class XZClient: NSObject {
   static let sharedInstance = XZClient()
    
   dynamic var username: String?
   dynamic var weatherTefurbishTime: String?
    
    
   fileprivate override init() {
        super.init()
        self.setupInMainThread()
    }
    
    func setupInMainThread() {
        if Thread.isMainThread {
            self.setup()
        }
        else {
            DispatchQueue.main.sync(execute: { () -> Void in
                self.setup()
            })
        }
    }
    
    func setup(){
        if (XZSetting.sharedInstance[KplacemarkName] == nil){
            self.username = "北京"
        }else{
            self.username = XZSetting.sharedInstance[KplacemarkName]
        }
        
        if (XZSetting.sharedInstance[KweatherTefurbishTime] == nil){
            self.weatherTefurbishTime = "2016-01-01"
        }else{
            self.weatherTefurbishTime = XZSetting.sharedInstance[KweatherTefurbishTime]
        }
        
    }
}
