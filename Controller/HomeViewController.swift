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
typealias cityHomeViewbackfunc=(_ weatherModel:WeatherModel)->Void

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //var myHomeFunc = cityHomeViewbackfunc?()
    
    //    func cityHomeViewBack(_ mathFunction:(_ weatherModel:WeatherModel)->Void ){
    //        myHomeFunc = mathFunction
    //    }
    
    var HomeWeatherMdoel = WeatherModel()
    
    var requCityName = XZClient.sharedInstance.username!
    var weatherArray = NSMutableArray()
    var weatherlocalArray = NSMutableArray()
    
    //var alamofireManager : Manager?
    var xxWeiHaoArray = NSMutableArray()
    
    var cityNameButton : UIButton?
    var cityIconImageView : UIImageView?
    
    fileprivate var _tableView : UITableView!
    fileprivate var tableView :UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                _tableView.delegate = self
                _tableView.dataSource = self
                
                self.tableView.register(Weather_titleTabeleViewCell.self, forCellReuseIdentifier: "Weather_titleTabeleViewCell")
                self.tableView.register(WeatherTabeleViewCell.self, forCellReuseIdentifier: "WeatherTabeleViewCell")
                self.tableView.register(Weather_LineTabeleViewCell.self, forCellReuseIdentifier: "Weather_LineTabeleViewCell")
                self.tableView.register(Weather_TimeTabeleViewCell.self, forCellReuseIdentifier: "Weather_TimeTabeleViewCell")
                self.tableView.register(Weather_WeekTabeleViewCell.self, forCellReuseIdentifier: "Weather_WeekTabeleViewCell")
            }
            return _tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameButton = UIButton()
        cityNameButton!.setImage(UIImage(named: ""), for: UIControlState())
        cityNameButton!.adjustsImageWhenHighlighted = false
        if (HomeWeatherMdoel.life == nil) {
            cityNameButton!.setTitle(XZClient.sharedInstance.username!, for: UIControlState())
        }else{
            cityNameButton!.setTitle(HomeWeatherMdoel.realtime!.city_name! as String, for: UIControlState())
        }
        cityNameButton!.addTarget(self, action: #selector(HomeViewController.cityClick), for: .touchUpInside)
        
        cityIconImageView = UIImageView()
        cityIconImageView?.isUserInteractionEnabled = true
        cityIconImageView?.image = UIImage.init(named: "fujindizhi")
        cityNameButton!.addSubview(cityIconImageView!)
        cityIconImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(cityNameButton!);
            make.right.equalTo(cityNameButton!.snp.left).offset(-5)
            make.width.height.equalTo(28)
        });
        
        self.navigationItem.titleView = cityNameButton
        
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        let leftButton = UIButton()
        leftButton.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        leftButton.setImage(UIImage(named: "bank"), for: UIControlState())
        leftButton.adjustsImageWhenHighlighted = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: #selector(HomeViewController.leftClick), for: .touchUpInside)
        
        let rightShareButton = UIButton()
        rightShareButton.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        rightShareButton.contentMode = .center
        rightShareButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        rightShareButton.adjustsImageWhenHighlighted = false
        rightShareButton.setImage(UIImage(named: "share"), for: UIControlState())
        rightShareButton.addTarget(self, action: #selector(HomeViewController.rightShareClick), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightShareButton)]
        
        
        self.kvoController .observe(XZClient.sharedInstance, keyPath:"username", options: [.initial,.new]){[weak self] (nav, color, change) -> Void in
            if (self!.HomeWeatherMdoel.life == nil) {
                self!.requCityName = XZClient.sharedInstance.username!
            }else{
                self!.requCityName = self!.HomeWeatherMdoel.realtime!.city_name! as String
            }
            self!.cityNameButton!.setTitle(self!.requCityName, for: UIControlState())
            self!.asyncRequestData()
        }
        if  TMCache.shared().object(forKey: kTMCacheWeatherArray) != nil{
            self.weatherlocalArray = TMCache.shared().object(forKey: kTMCacheWeatherArray) as! NSMutableArray
        }
        if self.weatherlocalArray.count > 0 {
            self.HomeWeatherMdoel = self.weatherlocalArray[0] as! WeatherModel
        }
    }
    
    func leftClick(){
        self.dismiss(animated: true, completion: nil)
    }
    func cityClick(){
        let cityVC = CityViewController()
//        cityVC.cityViewBack { (weatherModel) -> Void in
//            self.HomeWeatherMdoel = weatherModel
//            self.requCityName = weatherModel.realtime!.city_name! as String
//            self.cityNameButton!.setTitle(self.HomeWeatherMdoel.realtime!.city_name! as String, for: UIControlState())
//            self.asyncRequestData()
//            self.myHomeFunc!(weatherModel: weatherModel);
//        }
        self.navigationController?.pushViewController(cityVC, animated: true)
    }
    
    func rightShareClick(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: UIApplication.shared.keyWindow!.frame.width, height: UIApplication.shared.keyWindow!.frame.height), true, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
        UIApplication.shared.keyWindow!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
        
        let shareView = ShareView()
        shareView.title = "用易分享"
        shareView.image = viewImage
        
        let modelDic = self.HomeWeatherMdoel.weather[0]
        let infoDic =  ((modelDic as AnyObject).object(forKey: "info"))! as! NSDictionary
        let dayArray =  (infoDic.object(forKey: "day"))! as! NSArray
        let nightArray =  (infoDic.object(forKey: "night"))! as! NSArray
        
        let str: String = "  " + (nightArray[2] as? String)! + "℃ ~ " + (dayArray[2] as? String)! + "℃  想容易，就用易"
        if ((modelDic as AnyObject).object(forKey: "date") != nil) {
            shareView.content = (modelDic as AnyObject).object(forKey: "date") as! String  + (self.HomeWeatherMdoel.realtime?.city_name)! + " " + (self.HomeWeatherMdoel.realtime?.weather?.info)! + str
            shareView.showInWindowAnimated(true)
        }
    }
    
    func asyncRequestData() -> Void{
        //根据城市名称  获取城市ID
        //http://apistore.baidu.com/microservice/cityinfo?cityname=北京
        
        //得到ID  获取天气图标对应的值
        //http://tq.91.com/api/?act=210&city=101180712&sv=3.15.3
        
        //搜索城市
        //http://zhwnlapi.etouch.cn/Ecalender/api/city?keyword=%E6%B8%85%E8%BF%9C&timespan=1457518656.715996&type=search
        
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
                            TMCache.shared().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
                        }
                    }
                }
                break
            case .failure(let error):
                debugPrint(error)
                break
            }
            self.tableView .reloadData()
            //self.tableView.dg_stopLoading()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.HomeWeatherMdoel.life) != nil {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return [40,320,35,120,35][(indexPath as NSIndexPath).row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let titleCell = getCell(tableView, cell: Weather_titleTabeleViewCell.self, indexPath: indexPath)
            
            titleCell.bind(self.HomeWeatherMdoel)
            titleCell.selectionStyle = .none
            return titleCell
        }else if indexPath.row == 1 {
            let weatherCell = getCell(tableView, cell: WeatherTabeleViewCell.self, indexPath: indexPath)
            weatherCell.selectionStyle = .none
            weatherCell.bind(self.HomeWeatherMdoel)
            return weatherCell
        }else if indexPath.row == 2 {
            let weatherTimeCell = getCell(tableView, cell: Weather_TimeTabeleViewCell.self, indexPath: indexPath)
            weatherTimeCell.selectionStyle = .none
            weatherTimeCell.bind(self.HomeWeatherMdoel)
            return weatherTimeCell
        }
        else if (indexPath as NSIndexPath).row == 3{
            let lineCell = getCell(tableView, cell: Weather_LineTabeleViewCell.self, indexPath: indexPath)
            lineCell.selectionStyle = .none
            lineCell.weakWeatherArray = self.HomeWeatherMdoel.weather
            lineCell.configUI()
            lineCell.backgroundColor = UIColor.white
            return lineCell
        }
        else if (indexPath as NSIndexPath).row == 4{
            let weekTimeCell = getCell(tableView, cell: Weather_WeekTabeleViewCell.self, indexPath: indexPath)
            weekTimeCell.selectionStyle = .none
            weekTimeCell.binde(self.HomeWeatherMdoel)
            return weekTimeCell
        }
        return UITableViewCell()
    }
}
