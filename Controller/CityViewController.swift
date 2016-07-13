//
//  CityViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import TMCache
import GoogleMobileAds
typealias cityViewbackfunc=(weatherModel:WeatherModel)->Void

class CityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  ,GADBannerViewDelegate{
    
    var myFunc = cityViewbackfunc?()
    var bannerImageView: GADBannerView!
    
    func cityViewBack(mathFunction:(weatherModel:WeatherModel)->Void ){
        myFunc = mathFunction
    }
    
    var weatherArray = NSMutableArray()
    private var _tableView: UITableView!
    private var tableView: UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.delegate = self
                _tableView.dataSource = self
                _tableView.separatorStyle = .None
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                
                regClass(_tableView, cell: CityTableViewCell.self)
                regClass(_tableView, cell: addCityNullTabelView.self)
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "城市管理"
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(60);
        }
        
        self.bannerImageView = GADBannerView()
        self.bannerImageView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.view.addSubview(self.bannerImageView)
        self.bannerImageView.snp_makeConstraints{ (make) -> Void in
            make.bottom.right.left.equalTo(self.view);
            make.height.equalTo(60);
        }
        
        self.bannerImageView.delegate = self
        self.bannerImageView.adUnitID = "ca-app-pub-3469552292226288/9081240452";
        self.bannerImageView.rootViewController = self
        self.bannerImageView.loadRequest(GADRequest())
        
    
        if  TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) != nil{
            self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
        }
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 35, 30)
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        leftButton.setImage(UIImage(named: "bank"), forState: .Normal)
        leftButton.adjustsImageWhenHighlighted = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: #selector(HomeViewController.leftClick), forControlEvents: .TouchUpInside)
    }
    func leftClick(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherArray.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == self.weatherArray.count{
            let addCell = getCell(tableView, cell: addCityNullTabelView.self, indexPath: indexPath)
            addCell.selectionStyle = .None
            return addCell
        }
        
        let cityCell = getCell(tableView, cell: CityTableViewCell.self, indexPath: indexPath)
        cityCell.selectionStyle = .None
        cityCell.bind(self.weatherArray[indexPath.row] as! WeatherModel)
        cityCell.shanChuView?.tag = indexPath.row + 100
        cityCell.bgScrollView?.tag = indexPath.row + 1000
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CityViewController.deleteLocalCity(_:)))
        cityCell.shanChuView!.addGestureRecognizer(tapGestureRecognizer)
   
        let scrollViewRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CityViewController.selectModel(_:)))
        cityCell.bgScrollView!.addGestureRecognizer(scrollViewRecognizer)
        
        return cityCell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.weatherArray.count{
            let addCityVC = AddCityTableViewController()
            addCityVC.initBack({ (weatherModel) -> Void in
                self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
                self.tableView.reloadData()
                self.myFunc!(weatherModel: weatherModel);
            })
            self.navigationController?.pushViewController(addCityVC, animated: true)
        }
    }
    
    func deleteLocalCity(tap:UITapGestureRecognizer){
        self.weatherArray.removeObjectAtIndex(((tap.view?.tag)! - 100))
        TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
        self.tableView.reloadData()
        
    }
    
    func selectModel(tap:UITapGestureRecognizer){
        let weatherModel = self.weatherArray[((tap.view?.tag)! - 1000)]  as! WeatherModel
        self.myFunc!(weatherModel: weatherModel);
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
