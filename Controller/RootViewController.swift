//
//  RootViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/6/27.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,LBCalendarDataSource,UIScrollViewDelegate,ChangeBGScrollviewAlphaDelegate{
    
    var navItem : UINavigationItem?
    var todayTouchButton : UIButton?
    
    var calendarContentView : LBCalendarContentView?
    var BGScrollview : UIScrollView?
    var SelectionMonthBt : UIBarButtonItem?
    var calendar : LBCalendar?
    var dsView : DateSelectView?
    var dateDetailView : DateDetailView?
    
    var toolBarHairlineImageView : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = XZSwiftColor.barTintColor
        
        
        

    }

    func createCalendarheaderView() {
        let itemW  = self.view.bounds.size.width / 7.00
        let array = ["周一", "周二", "周三", "周四", "周五", "周六","周日"]
        let weekBg = UIView.init()
        weekBg.backgroundColor = XZSwiftColor.weekBgColor
        weekBg.frame = CGRectMake(0, 64, self.view.frame.size.width, 44)
        
        self.view .addSubview(weekBg)
        
        for <#item#> in <#items#> {
            <#code#>
        }
        
    }
  
    
    func calendarDidDateSelected(calendar: LBCalendar!, date: NSDate!) {
        
    }
    
    func calendarHaveEvent(calendar: LBCalendar!, date: NSDate!) -> Bool {
        return true
    }
    
    func changAlpha(BGAlpha: Float) {
        
    }
    
    func didTouchDatePickeOKBt(date1: NSDate!) {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
