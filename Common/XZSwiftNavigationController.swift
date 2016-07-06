//
//  XZSwiftNavigationController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/2.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit


class XZSwiftNavigationController: UINavigationController {
    
    var frostedView:UIToolbar?
    var shadowImage:UIImage?
    var navigationBarAlpha:CGFloat{
        get{
            return self.frostedView!.alpha
        }set{
            var value = newValue
            if newValue > 1 {
                value = 1
            }else if value < 0 {
                value = 0
            }
            self.frostedView!.alpha = newValue
            self.navigationBar.layer.shadowOpacity = Float(value * 0.5);
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.shadowRadius = 0.5;
        self.navigationBar.layer.shadowOffset = CGSizeMake(0, 0.5)
        self.navigationBar.layer.shadowOpacity=0.4
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true);
        
        let maskingView = UIView()
        maskingView.userInteractionEnabled = false
        maskingView.backgroundColor = UIColor(white: 0, alpha: 0.0);
        self.navigationBar.insertSubview(maskingView, atIndex: 0);
        
        maskingView.snp_makeConstraints{ (make) -> Void in
            make.left.bottom.right.equalTo(maskingView.superview!)
            make.top.equalTo(maskingView.superview!).offset(-20);
        }
        self.frostedView = UIToolbar()
        self.frostedView!.userInteractionEnabled = false
        self.frostedView!.clipsToBounds = true
        maskingView.addSubview(self.frostedView!);
        
        self.frostedView!.snp_makeConstraints{ (make) -> Void in
            make.top.bottom.left.right.equalTo(maskingView);
        }
        
        self.navigationBar.titleTextAttributes = [
            NSFontAttributeName : XZFont2(18),
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        self.navigationBar.setBackgroundImage(createImageWithColor(XZSwiftColor.navignationColor), forBarMetrics: .Default)
        self.navigationBar.barStyle = .Default;
        self.navigationBar.tintColor = XZSwiftColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
