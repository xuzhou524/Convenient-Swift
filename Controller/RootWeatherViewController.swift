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
    
    fileprivate var _tableView : UITableView!
    fileprivate var tableView :UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                _tableView.delegate = self
                _tableView.dataSource = self
                
                _tableView.register(RootCalendarTableViewCell.self, forCellReuseIdentifier: "RootCalendarTableViewCell")
                _tableView.register(RootWeatherTableViewCell.self, forCellReuseIdentifier: "RootWeatherTableViewCell")
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomNavBarBt()
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(RootWeatherViewController.updateym), name: NSNotification.Name(rawValue: "currentYearMonth"), object: nil)
        let tapGesturRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RootWeatherViewController.tapGestureRecognizer))
        self.view.addGestureRecognizer(tapGesturRecognizer)
        if  TMCache.shared().object(forKey: kTMCacheWeatherArray) != nil{
            self.weatherlocalArray = TMCache.shared().object(forKey: kTMCacheWeatherArray) as! NSMutableArray
        }
        if self.weatherlocalArray.count > 0 {
            self.HomeWeatherMdoel = self.weatherlocalArray[0] as! WeatherModel
        }
        self.asyncRequestData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootCalendarCell!.calendar?.reloadData()
    }
    
    func asyncRequestData() -> Void{
        //获取天气信息
        let urlString = "https://op.juhe.cn/onebox/weather/query"
        let prames = [
            "cityname" : self.requCityName,
            "key" : "af34bbdd7948b379a0d218fc2c59c8ba"
        ]
        Alamofire.request(urlString, method: .post, parameters: prames).responseJSON{ (response) -> Void in
            if response.result.error == nil {
                if let dict = response.result.value as? NSDictionary {
                    if let dicts = dict["result"] as? NSDictionary {
                        if let dictss = dicts["data"] as? NSDictionary {
                            if let model = WeatherModel(dictionary: dictss as! [AnyHashable: Any]) {
                                print(model);
                                self.HomeWeatherMdoel = model
                                if (TMCache.shared().object(forKey: kTMCacheWeatherArray) != nil){
                                    self.weatherArray = TMCache.shared().object(forKey: kTMCacheWeatherArray) as! NSMutableArray
                                }
                                //去重
                                var tempBool = true
                                for  i in 0  ..< self.weatherArray.count {
                                    let model = self.weatherArray[i] as! WeatherModel
                                    if model.realtime?.city_code == self.HomeWeatherMdoel.realtime?.city_code || model.realtime?.city_name == self.HomeWeatherMdoel.realtime?.city_name{
                                        self.weatherArray.removeObject(at: i)
                                        self.weatherArray.insert(self.HomeWeatherMdoel, at: i)
                                        tempBool = false
                                        break
                                    }
                                }
                                if tempBool{
                                    self.weatherArray.add(self.HomeWeatherMdoel)
                                }
                                
                                //  TMCache.shared().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
                                
                                let date = Date()
                                let timeFormatter = DateFormatter()
                                timeFormatter.dateFormat = "MM-dd HH:mm"
                                let strNowTime = timeFormatter.string(from: date) as String
                                
                                XZSetting.sharedInstance[KweatherTefurbishTime] = strNowTime;
                                var listData: NSDictionary = NSDictionary()
                                let filePath = Bundle.main.path(forResource: "TailRestrictions.plist", ofType:nil )
                                listData = NSDictionary(contentsOfFile: filePath!)!
                                let cityId = listData.object(forKey: self.requCityName) as? String
                                if (cityId != nil) {
                                    self.asyncRequestXianXingData(cityId!)
                                }else{
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func asyncRequestXianXingData(_ string:String) -> Void{
        let urlString = "http://forecast.sina.cn/app/lifedex/v3/html/channel.php?"
        let prames = [
            "ch_id" : "3",
            "citycode" : string,
            "pt" : "3010"
        ]
        Alamofire.request(urlString, method: .get, parameters: prames).responseString {response in
            switch response.result {
            case .success:
                debugPrint(response.result)
                
                let dataImage = response.result.value?.data(using: String.Encoding.utf8)
                let xpathParser = type(of: TFHpple()).init(htmlData: dataImage)
                let elements = xpathParser?.search(withXPathQuery: "//html//body//div//div//div//div[@class='number']")
                if (elements?.count)! > 0{
                    let temp = elements?.first as! TFHppleElement
                    for i in 0  ..< self.weatherArray.count {
                        let model = self.weatherArray[i] as! WeatherModel
                        if (model.realtime?.city_code == self.HomeWeatherMdoel.realtime?.city_code){
                            self.weatherArray.removeObject(at: i)
                            self.HomeWeatherMdoel.xxweihao = temp.content
                            self.weatherArray.insert(self.HomeWeatherMdoel, at: i)
                            //TMCache.shared().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
                        }
                    }
                }
                break
            case .failure(let error):
                debugPrint(error)
                break
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if (indexPath as NSIndexPath).row == 0 {
            return 300
        }
        return 110
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //星期
        let itemW  = UIScreen.main.bounds.size.width / 7.00
        let array = ["周日", "周一", "周二", "周三", "周四", "周五","周六"]
        let weekBg = UIView.init()
        weekBg.backgroundColor = XZSwiftColor.weekBgColor
        for  i in 0  ..< 7{
            let week = UILabel.init()
            week.text = array[i]
            week.font = UIFont.systemFont(ofSize: 14)
            week.frame = CGRect(x: itemW * CGFloat(i), y: 6, width: itemW, height: 32)
            week.textAlignment = .center
            week.textColor = XZSwiftColor.black
            week.backgroundColor = XZSwiftColor.clear
            weekBg.addSubview(week)
        }
        return weekBg
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            rootCalendarCell = getCell(tableView, cell: RootCalendarTableViewCell.self, indexPath: indexPath)
            rootCalendarCell!.selectionStyle = .none
            rootCalendarCell?.calendar.dataSource = self
            return rootCalendarCell!
        }
        
        let rootWeatherCell = getCell(tableView, cell: RootWeatherTableViewCell.self, indexPath: indexPath)
        rootWeatherCell.selectionStyle = .none
        rootWeatherCell.bind(self.HomeWeatherMdoel)
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RootWeatherViewController.tapWeatherClick))
        rootWeatherCell.addGestureRecognizer(tapGestureRecognizer)
        return rootWeatherCell
    }
    
    func createCustomNavBarBt(){
        let defaultDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let defaultDateStr = dateFormatter.string(from: defaultDate) as String
        
        SelectionMonthBt = UIBarButtonItem.init(title: defaultDateStr, style: .plain, target: self, action: #selector(RootWeatherViewController.action))
        SelectionMonthBt?.width = 30
        
        let TodayTouchBT = UIBarButtonItem.init(image: UIImage.init(named: "today"), style: .plain, target: self, action: #selector(RootWeatherViewController.didGoTodayTouch))
        TodayTouchBT.width = 15
        
        let MoreBt = UIBarButtonItem.init(title: "更多", style: .plain, target: self, action: #selector(RootWeatherViewController.moreBtTap))
        MoreBt.width = 25
        
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let  mycustomButtons = [TodayTouchBT,spaceItem,spaceItem,SelectionMonthBt!,spaceItem,spaceItem,MoreBt]
        
        let  mycustomToolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44))
        mycustomToolBar.barStyle = .blackTranslucent
        mycustomToolBar.items = mycustomButtons
        mycustomToolBar.sizeToFit()
        mycustomToolBar.tintColor = XZSwiftColor.white
        mycustomToolBar.setBackgroundImage(UIImage.init(named:"Transparent.png"), forToolbarPosition: .any, barMetrics: .default)
        let bgview = UIView()
        bgview.backgroundColor = XZSwiftColor.navignationColor
        mycustomToolBar.addSubview(bgview)
        bgview.snp.makeConstraints { (make) in
            make.left.right.equalTo(mycustomToolBar)
            make.bottom.equalTo(mycustomToolBar.snp.top).offset(1)
            make.height.equalTo(3)
        };
        self.navigationController?.navigationBar.addSubview(mycustomToolBar)
    }
    
    func moreBtTap(){
        dsView?.cancelBtTap()
        let centerNav = XZSwiftNavigationController(rootViewController: MoreTableViewController());
        self.present(centerNav, animated: true, completion: nil)
    }
    func action(){
        if (dsView == nil) {
            dsView =  DateSelectView.init(frame: CGRect(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: 270))
            dsView?.delegate = self
            BGScrollview?.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.6, animations: {
                self.dsView?.frame = CGRect(x: 0, y: self.view.frame.size.height - 270, width: self.view.bounds.size.width, height: 270)
                self.view.addSubview(self.dsView!)
                self.BGScrollview?.alpha = 0.4
            })
        }else{
            BGScrollview?.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.6, animations: {
                self.view.addSubview(self.dsView!)
                self.dsView?.frame = CGRect(x: 0, y: self.view.frame.size.height - 270, width: self.view.bounds.size.width, height: 270)
                self.BGScrollview?.alpha = 0.4
            })
        }
    }
    func didGoTodayTouch(){
        if (dsView != nil) {
            dsView?.cancelBtTap()
        }
        rootCalendarCell!.calendar?.currentDate = Date()
    }
    
    func tapGestureRecognizer(){
        dsView?.cancelBtTap()
    }
    
    func calendarDidDateSelected(_ calendar: LBCalendar!, date: Date!) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DaySelected"), object: date)
    }
    
    func calendarHaveEvent(_ calendar: LBCalendar!, date: Date!) -> Bool {
        return false
    }
    
    func changAlpha(_ BGAlpha: Float) {
        BGScrollview?.alpha = CGFloat(BGAlpha)
        BGScrollview?.isUserInteractionEnabled = true
    }
    
    func didTouchDatePickeOKBt(_ date1: Date!) {
        rootCalendarCell!.calendar?.currentDate = date1
        dsView?.cancelBtTap()
    }
    
    func updateym(_ notification: Notification) {
        SelectionMonthBt?.title = notification.object as? String
    }
    func tapWeatherClick() {
        let homeViewVC = HomeViewController()
        homeViewVC.HomeWeatherMdoel = self.HomeWeatherMdoel
        //        homeViewVC.cityHomeViewBack { (weatherModel) -> Void in
        //            self.HomeWeatherMdoel = weatherModel
        //            self.requCityName = weatherModel.realtime!.city_name! as String
        //            self.asyncRequestData()
        //        }
        let centerNav = XZSwiftNavigationController(rootViewController: homeViewVC);
        self.present(centerNav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
