//
//  ViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/1.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import KVOController



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let urlString = "http://op.juhe.cn/onebox/weather/query"
        
        let prames = [
            "cityname" : "北京",
            "key" : "af34bbdd7948b379a0d218fc2c59c8ba"
        ]
        
    
        Alamofire.request(.POST, urlString, parameters:prames, encoding: .URL, headers: nil).responseJSON{ (response) -> Void in
            print("response: \(response)")
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

