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


class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var weatherMdoel : WeatherModel?
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
                return _tableView
            }
          return _tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "北京"
        
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        self.asyncRequestData()
        self.setupPullToRefreshView(self.tableView)
    }
    
    
    func setupPullToRefreshView(tableView:UITableView) -> Void{
        
        self.cycle = DGElasticPullToRefreshLoadingViewCircle()
        self.cycle!.tintColor=UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ () -> Void in
            tableView.dg_stopLoading()
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
        
        //获取天气信息
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let urlString = "http://op.juhe.cn/onebox/weather/query"
        
        let prames = [
            "cityname" : "北京",
            "key" : "af34bbdd7948b379a0d218fc2c59c8ba"
        ]
//        Alamofire.request(.POST, urlString, parameters:prames, encoding: .URL, headers: nil).responseJSON { (response) -> Void in
//            print(response)
//        }
  
        Alamofire.request(.POST, urlString, parameters:prames, encoding: .URL, headers: nil).responseObject("result.data") {
            (response : Response<WeatherModel,NSError>) in
            if let model = response.result.value{
                self.weatherMdoel = model
                self.tableView.dg_stopLoading()
                self.tableView .reloadData()
            }
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return [40,300,35,120,35][indexPath.row]
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
            if ((self.weatherMdoel?.weather) != nil){
                lineCell.weakWeatherArray = (self.weatherMdoel?.weather)!
            }
            
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
