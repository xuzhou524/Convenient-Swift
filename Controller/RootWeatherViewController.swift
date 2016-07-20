//
//  RootWeatherViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/7/6.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import TMCache
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import SnapKit
import KVOController


class RootWeatherViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,LBCalendarDataSource,ChangeBGScrollviewAlphaDelegate{
    
    var SelectionMonthBt : UIBarButtonItem?
    var dsView : DateSelectView?
    var BGScrollview : UIScrollView?
    var rootCalendarCell : RootCalendarTableViewCell?
    var HomeWeatherMdoel = WeatherModel()
    var weatherlocalArray = NSMutableArray()
    
    var requCityName = XZClient.sharedInstance.username!
    var weatherArray = NSMutableArray()
    var alamofireManager : Manager?
    
    private var _tableView : UITableView!
    private var tableView :UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                _tableView.delegate = self
                _tableView.dataSource = self
                
                regClass(self.tableView, cell: RootCalendarTableViewCell.self)
                regClass(self.tableView, cell: RootWeatherTableViewCell.self)
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomNavBarBt()
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootViewController.updateym), name: "currentYearMonth", object: nil)
        let tapGesturRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RootViewController.tapGestureRecognizer))
        self.view.addGestureRecognizer(tapGesturRecognizer)
        if  TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil{
            self.weatherlocalArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
        }
        if self.weatherlocalArray.count > 0 {
            self.HomeWeatherMdoel = self.weatherlocalArray[0] as! WeatherModel
        }
        self.asyncRequestData()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rootCalendarCell!.calendar?.reloadData()
    }
    
    func asyncRequestData() -> Void{
        //根据城市名称  获取城市ID
        //http://apistore.baidu.com/microservice/cityinfo?cityname=北京
        
        //得到ID  获取天气图标对应的值
        //http://tq.91.com/api/?act=210&city=101180712&sv=3.15.3
        
        //搜索城市
        //http://zhwnlapi.etouch.cn/Ecalender/api/city?keyword=%E6%B8%85%E8%BF%9C&timespan=1457518656.715996&type=search
        
        //获取天气信息
        WeatherModel.like(self.requCityName, success: { (model) -> Void in
            self.HomeWeatherMdoel = model
            if (TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil){
                self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
            }
            //去重
            var tempBool = true
            for  i in 0  ..< self.weatherArray.count {
                let model = self.weatherArray[i] as! WeatherModel
                if model.realtime?.city_code == self.HomeWeatherMdoel.realtime?.city_code || model.realtime?.city_name == self.HomeWeatherMdoel.realtime?.city_name{
                    self.weatherArray.removeObjectAtIndex(i)
                    self.weatherArray.insertObject(self.HomeWeatherMdoel, atIndex: i)
                    tempBool = false
                    break
                }
            }
            if tempBool{
                self.weatherArray.addObject(self.HomeWeatherMdoel)
            }
            
            TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
            
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "MM-dd HH:mm"
            let strNowTime = timeFormatter.stringFromDate(date) as String
            
            XZSetting.sharedInstance[KweatherTefurbishTime] = strNowTime;
            var listData: NSDictionary = NSDictionary()
            let filePath = NSBundle.mainBundle().pathForResource("TailRestrictions.plist", ofType:nil )
            listData = NSDictionary(contentsOfFile: filePath!)!
            let cityId = listData.objectForKey(self.requCityName) as? String
            if (cityId != nil) {
                self.asyncRequestXianXingData(cityId!)
            }else{
                self.tableView.reloadData()
            }
            }, failure: { (error) -> Void in
                
        })
    }
    func asyncRequestXianXingData(string:String) -> Void{
        let urlString = "http://forecast.sina.cn/app/lifedex/v3/html/channel.php?"
        let prames = [
            "ch_id" : "3",
            "citycode" : string,
            "pt" : "3010"
        ]
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 30    // 秒
        self.alamofireManager = Manager(configuration: config)
        self.alamofireManager!.request(.GET, urlString, parameters:prames ).responseString {response in
            switch response.result {
            case .Success:
                debugPrint(response.result)
                
                let dataImage = response.result.value?.dataUsingEncoding(NSUTF8StringEncoding)
                let xpathParser = TFHpple().dynamicType.init(HTMLData: dataImage)
                let elements = xpathParser.searchWithXPathQuery("//html//body//div//div//div//div[@class='number']")
                if elements.count > 0{
                    let temp = elements.first as! TFHppleElement
                    for i in 0  ..< self.weatherArray.count {
                        let model = self.weatherArray[i] as! WeatherModel
                        if (model.realtime?.city_code == self.HomeWeatherMdoel.realtime?.city_code){
                            self.weatherArray.removeObjectAtIndex(i)
                            self.HomeWeatherMdoel.xxweihao = temp.content
                            self.weatherArray.insertObject(self.HomeWeatherMdoel, atIndex: i)
                            TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
                        }
                    }
                }
                break
            case .Failure(let error):
                debugPrint(error)
                break
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if indexPath.row == 0 {
            return 300
        }
        return 110
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //星期
        let itemW  = UIScreen.mainScreen().bounds.size.width / 7.00
        let array = ["周一", "周二", "周三", "周四", "周五", "周六","周日"]
        let weekBg = UIView.init()
        weekBg.backgroundColor = XZSwiftColor.weekBgColor
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
        return weekBg
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            rootCalendarCell = getCell(tableView, cell: RootCalendarTableViewCell.self, indexPath: indexPath)
            rootCalendarCell!.selectionStyle = .None
            rootCalendarCell?.calendar.dataSource = self
            return rootCalendarCell!
        }
        
        let rootWeatherCell = getCell(tableView, cell: RootWeatherTableViewCell.self, indexPath: indexPath)
        rootWeatherCell.selectionStyle = .None
        rootWeatherCell.bind(self.HomeWeatherMdoel)
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RootViewController.tapWeatherClick))
        rootWeatherCell.addGestureRecognizer(tapGestureRecognizer)
        return rootWeatherCell
    }
    
    func createCustomNavBarBt(){
        let defaultDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let defaultDateStr = dateFormatter.stringFromDate(defaultDate) as String
        
        SelectionMonthBt = UIBarButtonItem.init(title: defaultDateStr, style: .Plain, target: self, action: #selector(RootViewController.action))
        SelectionMonthBt?.width = 30
        
        let TodayTouchBT = UIBarButtonItem.init(title: "今", style: .Plain, target: self, action: #selector(RootViewController.didGoTodayTouch))
        TodayTouchBT.width = 15
        
        let MoreBt = UIBarButtonItem.init(title: "更多", style: .Plain, target: self, action: #selector(RootViewController.moreBtTap))
        MoreBt.width = 25
        
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        let  mycustomButtons = [TodayTouchBT,spaceItem,spaceItem,SelectionMonthBt!,spaceItem,spaceItem,MoreBt]
        
        let  mycustomToolBar = UIToolbar.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, 44))
        mycustomToolBar.barStyle = .BlackTranslucent
        mycustomToolBar.items = mycustomButtons
        mycustomToolBar.sizeToFit()
        mycustomToolBar.tintColor = XZSwiftColor.whiteColor()
        mycustomToolBar.setBackgroundImage(UIImage.init(named:"Transparent.png"), forToolbarPosition: .Any, barMetrics: .Default)
        let bgview = UIView()
        bgview.backgroundColor = XZSwiftColor.navignationColor
        mycustomToolBar.addSubview(bgview)
        bgview.snp_makeConstraints { (make) in
            make.left.right.equalTo(mycustomToolBar)
            make.bottom.equalTo(mycustomToolBar.snp_top).offset(1)
            make.height.equalTo(3)
        };
        self.navigationController?.navigationBar.addSubview(mycustomToolBar)
    }
    
    func moreBtTap(){
        dsView?.cancelBtTap()
        let centerNav = XZSwiftNavigationController(rootViewController: MoreTableViewController());
        self.presentViewController(centerNav, animated: true, completion: nil)
    }
    func action(){
        if (dsView == nil) {
            dsView =  DateSelectView.init(frame: CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 270))
            dsView?.delegate = self
            BGScrollview?.userInteractionEnabled = false
            UIView.animateWithDuration(0.6, animations: {
                self.dsView?.frame = CGRectMake(0, self.view.frame.size.height - 270, self.view.bounds.size.width, 270)
                self.view.addSubview(self.dsView!)
                self.BGScrollview?.alpha = 0.4
            })
        }else{
            BGScrollview?.userInteractionEnabled = false
            UIView.animateWithDuration(0.6, animations: {
                self.view.addSubview(self.dsView!)
                self.dsView?.frame = CGRectMake(0, self.view.frame.size.height - 270, self.view.bounds.size.width, 270)
                self.BGScrollview?.alpha = 0.4
            })
        }
    }
    func didGoTodayTouch(){
        if (dsView != nil) {
            dsView?.cancelBtTap()
        }
        rootCalendarCell!.calendar?.currentDate = NSDate()
    }
    
    func tapGestureRecognizer(){
         dsView?.cancelBtTap()
    }
    
    func calendarDidDateSelected(calendar: LBCalendar!, date: NSDate!) {
        NSNotificationCenter.defaultCenter().postNotificationName("DaySelected", object: date)
    }
    
    func calendarHaveEvent(calendar: LBCalendar!, date: NSDate!) -> Bool {
        return false
    }
    
    func changAlpha(BGAlpha: Float) {
        BGScrollview?.alpha = CGFloat(BGAlpha)
        BGScrollview?.userInteractionEnabled = true
    }
    
    func didTouchDatePickeOKBt(date1: NSDate!) {
        rootCalendarCell!.calendar?.currentDate = date1
        dsView?.cancelBtTap()
    }
    
    func updateym(notification: NSNotification) {
        SelectionMonthBt?.title = notification.object as? String
    }
    func tapWeatherClick() {
        let homeViewVC = HomeViewController()
        homeViewVC.HomeWeatherMdoel = self.HomeWeatherMdoel
        homeViewVC.cityHomeViewBack { (weatherModel) -> Void in
            self.HomeWeatherMdoel = weatherModel
            self.requCityName = weatherModel.realtime!.city_name! as String
            self.asyncRequestData()
        }
        let centerNav = XZSwiftNavigationController(rootViewController: homeViewVC);
        self.presentViewController(centerNav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
