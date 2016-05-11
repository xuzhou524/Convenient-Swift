//
//  HomeViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/2.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

import Alamofire
import SnapKit
import KVOController
import ObjectMapper
import AlamofireObjectMapper
import TMCache
import SVProgressHUD

let kTMCacheWeatherArray = "kTMCacheWeatherArray"

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var HomeWeatherMdoel = WeatherModel()
    var requCityName = XZClient.sharedInstance.username!
    var weatherArray = NSMutableArray()
    var weatherlocalArray = NSMutableArray()
    var cycle : DGElasticPullToRefreshLoadingViewCircle?
    
    var alamofireManager : Manager?
    var xxWeiHaoArray = NSMutableArray()
    
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
        self.navigationItem.title = XZClient.sharedInstance.username
        
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        self.setupPullToRefreshView(self.tableView)
        
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 40, 40)
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
        leftButton.setImage(UIImage(named: "fujindizhi"), forState: .Normal)
        leftButton.adjustsImageWhenHighlighted = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: #selector(HomeViewController.leftClick), forControlEvents: .TouchUpInside)
        
        let rightShareButton = UIButton()
        rightShareButton.frame = CGRectMake(0, 0, 21, 21)
        rightShareButton.contentMode = .Center
        rightShareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -0)
        rightShareButton.adjustsImageWhenHighlighted = false
        rightShareButton.setImage(UIImage(named: "share"), forState: .Normal)
        rightShareButton.addTarget(self, action: #selector(HomeViewController.rightShareClick), forControlEvents: .TouchUpInside)
        
        let rightMoreButton = UIButton()
        rightMoreButton.frame = CGRectMake(0, 0, 21, 21)
        rightMoreButton.contentMode = .Center
        rightMoreButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -0)
        rightMoreButton.setImage(UIImage(named: "gengduo"), forState: .Normal)
        rightMoreButton.adjustsImageWhenHighlighted = false
        rightMoreButton.addTarget(self, action: #selector(HomeViewController.rightMoreClick), forControlEvents: .TouchUpInside)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightMoreButton),UIBarButtonItem(customView: rightShareButton)]
    
        self.KVOController .observe(XZClient.sharedInstance, keyPath:"username", options: [.Initial,.New]){[weak self] (nav, color, change) -> Void in
            self!.asyncRequestData()
        }
        if  TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil{
            self.weatherlocalArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
        }
        if self.weatherlocalArray.count > 0 {
            self.HomeWeatherMdoel = self.weatherlocalArray[0] as! WeatherModel
        }
    }
    
    func leftClick(){
        let cityVC = CityViewController()
        
        cityVC.cityViewBack { (weatherModel) -> Void in
            self.HomeWeatherMdoel = weatherModel
            self.requCityName = weatherModel.realtime!.city_name! as String
            self.navigationItem.title = self.requCityName
            self.asyncRequestData()
        }
        self.navigationController?.pushViewController(cityVC, animated: true)
    }
    
    func rightShareClick(){
       UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(UIApplication.sharedApplication().keyWindow!.frame), CGRectGetHeight(UIApplication.sharedApplication().keyWindow!.frame)), true, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
        UIApplication.sharedApplication().keyWindow!.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let viewImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
   
        let shareView = ShareView()
        shareView.title = "用易"
        shareView.image = viewImage
        
        let modelDic = self.HomeWeatherMdoel.weather[0]
        let infoDic =  (modelDic.objectForKey("info"))! as! NSMutableDictionary
        let dayArray =  (infoDic.objectForKey("day"))! as! NSMutableArray
        let nightArray =  (infoDic.objectForKey("night"))! as! NSMutableArray
        
        
        let str: String = "  " + (nightArray[2] as? String)! + "℃ ~ " + (dayArray[2] as? String)! + "℃  想容易，就用易"
        
        shareView.content = modelDic.objectForKey("date") as! String  + (self.HomeWeatherMdoel.realtime?.city_name)! + " " + (self.HomeWeatherMdoel.realtime?.weather?.info)! + str
        shareView.showInWindowAnimated(true)
    }
    
    func rightMoreClick(){
        let moreVC = MoreTableViewController()
        self.navigationController?.pushViewController(moreVC, animated: true)
    }
    
    func setupPullToRefreshView(tableView:UITableView) -> Void{
        
        self.cycle = DGElasticPullToRefreshLoadingViewCircle()
        self.cycle!.tintColor=UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ () -> Void in
            self.asyncRequestData()
            }, loadingView: self.cycle)
        self.tableView.dg_setPullToRefreshFillColor(XZSwiftColor.navignationColor)
        self.tableView.dg_setPullToRefreshBackgroundColor(XZSwiftColor.convenientBackgroundColor)
    }
    func asyncRequestData() -> Void{
        //根据城市名称  获取城市ID
        //http://apistore.baidu.com/microservice/cityinfo?cityname=北京
        
        //得到ID  获取天气图标对应的值
        //http://tq.91.com/api/?act=210&city=101180712&sv=3.15.3
        
        //搜索城市
        //http://zhwnlapi.etouch.cn/Ecalender/api/city?keyword=%E6%B8%85%E8%BF%9C&timespan=1457518656.715996&type=search
        
        //获取天气信息
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        WeatherModel.like(self.requCityName, success: { (model) -> Void in
                self.HomeWeatherMdoel = model
                if (TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil){
                    self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
                }
                //去重
                var tempBool = true
                for  i in 0  ..< self.weatherArray.count {
                    let model = self.weatherArray[i] as! WeatherModel
                    if model.realtime?.city_code == self.HomeWeatherMdoel.realtime?.city_code{
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
                   self.tableView .reloadData()
                   self.tableView.dg_stopLoading()
                }
            }, failure: { (error) -> Void in
                self.tableView.dg_stopLoading()
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
                    let tempInt = self.weatherArray.indexOfObject(self.HomeWeatherMdoel)
                    self.weatherArray.removeObject(self.HomeWeatherMdoel)
                    self.HomeWeatherMdoel.xxweihao = temp.content
                    self.weatherArray.insertObject(self.HomeWeatherMdoel, atIndex: tempInt)
                    TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
                }
                break
            case .Failure(let error):
                debugPrint(error)
                break
            }
            self.tableView .reloadData()
            self.tableView.dg_stopLoading()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.HomeWeatherMdoel.life) != nil {
            return 5
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return [40,320,35,120,35][indexPath.row]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let titleCell = getCell(tableView, cell: Weather_titleTabeleViewCell.self, indexPath: indexPath)
            
            titleCell.bind(self.HomeWeatherMdoel)
            titleCell.selectionStyle = .None
            return titleCell
        }else if indexPath.row == 1{
            let weatherCell = getCell(tableView, cell: WeatherTabeleViewCell.self, indexPath: indexPath)
             weatherCell.selectionStyle = .None
            weatherCell.bind(self.HomeWeatherMdoel)
            return weatherCell
        }else if indexPath.row == 2{
            let weatherTimeCell = getCell(tableView, cell: Weather_TimeTabeleViewCell.self, indexPath: indexPath)
            weatherTimeCell.selectionStyle = .None
            weatherTimeCell.bind(self.HomeWeatherMdoel)
            return weatherTimeCell
        }
        else if indexPath.row == 3{
            let lineCell = getCell(tableView, cell: Weather_LineTabeleViewCell.self, indexPath: indexPath)
            lineCell.selectionStyle = .None
            lineCell.weakWeatherArray = self.HomeWeatherMdoel.weather
            lineCell.configUI()
            lineCell.backgroundColor = UIColor.whiteColor()
            return lineCell
        }else if indexPath.row == 4{
            let weekTimeCell = getCell(tableView, cell: Weather_WeekTabeleViewCell.self, indexPath: indexPath)
            weekTimeCell.selectionStyle = .None
            weekTimeCell.binde(self.HomeWeatherMdoel)
            return weekTimeCell
        }
        return UITableViewCell()
    }
}
