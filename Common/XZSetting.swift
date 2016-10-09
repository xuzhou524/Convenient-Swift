//
//  XZSetting.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/9.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

let keyPrefix =  "me.XZ.XZSetting."

class XZSetting: NSObject {
    static let sharedInstance = XZSetting()
    
    subscript(key:String) -> String? {
        get {
            return UserDefaults.standard.object(forKey: key) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key )
        }
    }
    
    func save(){
        UserDefaults.standard.synchronize()
    }

}
