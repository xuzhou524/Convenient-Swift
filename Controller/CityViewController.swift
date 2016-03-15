//
//  CityViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import TMCache


typealias cityViewbackfunc=(cityName:NSString)->Void

class CityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var myFunc = cityViewbackfunc?()
    
    func cityViewBack(mathFunction:(cityName:NSString)->Void ){
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
                
                return _tableView
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "城市管理"
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
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
        
       // if cityCell.shanChuView?.gestureRecognizers?.count == 0{
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: Selector("deleteLocalCity:"))
            cityCell.shanChuView!.addGestureRecognizer(tapGestureRecognizer)
      //  }
        
        return cityCell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.weatherArray.count{
            let addCityVC = AddCityTableViewController()
            addCityVC.initBack({ (cityName) -> Void in
                self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
                self.tableView.reloadData()
                self.myFunc!(cityName: cityName);
                
            })
            self.navigationController?.pushViewController(addCityVC, animated: true)
        }
    }
    
    func deleteLocalCity(tap:UITapGestureRecognizer){
        
        self.weatherArray.removeObjectAtIndex(((tap.view?.tag)! - 100))
        TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
        self.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
