//
//  RootViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/6/27.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import TMCache
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import SnapKit
import KVOController

class RootViewController: UIViewController,LBCalendarDataSource,UIScrollViewDelegate,ChangeBGScrollviewAlphaDelegate{
    
    var navItem : UINavigationItem?
    var todayTouchButton : UIButton?
    var requCityName = XZClient.sharedInstance.username!
    var calendarContentView : LBCalendarContentView?
    var BGScrollview : UIScrollView?
    var SelectionMonthBt : UIBarButtonItem?
    var calendar : LBCalendar!
    var dsView : DateSelectView?
    var HomeWeatherMdoel = WeatherModel()
    var weatherArray = NSMutableArray()
    var alamofireManager : Manager?
    var rootWeatherView : RootWeatherTableViewCell?
    
    var toolBarHairlineImageView : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = XZSwiftColor.navignationColor
        
        self.createCalendarheaderView()
        self.createBGScrollview()
        
        calendarContentView = LBCalendarContentView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 300))
        calendarContentView?.backgroundColor = XZSwiftColor.whiteColor()
        BGScrollview?.addSubview(calendarContentView!)
        
        self.calendar = LBCalendar.init()
        self.calendar?.calendarAppearance().calendar().firstWeekday = 2  //Sunday ==1,Saturday == 7
        self.calendar?.calendarAppearance().dayRectangularRatio = 9.00 / 10.00
        
        self.calendar?.contentView = calendarContentView
        self.calendar?.dataSource = self
        
        self.createCustomNavBarBt()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootViewController.updateym), name: "currentYearMonth", object: nil)
        
        let tapGesturRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RootViewController.tapGestureRecognizer))
        self.view.addGestureRecognizer(tapGesturRecognizer)
        self.requCityName = XZClient.sharedInstance.username!
        self.KVOController .observe(XZClient.sharedInstance, keyPath:"username", options: [.Initial,.New]){[weak self] (nav, color, change) -> Void in
            self!.asyncRequestData()
        }
    }
    
    func  sebViews(){
        rootWeatherView = RootWeatherTableViewCell()
        rootWeatherView?.frame = CGRectMake(0, 310, self.view.frame.size.width, 100)
        BGScrollview?.addSubview(rootWeatherView!)
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RootViewController.tapWeatherClick))
        rootWeatherView!.addGestureRecognizer(tapGestureRecognizer)
        rootWeatherView?.bind(self.HomeWeatherMdoel)
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
                self.sebViews()
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
            self.sebViews()
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.calendar?.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        toolBarHairlineImageView?.hidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        toolBarHairlineImageView?.hidden = false
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
        BGScrollview = UIScrollView.init(frame: CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.height - 44))
        BGScrollview?.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.height)
        BGScrollview?.pagingEnabled = true
        BGScrollview?.showsVerticalScrollIndicator = false
        BGScrollview?.backgroundColor = XZSwiftColor.convenientBackgroundColor
        BGScrollview?.delegate = self
        self.view.addSubview(BGScrollview!)
    }
    
    func createCustomNavBarBt(){

        let defaultDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let defaultDateStr = dateFormatter.stringFromDate(defaultDate) as String

        let backBt = UIBarButtonItem.init(title: "返回", style: .Plain, target: self, action: #selector(RootViewController.backBtTap))
        backBt.width = 30
        
        SelectionMonthBt = UIBarButtonItem.init(title: defaultDateStr, style: .Plain, target: self, action: #selector(RootViewController.action))
        SelectionMonthBt?.width = 30
        
        let TodayTouchBT = UIBarButtonItem.init(title: "今", style: .Plain, target: self, action: #selector(RootViewController.didGoTodayTouch))
        TodayTouchBT.width = 30
        
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
            make.bottom.equalTo(mycustomToolBar.snp_top).offset(2)
            make.height.equalTo(4)
        };
        
        toolBarHairlineImageView = self.findHairlineImageViewtop(mycustomToolBar)
        self.navigationController?.navigationBar.addSubview(mycustomToolBar)
    }
    
    func findHairlineImageViewtop(view : UIView) -> UIImageView{
        if view.isKindOfClass(UIImageView.classForCoder())  && view.bounds.size.height <= 1.0 {
            return (view as? UIImageView)!
        }
        for  subiew in view.subviews {
            let imageView: UIImageView? = self.findHairlineImageViewtop(subiew) as UIImageView
            if (imageView != nil) {
                 return imageView!
            }
        }
        return UIImageView.init()
    }
    
    func backBtTap(){
        dsView?.cancelBtTap()
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
        self.calendar?.currentDate = NSDate()
    }
 
    func tapGestureRecognizer(){
        dsView?.cancelBtTap()
    }
    
    func calendarDidDateSelected(calendar: LBCalendar!, date: NSDate!) {
        NSNotificationCenter.defaultCenter().postNotificationName("DaySelected", object: date)
    }
    
    func calendarHaveEvent(calendar: LBCalendar!, date: NSDate!) -> Bool {
        return false
        return (rand() % 10) == 1
    }
    
    func changAlpha(BGAlpha: Float) {
        BGScrollview?.alpha = CGFloat(BGAlpha)
        BGScrollview?.userInteractionEnabled = true
    }
    
    func didTouchDatePickeOKBt(date1: NSDate!) {
        self.calendar?.currentDate = date1
        dsView?.cancelBtTap()
    }
    
    func updateym(notification: NSNotification) {
        SelectionMonthBt?.title = notification.object as? String
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        return
        if self.calendar.calendarAppearance().isWeekMode {
            if BGScrollview?.contentOffset.y < -10 {
                self.calendar.calendarAppearance().isWeekMode = false
                self.transitionExample()
            }
        }else{
            if BGScrollview?.contentOffset.y >= 10 {
                self.calendar.calendarAppearance().isWeekMode = true
                self.transitionExample()
            }
        }
        BGScrollview?.contentOffset = CGPointMake(0, 0)
    }
    func transitionExample(){
        var newHeight:CGFloat? = 300
        if self.calendar.calendarAppearance().isWeekMode {
            newHeight = 50
        }
    
        UIView.animateWithDuration(0.5){
            self.calendarContentView?.frame = CGRectMake(0, 0, self.view.bounds.size.width, newHeight!)
            self.view.layoutIfNeeded()
        }
        
        UIView.animateWithDuration(0.25, animations: { 
            self.calendarContentView?.layer.opacity = 0
            }) { (finished) in
                self.calendar?.reloadAppearance()
                UIView.animateWithDuration(0.25){
                   self.calendarContentView?.layer.opacity = 1
                }
        }
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
        
        //self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
