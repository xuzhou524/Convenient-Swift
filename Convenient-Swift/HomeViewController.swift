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
    
    var weatherMdoel = WeatherModel()
    var requCityName = XZClient.sharedInstance.username!
    var weatherArray = NSMutableArray()
    var weatherlocalArray = NSMutableArray()
    var cycle : DGElasticPullToRefreshLoadingViewCircle?
    
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
        leftButton.addTarget(self, action: Selector("leftClick"), forControlEvents: .TouchUpInside)
        
        let rightShareButton = UIButton()
        rightShareButton.frame = CGRectMake(0, 0, 21, 21)
        rightShareButton.contentMode = .Center
        rightShareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -0)
        rightShareButton.adjustsImageWhenHighlighted = false
        rightShareButton.setImage(UIImage(named: "share"), forState: .Normal)
        rightShareButton.addTarget(self, action: Selector("rightShareClick"), forControlEvents: .TouchUpInside)
        
        let rightMoreButton = UIButton()
        rightMoreButton.frame = CGRectMake(0, 0, 21, 21)
        rightMoreButton.contentMode = .Center
        rightMoreButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -0)
        rightMoreButton.setImage(UIImage(named: "gengduo"), forState: .Normal)
        rightMoreButton.adjustsImageWhenHighlighted = false
        rightMoreButton.addTarget(self, action: Selector("rightMoreClick"), forControlEvents: .TouchUpInside)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightMoreButton),UIBarButtonItem(customView: rightShareButton)]
        
        
        self.KVOController .observe(XZClient.sharedInstance, keyPath:"username", options: [.Initial,.New]){[weak self] (nav, color, change) -> Void in
            self!.asyncRequestData()
        }
        if  TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil{
            self.weatherlocalArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
        }
        if self.weatherlocalArray.count > 0 {
            self.weatherMdoel = self.weatherlocalArray[0] as! WeatherModel
        }
    }
    
    func leftClick(){
        let cityVC = CityViewController()
        
        cityVC.cityViewBack { (cityname) -> Void in
            self.requCityName = cityname as String
            self.navigationItem.title = self.requCityName
            self.asyncRequestData()
        }
        self.navigationController?.pushViewController(cityVC, animated: true)
    }
    
    func rightShareClick(){
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(UIApplication.sharedApplication().keyWindow!.frame), CGRectGetHeight(UIApplication.sharedApplication().keyWindow!.frame)), true, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
//        UIApplication.sharedApplication().keyWindow!.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let viewImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
//        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
        
        let shareView = ShareView()
        shareView.title = "想容易，就用易"
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
        
        //http://www.data321.com/e6bb5a30
        //根据城市名称  获取城市ID
        //http://apistore.baidu.com/microservice/cityinfo?cityname=北京
        
        //得到ID  获取天气图标对应的值
        //http://tq.91.com/api/?act=210&city=101180712&sv=3.15.3
        
        //搜索城市
        //http://zhwnlapi.etouch.cn/Ecalender/api/city?keyword=%E6%B8%85%E8%BF%9C&timespan=1457518656.715996&type=search
        
        //获取天气信息
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        WeatherModel.like(self.requCityName, success: { (model) -> Void in
            self.weatherMdoel = model
            if (TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil){
                self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
            }
            //去重
            var tempBool = true
            for  var i = 0 ; i < self.weatherArray.count; i++ {
                let model = self.weatherArray[i] as! WeatherModel
                if model.realtime?.city_code == self.weatherMdoel.realtime?.city_code{
                    self.weatherArray.removeObjectAtIndex(i)
                    self.weatherArray.insertObject(self.weatherMdoel, atIndex: i)
                    tempBool = false
                    break
                }
            }
            if tempBool{
                self.weatherArray.addObject(self.weatherMdoel)
            }
            
            TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
            print(TMCache.sharedCache().objectForKey(kTMCacheWeatherArray))
            self.tableView.dg_stopLoading()
            self.tableView .reloadData()
            }, failure: { (error) -> Void in
                self.tableView.dg_stopLoading()
                SVProgressHUD.showErrorWithStatus("请求失败")
         })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.weatherMdoel.life) != nil {
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
            
            titleCell.bind(self.weatherMdoel)
            titleCell.selectionStyle = .None
            return titleCell
        }else if indexPath.row == 1{
            let weatherCell = getCell(tableView, cell: WeatherTabeleViewCell.self, indexPath: indexPath)
             weatherCell.selectionStyle = .None
            weatherCell.bind(self.weatherMdoel)
            return weatherCell
        }else if indexPath.row == 2{
            let weatherTimeCell = getCell(tableView, cell: Weather_TimeTabeleViewCell.self, indexPath: indexPath)
            weatherTimeCell.selectionStyle = .None
            weatherTimeCell.bind(self.weatherMdoel)
            return weatherTimeCell
        }
        else if indexPath.row == 3{
            let lineCell = getCell(tableView, cell: Weather_LineTabeleViewCell.self, indexPath: indexPath)
            lineCell.selectionStyle = .None
            lineCell.weakWeatherArray = self.weatherMdoel.weather
            lineCell.configUI()
            lineCell.backgroundColor = UIColor.whiteColor()
            return lineCell
        }else if indexPath.row == 4{
            let weekTimeCell = getCell(tableView, cell: Weather_WeekTabeleViewCell.self, indexPath: indexPath)
            weekTimeCell.selectionStyle = .None
            weekTimeCell.binde(self.weatherMdoel)
            return weekTimeCell
        }
        return UITableViewCell()
    }
}
