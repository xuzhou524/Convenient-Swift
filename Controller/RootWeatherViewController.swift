//
//  RootWeatherViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/7/6.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class RootWeatherViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,LBCalendarDataSource,ChangeBGScrollviewAlphaDelegate{
    
    private var _tableView : UITableView!
    private var tableView :UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                _tableView.delegate = self
                _tableView.dataSource = self
                
                regClass(self.tableView, cell: Weather_titleTabeleViewCell.self)
                regClass(self.tableView, cell: WeatherTabeleViewCell.self)
                regClass(self.tableView, cell: Weather_LineTabeleViewCell.self)
                regClass(self.tableView, cell: Weather_TimeTabeleViewCell.self)
                regClass(self.tableView, cell: Weather_WeekTabeleViewCell.self)
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
    
    
    func createCalendarheaderView() {
        let itemW  = self.view.bounds.size.width / 7.00
        let array = ["周一", "周二", "周三", "周四", "周五", "周六","周日"]
        let weekBg = UIView.init()
        weekBg.backgroundColor = XZSwiftColor.weekBgColor
        weekBg.frame = CGRectMake(0, 0, self.view.frame.size.width, 44)
        self.view .addSubview(weekBg)
        for  i in 0  ..< 7{
            let week = UILabel.init()
            week.text = array[i]
            
            week.font = UIFont.systemFontOfSize(14)
            week.frame = CGRectMake(itemW * CGFloat(i), 6, itemW, 32)
            week.textAlignment = .Center
            week.textColor = XZSwiftColor.blackColor()
            week.backgroundColor = XZSwiftColor.clearColor()
            weekBg.addSubview(week)
        }
    }
    
    func createBGScrollview(){
        
    }
    
    func createCustomNavBarBt(){
        
    }
    
    func findHairlineImageViewtop(view : UIView) -> UIImageView{
       return UIImageView()
    }
    
    func backBtTap(){
        
    }
    func moreBtTap(){
        
    }
    
    
    func action(){
        
    }
    
    
    func didGoTodayTouch(){
        
    }
    
    func tapGestureRecognizer(){
    
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
    
    func updateym(notification: NSNotification) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
       
    }
    
    
    func transitionExample(){
        
    }
    
    
    
    func tapWeatherClick() {

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
